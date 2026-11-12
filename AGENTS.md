## TODO

The TODO.md file includes our next tasks.

## Development

This site is Hugo 0.169 (extended) + the Blowfish theme, vendored as the git
submodule `themes/blowfish`.

Serve the site in the background with:

```
hugo server --port 4321 &
```

Manage it with `kill %1` (or `pkill -f "hugo server"`) to stop, and read the
build log from the terminal that started it. To rebuild once instead of serving:

```
hugo --minify --enableGitInfo
```

The theme submodule must be checked out before serving (`git submodule update --init --recursive`).

## Documentation

Full Hugo documentation: https://docs.hugo.io
Blowfish documentation: https://blowfish.page/docs/

Consult these guides before working on related tasks:

- [Content organization and page bundles](https://docs.hugo.io/content-management/organization/)
- [Managing content](https://docs.hugo.io/content-management/)
- [Front matter](https://docs.hugo.io/content-management/front-matter/)
- [Shortcodes](https://docs.hugo.io/content-management/shortcodes/)
- [Multi-language support](https://docs.hugo.io/content-management/i18n/)
