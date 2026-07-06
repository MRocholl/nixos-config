{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # Latest neovim
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    hunk = {
      url = "github:modem-dev/hunk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      neovim-nightly,
      hunk,
    }:
    let
      configuration =
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
          # services.sketchybar.enable = true;
          system.defaults.NSGlobalDomain._HIHideMenuBar = false;

          homebrew = {
            enable = true;
            brews = [
              "nvm"
              "protobuf"
              "java"
              "opencode"
              "watch"
            ];

            taps = [
              {
                name = "nikitabobko/tap";
                trusted = true;
              }
              {
                name = "leoafarias/fvm";
                trusted = true;
              }
              {
                name = "dart-lang/dart";
                trusted = true;
              }
            ];
            casks = [
              "1password-cli"
              "aerospace"
              "gcloud-cli"
              "sf-symbols"

              {
                name = "hammerspoon";
                greedy = true;
              }

              # {
              #   name = "ghostty";
              #   greedy = true;
              # }
            ];

          };
          fonts.packages = [
            pkgs.nerd-fonts.hack
            pkgs.nerd-fonts.jetbrains-mono
          ];

          nixpkgs.config.allowUnfree = true;
          environment.systemPackages = [
            inputs.neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.default

            # pkgs.bitwarden-desktop
            # pkgs.brave

            pkgs.ghostty-bin
            #
            pkgs.ffmpeg
            pkgs.lua
            pkgs.stylua
            pkgs.nodejs_24

            # pkgs.spotify

            pkgs.lefthook
            pkgs.postgresql_17
            pkgs.pgformatter
            pkgs.squawk
            # pkgs.sqlfluff
            pkgs.sqruff
            pkgs.lazysql

            pkgs.tldr

            pkgs.infracost

            pkgs.cocoapods
            pkgs.hcloud
            pkgs.google-cloud-sdk
            pkgs.shellcheck
            pkgs.terragrunt
            pkgs.slack

            pkgs.notion-app

            pkgs.gitlab-ci-ls
            pkgs.glab
            pkgs.cargo

            pkgs.zulu

            pkgs.devenv
            pkgs.mise
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
            pkgs.basedpyright

            # Data tools
            # pkgs.dbt
            # pkgs.parquet-tools

            # JS related packages
            pkgs.pnpm
            pkgs.bun
            pkgs.biome

            pkgs.buf

            pkgs.mimir
            pkgs.prometheus

            pkgs.devenv

            # other programming lanugages
            pkgs.go
            pkgs.gopls

            pkgs.ruby

            pkgs.pandoc
            pkgs.xlsx2csv
            pkgs.miller
            pkgs.mupdf-headless

            # k8s related cli tools
            pkgs.k9s
            pkgs.kubectl-cnpg
            pkgs.kustomize
            pkgs.kubie
            pkgs.kubectl
            pkgs.kubernetes-helm
            pkgs.argo-workflows
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
            pkgs.hasura-cli

            pkgs.dvc

            # S3 and cloud CLIs
            pkgs.s3cmd
            pkgs.awscli2
            pkgs.stackit-cli
            pkgs.stu
            pkgs.rclone

            # IaC tools
            # pkgs.opentofu
            pkgs.terraform

            # pkgs.opencode

            # Security related tools
            pkgs.pass
            pkgs.teller
            # pkgs.vault
            # pkgs.libfido2
            # pkgs.apacheHttpd
            pkgs.openssl
            pkgs.nixfmt
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

            pkgs.delta # pager for git

            pkgs.git
            pkgs.lazygit
            pkgs.tree-sitter
            pkgs.tokei
            pkgs.stow
            pkgs.eza
            pkgs.carapace
            pkgs.tree
            pkgs.umoci
            pkgs.direnv
            pkgs.jq
            pkgs.jqp
            pkgs.gron
            pkgs.yq-go
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
            pkgs.grex

            pkgs.lazydocker
            pkgs.tilt
            
            pkgs.texliveSmall
            pkgs.renovate

            # pkgs.eslint
            #
            pkgs.markdownlint-cli2

            # pkgs.cspell
            pkgs.firebase-tools
            pkgs.viu
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";
          nix.enable = false;

          # Enable alternative shell support in nix-darwin.
          programs.zsh.enable = true;
          programs.direnv.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Moritzs-MacBook-Air
      darwinConfigurations."Moritzs-MacBook-Air" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };
      darwinConfigurations."Moritzs-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };
      darwinConfigurations."Moritzs-MacBook-Pro-2" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };
    };
}
