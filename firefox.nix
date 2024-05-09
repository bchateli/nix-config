{ inputs, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      bookmarks = [
        {
          name = "Toolbar";
          toolbar = true;
          bookmarks = [
	    {
	      name = "homelab";
	      url = "http://192.168.1.60/login";
	    }
	    {
	      name = "Dahsboard";
	      url = "http://192.168.1.60:3000";
   	    }
	    {
	      name = "GitHub";
	      url = "https://github.com/";
	    }
            {
              name = "IEEE INSA";
              url = "javascript:(function(){window.open('https://ieeexplore-ieee-org.rproxy.insa-rennes.fr'+location.pathname+location.search,'_blank')})();";
            }
          ];
        }
      ];
      settings = {
        "browser.download.useDownloadDir" = false;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.startup.page" = 3; # Resume the previous session at startup
        "signon.rememberSignons" = false; # Disable built-in password manager
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardwaremediakeys.enabled" = false;
      };
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [ # See https://github.com/nix-community/nur-combined/tree/master/repos/rycee
        ublock-origin
        bitwarden
        i-dont-care-about-cookies

      ];
    };
  };
}
