{ ... }: {

    imports = [        
        ./zsh.nix       # zsh shell configuration, including setting up the shell environment and options
        ./utils.nix     # utility functions and common configurations used in the shell setup
        ./direnv.nix    # direnv integration, which allows for automatic loading of environment variables based on the current directory
        ./charm.nix     # charm shell integration, which provides a better shell experience
        ./git.nix       # git integration in the shell
        ./starship.nix  # setting up the starship prompt
        ./nix-ld.nix    # setting up LD_LIBRARY_PATH for dynamically linked applications
    ];
}