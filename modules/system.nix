{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Asia/Bangkok";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableAllFirmware = true;
  hardware.firmware = with pkgs; [
    linux-firmware
    sof-firmware
    iwlwifi-mvm-firmware
  ];

  boot.kernelModules = [ "iwlwifi" ];
  fileSystems."/" = {
    device = "/dev/nvme0n1p3";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/nvme0n1p2"; }
  ];
  networking.hostName = "nixxs";
  networking.networkmanager.enable = true;

# Audio: Pipewire + Pulse
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };
# Display manager: SDDM
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";

  # Hyprland WM
  programs.hyprland.enable = true;

  # Shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts noto-fonts-cjk noto-fonts-emoji
    font-awesome
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Environment variables for Wayland
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  services.openssh.enable = true;
  environment.systemPackages = with pkgs; [
     git curl wget unzip btop htop neovim
     starship
     xwayland xdg-utils
 
     # Wayland tools
     swww waybar rofi-wayland wl-clipboard
     grim slurp swappy mako
 
     # Audio
     pavucontrol helvum
 
     # Terminal
     kitty
   ];


}

