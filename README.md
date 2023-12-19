# NixOS server for my [website](https://github.com/zkwinkle/website)

My personal reproducible NixOS server to host my [website](https://github.com/zkwinkle/website).

## Setup

The configuration expects the a `website/` dir that holds the contents of the
[website's git repository](https://github.com/zkwinkle/website).
It looks for it locally so as to not look for a specific commit/hash of the
repo (so I don't have to constantly update the hash to reflect new changes).
(Also yes this is impure but IDC about having a pure build of my website, I
care more about easily updating.)

### Manual setup

To setup manually one would run:

```sh
git clone https://github.com/zkwinkle/website-server.git
cd website-server
git clone https://github.com/zkwinkle/website.git
sudo nixos-rebuild switch --flake '.#website-server'
```

### Install script setup

Or use the `install.sh` script which automates this process and automatically
cleans up the downloaded git repos.

Here's how to bootstrap it in any NixOS instance.
```sh
# OUTDATED, WILL FIX NEXT COMMIT
nix-shell -p curl --run 'curl https://raw.githubusercontent.com/zkwinkle/website-server/main/install.sh > install.sh'
chmod +x install.sh
./install.sh
```
