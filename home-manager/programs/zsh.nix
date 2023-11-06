{ config, pkgs, lib, ... }:
let
  omz-plugins = [
    "git"
    "archlinux"
    "composer"
    "colored-man-pages"
    "extract"
    "gradle"
    "node"
    "npm"
    "rbenv"
    "sudo"
    "direnv"
    "docker"
    "docker-compose"
    "golang"
    "pip"
    "history"
    "vagrant"
  ];
in {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
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
    zplug = {
      enable = true;
      plugins = map (x: {
        name = "plugins/${x}";
        tags = [ "from:oh-my-zsh" ];
      }) omz-plugins;
    };
    initExtra = ''
      eval $(${pkgs.thefuck}/bin/thefuck --alias)
      [ -d ~/.npm-global ] || mkdir ~/.npm-global
      ${pkgs.nodejs}/bin/npm config set prefix '~/.npm-global'
      export PATH=~/.npm-global/bin:$PATH
    '';
  };
}