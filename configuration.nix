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
  networking.wireless.enable = true;

  # Internationalisation
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # User
  users.users.nikki = {
    isNormalUser = true;
    name = "nikki";
    home = "/home/nikki";
    description = "Nikhilesh Sigatapu";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
    createHome = true;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    acpi

    wget vim

    xorg.xdpyinfo xorg.xbacklight xclip

    lastpass-cli htop

    ranger

    scrot feh

    #((import <nixos-unstable> {}).luakit.overrideAttrs ({ buildInputs, ... }: { buildInputs = buildInputs ++ [ glib-networking ]; }))
    surf dmenu

    git
    ripgrep

    emacs

    love
  ];

  # Show manual in Ctrl+Alt+F8
  services.nixosManual.showManual = true;

  # Bash
  programs.bash.enableCompletion = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # X
  services.xserver = {
    enable = true;

    layout = "us";
    xkbOptions = "eurosign:e";
    libinput.enable = true;

    windowManager.awesome.enable = true;
  };

  # Fonts
  fonts.fonts = with pkgs; [
    meslo-lg
  ];

  # DPI
  services.xserver.dpi = 120;
  fonts.fontconfig.dpi = 120;

  # Trackpoint
  # hardware.trackpoint = {
  #   enable = true;
  #   sensitivity = 800;
  #   speed = 800;
  # };

  # Emacs
  services.emacs.enable = true;

  # NixOS release version
  system.stateVersion = "18.03";

}
