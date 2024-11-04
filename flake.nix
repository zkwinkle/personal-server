{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";

    crane.url = "github:ipetkov/crane";
    flake-utils.url = "github:numtide/flake-utils";

    website = {
      url = "github:zkwinkle/website";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.crane.follows = "crane";
      inputs.flake-utils.follows = "flake-utils";
    };

    uwgpu = {
      url = "github:zkwinkle/uwgpu";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.crane.follows = "crane";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { nixpkgs, website, uwgpu, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (
            final: prev: {
              uwgpu-server = uwgpu.packages.${prev.system}.web-server;
              personal-website = website.packages.${prev.system}.default;
            }
          )
        ];
      };
    in
    {
      nixosConfigurations.personal-server = nixpkgs.lib.nixosSystem {
        inherit pkgs system;
        modules = [ ./configuration ];
      };
    };
}
