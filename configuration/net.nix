{ pkgs, ... }: {
  config = {

    networking = {
      usePredictableInterfaceNames = false;
      firewall.allowedTCPPorts = [
        80 # http
        443 # https
        22 # SSH
      ];
      hostName = "website-server";
      useDHCP = false;
      interfaces.eth0.useDHCP = true;
    };

    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    services.nginx = {
      enable = true;

      recommendedGzipSettings = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedOptimisation = true;

      virtualHosts."zkwinkle.is-a.dev" = {
        listenAddresses = [
					"zkwinkle.is-a.dev"
        ];
        locations."/" = {
          proxyPass = "http://0.0.0.0:31415";
          proxyWebsockets = true;
        };
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
