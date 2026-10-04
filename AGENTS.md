# new Agent Guide

`new` holds the skills and templates used to create Liang's new projects. Agents install the skills in `skills/` through the `skills` CLI, and [liangmiQwQ/skills](https://github.com/liangmiQwQ/skills) syncs them daily.

## Templates

Templates are layers under `skills/creating-projects/templates`, copied in order by the agent. The layer list of each stack and the copy steps live in `skills/creating-projects/SKILL.md`, so keep it in sync when a layer or placeholder changes. The reasoning behind the steps, like how to read a request and what may change in a template, lives in `skills/creating-projects/guide.md`. Put new procedure in `SKILL.md` and new explanations in `guide.md`.

- `_name` paths become `.name`, so dotfiles like `.github` and `.gitignore` don't affect this repo or get dropped by skill installers. `__repo__` in a path becomes the repo name.
- `AGENTS.part.md` and `CONTRIBUTING.part.md` are merged into `{{toolchain}}` and `{{setup}}`, not copied.
- Lowercase placeholders like `{{repo}}` and `{{TODO: ...}}` placeholders are all filled by the agent.

Never pin dependency versions in templates. List the install commands in `SKILL.md` so new projects start from the latest versions. Only GitHub Action tags and versions required by another tool (like the Vite+ version `@liangmi/vp-config` supports) are allowed.

Templates may contain invalid code before placeholders are filled, so they are not linted or formatted directly.

## Rules

Keep the common `AGENTS.md` template close to the rules shared by Liang's existing projects. Only add a rule to it when most new projects need it.

Keep templates small. A template is a starting point that the agent adjusts, not a framework.

Templates keep the file shape, not config owned by a fast-moving tool. Leave such a file as a `{{TODO: ...}}` that points to the tool's skill (like `vite.config.ts` and `$use-vp-config`), so a breaking release doesn't make templates and skills disagree.

If you find AGENTS.md is outdated, please notice users to change in response.

Commit messages and PR titles follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).
