{ config, pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
        # Compilers and build tools
        gcc
        gnat
        gnumake
        cmake
        gdb
        pkg-config
        
        # C++ development libraries
        libcxx
        
        # Embedded development
        libusb1
        pico-sdk
        
        # Additional development tools
        binutils
        file
    ];
}
