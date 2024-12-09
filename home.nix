{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "moritz";
  home.homeDirectory = "/home/moritz";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

    pkgs.lua

    # Python related packages
    pkgs.pipx
    pkgs.uv
    pkgs.poetry
        
    # Python LSP
    pkgs.ruff
    pkgs.pyright

    # Data tools
    pkgs.dbt
    pkgs.parquet-tools


    # JS related packages
    pkgs.pnpm
    pkgs.vite
    pkgs.biome
	

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
    pkgs.kcl
    pkgs.cmctl
    pkgs.kind
  
    
    # Database management stuff
    pkgs.atlas
    pkgs.duckdb
    pkgs.postgresql_16
    pkgs.sqlfluff
    pkgs.gdal

    # S3 and cloud CLIs
    pkgs.s3cmd
    pkgs.awscli2
    pkgs.stackit-cli
  
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
  
    # Network related tools
    pkgs.httpie
    pkgs.wget
    pkgs.dig
    pkgs.netcat
    pkgs.protonvpn-gui


    # Shell and Terminal
    pkgs.zsh
    pkgs.kitty
    pkgs.zellij
    pkgs.fortune
    
    # Common tools
    pkgs.neofetch
    pkgs.atuin

    pkgs.git
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
    pkgs.lf

    # Archives
    pkgs.xclip
    pkgs.unzip

    # Markdown readers
    pkgs.glow
    pkgs.mdcat
    
    # Image related 
    pkgs.graphviz
    pkgs.nsxiv
    
    # Screen
    pkgs.arandr
    
    # Graphics tools
    pkgs.vulkan-tools

    # Browser
    pkgs.brave
    pkgs.ungoogled-chromium
    

    # Container and oci
    pkgs.hadolint
    pkgs.rakkess
    pkgs.skopeo
    pkgs.buildpack
    pkgs.trivy
    pkgs.syft

    pkgs.dive # look into docker image layers
    pkgs.podman-tui # status of containers in the terminal
    
    # Package manager
    pkgs.cargo
    pkgs.meson
    pkgs.ninja

    
    # Sound and Music
    pkgs.spotify
    pkgs.ffmpeg
    
    # Social and Messenging
    pkgs.slack
    pkgs.signal-desktop
    pkgs.telegram-desktop
    
    # Office
    pkgs.thunderbird
    pkgs.libreoffice
    pkgs.xournal
    pkgs.texliveFull
    pkgs.pandoc
    pkgs.python312Packages.weasyprint

    # LLM related
    pkgs.ollama












  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/moritz/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
