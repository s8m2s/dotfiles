# dotfiles

My config files for bash, vim, tmux and emacs. They're kept minimal: a light colour scheme, git info in the prompt and the vim statusline, and mouse support turned on everywhere.

## What's included

| File            | Purpose |
| --------------- | ------- |
| `.bashrc`       | Prompt colour-coded by git status, colourised `ls`, `~/scripts` on `PATH`, vim as the editor |
| `.bash_aliases` | Shell aliases (`aptup` updates and upgrades apt packages) |
| `.vimrc`        | Hybrid line numbers, a custom statusline, 4-space indentation, visible whitespace, plugins through vim-plug |
| `.tmux.conf`    | `\|` / `-` pane splits, mouse mode, vi copy mode, a light status bar |
| `.emacs`        | Line numbers, mouse mode, CUA keys, and shortcuts to move the current line |

## Installation

Clone the repo, then symlink each file into your home directory:

```sh
git clone git@github.com:s8m2s/dotfiles.git ~/dotfiles
cd ~/dotfiles

for f in .bashrc .bash_aliases .vimrc .tmux.conf .emacs; do
  ln -sf "$PWD/$f" "$HOME/$f"
done
```

> `ln -sf` overwrites any of these files already in your home directory. Back them up first if you want to keep them.

Then reload:

```sh
source ~/.bashrc
tmux source-file ~/.tmux.conf   # or press prefix + r inside tmux
```

Vim installs [vim-plug](https://github.com/junegunn/vim-plug) and its plugins automatically the first time it starts. That step needs `curl` and a network connection.

## Highlights

### Bash

The prompt shows `user@host:path`, then the current git branch in a colour that reflects the repo's state:

| Colour | Meaning |
| ------ | ------- |
| Red    | Uncommitted changes |
| Yellow | Clean, but ahead of the remote |
| Green  | Clean and up to date |
| Ochre  | Any other state |

Any script you put in `~/scripts` can be run from anywhere.

### Vim

- **Statusline:** full file path, modified flag, git branch, indentation settings (`Spaces:4`, or `TS`/`STS`/`SW` when they differ), filetype, and `line/total:column`.
- **Indentation:** spaces instead of tabs, 4 wide, with `autoindent`, `copyindent` and `shiftround`.
- **Whitespace:** tabs, spaces and line endings are shown as `->`, `·` and `¬`.
- **Plugins:** [vim-editorconfig](https://github.com/sgur/vim-editorconfig). vim-gitgutter and vim-fugitive are in the file but commented out.

### tmux

| Key            | Action |
| -------------- | ------ |
| `prefix` + `\|` | Split the pane side by side |
| `prefix` + `-` | Split the pane top and bottom |
| `prefix` + `r` | Reload the config |

The prefix is still the default `C-b`. To switch it to `C-a`, uncomment the lines at the top of `.tmux.conf`.

### Emacs

| Key                         | Action |
| --------------------------- | ------ |
| `C-x` / `C-c` / `C-v`       | Cut / copy / paste (CUA mode) |
| `C-M-S-↑` / `C-M-S-↓`       | Move the current line up or down |

## Notes

- **`.bash_aliases` isn't loaded automatically.** This `.bashrc` doesn't source it. To use the aliases, add this line to `.bashrc`:
  ```sh
  [ -f ~/.bash_aliases ] && . ~/.bash_aliases
  ```
- **`aptup` only works on Debian and Ubuntu.**
- **The tmux colours need tmux older than 2.9.** The style options in `.tmux.conf` (`status-attr`, `window-status-fg`, `pane-border-fg` and the like) were removed in tmux 2.9. Newer versions report errors for those lines, and the theme won't be applied until they're rewritten with the `*-style` options.

## People
daddy is cute and nice and has a mustache and glasses
Adalyn is cute and is wearing a red shirt