{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      vim
      git
      inetutils
      mtr
      sysstat
			sqlx-cli
      personal-website
      uwgpu-server
    ];
  };
}
