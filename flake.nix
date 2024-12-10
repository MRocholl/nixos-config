{
  description = "Moritz NixOS";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Latest neovim
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
	
    # Add xremap flake required to map capslock to escape
    xremap-flake.url = "github:xremap/nix-flake";

    # Add home-manager
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };


    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    hyprland,
    ...
  }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      # Set all inputs parameters as special arguments for all submodules,
      # so you can directly use all dependencies in inputs in submodules
      specialArgs = {
        inherit inputs;
	    };
    	modules = [
        inputs.xremap-flake.nixosModules.default
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = { inherit inputs; }; 
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.moritz = import ./home.nix;
        }
	    ];
    };
  };
}
