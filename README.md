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

Templates are layered under [`skills/creating-projects/templates`](./skills/creating-projects/templates). Every stack starts from `common`, which carries the license, docs and the `AGENTS.md` template.

| Stack    | Layers                     |
| -------- | -------------------------- |
| `rust`   | `common` + `rust`          |
| `js-lib` | `common` + `js` + `js-lib` |
| `js-cli` | `common` + `js` + `js-cli` |

The `creating-projects` skill tells the agent how to copy the layers and fill them. Templates don't pin dependency versions, the agent adds them at their latest versions.

## License

[MIT](./LICENSE) License © [Liang Mi](https://github.com/liangmiQwQ) and contributors.
