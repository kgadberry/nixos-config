{ pkgs, ... }:

{
    packages = with pkgs; [
        dig
    ];

    homeFiles.".digrc".text = "+noall +answer";
}
