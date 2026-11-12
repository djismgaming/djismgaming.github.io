# djismgaming.github.io

Personal tech blog — Hugo + [Blowfish](https://blowfish.page).

- Source content: [`content/`](content)
- Blog posts: [`content/blog/`](content/blog)
- Theme: `themes/blowfish` (git submodule of <https://github.com/nunocoracao/blowfish>)
- Deployed at <https://djismgaming.github.io>

## Requirements

Hugo **0.169.0 extended** (Blowfish requires 0.166.0–0.169.0).
Install it with your package manager, `brew`, or `pip install hugo`.

## Development

```bash
# first checkout only: pull the theme submodule
git submodule update --init --recursive

hugo server          # live preview at http://localhost:1313/
hugo server --buildDrafts
```

Content dates come from git history (`date: gitLastModified` on ported posts), so `hugo server` and CI builds need the repo committed; set `date:` explicitly on new posts when you want a fixed publish date.

## Build / Deploy

```bash
hugo --minify --enableGitInfo
```

The `.github/workflows/hugo.yml` workflow builds the site on every push to `main` and publishes the `public/` directory to GitHub Pages.

To track upstream theme releases:

```bash
git submodule update --remote themes/blowfish
```

## Structure

```
.
├── config/
│   └── _default/           # hugo.toml, params.toml, languages.en.toml, menus.en.toml, markup.toml
├── content/
│   ├── _index.md           # homepage (Blowfish landing layout)
│   └── blog/               # all posts, flat; images live in each page bundle
├── themes/
│   └── blowfish/           # theme git submodule
├── static/                 # favicons and other site assets
└── .github/workflows/hugo.yml
