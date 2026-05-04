{ config, pkgs, ... }:

let

    ignorePatterns = ''
        !.env*
        !.github/
        !.gitignore
        !*.tfvars
        .terraform/
        .target/
        /Library/'';

in {

    config = {

        home-manager.users.${config.user} = {

            home.packages = with pkgs; [
                age         # Encryption
                bc          # Calculator
                dig         # DNS lookup
                fd          # find
                htop        # Show system processes
                inetutils   # Includes telnet, whois
                jq          # JSON manipulation
                lf          # File viewer
                qrencode    # Generate qr codes
                rsync       # Copy folders
                ripgrep     # grep
                sd          # sed
                tealdeer    # Cheatsheets
                tree        # View directory hierarchy
                zip         # Create zips
                unzip       # Extract zips
                broot       # TUI file manager
                neofetch    # System info
                wget        # Download files
                mc          # Better than termscp
                dos2unix    # Convert line endings
                usbutils    # For lsusb, etc
                nmap        # Network exploration
                tcpdump     # Packet sniffer
                openssl     # Cryptographic tools
                libargon2   # argon2 hash tool
                opentofu    # Terraform-compatible
                pwgen	    # Password generator
            ];

            programs.zoxide.enable = true; # Shortcut jump command

            home.file = {
                ".rgignore".text = ignorePatterns;
                ".fdignore".text = ignorePatterns;
                ".digrc".text = "+noall +answer"; # Cleaner dig commands
            };

            programs.bat = {
                enable = true; # cat replacement
                config = {
                    pager = "less -R"; # Don't auto-exit if one screen
                };
            };

            programs.eza = {
                enable = true; # ls replacement
            };
        };

    };

}
