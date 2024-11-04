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

### SSH Root access

To allow root access to the server do the same setup but **make sure the ssh key
is password protected**.

```sh
ssh-keygen -t ed25519 -a 100 -f ~/.ssh/personal-server-root
```

```
Host personal-server-root
  HostName 198.74.54.85
  User root

  IdentitiesOnly yes
  IdentityFile ~/.ssh/personal-server-root
```

The reason root access is desired is to deploy with `nixos-rebuild` remotely,
being able to build the derivation locally.

## Deploy

With the system and ssh config up and running the following command will update
the OS and pull in any new changes from the master branch:

```sh
ssh personal-server -t sudo nixos-rebuild switch --flake "github:zkwinkle/personal-server#personal-server" --refresh
```

If root access is configured, it's possible to deploy without having to push to
the github repo and also being able to build locally:

```sh
nix-shell -p '(nixos{}).nixos-rebuild' # get nixos-rebuild in non-nixos system
nixos-rebuild switch --flake .#personal-server --target-host personal-server-root --use-remote-sudo --refresh
```

## DB

There's 1 configured PostgreSQL database, `uwgpu`. It's used by the µwgpu
server.

To access it:
```
sudo -u uwgpu psql -U uwgpu -d uwgpu
```
