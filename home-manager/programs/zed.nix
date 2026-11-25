{ pkgs, config, ... }:

{
  programs.zed-editor = {
    enable = config.machine.isGraphical;
    package = pkgs.zed-editor;
    mutableUserSettings = true;
    extraPackages = with pkgs; [
      go
      gopls
      delve
      gofumpt
      nodejs
      vue-language-server
      tailwindcss-language-server
      vtsls
      prettier
    ];
    extensions = [
      "astro"
      "dockerfile"
      "git-firefly"
      "html"
      "latex"
      "less"
      "material-icon-theme"
      "nix"
      "scss"
      "svelte"
      "unocss"
      "vento"
      "vue"
      "dart"
      "emmet"
      "zed-docker-compose"
      "xy-zed"
      "exquisite"
    ];
    userSettings = {
      telemetry = {
        metrics = false;
      };
      theme = {
        mode = "system";
        dark = "Exquisite Blue";
        light = "Exquisite Blue";
      };
      ui_font_family = "JetBrainsMono Nerd Font";
      ui_font_size = 17;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 18;
      restore_on_startup = "none";
      auto_update = false;
      mouse_wheel_zoom = true;
      icon_theme = "Material Icon Theme";
      hour_format = "hour24";
      code_lens = "on";
      tabs = {
        file_icons = true;
        git_status = true;
      };
      terminal = {
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
        };
      };
      indent_guides = {
        enable = true;
      };
      languages = {
        "Vue.js" = {
          tab_size = 2;
          language_servers = [
            "vue-language-server"
            "vtsls"
            "tailwindcss-language-server"
            "eslint"
            "emmet-language-server"
            "..."
          ];
          formatter = "prettier";
          prettier.allowed = true;
          format_on_save = "on";
          code_actions_on_format = {
            "source.fixAll.eslint" = true;
          };
          show_edit_predictions = true;
          linked_edits = true;
        };
        TypeScript = {
          tab_size = 2;
          formatter = "prettier";
          prettier.allowed = true;
          format_on_save = "on";
          language_servers = [
            "vtsls"
            "tailwindcss-language-server"
            "eslint"
            "!typescript-language-server"
            "..."
          ];
        };
        JavaScript = {
          tab_size = 2;
          formatter = "prettier";
          prettier.allowed = true;
          format_on_save = "on";
          language_servers = [
            "vtsls"
            "tailwindcss-language-server"
            "eslint"
            "..."
          ];
        };
        CSS = {
          language_servers = [
            "tailwindcss-language-server"
            "..."
          ];
          prettier.allowed = true;
        };
        HTML = {
          language_servers = [
            "tailwindcss-language-server"
            "emmet-language-server"
            "..."
          ];
          prettier.allowed = true;
        };
        Nix = {
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [
                "--quiet"
                "--"
              ];
            };
          };
        };
      };
      formatter = "language_server";
      inlay_hints.enabled = true;
      lsp = {
        tailwindcss-language-server = {
          settings = {
            includeLanguages = {
              vue = "html";
              html = "html";
              css = "css";
              javascript = "javascript";
              typescript = "typescript";
            };
            classAttributes = [
              "class"
              "className"
              ":class"
              "ngClass"
            ];
            experimental.classRegex = [
              [
                "cva\\(([^)]*)\\)"
                "[\"'`]([^\"'`]*).*?[\"'`]"
              ]
              [
                "cx\\(([^)]*)\\)"
                "(?:'|\"|`)([^']*)(?:'|\"|`)"
              ]
              [
                "clsx\\(([^)]*)\\)"
                "(?:'|\"|`)([^']*)(?:'|\"|`)"
              ]
            ];
          };
        };
        biome = {
          settings = {
            require_config_file = true;
          };
        };
        gopls = {
          binary.path = "${pkgs.gopls}/bin/gopls";
        };
      };
      collaboration_panel.button = false;
      notification_panel.button = false;
    };
  };
}
