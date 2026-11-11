# dotfiles

## Managed with chezmoi

This repo is the [chezmoi](https://www.chezmoi.io/) source directory. `.chezmoiroot` contains
`home`, so chezmoi only reads files inside `home/`. Anything at the repo root (like this README)
is never applied to the machine.

### What's managed

| Repo file (`home/…`) | Target on the Mac |
|---|---|
| `dot_zshrc` | `~/.zshrc` |
| `private_Library/Application Support/com.mitchellh.ghostty/config.ghostty` | `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty` |

chezmoi encodes target names in the file names: `dot_` → leading `.`, `private_` → owner-only permissions.

### Where things live

- Source (this repo): `~/Projects/dotfiles`, with the managed files in `home/`
- chezmoi config: `~/.config/chezmoi/chezmoi.toml` (sets `sourceDir` to this repo)

### Day-to-day commands

```sh
chezmoi diff                 # what `apply` would change on the machine (empty = in sync)
chezmoi re-add               # copy edits made to the real files back into the repo
chezmoi apply                # write the repo versions onto the machine
chezmoi cd                   # open a shell in the source dir (home/) to commit/push
chezmoi add ~/.some/file     # start managing another file
chezmoi managed              # list managed files
```

Typical flow after editing `~/.zshrc`: `chezmoi re-add`, then `chezmoi cd`, then
`git commit -am "…"` and `git push`.
