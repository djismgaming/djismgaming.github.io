---
tags:
  - markdown
  - reference
---

# Notes

## Material for MkDocs notes

To see code examples for reference, access the source <a href="https://squidfunk.github.io/mkdocs-material/reference/" target="_blank">reference material from Material for MkDocs</a>

## MkDocs notes

For full documentation visit [mkdocs.org](https://www.mkdocs.org).

## Markdown code examples :smile:

### inline code

Some `code` goes here.

### code blocks

``` bash
echo env > .bash_env
```

### code highlight with line highlights

``` yaml hl_lines="4"
services:
  nginx:
    container_name: nginx
    image: linuxserver/nginx
    ports:
      - 80:80
```

## admonitions

!!! note

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

supported types beside "note" 
https://squidfunk.github.io/mkdocs-material/reference/admonitions/#supported-types