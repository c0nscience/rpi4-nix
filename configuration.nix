{ config, pkgs, lib, ... }:

let
  user = "pi";
  password = "pix42";
  hostname = "pix";
in {
  imports = [
    ./hardware-configuration.nix
  ];

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
