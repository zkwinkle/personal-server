# Misc configurations
{
  time.timeZone = "America/Costa_Rica";

  # Allow flakes permanently
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.user = {
    isNormalUser = true;
    home = "/home/user";
    description = "Non-root default user";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBwxMMvXmcV91sgDwLTO+la5zKsMAKPkFSPKyqBaiGUT igna@waterfall" ];
  };
}
