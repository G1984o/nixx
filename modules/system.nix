{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Asia/Bangkok";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    git curl wget vim neovim
    foot wayland-utils
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  services.xserver.enable = false;
}

