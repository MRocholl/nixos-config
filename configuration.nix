# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-stable,  inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "mem_sleep_default=deep"
  ];
  services.thermald.enable = true;
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };


  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.



  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  virtualisation.containers.enable = true;


  virtualisation.docker.enable = true;

  virtualisation = {
    podman = {
      enable = true;

      # # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # virtualisation.lxd.enable = true;
  # users.users.srid.group = "srid";
  # users.groups.srid = {};
  # users.users.srid = {
  #   isNormalUser = true;
  #   extraGroups = [ "lxd" ];
  # };

  programs.steam = {
    enable = true;
  };
 
  # Start the driver at boot
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };


	# Modmap for single key rebinds
  services.xremap.config.modmap = [
    {
      name = "Global";
      remap = { "CapsLock" = "Esc"; }; # globally remap CapsLock to Esc
    }
  ];
  
  # Install the driver
  services.fprintd.enable = true;
  # services.fprintd.package = pkgs-stable.libfprint;
  # If simply enabling fprintd is not enough, try enabling fprintd.tod...
  services.fprintd.tod.enable = true;
  # ...and use one of the next four drivers
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix; # Goodix driver module
 
  services.logind = {
  	lidSwitch = "suspend";
	  extraConfig = ''
      HandlePowerKey=suspend
      HandleLidSwitch=suspend
      HandleLidSwitchExternalPower=suspend
    '';  
 };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.

  services.displayManager.gdm.enable = true;
  
  services.desktopManager.gnome.enable = true;


  services.xserver.displayManager.sessionCommands = ''
 	${pkgs.xorg.xset}/bin/xset r rate 530 200 
  '';


  programs.dconf.profiles.gdm.databases = [{
      settings."org/gnome/settings-daemon/plugins/power" = {
        power-button-action = "suspend";
      };
    }];


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
    options = "caps:escape";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;


  security.apparmor = {
    enable = true;
  };

  # Enable sound with pipewire.
  # services.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;



    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # services.pipewire.extraConfig.pipewire."92-scarlett" = {
  #   "context.modules" = [
  #     {
  #       name = "libpipewire-module-rt";
  #       args = {
  #         "nice.level" = -15;
  #         "rt.prio" = 88;
  #         "rt.time.soft" = 200000;
  #         "rt.time.hard" = 200000;
  #       };
  #       flags = [ "ifexists" "nofail" ];
  #     }
  #   ];
  #   "context.properties" = {
  #     "default.clock.rate" = 48000;
  #     "default.clock.quantum" = 1024;
  #     "default.clock.min-quantum" = 1024;
  #     "default.clock.max-quantum" = 1024;
  #   };
  #   "stream.properties" = {
  #     "node.latency" = "1024/48000";
  #     "resample.quality" = 1;
  #   };
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.moritz = {
    isNormalUser = true;
    description = "moritz";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  programs.nix-ld.enable = true;
  programs.git.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
  	enable = true;
	polkitPolicyOwners = ["moritz"];
	};

  programs.gnupg = {
  	package = pkgs.gnupg;
  };

  programs.gnupg.agent  = {
	enable = true;
	pinentryPackage = pkgs.pinentry-curses;
	enableSSHSupport = true;
  };

  programs.zsh.enable = true;

  # programs.kitty.enable = true;
  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  # };

  # Install firefox.
  programs.firefox.enable = true;

  programs.neovim = { 
  	enable = true;
    package = inputs.neovim-nightly.packages."${pkgs.system}".default;
	  defaultEditor = true;
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  #

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     # neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # Prolangs
    pkgs.lua
    pkgs.python312Packages.pip
    pkgs.python312
    pkgs.python310
    pkgs.python311
    pkgs.python312Full
    pkgs.python313
    pkgs.nodejs_22
    pkgs.go
    
    # Package manager
    pkgs.devbox

    # Networing
    pkgs.openvpn
    pkgs.openresolv

    pkgs.zsh
    pkgs.bash
    pkgs.carapace

    # Sound and Music
    pkgs.pipewire
    
    # Container related
    pkgs.podman
    pkgs.podman-compose # start group of containers for dev
    pkgs.podman-desktop 
    pkgs.buildkit
    pkgs.buildah


    pkgs.xdg-desktop-portal-gnome

    pkgs.lshw
    pkgs.gnumake
    pkgs.gcc
    pkgs.cmake


];

  fonts.packages =  builtins.filter pkgs.lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions. programs.mtr.enable = true; programs.gnupg.agent = { enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  hardware.bluetooth.enable = true;
  hardware.graphics = {
  	enable = true;
	  extraPackages = with pkgs; [
	  vpl-gpu-rt
    intel-media-driver
    mesa

    # EGL-specific packages
    libglvnd  # Provides the OpenGL/EGL implementation
    
	];
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver
}
