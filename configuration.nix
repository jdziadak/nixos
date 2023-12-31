# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #boot.kernelParams = ["nomodeset"]; #VM
  networking.hostName = "fujibook"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8";
  #console = {
  #  font = "Lat2-Terminus16";
  #  keyMap = "pl";
  #  useXkbConfig = true; # use xkbOptions in tty.
  #};

  # VM
  #virtualisation.hypervGuest.enable = true;
  #virtualisation.hypervGuest.videoMode = "1024x768";
  
  # Enable the X11 windowing system.
  services.xserver = {
      enable = true;
      excludePackages = with pkgs; [
        xterm
      ];
      displayManager = {
        lightdm = {
          enable = true;
          greeters.slick = {
            enable = true;
            theme.name = "Zukitre-dark";
          };
        };
	defaultSession = "xfce";
      };
      desktopManager.xfce.enable = true;
    };


  # Configure keymap in X11
  services.xserver.layout = "pl";
  services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  #audio
  security.rtkit.enable = true;
  services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;
};


  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kuba = {
    isNormalUser = true;
    extraGroups = [ "video" "wheel" "input" "disk" "network" "podman" "networkmanager"]; # Enable ‘sudo’ for the user.
    createHome = true;
    uid = 1000;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     # ---- SYSTEM ----
    curl                       # > self
    tree                       # > self
    wget                       # > self
    gnugrep                    # > self
    util-linux                 # > self
    bat                        # > better ls
    bash
    kitty
    # ---- DE ----
    xclip
    xcolor
    xcolor
    xdo 
    xdotool
    xfce.catfish
    xfce.gigolo
    xfce.orage
    xfce.xfburn
    xfce.xfce4-appfinder
    xfce.xfce4-clipman-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-dict
    xfce.xfce4-fsguard-plugin
    xfce.xfce4-genmon-plugin
    xfce.xfce4-netload-plugin
    xfce.xfce4-panel
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-systemload-plugin
    xfce.xfce4-weather-plugin
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-xkb-plugin
    xfce.xfdashboard
    xorg.xev
    xorg.xinit
    xsel
    xtitle
    xwinmosaic
    xorg.xf86videointel
    # ---- EDITOR ----
    emacs                      # > editor
    pkgs.emacsPackages.doom
    # ---- TOOLS ----
    gh                         #  > github cli
    git                        #  > git
    podman                     # \
    podman-tui                 #  > pods/containers
    podman-desktop             # /
    tmux
    # ---- UTILITIES ----
    firefox                    #  > browser
    thunderbird                #  > mail client
    libreoffice-qt             # \
    hunspell                   #  >libreoffice
    hunspellDicts.pl_PL        # /
    # ---- DEV ----
    python3Full
    go
    gopls
    nodePackages_latest.pyright
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  # export services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
