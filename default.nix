let
 pkgs = import (fetchTarball "https://github.com/b-rodrigues/nixpkgs/archive/06b93631a20bc9c1e73d7b5c706af12ee01922aa.tar.gz") {};
 rpkgs = builtins.attrValues {
  inherit (pkgs.rPackages) blogdown dplyr;
};
 system_packages = builtins.attrValues {
  inherit (pkgs) R glibcLocalesUtf8 pandoc;
};
 hugo_0251 = pkgs.stdenv.mkDerivation {
        name = "hugo_0251";
        src = pkgs.fetchFromGitHub {
          owner = "gohugoio";
          repo = "hugo";
          rev = "v0.25.1";
          sha256 = "sha256-fwU1EHwui0OflOovzIOGdwjGoVsJyX0tKrwlT46uniU=";
        };
        buildInputs = [pkgs.go];
        installPhase = ''
          mkdir -p $out/bin
          cp -r . $out/bin/
        '';
};
  in
  pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    buildInputs = [  rpkgs system_packages hugo_0251 ];
      
  }