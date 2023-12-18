# NixOS server for my [website](https://github.com/zkwinkle/website)

This repo contains the configuration files that I use in my NixOS server
to host my [website](https://github.com/zkwinkle/website-server).

## Cloning

```sh
git clone --recurse-submodules https://github.com/zkwinkle/website-server.git
```

## Loading configuration remotely

```sh
nixos-rebuild switch --flake github:zkwinkle/website-server
```
