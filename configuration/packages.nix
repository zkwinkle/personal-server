{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      vim
      git
      inetutils
      mtr
      sysstat
      personal-website
    ];
  };
}
