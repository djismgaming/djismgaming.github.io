# Adding new documentation entries (guides)

Here's your workflow for adding an entry:

1. **Create the entry** — `docs/documentation/guides/my-new-entry.md` with frontmatter:

   ```yaml
   ---
   title: My new entry
   date: 2026-08-18
   tags:
     - linux
   ---
   ```

2. **Add it to the listing** — append a line to `docs/documentation/guides/index.md` (newest first):

   ```
   - **2026-08-18** - [My new entry](my-new-entry.md)
   ```

3. **Add it to the nav** — insert an entry in the `Guides = [...]` block of `zensical.toml`.

4. **Preview** — if `zensical serve` is running it reloads automatically; otherwise run it and check http://localhost:8000

5. **Publish** — commit and push to `main`; the GitHub Actions workflow builds and deploys to GitHub Pages.

Steps 2-3 are the only extra bookkeeping. Keep filenames slug-style (`my-new-entry.md`, not `My New Entry.md`) so URLs stay clean.

## Tone

Write entries as documentation, not blog posts: factual, instructional, no first-person anecdotes or sign-offs.

## Archiving

If an entry covers a deprecated product or obsolete hardware, move the file to `docs/archive/`, add a line to `docs/archive/index.md`, insert it in the `Archive = [...]` nav block, and add a `!!! warning "Deprecated"` or `"Historical"` admonition at the top.
