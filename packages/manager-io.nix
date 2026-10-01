{
  lib,
  fetchurl,
  appimageTools,
}: let
  pname = "manager";
  version = "26.8.4.3664";

  src = fetchurl {
    url = "https://github.com/Manager-io/Manager/releases/download/${version}/Manager-x86_64.AppImage";
    hash = "sha256-QAGWrq62tDhBl5Y0sJmeRB68lPv2ETuviAhPR0VH0ts=";
  };

  appimageContents = appimageTools.extract {inherit pname version src;};
in
  appimageTools.wrapType2 rec {
    inherit pname version src;

    extraPkgs = pkgs: [
      pkgs.icu
    ];

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/1024x1024/apps/${pname}.png \
        $out/share/icons/hicolor/1024x1024/apps/${pname}.png
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace-fail 'Exec=AppRun --no-sandbox %U' 'Exec=${pname} %U'
    '';

    meta = {
      description = "Accounting software. Available for Windows, Mac and Linux";
      homepage = "https://www.manager.io/";
      license = lib.licenses.fsl11Asl20;
      maintainers = with lib.maintainers; [dawnj26];
      mainProgram = "manager";
      platforms = lib.platforms.all;
    };
  }
