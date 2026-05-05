# direnv integration — automatically loads environment variables based on the current directory
{ config, ... }: {

    home-manager.users.${config.user}.programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        config = { whitelist = { prefix = [ config.dotfilesPath ]; }; };
    };

    # Prevent garbage collection
    nix.extraOptions = ''
        keep-outputs = true
        keep-derivations = true
    '';

}