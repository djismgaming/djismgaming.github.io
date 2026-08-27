// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import starlightBlog from "starlight-blog";

export default defineConfig({
  site: "https://djismgaming.github.io",
  integrations: [
    starlight({
      title: "djismgaming's tech home",
      description: "Web home for tech things!",
      social: [
        { icon: "github", label: "GitHub", href: "https://github.com/djismgaming" },
        { icon: "twitter", label: "Twitter", href: "https://twitter.com/djismgaming" },
        { icon: "linkedin", label: "LinkedIn", href: "https://www.linkedin.com/in/ismaellm/" },
      ],
      plugins: [
        starlightBlog({
          authors: {
            djismgaming: {
              name: "Ismael Lamberty",
              title: "Tech Lead / Creator",
              url: "https://github.com/djismgaming",
            },
          },
        }),
      ],
      editLink: {
        baseUrl: "https://github.com/djismgaming/djismgaming.github.io/blob/main/src/content/docs/",
      },
      sidebar: [
        {
          label: "Blog",
          items: [
            { label: "Blog Posts", link: "/blog" },
          ],
        },
        {
          label: "Documentation",
          items: [
            { label: "Overview", link: "/documentation/" },
            {
              label: "Commands",
              items: [{ autogenerate: { directory: "documentation/Commands" } }],
            },
            {
              label: "Docker",
              items: [{ autogenerate: { directory: "documentation/docker" } }],
            },
            {
              label: "SAP Scripts",
              items: [{ autogenerate: { directory: "documentation/SAP-Scripts" } }],
            },
            {
              label: "Archive",
              items: [{ autogenerate: { directory: "documentation/archive" } }],
            },
          ],
        },
      ],
    }),
  ],
});
