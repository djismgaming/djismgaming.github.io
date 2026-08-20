# AGENTS.md

## GitHub CLI

The `gh` CLI is available and authenticated. Use it for repo operations (issues, PRs, actions, etc.) instead of web UI or API calls.

## Post types
- Blog posts
- Draft posts

## Blog posts

Zensical has no built-in blog engine, so a post needs manual bookkeeping beyond the Markdown file. Steps (details in `NEW_POSTS.md`):

1. **Create the post** — `docs/blog/posts/my-new-post.md` with frontmatter (`title`, `date`, `tags`), slug-style filename.
2. **Add it to the listing** — append a line to `docs/blog/index.md` (newest first).
3. **Add it to the nav** — insert an entry in the `Blog = [...]` block of `zensical.toml`.
4. **Preview** — run `zensical serve`, check `http://localhost:8000/blog/posts/my-new-post/`.
5. **Publish** — commit and push to `main`; GitHub Actions builds and deploys.

## Draft posts

Zensical has no built-in draft feature, and only `docs/` is built and deployed. To keep a draft unpublished:

1. **Write it in `drafts/`** — `drafts/my-draft.md` at the repo root (gitignored, see `.gitignore`), with the same frontmatter as a published post (`title`, `date`, `tags`).
2. **Preview** — temporarily copy it into `docs/blog/posts/`, run `zensical serve`, and open `http://localhost:8000/blog/posts/my-draft/`.
3. **Publish** — move the file into `docs/blog/posts/my-draft.md`, then follow `NEW_POSTS.md` (blog listing + nav).