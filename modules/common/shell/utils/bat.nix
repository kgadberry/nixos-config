{ pkgs, ... }:

{
    # more stuff to make the shell pretty
    programs.bat = {
        enable = true;
        config = {
            pager = "less -R";
            theme = "Catppuccin Mocha";
        };
    };

    # use bat as pager for git diff
    programs.git.settings.pager.diff = "bat --diff";

    # shadow tail and pipe it into bat for log highlighting
    programs.zsh.initContent = ''
        tail() {
            command tail "$@" | bat --paging=never -l log --plain
        }
    '';

    shellAliases = {
        cat = "bat";
        catp = "bat --plain";
        rg = "batgrep";
    };

    # use bat as pager for everything else
    sessionVariables = {
        MANPAGER = "bat -plman";
        PAGER = "bat -plman";
    };

    # https://github.com/eth-p/bat-extras/blob/master/README.md
    packages = with pkgs; [
        bat-extras.batgrep
        bat-extras.prettybat
    ];
}
