# djismgaming.github.io

Web home for tech things - [djismgaming.github.io](https://djismgaming.github.io)

A static site built with [Astro](https://astro.build) and [Starlight](https://starlight.astro.build), with a blog powered by `starlight-blog` and search via Pagefind.

## Project structure

```
src/content/docs/
  index.mdx                       # home page (splash)
  blog/                          # dated guides / blog posts (+ images/)
  documentation/
    index.mdx                    # documentation main menu
    Commands/, docker/, SAP-Scripts/   # command and docker notes
    guides/index.md              # guides listing (entries live in /blog/)
    archive/                     # older entries kept for history
public/                          # static assets, favicons, _redirects
```

## Local development

```bash
npm install
npm run dev
```

Then visit http://localhost:4321.

Note: search (Pagefind) is only bundled into production builds — use `npm run build` and `npm run preview` to test it.

## Build

```bash
npm run build
```

Output is written to `dist/`.

## Deploy

Pushes to `main` deploy the site to GitHub Pages via the GitHub Actions workflow in `.github/workflows/docs.yml`. Make sure the Pages source is set to **GitHub Actions** in the repository settings.
