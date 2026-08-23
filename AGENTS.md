# AGENTS.md

## GitHub CLI

The `gh` CLI is available and authenticated. Use it for repo operations (issues, PRs, actions, etc.) instead of web UI or API calls.

## Post types
- Documentation entries (guides)
- Draft posts
- Archive entries

## Documentation entries (guides)

Zensical has no built-in blog engine, so an entry needs manual bookkeeping beyond the Markdown file. Steps (details in `NEW_POSTS.md`):

1. **Create the entry** — `docs/documentation/guides/my-new-entry.md` with frontmatter (`title`, `date`, `tags`), slug-style filename.
2. **Add it to the listing** — append a line to `docs/documentation/guides/index.md` (newest first).
3. **Add it to the nav** — insert an entry in the `Guides = [...]` block of `zensical.toml`.
4. **Preview** — run `zensical serve`, check `http://localhost:8000/documentation/guides/my-new-entry/`.
5. **Publish** — commit and push to `main`; GitHub Actions builds and deploys.

Keep the tone factual and instructional — these are documentation entries, not blog posts.

## Archive entries

Entries about deprecated products or obsolete hardware go in `docs/archive/`. Add the file there, add a line to `docs/archive/index.md`, and insert it in the `Archive = [...]` block of `zensical.toml`. Mark the entry itself with a `!!! warning "Deprecated"` or `"Historical"` admonition.
5. **Publish** — commit and push to `main`; GitHub Actions builds and deploys.

## Draft posts

Zensical has no built-in draft feature, and only `docs/` is built and deployed. To keep a draft unpublished:

1. **Write it in `drafts/`** — `drafts/my-draft.md` at the repo root (gitignored, see `.gitignore`), with the same frontmatter as a published post (`title`, `date`, `tags`).
2. **Preview** — temporarily copy it into `docs/documentation/guides/`, run `zensical serve`, and open `http://localhost:8000/documentation/guides/my-draft/`.
3. **Publish** — move the file into `docs/documentation/guides/my-draft.md`, then follow `NEW_POSTS.md` (guides listing + nav).