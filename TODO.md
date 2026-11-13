# Code Review Findings (2026-11-12)

From reviewing the Astro→Hugo migration result (`config/`, `content/`, `.github/workflows/hugo.yml`,
`.gitignore`, `.gitmodules`, README, AGENTS.md). Build verified clean with the pinned
`hugo v0.169.0+extended`.

## Blockers

- [ ] `config/_default/hugo.toml`: `buildDrafts = false`, `buildFuture = false` and
      `goCopyForRender = false` sit *after* the `[frontmatter]` header, so they parse as
      `frontmatter.*` keys and are ignored. They match Hugo's defaults today, so the config
      "works by accident"; flipping `buildDrafts = true` will do nothing. Hoist the three keys
      above the first table header (or drop `goCopyForRender`, `false` is the default).
- [ ] `content/_index.md`: `description: Get started building your docs site with Starlight.` is
      an Astro leftover now live in `description`, `og:description` and `twitter:description`
      tags. Replace it with the site blurb already set in `config/_default/languages.en.toml`
      ("Web home for tech things!").
- [ ] `content/blog/installing-microsoft-edit-debian-ubuntu.md`: unclosed code fence — the
      "Install the latest Edit version" block is missing its opening fence (a `bash` info-string line).
      The 6 shell lines
      render as one prose paragraph (smart quotes turn `"tag_name"` into `&ldquo;`, the URL
      becomes an `<a>`), and the trailing fence swallows the rest of the post. Add the opener
      before `EDIT_VERSION=$(curl …`.
- [ ] Post bodies re-type their own title as a leading `#` heading: 24 of 37 posts duplicate
      `title:`, so built pages have two identical `<h1>`s. Remove the `# Title` line from the
      bodies and promote section headings; that also gives `showTableOfContents = true` and
      `[tableOfContents] startLevel = 2` real headings (42 of 61 body headings are currently H1).
- [ ] Front matter scraped admonition junk in `description`: `delete-local-lvm-proxmox.md`
      (`'!!! note'` → live as `<meta name=description content="!!! note">`),
      `store-credentials-git.md`, `create-sudo-user-in-ubuntu-lxc-container.md`
      (`or alternatively`), `yt-dlp-command-to-transcode-video-to-h264-after-download.md`
      (`'Here''s a breakdown:'`), `specifying-a-static-container-ip-on-the-same-subnet-of-an-unraid-host.md`
      (`'networks: dockernat: …'`), `fix-origin-game-downloads-speed.md` (`'ORIGINAL POST BELOW:'`).
      Hand-write ~140-char descriptions for these, plus the four posts with none
      (`clear-nextcloud-turnkey-vm-logs`, `create-a-logon-task-in-task-scheduler-to-a-specific-directory`,
      `pi-hole-one-line-install`, `yt-dlp-command-to-record-in-a-different-file-each-time-copy`),
      which currently fall back to the site blurb.
- [ ] `.github/workflows/hugo.yml`: the `deploy` job is gated on
      `github.event.pull_request.merged`, but PR runs check out the PR *head*, not the merge
      result, while the `push`-to-`main` run builds the merged tree. Different `concurrency`
      groups per event plus `cancel-in-progress: false` means the two runs overlap, upload the
      same `pages` artifact, and whichever finishes last wins → the live site can briefly serve
      unmerged content. Change the gate to `if: github.event_name == 'push'` and keep PR runs as
      build checks only.

## Should do

- [ ] `themes/blowfish` is a full theme checkout: 121 MB, 93 MB of it `exampleSite`, carried into
      every CI checkout. Pin the submodule SHA deliberately instead of `git submodule update --remote`
      (README line breaks builds once upstream Blowfish requires Hugo > 0.169.0, per
      `[module.hugoVersion] max = "0.169.0"`), and prefer a `--depth 1` submodule clone.
- [ ] Big screenshots get no resized variant (`gog-galaxy-integrations-settings.png`, 62 KB, whose
      `srcset` lists the same file at 800w and 1280w). Add `[imaging] resample = "Lanczos"`, convert
      to webp, or use the theme's `{{< screenshot >}}` shortcode.
- [ ] `content/blog/docker-backup.md`, `docker-restore.md`, `docker-start.md`: the "Can be used in a
      set" lists link to the page they're on. Use `{% article link="/blog/docker-restore/" %}` so
      self-links are dropped and cross-links get styled cards.
- [ ] `content/blog/no-sudo-password-prompt-for-current-user.md` publishes
      `ALL=(ALL:ALL) NOPASSWD: ALL` — passwordless sudo for *every* command. Add the caveat and a
      command-scoped example; `visudo -cf` the drop-in before shipping.
- [ ] `content/blog/store-credentials-git.md`: make the plaintext-token warning visible with
      `{% alert %}…{% endalert %}` (currently only a blockquote + `!!! note` in meta tags), and link
      the safer defaults (`credential.helper "gpg"`, `gh auth login`).
- [ ] `config/_default/markup.toml`: `\[ \]` and `$$ $$` passthrough delimiters silently turn any
      future `\[ … \]` block into an invisible KaTeX span. Drop the `\[ \]` pair and use the theme's
      `{{< katex >}}` shortcode instead.
- [ ] `concurrency.cancel-in-progress: false` in `hugo.yml` queues pointless full builds+deploys on
      rapid pushes to `main`; set `true` for `push`.

## Polish

- [ ] 104 code fences have no language vs 91 labeled → highlight-free text across most of the site.
      Label every fence, and unify info strings: `bash` (56) vs `shell` (20) vs `sh` (6),
      `pwsh` (2) vs `powershell` (1).
- [ ] Replace `> **Note**` blockquotes with the theme's `{% alert %}` shortcode site-wide, so the
      migration's admonition leftovers stop being hand-written HTML-ish noise.
- [ ] Taxonomy is too flat for 37 posts: 34 tags, 16 singletons, `commands` on 19. Add
      `categories = "categories"` in `[taxonomies]` for the big buckets (proxmox, unraid, windows,
      sap).
- [ ] Title casing is inconsistent (`pi-hole one line install`, `ubuntu kernel upgrade` vs
      `Create New Table Entries in SAP SM30…`); it feeds `<title>` and the sitemap. Batch with the
      grammar pass below.
- [ ] README fixes: drop `pip install hugo` (Hugo is a Go binary), align the preview port with
      AGENTS.md (`1313` vs `--port 4321`), and document `pkill -f "hugo server"` as the reliable
      stop (`kill %1` is job control and only works in the same interactive shell).
- [ ] `.gitignore` buries the migration tooling: `fix_frontmatter.py` is ignored and absent, so the
      script that produced the `!!! note`/`…` descriptions can't be re-run or reviewed. Move helpers
      to a committed `scripts/` dir (or delete the stale entry).
- [ ] `[related] threshold = 0` forces 5 related links per post regardless of score; raise the
      threshold (~80) and drop or reweight the `title` index.

# Grammar & Clarity Review

Check grammar and clarity for each blog post.
