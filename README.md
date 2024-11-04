# NixOS personal server

My personal reproducible NixOS server, for my own tinkering.

Currently hosting:
- [my personal website](https://github.com/zkwinkle/website)

## SSH Setup

SSH password login is disabled, so a public key authentication is required.

Either use an existing key or create a new one:

```sh
ssh-keygen -t ed25519 -a 100 -f ~/.ssh/personal-server
```

Then add the public key to the user's authorized keys list in `configuration.nix`.

To connect you'll need to specify which file to use
```sh
ssh -i ~/.ssh/personal-server user@198.74.54.85
```

To make the SSH client automatically use the key file, we add this to `/home/<user>/.ssh/config`:

```
Host personal-server
  HostName 198.74.54.85
  User user

  IdentitiesOnly yes
  IdentityFile ~/.ssh/personal-server
```

With this just running `ssh personal-server` should let you through.

## Deploy

With the system and ssh config up and running the following command will update
the OS and pull in any new changes from the master branch:

```sh
ssh personal-server -t sudo nixos-rebuild switch --flake "github:zkwinkle/personal-server#personal-server" --refresh
```
