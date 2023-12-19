#! /usr/bin/env nix-shell
#! nix-shell -i bash
#! nix-shell -p bash git mktemp

TMPDIR=$(mktemp -d)
trap "rm -rf \"$TMPDIR\"" EXIT

git clone https://github.com/zkwinkle/website-server.git "$TMPDIR"
git clone https://github.com/zkwinkle/website.git "${TMPDIR}/website"
sudo nixos-rebuild switch --flake "${TMPDIR}#website-server"
