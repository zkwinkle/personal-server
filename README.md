# NixOS server for my [website](https://github.com/zkwinkle/website)

My personal reproducible NixOS server to host my [website](https://github.com/zkwinkle/website).

## Setup

The configuration expects the a `website/` dir that holds the contents of the
[website's git repository](https://github.com/zkwinkle/website).
It looks for it locally so as to not look for a specific commit/hash of the
repo (so I don't have to constantly update the hash to reflect new changes).
(Also yes this is impure but IDC about having a pure build of my website, I
care more about easily updating.)

### Install script setup

Use the `update-website` command which automates cloning both repos together and
cleaning them up afterwards. It's included in the distribution.

### Bootstrap

Here's how to bootstrap it in any NixOS instance.
```sh
nix-shell -p curl bash git mktemp
```
And then in the nix-shell:
```sh
curl https://raw.githubusercontent.com/zkwinkle/website-server/main/update-website/update-website > bootstrap.sh
./bootstrap.sh
```

Piping the script into bash doesn't work (IDK why).
