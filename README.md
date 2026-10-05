# TwinApp

Probador virtual móvil. Sitio estático (sin build): `index.html` en la raíz + Supabase.

## Qué hace
- **Yo**: subes tu foto de frente y de espalda; el fondo se quita en tu teléfono y se guarda en Supabase.
- **Armario**: añades prendas (frente y, opcional, espalda), con el fondo quitado y recortadas automáticamente.
- **Probador**: tu gemelo con las prendas encima; arrastra y pellizca para ajustarlas, cambia entre frente y espalda.
- **Outfits**: guarda combinaciones (con posición y tamaño de cada prenda) y vuelve a probarlas.

La primera vez que se quita un fondo, el navegador descarga un modelo (~40 MB); después queda en caché.

## Publicar en GitHub Pages
1. Sube estos archivos a la raíz de tu repositorio (`index.html` debe quedar en la raíz).
2. En GitHub: Settings > Pages > Source: "Deploy from a branch", rama `main`, carpeta `/ (root)`.
3. En Supabase: Authentication > URL Configuration, pon tu URL de Pages como Site URL y en Redirect URLs.

Nota: un sitio de GitHub Pages es público. Las fotos y datos siguen protegidos porque cada usuario solo accede a lo suyo (login + reglas RLS).

## Probar en local
`python3 -m http.server` en esta carpeta y abre http://localhost:8000

## Base de datos
`supabase/schema.sql` ya está aplicado en el proyecto TwinApp de Supabase.
