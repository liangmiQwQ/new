# new Agent Guide

`new` holds the skills and templates used to create Liang's new projects. Agents install the skills in `skills/` through the `skills` CLI, and [liangmiQwQ/skills](https://github.com/liangmiQwQ/skills) syncs them daily.

## Templates

Templates are layers under `skills/creating-projects/templates`, copied in order by `skills/creating-projects/scripts/scaffold.sh`. The layer list of each stack lives in that script.

- `_name` paths become `.name`, so dotfiles like `.github` and `.gitignore` don't affect this repo or get dropped by skill installers. `__repo__` in a path becomes the repo name.
- `AGENTS.part.md` and `CONTRIBUTING.part.md` are merged into `{{toolchain}}` and `{{setup}}`. `setup.sh` runs inside the generated project. None of them are copied.
- Lowercase placeholders like `{{repo}}` are filled by the script. `{{TODO: ...}}` placeholders are written by the agent.

Never pin dependency versions in templates. Add them in `setup.sh` so new projects start from the latest versions. Only GitHub Action tags and versions required by another tool (like the Vite+ version `@liangmi/vp-config` supports) are allowed.

Templates may contain invalid code before placeholders are filled, so they are not linted or formatted directly. Run `scripts/check.sh [stack...]` to scaffold stacks into a temporary directory and run their own checks after you change a template.

`skills/creating-projects/scripts/verify.sh` checks the pieces every new project needs, and `scripts/check.sh` runs it on each scaffolded stack. When a template gains or drops a required piece, update `verify.sh` too.

## Rules

Keep the common `AGENTS.md` template close to the rules shared by Liang's existing projects. Only add a rule to it when most new projects need it.

Keep templates small. A template is a starting point that the agent adjusts, not a framework.

Templates keep the file shape, not config owned by a fast-moving tool. Leave such a file as a `{{TODO: ...}}` that points to the tool's skill (like `vite.config.ts` and `$use-vp-config`), so a breaking release doesn't make templates and skills disagree. `scripts/check.sh` fills it with a stand-in to test the rest of the template.

Keep AGENTS.md updated with the project codebase. Only record non-obvious rules and gotchas in AGENTS.md.

Commit messages and PR titles follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).
