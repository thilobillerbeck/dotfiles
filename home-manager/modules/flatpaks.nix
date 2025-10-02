{
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "com.spotify.Client"
      "com.github.wwmm.easyeffects"
      "com.heroicgameslauncher.hgl"
      "com.usebottles.bottles"
      "dev.deedles.Trayscale"
      "info.mumble.Mumble"
      "io.ossia.score"
      "io.podman_desktop.PodmanDesktop"
      "it.fabiodistasio.AntaresSQL"
      "it.mijorus.gearlever"
      "md.obsidian.Obsidian"
      "net.ankiweb.Anki"
      "net.retrodeck.retrodeck"
      "org.ardour.Ardour"
      "org.audacityteam.Audacity"
      "org.fedoraproject.MediaWriter"
      "org.filezillaproject.Filezilla"
      "org.inkscape.Inkscape"
      "org.mixxx.Mixxx"
      "org.mozilla.Thunderbird"
      "org.mozilla.firefox"
      "org.musescore.MuseScore"
      "org.onlyoffice.desktopeditors"
      "org.raspberrypi.rpi-imager"
      "org.signal.Signal"
      "org.telegram.desktop"
      "org.zotero.Zotero"
      "page.kramo.Cartridges"
      "app.grayjay.Grayjay"
      "com.discordapp.Discord"
      "page.kramo.Sly"
    ];
  };
}
