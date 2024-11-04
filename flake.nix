{
  inputs = {
    website.url = "github:zkwinkle/website";
    uwgpu.url = "github:zkwinkle/uwgpu";
  };

  outputs = { self, nixpkgs, website, uwgpu }:
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
