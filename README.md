# djismgaming.github.io

Web home for tech things - [djismgaming.github.io](https://djismgaming.github.io)

A static site built with [Zensical](https://zensical.org), the static site generator from the creators of Material for MkDocs.

## Project structure

```
zensical.toml                    # site configuration
docs/
  index.md                       # home page
  documentation/
    index.md                     # documentation landing
    guides/index.md              # guides listing (entries in guides/)
    Commands/, docker/, ...      # command and docker notes
  archive/index.md               # archive of old entries (files in archive/)
  assets/                        # shared assets
```

## Local development

```bash
python -m venv .venv
source .venv/bin/activate
pip install zensical
zensical serve
```

Then visit http://localhost:8000

## Build

```bash
zensical build --clean
```

Output is written to `site/`.

## Deploy

Pushes to `main` deploy the site to GitHub Pages via the GitHub Actions
workflow in `.github/workflows/docs.yml`. Make sure the Pages source is set to
**GitHub Actions** in the repository settings.