{ config, pkgs, ... }:

{
  users.users.walden = {
    isNormalUser = true;
    description = "Walden";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  security.sudo.enable = true;
}

