{
  outputs = { self, nixpkgs }: {
    nixosConfigurations.website-server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}

