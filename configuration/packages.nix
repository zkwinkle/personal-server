{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      vim
      git
      inetutils
      mtr
      sysstat
      website
      update-website
    ];
  };
}
