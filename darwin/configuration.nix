{ pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  environment.variables = {
    EDITOR = "nvim";
  };

  system.primaryUser = "mrocholl";

  security.pam.services.sudo_local.touchIdAuth = true;
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;

  };
  # services.aerospace.enable = true;
  services.sketchybar.enable = true;

  homebrew = {
    enable = true;

    taps = [
      "nikitabobko/tap"
    ];
    casks = [
      "1password-cli"
      "aerospace"

      {
        name = "hammerspoon";
        greedy = true;
      }

      {
        name = "ghostty";
        greedy = true;
      }
    ];

  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
    pkgs.neovim

    # ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
    #

    pkgs.lua
    pkgs.nodejs_24

    pkgs.zoxide

    pkgs.lua
    pkgs.python313
    pkgs.nodejs_22
    pkgs.go

    pkgs.container

    pkgs.graphviz

    pkgs.mutt
    pkgs.fortune-kind

    pkgs.gnumake
    pkgs.gcc
    pkgs.cmake

    # Python related packages
    pkgs.pipx
    pkgs.uv
    pkgs.poetry

    # Python LSP
    pkgs.ruff
    pkgs.pyright

    # Data tools
    # pkgs.dbt
    pkgs.parquet-tools

    # JS related packages
    pkgs.pnpm
    pkgs.biome

    pkgs.mimir
    pkgs.prometheus

    pkgs.devenv

    # other programming lanugages
    pkgs.go
    pkgs.gopls

    pkgs.ruby

    # k8s related cli tools
    pkgs.k9s
    pkgs.kubectl-cnpg
    pkgs.kustomize
    pkgs.kubie
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.argo
    pkgs.argocd
    # pkgs.kcl
    pkgs.cmctl
    pkgs.kind
    pkgs.ctlptl
    pkgs.kubebuilder
    pkgs.gnused
    pkgs.openfga-cli
    pkgs.openfga
    pkgs.go-task

    # Database management stuff
    # pkgs.atlas

    # S3 and cloud CLIs
    pkgs.s3cmd
    pkgs.awscli2
    pkgs.stackit-cli
    pkgs.stu
    pkgs.rclone

    # IaC tools
    pkgs.opentofu
    pkgs.terraform

    # Security related tools
    pkgs.pass
    pkgs.teller
    pkgs.vault
    pkgs.libfido2
    pkgs.apacheHttpd
    pkgs.openssl
    pkgs.nixfmt-rfc-style
    # Network related tools
    pkgs.httpie
    pkgs.wget
    pkgs.dig
    pkgs.netcat

    # Shell and Terminal
    pkgs.zsh
    pkgs.zellij
    pkgs.tmux
    pkgs.fortune

    # Common tools
    pkgs.fastfetch
    pkgs.atuin

    pkgs.git
    pkgs.lazygit
    pkgs.tree-sitter
    pkgs.tokei
    pkgs.stow
    pkgs.eza
    pkgs.tree
    pkgs.umoci
    pkgs.direnv
    pkgs.jq
    pkgs.yq
    pkgs.gh
    pkgs.btop
    pkgs.bat
    pkgs.ripgrep
    pkgs.fzf
    pkgs.fd
    pkgs.parallel
    pkgs.findutils
    pkgs.file
    pkgs.lf

  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  nix.enable = false;

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
