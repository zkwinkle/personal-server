# NixOS server for my [website](https://github.com/zkwinkle/website)

My personal reproducible NixOS server.

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
First, create a nix-shell with the required packages:
```sh
nix-shell -p curl bash git mktemp
```
And then in the nix-shell run the following commands:
```sh
curl https://raw.githubusercontent.com/zkwinkle/website-server/main/update-website/update-website > bootstrap.sh
# Although omitted, highly recommend to inspect the script's contents
./bootstrap.sh
```

Piping the script into bash doesn't work (IDK why).

## SSH Setup

SSH password login is disabled, so a public key authentication is required.

Either use an existing key or create a new one:

```sh
ssh-keygen 0t ed25519 -a 100 -f ~/.ssh/website-server
```

Then add the public key to the user's authorized keys list in `configuration.nix`.

To connect you'll need to specify which file to use
```sh
ssh -i ~/.ssh/website-server user@198.74.54.85
```

To make the SSH client automatically use the key file, we add this to `/home/<user>/.ssh/config`:

```
Host website-server
  HostName 198.74.54.85
  User user

  IdentitiesOnly yes
  IdentityFile ~/.ssh/website-server
```

With this just running `ssh website-server` should let you through.

## Deploy

With the system and ssh config up and running the following command will update
the OS and pull in any new changes to the website:

```sh
ssh website-server -t update-website
```
