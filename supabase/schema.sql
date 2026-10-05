-- TwinApp: ejecuta esto completo en Supabase > SQL Editor.

-- 1) Perfiles (una fila por usuario; guarda RUTAS en Storage, no URLs)
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text not null,
  avatar_front_path text,
  avatar_back_path text,
  created_at timestamptz not null default now()
);

-- 2) Prendas (la espalda es opcional)
create table public.garments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade default auth.uid(),
  name text not null,
  category text not null check (category in ('superior','inferior','enterito','abrigo','calzado')),
  front_path text not null,
  back_path text,
  created_at timestamptz not null default now()
);

-- 3) Outfits: items = [{"garment_id": "...", "x": 0, "y": 0, "scale": 1}]
create table public.outfits (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade default auth.uid(),
  name text not null,
  items jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);

-- 4) Seguridad por fila: cada usuario solo ve y edita lo suyo
alter table public.profiles enable row level security;
alter table public.garments enable row level security;
alter table public.outfits enable row level security;

create policy "perfil propio" on public.profiles
  for all using (id = auth.uid()) with check (id = auth.uid());
create policy "prendas propias" on public.garments
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "outfits propios" on public.outfits
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

-- 5) Crear el perfil automáticamente al registrarse
create function public.handle_new_user() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, username)
  values (new.id, coalesce(new.raw_user_meta_data->>'username', split_part(new.email, '@', 1)));
  return new;
end $$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- 6) Buckets privados; cada usuario solo accede a su carpeta (<user_id>/archivo.png)
insert into storage.buckets (id, name, public)
values ('avatars', 'avatars', false), ('garments', 'garments', false)
on conflict (id) do nothing;

create policy "archivos propios: leer" on storage.objects for select to authenticated
  using (bucket_id in ('avatars','garments') and (storage.foldername(name))[1] = auth.uid()::text);
create policy "archivos propios: subir" on storage.objects for insert to authenticated
  with check (bucket_id in ('avatars','garments') and (storage.foldername(name))[1] = auth.uid()::text);
create policy "archivos propios: editar" on storage.objects for update to authenticated
  using (bucket_id in ('avatars','garments') and (storage.foldername(name))[1] = auth.uid()::text);
create policy "archivos propios: borrar" on storage.objects for delete to authenticated
  using (bucket_id in ('avatars','garments') and (storage.foldername(name))[1] = auth.uid()::text);

-- 7) El trigger no debe poder llamarse desde la API
revoke execute on function public.handle_new_user() from public, anon, authenticated;
