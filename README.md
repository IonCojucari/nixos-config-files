# NixOS config

## Deploy on a fresh machine

```bash
# 1) Clone
git clone --depth 1 git@github.com:IonCojucari/nixos-config-files.git ~/nixos-config

# 2) Link to /etc/nixos
sudo ln -s ~/nixos-config /etc/nixos

# 3) Build
sudo nixos-rebuild switch --flake /etc/nixos#nixos
