# new

Liang's skills and templates for creating new projects. It replaces [rs-starter](https://github.com/liangmiQwQ/rs-starter) and the old `creating-projects` skill in [liangmiQwQ/skills](https://github.com/liangmiQwQ/skills).

## Skills

| Skill                                           | Description                                                    |
| ----------------------------------------------- | -------------------------------------------------------------- |
| [creating-projects](./skills/creating-projects) | Initialize a managed repo, then scaffold it from the templates |
| [choosing-tools](./skills/choosing-tools)       | Tool and library choices for each kind of project              |

```bash
skills add liangmiQwQ/new
```

## Templates

Templates are layered under [`skills/creating-projects/templates`](./skills/creating-projects/templates). Every stack starts from `common`, which carries the license, docs, PR title check and the `AGENTS.md` template.

| Stack    | Layers                     |
| -------- | -------------------------- |
| `rust`   | `common` + `rust`          |
| `js-lib` | `common` + `js` + `js-lib` |
| `js-cli` | `common` + `js` + `js-cli` |

```bash
skills/creating-projects/scripts/scaffold.sh rust ~/code/liangmiQwQ/foo liangmiQwQ foo "A foo crate"
```

Templates don't pin dependency versions. Each layer's `setup.sh` adds them at their latest versions when scaffolding, and CI scaffolds every stack weekly to catch breakage.

## License

[MIT](./LICENSE) License © [Liang Mi](https://github.com/liangmiQwQ) and contributors.
