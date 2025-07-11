{ config, pkgs, ... }:

{
  home.username = "walden";
  home.homeDirectory = "/home/walden";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    neofetch
    unzip
    htop
    starship
  ];

  programs.starship.enable = true;
  programs.zsh.enable = true;

  home.file.".config/hypr/hyprland.conf".text = ''
    monitor=,preferred,auto,1
    exec-once=swww init && swww img /home/walden/wall.png
    exec-once=waybar
    bind=SUPER,Return,exec,kitty
    bind=SUPER,Q,killactive
    bind=SUPER,D,exec,rofi -show drun
    bind=SUPER,F,fullscreen
  '';

  home.file.".config/waybar/config".text = ''
    {
      "layer": "top",
      "modules-left": ["clock"],
      "modules-right": ["battery", "network"]
    }
  '';

  home.file.".config/waybar/style.css".text = ''
    * {
      font-family: "Noto Sans", sans-serif;
      font-size: 13px;
    }
  '';
}

