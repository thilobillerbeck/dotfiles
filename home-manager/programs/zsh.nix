{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      pub-ipv4 = "curl ip4.clerie.de";
      serve = "python -m SimpleHTTPServer 8080";
      week = "date +%V";
      path = "echo -e \${PATH//:/\\n}";
      distro = "cat /etc/*-release";
      reload = "source ~/.zshrc";
      undo-git-reset-head = "git reset 'HEAD@{1}'";
      update-local = "bash $HOME/.dotfiles/install";
    };
    initExtra = ''
      export PATH=~/.npm-global/bin:$PATH
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    '';
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
  };
}
