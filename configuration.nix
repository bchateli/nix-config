# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      
      "${inputs.nixos-hardware}/framework/13-inch/common/audio.nix"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "framework"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Add flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Declutter nix-store
  nix.settings.auto-optimise-store = true;
  
  # Allow garbage collector
  nix.gc = {
	automatic = true;
	persistent = true;
	dates = "05:00:00";
	options = "--delete-older-than 7d";
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };


  # Configure xserver
  services.xserver = {
    #Enable the X11 windowing system
    enable = true;

    #Enable the GNOME DE
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    
    #Configure keymap
    xkb.layout = "fr";
    xkb.variant = "azerty";

  };

  #Enable autologin
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable fingerprint reader
  services.fprintd.enable = true;
 
  # Enable power saving services
  services.thermald.enable = false;
  services.power-profiles-daemon.enable = true;
  services.tlp.enable = false;

  # Enable Tailscale
  services.tailscale = {
  	enable = true;
	useRoutingFeatures = "client";
  };

  # Enable system-wide needed programs
  programs = {
	zsh.enable = true;
  };
  
  #Install fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];  
   
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.baptiste = {
    isNormalUser = true;
    description = "Baptiste";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
    packages = with pkgs; [
  
    ];
  };

  #home-manager
  home-manager = {
   #pass inputs
   extraSpecialArgs = { inherit inputs unstable;};
   users = {
	"baptiste" = import ./home.nix;
    };
  };  

  #Allows unfree
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     mlocate
     neofetch
     kitty
     thermald
     dig
     protonup
     docker-compose
])++(with unstable; [
     gnomeExtensions.another-window-session-manager 
 ]);
  
  # Add Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.sessionVariables = {
  	STEAM_EXTRA_COMPAT_TOOL_PATHS = "/home/user/.steam/root/compatibilitytools.d";
  };
  
  # Enable docker
  virtualisation.docker.enable = true;

  # Add env variable for unblurry vscode
  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };


  # Audio enhancements
  hardware.framework.laptop13.audioEnhancement = {
  	enable = true;
	rawDeviceName = "alsa_output.pci-0000_c1_00.6.analog-stereo";
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "23.11"; # Did you read the comment?

}
