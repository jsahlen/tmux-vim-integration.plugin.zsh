A Zsh plugin to open files in a running Vim (or NeoVim) session, from an adjacent Tmux pane.

When running either of these commands, they will find the first Tmux pane with Vim running in it, in the same window, and use `send-keys` to open the file there. Each command takes exactly one argument; the file path to open.

## Available Commands

* `tmux-vim-tabedit`
* `tmux-vim-split`
* `tmux-vim-vsplit`
