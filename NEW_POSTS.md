# Adding new blog posts

Here's your workflow for adding a post:

1. **Create the post** — `docs/blog/posts/my-new-post.md` with frontmatter:

   ```yaml
   ---
   title: My new post
   date: 2026-08-18
   tags:
     - linux
   ---
   ```

2. **Add it to the listing** — append a line to `docs/blog/index.md` (newest first):

   ```
   - **2026-08-18** - [My new post](posts/my-new-post.md)
   ```

3. **Add it to the nav** — insert an entry in the `Blog = [...]` block of `zensical.toml` (matches the ordering you want in the sidebar).

4. **Preview** — if `zensical serve` is running it reloads automatically; otherwise run it and check http://localhost:8000

5. **Publish** — commit and push to `main`; the GitHub Actions workflow builds and deploys to GitHub Pages.

Steps 2-3 are the only extra bookkeeping vs. a real blog engine. Keep filenames slug-style (`my-new-post.md`, not `My New Post.md`) so URLs stay clean.