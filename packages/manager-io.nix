{
  lib,
  fetchFromGitHub,
  appimageTools,
}: let
  pname = "manager";
  version = "26.8.4.3664";

  src = fetchFromGitHub {
    owner = "Manager-io";
    repo = "Manager";
    tag = version;
    hash = "sha256-aFHPTrYw1mxaB/QZVrLq0UAHXXgBzrV2EUaJg9uKsro=";
  };

  appimageContents = appimageTools.extract {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      mv $out/bin/${pname}-${version} $out/bin/${pname}
      install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/1024x1024/apps/${pname}.png \
        $out/share/icons/hicolor/1024x1024/apps/${pname}.png
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace-fail 'Exec=AppRun --no-sandbox %U' 'Exec=${pname}'
    '';

    meta = {
      description = "Accounting software. Available for Windows, Mac and Linux";
      homepage = "https://www2.manager.io/";
      license = lib.licenses.unfree;
      maintainers = with lib.maintainers; [dawnj26];
      mainProgram = "manager-io";
      platforms = lib.platforms.all;
    };
  }
