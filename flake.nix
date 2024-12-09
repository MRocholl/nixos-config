{
  description = "Moritz NixOS";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Latest neovim
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
	
    # Add xremap flake required to map capslock to escape
    xremap-flake.url = "github:xremap/nix-flake";

  };

  outputs = inputs@{
    self,
    nixpkgs,
    ...
  }: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
    	system = "x86_64-linux";

 	# Set all inputs parameters as special arguments for all submodules,
        # so you can directly use all dependencies in inputs in submodules
        specialArgs = {
	  inherit inputs;
	  # pkgs-unstable = import nixpkgs-unstable {
	  #   inherit system;
	  #   config.allowUnfree = true;
	  # };
	};

    	modules = [

    	inputs.xremap-flake.nixosModules.default
	./configuration.nix

	];
    };
  };
}
