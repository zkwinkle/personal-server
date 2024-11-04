{ pkgs, ... }: {
  config = {

    networking = {
      usePredictableInterfaceNames = false;
      firewall.allowedTCPPorts = [
        80 # http
        443 # https
        22 # SSH
      ];
      hostName = "personal-server";
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
        forceSSL = true;
        enableACME = true;
        root = "/var/www/zkwinkle.is-a.dev";
        locations."/" = {
          proxyPass = "http://0.0.0.0:31415";
          proxyWebsockets = true;
        };
        locations."/uwgpu/" = {
          proxyPass = "http://0.0.0.0:31416/";
          proxyWebsockets = true;
        };
      };
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "ignaevc@gmail.com";
    };

    systemd.services.website = {
      enable = true;
      description = "My own personal website";

      after = [ "network.target" "network-online.target" "nss-lookup.target" ];
      requires = [ "network.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.personal-website}/bin/website";
        Type = "simple";
        Restart = "always";
        RestartSec = 10;
      };

      environment = {
        PUBLIC_DIR = "${pkgs.personal-website}/public";
      };
    };

    services.postgresql = {
      enable = true;
      ensureDatabases = [ "uwgpu" ];
      ensureUsers = [
        {
          name = "uwgpu";
          ensureDBOwnership = true;
        }
      ];
      enableTCPIP = true;
      authentication = ''
                # TYPE  DATABASE  USER   ADDRESS        METHOD
                local   uwgpu     uwgpu                 peer
        				# ipv4 / ipv6
        				host    uwgpu     uwgpu  localhost      trust
      '';
    };

    systemd.services.uwgpu-server = {
      enable = true;
      description = "Server for µwgpu website.";

      after = [ "network.target" "network-online.target" "nss-lookup.target" ];
      requires = [ "network.target" ];
      wants = [ "network-online.target" ];

      serviceConfig = {
        ExecStartPre = ''${pkgs.sqlx-cli}/bin/sqlx migrate run --source "${pkgs.uwgpu-server}/migrations" --database-url "postgres://uwgpu@localhost/uwgpu"'';
        ExecStart = "${pkgs.uwgpu-server}/bin/web-server";
        Type = "simple";
        Restart = "always";
        RestartSec = 10;
        User = "uwgpu";
      };
      wantedBy = [ "multi-user.target" ];

      environment = {
        PUBLIC_DIR = "${pkgs.uwgpu-server}/public";
        DATABASE_URL = "postgres://uwgpu@localhost/uwgpu";
        SERVER_URL = "https://zkwinkle.is-a.dev/uwgpu";
      };
    };
  };
}
