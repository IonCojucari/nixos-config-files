# NixOS config

## Deploy on a fresh machine

```bash
# 1) Clone
git clone --depth 1 git@github.com:IonCojucari/nixos-config-files.git ~/nixos

# 2) Link to /etc/nixos
sudo ln -s ~/nixos /etc/nixos

# 3) Build the right host
sudo nixos-rebuild switch --flake /etc/nixos#homepc
# or
sudo nixos-rebuild switch --flake /etc/nixos#laptop
```
