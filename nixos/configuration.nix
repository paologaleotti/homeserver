{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  ## Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ## Networking
  networking.hostName = "crispy-svr";
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [ 9090 8080 9000 3000 ];
  networking.firewall.allowedUDPPorts = [ 41641 ];
  networking.firewall.enable = false;

  ## Locale settings
  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  ## Users
  users.users.paolo = {
    isNormalUser = true;
    description = "paolo";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  ## Services
  services.openssh.enable = true;
  services.tailscale.enable = true; # VPN

  virtualisation.docker.enable = true;

  services.cockpit = {
    enable = true;
    port = 9090;
    settings = {
      WebService = {
        AllowUnencrypted = true;
     };
   };
  };

  ## Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    btop
    htop
    tmux
    neofetch
    cockpit
    gh
  ];

  programs.nix-ld.enable = true;

  # Intel graphics drivers

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = { # hardware.opengl in 24.05
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiVdpau
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      intel-media-sdk # QSV up to 11th gen
    ];
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Optionally, set the environment variable



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
