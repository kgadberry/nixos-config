{ config, pkgs, lib, ... }: 
{
    config = lib.mkIf (pkgs.stdenv.isLinux && config.wsl.enable) {
        # Copy the vscode server env setup file if in WSL
        system.activationScripts.vscodeSetup = {
            text = ''
                mkdir -p $HOME/.vscode-server
                cp ${config.dotfilesPath}/resources/vscode_server-env-setup $HOME/.vscode-server/server-env-setup
                echo "Added vscode server env setup file to WSL" >> $HOME/.vscode-server/server-env-setup.log"
            '';
            # Depends on configDir to ensure the dotfilesPath is available
            deps = [ "configDir" ];
        };
    };
}