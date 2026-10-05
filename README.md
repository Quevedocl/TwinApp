# TwinApp

Probador virtual móvil. Sitio estático (sin build): `index.html` en la raíz + Supabase + IA gratuita de Hugging Face.

## Cómo funciona
- **Yo**: subes tu foto de frente y de espalda. La IA te quita la ropa que llevas y te deja un traje gris (conserva cara y manos).
- **Armario**: añades prendas (frente y, opcional, espalda); se les quita el fondo en el teléfono.
- **Probador**: eliges una prenda por categoría (superior, inferior, enterito, abrigo) y pulsas Vestir; la IA te pone las prendas encima del traje gris, una tras otra.
- **Outfits**: guardas el resultado y lo recuperas cuando quieras.

## IA gratuita (Hugging Face)
Usa el Space `zhengchong/CatVTON` (ZeroGPU). Es gratis pero con cupo limitado y a veces con cola:
- Cada prenda tarda entre 1 y 2 minutos.
- Para tener más cupo, cada persona crea un token gratis (Read) en huggingface.co/settings/tokens y lo pega en la pestaña Yo; se guarda solo en su teléfono.
- Si el Space cambia o se cae, se edita `HF_SPACE` / `HF_ENDPOINT` al inicio del script de `index.html`.

## Publicar en GitHub Pages
1. Sube estos archivos a la raíz del repositorio (`index.html` en la raíz).
2. Settings > Pages > "Deploy from a branch", rama `main`, carpeta `/ (root)`.
3. En Supabase: Authentication > URL Configuration, pon tu URL de Pages como Site URL y en Redirect URLs.

Nota: un sitio de GitHub Pages es público; los datos siguen protegidos por login + reglas RLS.

## Base de datos
`supabase/schema.sql` ya está aplicado en el proyecto TwinApp de Supabase (incluye las columnas del traje gris y la vista previa de outfits).
