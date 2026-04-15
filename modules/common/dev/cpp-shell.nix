{ pkgs }:

pkgs.mkShell {
    name = "cpp-dev";
    description = "C++ development environment with libusb1 and pico-sdk";
    buildInputs = with pkgs; [
        # Compilers and build tools
        gcc
        gdb
        cmake
        gnumake
        pkg-config
        
        # C++ development
        libcxx
        
        # USB and embedded development
        libusb1
        pico-sdk
        
        # Additional tools
        binutils
        file
    ];

    shellHook = ''
        echo "C++ Development Environment"
        echo "Tools available:"
        echo "  - GCC compiler"
        echo "  - CMake build system"
        echo "  - GDB debugger"
        echo "  - libusb1 - USB device access"
        echo "  - pico-sdk - Raspberry Pi Pico development"
        echo ""
        # Set PICO_SDK_PATH for convenient access
        export PICO_SDK_PATH="${pkgs.pico-sdk}"
        echo "PICO_SDK_PATH set to: $PICO_SDK_PATH"
    '';
}
