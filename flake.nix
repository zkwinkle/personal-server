{
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (import ./overlay.nix) ];
      };
    in
    {
      nixosConfigurations.website-server = nixpkgs.lib.nixosSystem {
        inherit pkgs system;
        modules = [ ./configuration ];
      };
    };
}
