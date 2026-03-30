# dotfiles

Dotfiles managed with GNU Stow.

## Layout

Each top-level directory is a Stow package. Files inside each package mirror
their final location under `$HOME`.

Current starter packages:

- `hypr`
- `nvim`
- `systemd-user`
- `waybar`
- `zed-projects`
- `zed-linux`
- `zed-macos`

Example:

```text
nvim/.config/nvim/
hypr/.config/hypr/
systemd-user/.config/systemd/user/
```

## Install stow

On Arch-based systems:

```bash
sudo pacman -S stow
```

## Usage

From this repo:

```bash
./scripts/install
```

Or install selected packages manually:

```bash
stow --target="$HOME" nvim hypr zed
```

## Migrating existing config

1. Copy the config you want to track into the matching package directory.
2. Keep machine-specific or secret values in local files that are not checked
   into git.
3. Run `stow --target="$HOME" <package>`.

Hyprland example:

- Track shared files in `hypr/.config/hypr/`
- Source an untracked `~/.config/hypr/local.conf` from your tracked config

## Notes

- Do not store secrets in this repo.
- Prefer one package per app so you can install only what a machine needs.
- Generated caches, logs, and session files should stay out of git.
