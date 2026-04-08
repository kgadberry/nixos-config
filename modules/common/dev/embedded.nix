{ config, pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
        gcc-arm-embedded
        dfu-util
        stm32flash
    ];

    # udev rule for STM32
    services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0664", GROUP="plugdev"
    '';

    users.groups.plugdev = {};
    users.users.${config.user}.extraGroups = [ "plugdev" ];
}
