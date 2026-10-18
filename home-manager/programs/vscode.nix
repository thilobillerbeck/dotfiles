{
  config,
  lib,
  pkgs,
  ...
}:

let
  marketplace = pkgs.vscode-marketplace;
  extensionIds = [
    "alfredbirk.tailwind-documentation"
    "anthropic.claude-code"
    "astro-build.astro-vscode"
    "biomejs.biome"
    "bradlc.vscode-tailwindcss"
    "christian-kohler.path-intellisense"
    "dart-code.dart-code"
    "dart-code.flutter"
    "dbaeumer.vscode-eslint"
    "denoland.vscode-deno"
    "docker.docker"
    "editorconfig.editorconfig"
    "esbenp.prettier-vscode"
    "golang.go"
    "jnoortheen.nix-ide"
    "mkhl.direnv"
    "mrmlnc.vscode-scss"
    "ms-python.debugpy"
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-python.vscode-python-envs"
    "ms-vscode.makefile-tools"
    "oscarotero.vento-syntax"
    "pandy.bun"
    "pinage404.nix-extension-pack"
    "pkief.material-icon-theme"
    "redhat.vscode-yaml"
    "sissel.shopify-liquid"
    "solomonkinard.git-blame"
    "sst-dev.opencode"
    "svelte.svelte-vscode"
    "syler.sass-indented"
    "tamasfe.even-better-toml"
    "unifiedjs.vscode-mdx"
    "usernamehw.errorlens"
    "vue.volar"
  ];
  prettier = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
in
{
  programs.vscode = {
    enable = !config.machine.isGeneric && config.machine.isGraphical;
    mutableExtensionsDir = false;

    profiles.default = {
      extensions = map (id: lib.getAttrFromPath (lib.splitString "." id) marketplace) extensionIds;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableUserSettings = true;
      userSettings = {
        "workbench.activityBar.location" = "top";
        "workbench.iconTheme" = "material-icon-theme";
        "editor.fontSize" = 18;
        "editor.mouseWheelZoom" = true;
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "terminal.integrated.initialHint" = false;
        "files.exclude"."**/.direnv" = true;
        "js/ts.updateImportsOnFileMove.enabled" = "always";

        "git.openRepositoryInParentFolders" = "never";
        "git.confirmSync" = false;
        "git.terminalAuthentication" = false;
        "github.gitAuthentication" = false;

        "chat.disableAIFeatures" = true;

        "claudeCode.preferredLocation" = "panel";
        "claudeCode.hideOnboarding" = true;

        "telemetry.telemetryLevel" = "off";
        "workbench.enableExperiments" = false;
        "workbench.startupEditor" = "none";
        "workbench.welcomePage.walkthroughs.openOnInstall" = false;
        "extensions.ignoreRecommendations" = true;

        "json.schemaDownload.trustedDomains" = {
          "https://schemastore.azurewebsites.net/" = true;
          "https://raw.githubusercontent.com/" = true;
          "https://www.schemastore.org/" = true;
          "https://json.schemastore.org/" = true;
          "https://json-schema.org/" = true;
          "https://biomejs.dev" = true;
        };

        "[typescript]" = prettier;
        "[typescriptreact]" = prettier;
        "[javascript]" = prettier;
        "[javascriptreact]" = prettier;
        "[html]" = prettier;
        "[css]" = prettier;
        "[yaml]" = prettier;
        "[jsonc]" = prettier;
        "[vue]"."editor.defaultFormatter" = "Vue.volar";
        "[liquid]"."editor.defaultFormatter" = "sissel.shopify-liquid";
        "[astro]"."editor.defaultFormatter" = "astro-build.astro-vscode";
      };
    };
  };
}
