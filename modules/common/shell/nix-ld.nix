{ config, pkgs, lib, ... }:

{
    # Needed to run dynamically linked applications (like vscode server and numpy)        
    programs.nix-ld.enable = true;
    
    home-manager.users.${config.user} = {

        # Caution: This can cause issues with some applications that expect a different LD_LIBRARY_PATH, 
        # but is needed for python modules with native extensions (like numpy) to work
        programs.zsh.initExtra = ''
            # Prefer system libraries by default to avoid incompatible lib versions
            # (e.g. libmount MOUNT_2_40 conflicts). Append nix-ld libs so system
            # libraries remain first for tools like gradle.
            if [ -n "$NIX_LD_LIBRARY_PATH" ]; then
              export LD_LIBRARY_PATH="$${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$NIX_LD_LIBRARY_PATH"
            fi

            # Helper to run a command with nix-ld libs first when needed (VS Code / python native modules)
            nixld-run() {
              env LD_LIBRARY_PATH="$NIX_LD_LIBRARY_PATH$${LD_LIBRARY_PATH:+:}$LD_LIBRARY_PATH" "$@"
            }
            # optional convenience wrapper for gradle if you need nix-ld first
            gradle-nixld() { nixld-run gradle "$@"; }
        ''; 
    };
}