[1mdiff --git a/configuration.nix b/configuration.nix[m
[1mindex 91b202b..9d35c3f 100644[m
[1m--- a/configuration.nix[m
[1m+++ b/configuration.nix[m
[36m@@ -84,7 +84,7 @@[m
   services.printing.enable = true;[m
 [m
   # Enable sound with pipewire.[m
[31m-  sound.enable = true;[m
[32m+[m[32m  #sound.enable = true;[m
   hardware.pulseaudio.enable = false;[m
   security.rtkit.enable = true;[m
   services.pipewire = {[m
[1mdiff --git a/flake.lock b/flake.lock[m
[1mindex 4c101c9..31aeb1c 100644[m
[1m--- a/flake.lock[m
[1m+++ b/flake.lock[m
[36m@@ -45,32 +45,32 @@[m
         ][m
       },[m
       "locked": {[m
[31m-        "lastModified": 1726989464,[m
[31m-        "narHash": "sha256-Vl+WVTJwutXkimwGprnEtXc/s/s8sMuXzqXaspIGlwM=",[m
[32m+[m[32m        "lastModified": 1732453608,[m
[32m+[m[32m        "narHash": "sha256-HeFye2mgoBZWtRLMSwGxdNabB4haWeWw2mS+hDF0mTo=",[m
         "owner": "nix-community",[m
         "repo": "home-manager",[m
[31m-        "rev": "2f23fa308a7c067e52dfcc30a0758f47043ec176",[m
[32m+[m[32m        "rev": "2777de38dd20826238712c8fdaac3e960773e43a",[m
         "type": "github"[m
       },[m
       "original": {[m
         "owner": "nix-community",[m
[31m-        "ref": "release-24.05",[m
[32m+[m[32m        "ref": "release-24.11",[m
         "repo": "home-manager",[m
         "type": "github"[m
       }[m
     },[m
     "nixpkgs": {[m
       "locked": {[m
[31m-        "lastModified": 1731797254,[m
[31m-        "narHash": "sha256-df3dJApLPhd11AlueuoN0Q4fHo/hagP75LlM5K1sz9g=",[m
[32m+[m[32m        "lastModified": 1731755305,[m
[32m+[m[32m        "narHash": "sha256-v5P3dk5JdiT+4x69ZaB18B8+Rcu3TIOrcdG4uEX7WZ8=",[m
         "owner": "nixos",[m
         "repo": "nixpkgs",[m
[31m-        "rev": "e8c38b73aeb218e27163376a2d617e61a2ad9b59",[m
[32m+[m[32m        "rev": "057f63b6dc1a2c67301286152eb5af20747a9cb4",[m
         "type": "github"[m
       },[m
       "original": {[m
         "owner": "nixos",[m
[31m-        "ref": "nixos-24.05",[m
[32m+[m[32m        "ref": "nixos-24.11",[m
         "repo": "nixpkgs",[m
         "type": "github"[m
       }[m
[1mdiff --git a/home.nix b/home.nix[m
[1mindex 2300a39..e07127b 100644[m
[1m--- a/home.nix[m
[1m+++ b/home.nix[m
[36m@@ -58,7 +58,6 @@[m
     # (pkgs.writeShellScriptBin "my-hello" ''[m
     #   echo "Hello, ${config.home.username}!"[m
     # '')[m
[31m-   firefox[m
    thunderbird[m
    spotify[m
    discord[m
[36m@@ -74,6 +73,7 @@[m
    ])[m
    ++[m
    (with unstable; [[m
[32m+[m[32m   firefox[m
    vscode[m
    (inkscape-with-extensions.override {inkscapeExtensions = [ inkscape-extensions.textext ];})[m
    ]);[m
