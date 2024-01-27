{ config, pkgs, lib, ... }:

let
  user = "pi";
  password = "pix42";
  hostname = "pix";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ]

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
    git
    tig
  ];

  time.timeZone = "Europe/Berlin";

  services.openssh.enable = true;

  users = {
    users."${user}" = {
      isNormalUser = true;
      initialPassword = password;
      extraGroups = [ "wheel" "networkmanager" ];
      openssh = {
        authorizedKeys.keyFiles = [
          /etc/nixos/ssh/authorized_keys
        ];
      };
    };
  };

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.11";
}
