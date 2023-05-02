{ config, pkgs, lib, ... }:

{
  programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableVteIntegration = true;
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
      zplug = {
        enable = true;
        plugins = [
          {
            name = "plugins/git";
            tags = [ from:oh-my-zsh ];
          }
          {
            name = "plugins/archlinux";
            tags = [ from:oh-my-zsh ];
          }
          {
            name = "plugins/composer";
            tags = [ from:oh-my-zsh ];
          }
          {
            name = "plugins/colored-man-pages";
            tags = [ from:oh-my-zsh ];
          }
        ];
      };
    };
}
