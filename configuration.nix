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

  # Internationalisation
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Time zone
  #time.timeZone = "America/Los_Angeles";
  time.timeZone = "America/New_York";

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
    wget vim fzf unzip

    acpi xorg.xbacklight xclip xsel

    dropbox-cli lastpass-cli

    htop ranger


    scrot peek feh mupdf

    gimp aseprite


    firefox


    git ripgrep

    gdb ycmd python racket sbcl rustc cargo rustracer rustPlatform.rustcSrc

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

  # For Steam
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # NixOS release version
  system.stateVersion = "18.03";

}
