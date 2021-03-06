# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nikki-nixos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false; # I serve things to my phone a lot...

  # Internationalisation
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Time zone
  time.timeZone = "America/Los_Angeles";
  #time.timeZone = "America/New_York";

  # User
  users.users.nikki = {
    isNormalUser = true;
    name = "nikki";
    home = "/home/nikki";
    description = "Nikhilesh Sigatapu";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "vboxusers" ];
    createHome = true;
  };

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget vim fzf unzip unrar

    acpi xorg.xbacklight xclip xsel

    dropbox-cli lastpass-cli config.services.samba.package

    htop ranger


    scrot peek feh mupdf simplescreenrecorder

    gimp aseprite


    firefox


    git ripgrep

    gdb ycmd python racket sbcl

    emacs


    steam
  ];

  # Bash
  programs.bash.enableCompletion = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # X
  services.xserver = {
    enable = true;

    layout = "us";
    xkbOptions = "eurosign:e";
    libinput.enable = true;

    displayManager.slim = {
      enable = true;
      theme = pkgs.fetchurl {
        url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
        sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
      };
    };

    windowManager.awesome.enable = true;
  };

  # Support 32-bit programs (such as Steam, Wine, ...)
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # Fonts
  fonts.fonts = with pkgs; [
    terminus_font fira-mono
  ];

  # DPI
  services.xserver.dpi = 120;
  fonts.fontconfig.dpi = 120;

  # Emacs
  services.emacs.enable = true;
  services.emacs.defaultEditor = true;

  # Firefox
  nixpkgs.config.firefox = {
    enableAdobeFlash = true;
    enableAdobeFlashDRM = true;
  };

  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  nixpkgs.config.virtualbox.enableExtensionPack = true;

  # Samba sharing
  services.samba = {
    enable = true;
    securityType = "user";
    shares = {
      Development = {
        path = "/home/nikki/Development";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no"; # Changed this after it last worked
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "nikki";
        # "force group" = "users";
      };
    };
  };

  # NixOS release version
  system.stateVersion = "18.03";

}
