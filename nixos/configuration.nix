{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  ## Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  ## Networking
  networking.hostName = "crispy-svr";
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [ ... ];
  networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;

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

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
  enable = true;
  setSocketVariable = true;
};

  ## Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    btop
    htop
    tmux
    neofetch
  ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
