{ config, pkgs, lib, ... }:

{
    # Needed to run dynamically linked applications (like vscode server and numpy)        
    programs.nix-ld.enable = true;
    
    home-manager.users.${config.user} = {

        # Caution: This can cause issues with some applications that expect a different LD_LIBRARY_PATH, 
        # but is needed for python modules with native extensions (like numpy) to work
        programs.zsh.initExtra = ''
            export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH:$LD_LIBRARY_PATH
        ''; 
    };
}