{ config, pkgs, lib, ... }:
let 
  chromeArgs = "--force-dark-mode --enable-features=WebUIDarkMode --enable-smooth-scrolling --ozone-platform-hint=auto --ignore-gpu-blocklist --enable-gpu-rasterization --enable-zero-copy";
in {
  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true;
  
  home = {
    username = "thilo";
    homeDirectory = "/home/thilo";
    stateVersion = "22.11";
    packages = [
      pkgs.up
      pkgs.rbenv
      pkgs.cargo-update
      pkgs.htop
      pkgs.rustup
      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "FiraMono" ]; })
      (pkgs.vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = true;
        commandLineArgs = chromeArgs;
      })
      (pkgs.google-chrome.override {
        commandLineArgs = chromeArgs;
      })
      (pkgs.writeShellScriptBin "ssh-fix-permissions" ''
        chmod 700 ~/.ssh
        chmod 600 ~/.ssh/*
        chmod 644 -f ~/.ssh/*.pub ~/.ssh/authorized_keys ~/.ssh/known_hosts
      '')
    ];
    file = {
      ".config/htop/htoprc".source = ./dotfiles/htoprc;
      ".config/nano/nanorc".source = ./dotfiles/nanorc;
      ".config/locale.conf".source = ./dotfiles/locale.conf;
      ".ssh/config".source = ./dotfiles/ssh-config;
      ".config/beets/config.yaml".source = ./dotfiles/beets.yaml;
    };
    sessionVariables = {
      
    };
    activation = {
      linkDesktopApplications = {
        after = [ "writeBoundary" "createXdgUserDirectories" ];
        before = [ ];
        data = ''
          rm -rf ${config.xdg.dataHome}/"applications/home-manager"
          mkdir -p ${config.xdg.dataHome}/"applications/home-manager"
          cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/"applications/home-manager/"
        '';
      };
    };
  }
  ;
  xdg = {
    enable = true;
    mime.enable = true;
  };

  programs = {
    home-manager.enable = true;
    vscode = {
      enable = true;
      package = pkgs.vscode.override { commandLineArgs = "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --gtk-version=4"; };
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableVteIntegration = true;
    };
    git = {
      enable = true;
      lfs.enable = true;
      userEmail = "thilo.billerbeck@officerent.de";
      userName = "Thilo Billerbeck";
      extraConfig = {
        color = {
          diff = "auto";
          status = "auto";
          branch = "auto"; 
          interactive = "auto";
          ui = true;
          pager = true;
        };
        log = {
          date = "short";
        };
        rerere = {
          enabled = "1";
        };
        core = {
          whitespace="fix,-indent-with-non-tab,trailing-space,cr-at-eol";
          excludesfile = "~/.gitignore-rab";
          autocrlf = "input";
        };
        apply = {
          whitespace = "nowarn";
        };
        branch = {
          autosetuprebase = "always";
        };
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[❯](bold white)";
        };
        package = {
          disabled = true;
        };
      };
    };
    topgrade = {
      enable = true;
      settings = {
        assume_yes = true;
        ignore_failures = ["git_repos"];
        no_retry = true;
        pre_sudo = false;
        cleanup = true;
        skip_notify = true;
        firmware = {
          upgrade = true;
        };
      };
    };
    alacritty = {
      enable = true;
      settings = {
        window = {
            decorations = "full";
            dynamic_title = true;
            gtk_theme_variant = "None";
        };
        background_opacity = 1;
        font = {
            normal = {
                family = "FiraMono Nerd Font";
                style = "Regular";
            };
            bold = {
                family = "FiraMono Nerd Font";
                style = "Bold";
            };
            size = 14;
            offset = {
              x = 1;
            };
          };
          cursor.style.shape = "Beam";
          colors = {
            primary = {
              background = "0x282a36";
              foreground = "0xeff0eb";
            };
            normal = {
              black = "0x282a36";
              red = "0xff5c57";
              green = "0x5af78e";
              yellow = "0xf3f99d";
              blue = "0x57c7ff";
              magenta = "0xff6ac1";
              cyan = "0x9aedfe";
              white = "0xf1f1f0";
            };
            bright = {
              black = "0x686868";
              red = "0xff5c57";
              green = "0x5af78e";
              yellow = "0xf3f99d";
              blue = "0x57c7ff";
              magenta = "0xff6ac1";
              cyan = "0x9aedfe";
              white = "0xf1f1f0";
            };
          };
        };
      };
    neovim = {
      defaultEditor = true;
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      coc = {
        enable = true;
      };
      extraConfig = ''
        set title
        set number
        set relativenumber
        set cursorline
        set mouse=a
        syntax enable
        let g:NERDTreeShowHidden = 1
        let g:NERDTreeMinimalUI = 1
        let g:NERDTreeIgnore = [ '.git/' ]
        let g:NERDTreeStatusline = ""
        let g:NERDTreeMouseMode = 2
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
        nnoremap <silent> <C-b> :NERDTreeToggle<CR>
      '';
      plugins = with pkgs.vimPlugins; [
        nerdtree
        vim-devicons
        # fzf
        ale
      ];
    };
  };
}