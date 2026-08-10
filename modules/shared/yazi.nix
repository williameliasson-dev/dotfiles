{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    plugins = {
      git = pkgs.yaziPlugins.git;
    };

    initLua = ''
      require("git"):setup()
    '';

    settings = {
      plugin = {
        prepend_fetchers = [
          {
            url = "*";
            run = "git";
            group = "git";
          }
          {
            url = "*/";
            run = "git";
            group = "git";
          }
        ];
      };
    };
  };
}
