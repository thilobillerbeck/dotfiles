{ lib, config, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    completionInit = "autoload -U compinit && compinit -i";
    enableVteIntegration = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    shellAliases = {
      pub-ipv4 = "curl ip4.clerie.de";
      serve = "python3 -m http.server 8080";
      week = "date +%V";
      path = "echo -e \${PATH//:/\\n}";
      distro = "cat /etc/*-release";
      reload = "source ~/.zshrc";
      undo-git-reset-head = "git reset 'HEAD@{1}'";
    };
    antidote = {
      enable = true;
      plugins = [
        "ohmyzsh/ohmyzsh path:plugins/dotenv"
      ];
    };
    initContent = lib.mkBefore ''
      ZSH_DOTENV_PROMPT=false
    '';
  };
}
