{ ... }: {

    imports = [        
        ./zsh.nix           # zsh shell configuration, including setting up the shell environment and options
        ./utils             # utility functions and common configurations split into utils/ features
        ./direnv.nix        # direnv integration, which allows for automatic loading of environment variables based on the current directory
        ./git.nix           # git integration in the shell
        ./starship.nix      # setting up the starship prompt
        ./nix-ld.nix        # setting up LD_LIBRARY_PATH for dynamically linked applications
    ];
}
