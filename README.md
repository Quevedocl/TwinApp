# TwinApp

Probador virtual móvil. Sitio estático (sin build): `index.html` en la raíz + Supabase.

## Publicar en GitHub Pages
1. Sube estos archivos a la raíz de tu repositorio (`index.html` debe quedar en la raíz).
2. En GitHub: Settings > Pages > Source: "Deploy from a branch", rama `main`, carpeta `/ (root)`.
3. En Supabase: Authentication > URL Configuration, pon tu URL de Pages (https://TU-USUARIO.github.io/TU-REPO/) como Site URL y en Redirect URLs.

Nota: un sitio de GitHub Pages es público. Las fotos y datos siguen protegidos porque cada usuario solo accede a lo suyo (login + reglas RLS).

## Probar en local
Abre `index.html` con un servidor simple (por ejemplo `python3 -m http.server`) y entra a http://localhost:8000.

## Base de datos
`supabase/schema.sql` ya está aplicado en el proyecto TwinApp de Supabase.
