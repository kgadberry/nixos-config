{ pkgs }:

pkgs.mkShell {
    name = "dev";
    description = "General development environment (C++)";

    buildInputs = with pkgs; [
        # Core toolchain and build tools
        gcc
        gdb
        cmake
        gnumake
        pkg-config

        # Embedded and USB development
        libusb1
        pico-sdk

        # General utilities
        binutils
        file
    ];

    shellHook = ''
        echo "Development Environment"
        echo ""
        export PICO_SDK_PATH="${pkgs.pico-sdk}"
        echo "PICO_SDK_PATH set to: $PICO_SDK_PATH"
    '';
}