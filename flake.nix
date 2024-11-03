{
  inputs = {
    personal-website.url = "github:zkwinkle/website";
    uwgpu.url = "github:zkwinkle/uwgpu";
  };

  outputs = { self, nixpkgs, personal-website, uwgpu }:
  let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    overlays = [
      (
        final: prev: {
          inherit personal-website;
          uwgpu-server = uwgpu.web-server;
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
