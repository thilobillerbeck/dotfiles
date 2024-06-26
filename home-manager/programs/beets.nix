{
  programs.beets = {
    enable = false;
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
}
