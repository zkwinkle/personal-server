{ pkgs, ... }: {
  config = {

    networking = {
      usePredictableInterfaceNames = false;
      firewall.allowedTCPPorts = [ 22 31415 ]; # SSH & website
      hostName = "website-server";
      useDHCP = false;
      interfaces.eth0.useDHCP = true;
      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };

    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    systemd.services.website = {
      enable = true;
      description = "My own personal website";

      after = [ "network.target" "network-online.target" "nss-lookup.target" ];
      requires = [ "network.target" ];
      wants = [ "network-online.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.website}/bin/website";
        Type = "simple";
        Restart = "always";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
