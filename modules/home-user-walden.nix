{ config, pkgs, ... }:

{
  home.username = "walden";
  home.homeDirectory = "/home/walden";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    neofetch
    unzip
    htop
    starship
  ];

 # CLI & Shell
  programs.fish.enable = true;
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  home.file.".config/hypr/hyprland.conf".text = ''
    monitor=,preferred,auto,1
    exec-once=swww init && swww img /home/walden/wall.png
    exec-once=waybar &
    exec-once=mako &

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
  
  # Notification daemon
  services.mako.enable = true;

  home.packages = with pkgs; [
    rofi-wayland
    nautilus
  ];
}

