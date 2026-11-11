# dotfiles

## Managed with chezmoi

This repo is the [chezmoi](https://www.chezmoi.io/) source directory. `.chezmoiroot` contains
`home`, so chezmoi only reads files inside `home/`. Anything at the repo root (like this README)
is never applied to the machine.

### What's managed

| Repo file (`home/…`) | Target on the Mac |
|---|---|
| `dot_zshrc` | `~/.zshrc` |
| `dot_Brewfile` | `~/.Brewfile` (Homebrew packages, see below) |
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

## Brewfile

`~/.Brewfile` lists the Homebrew command-line tools, casks and VS Code extensions on this Mac,
grouped under Shell, Dev tools and VS Code extensions. `--global` makes `brew bundle` use `~/.Brewfile`.

```sh
brew bundle --global                  # install everything in the list
brew bundle check --global            # confirm everything in it is installed
brew bundle dump --global --force     # refresh it after installing new things
brew bundle cleanup --global          # show what's installed but not in the list
```

- `dump --force` rewrites the whole file in Homebrew's own order, so the section headers are lost.
  Usually it's easier to add a new line by hand under the right header. After a dump, re-sort
  the file before running `chezmoi re-add`.
- Run `cleanup` **without** `--force`. With `--force` it uninstalls everything that isn't in the list.
- Descriptions above each item are added automatically (Homebrew 7 dropped the `--describe` flag).
- Apps installed outside Homebrew (e.g. directly or from the App Store) aren't in the list.
