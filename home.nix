{ config, pkgs, lib, ... }:
let
  chromeArgs =
    "--force-dark-mode --enable-features=WebUIDarkMode --enable-smooth-scrolling --ozone-platform-hint=auto --ignore-gpu-blocklist --enable-gpu-rasterization --enable-zero-copy";
  nixgl = import <nixgl> { };
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "exec ${lib.getExe nixgl.auto.nixGLDefault} $bin \$@" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';
in {
  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true;
  news.display = "silent";

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
      pkgs.nixfmt
      (pkgs.nerdfonts.override {
        fonts = [ "JetBrainsMono" "FiraCode" "FiraMono" ];
      })
      (nixGLWrap (pkgs.vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = true;
        commandLineArgs = chromeArgs;
      }))
      (nixGLWrap
        (pkgs.google-chrome.override { commandLineArgs = chromeArgs; }))
      (pkgs.writeShellScriptBin "ssh-fix-permissions" ''
        chmod 700 ~/.ssh
        chmod 600 ~/.ssh/*
        chmod 644 -f ~/.ssh/*.pub ~/.ssh/authorized_keys ~/.ssh/known_hosts
      '')
    ];
    file = {
      ".config/nano/nanorc".source = ./dotfiles/nanorc;
      ".config/locale.conf".source = ./dotfiles/locale.conf;
      ".ssh/config".source = ./dotfiles/ssh-config;
    };
    sessionVariables = {

    };
    activation = {
      linkDesktopApplications = {
        after = [ "writeBoundary" "createXdgUserDirectories" ];
        before = [ ];
        data = ''
          for dir in ${config.home.homeDirectory}/.nix-profile/share/applications/*; do
            chmod +x $(realpath $dir) -v
          done
        '';
      };
    };
  };
  xdg = {
    enable = true;
    mime.enable = true;
  };

  programs = {
    home-manager.enable = true;
    vscode = {
      enable = true;
      package = (nixGLWrap (pkgs.vscode.override {
        commandLineArgs =
          "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --gtk-version=4";
      }));
    };
    htop = {
      enable = true;
      settings = {
        fields="0 48 17 18 38 39 40 2 46 47 49 1";
        sort_key="46";
        sort_direction="1";
        tree_sort_key="0";
        tree_sort_direction="1";
        hide_kernel_threads="1";
        hide_userland_threads="0";
        shadow_other_users="0";
        show_thread_names="0";
        show_program_path="1";
        highlight_base_name="0";
        highlight_megabytes="1";
        highlight_threads="1";
        highlight_changes="0";
        highlight_changes_delay_secs="5";
        find_comm_in_cmdline="1";
        strip_exe_from_cmdline="1";
        show_merged_command="0";
        tree_view="1";
        tree_view_always_by_pid="0";
        header_margin="1";
        detailed_cpu_time="0";
        cpu_count_from_one="0";
        show_cpu_usage="1";
        show_cpu_frequency="0";
        show_cpu_temperature="0";
        degree_fahrenheit="0";
        update_process_names="0";
        account_guest_in_cpu_meter="0";
        color_scheme="0";
        enable_mouse="1";
        delay="15";
        left_meters="LeftCPUs2 CPU Memory DiskIO NetworkIO";
        left_meter_modes="1 1 1 2 2";
        right_meters="RightCPUs2 Tasks LoadAverage Uptime Battery";
        right_meter_modes="1 2 2 2 2";
        hide_function_bar="0";
      };
    };
    beets = {
      enable = true;
      settings = {
        directory = "~/Music/dj/Library";
        library = "~/Music/dj/library.db";
        plugins = "spotify acousticbrainz badfiles duplicates fetchart";
        import = {
          write = "yes";
          copy = "yes";
          resume = "no";
          duplicate_action = "ask";
          default_action = "apply";
        };
        badfiles = {
          check_on_import = "yes";
        };
        match = {
          max_rec = {
            track_length = "strong";
            track_title = "strong";
            track_artist = "strong";
          };
        };
      };
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableVteIntegration = true;
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
        log = { date = "short"; };
        rerere = { enabled = "1"; };
        core = {
          whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
          excludesfile = "~/.gitignore-rab";
          autocrlf = "input";
        };
        apply = { whitespace = "nowarn"; };
        branch = { autosetuprebase = "always"; };
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
        character = { success_symbol = "[❯](bold white)"; };
        package = { disabled = true; };
      };
    };
    topgrade = {
      enable = true;
      settings = {
        assume_yes = true;
        ignore_failures = [ "git_repos" ];
        no_retry = true;
        pre_sudo = false;
        cleanup = true;
        skip_notify = true;
        firmware = { upgrade = true; };
      };
    };
    alacritty = {
      enable = true;
      package = (nixGLWrap pkgs.alacritty);
      settings = {
        window = {
          decorations = "full";
          dynamic_title = true;
          gtk_theme_variant = "None";
        };
        window.opacity = 1;
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
          offset = { x = 1; };
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
    yt-dlp = {
      enable = true;
    };
    neovim = {
      defaultEditor = true;
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      coc = { enable = true; };
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
