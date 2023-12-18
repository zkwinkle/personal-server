{
  config.boot = {

    # Enable LISH
    kernelParams = [ "console=ttyS0,19200n8" ];

    loader = {
      grub = {
				enable = true;
        extraConfig = ''
          serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
          terminal_input serial;
          terminal_output serial
        '';
        forceInstall = true;
        device = "nodev";
      };
      timeout = 10;
    };
  };
}
