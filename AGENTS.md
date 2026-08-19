# AGENTS.md

## Post types
- Blog posts
- Draft posts

## Draft posts

Zensical has no built-in draft feature, and only `docs/` is built and deployed. To keep a draft unpublished:

1. **Write it in `drafts/`** — `drafts/my-draft.md` at the repo root (gitignored, see `.gitignore`), with the same frontmatter as a published post (`title`, `date`, `tags`).
2. **Preview** — temporarily copy it into `docs/blog/posts/`, run `zensical serve`, and open `http://localhost:8000/blog/posts/my-draft/`.
3. **Publish** — move the file into `docs/blog/posts/my-draft.md`, then follow `NEW_POSTS.md` (blog listing + nav).