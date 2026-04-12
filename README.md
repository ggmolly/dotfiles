# Commands

```bash
paru -S chezmoi i3-wm polybar picom-ftlabs-git rofi rofi-greenclip dunst feh xdotool i3-resurrect unclutter-xfixes-git xidlehook redshift i3lock-color alacritty zsh starship zoxide direnv eza bat bat-extras fzf ripgrep ripgrep-all fd tealdeer git-delta navi atuin tmux zellij btop lazygit yazi fastfetch cbonsai zed-editor gping xh dust fx glow github-cli khal papirus-icon-theme zsh-autosuggestions zsh-syntax-highlighting
```

```bash
git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/fzf-tab
```

```bash
chezmoi init --apply --source="$HOME/Documents/dotfiles"
```

```bash
chezmoi apply --source="$HOME/Documents/dotfiles"
```

Encrypted `chezmoi` files now use `gpg` and require one of the configured private keys for decryption.

# Cheat Sheet

- `Mod + Enter`: terminal
- `Mod + Shift + Space`: toggle floating
- `Mod + [j,k,l,;]` or `Arrows`: move focus
- `Mod + Shift + [j,k,l,;]`: move window
- `Mod + r`: resize mode
- `Mod + Ctrl + s`: save layout
- `Mod + Ctrl + r`: restore layout
- `Mod + Shift + c`: reload i3
- `Mod + Shift + r`: restart i3
- `Mod + d`: app launcher
- `Mod + Tab`: window switcher
- `Mod + c`: clipboard history
- `Mod + e`: file browser
- `Mod + w`: Wi-Fi manager
- `Mod + b`: Bluetooth manager
- `Mod + .`: emoji picker
- `Mod + Ctrl + l`: lock screen
- `Mod + Ctrl + n`: navi
- `Mod + Shift + z`: zen mode
- `Ctrl + Alt + Delete`: power menu
- `khal`: calendar
- `z [dir]`: zoxide jump
- `Up Arrow` or `Ctrl + R`: atuin history
- `fzf` or `Ctrl + T`: fuzzy find
- `rga [query]`: search inside docs
- `Tab`: fzf-tab completion
