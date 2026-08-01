{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  alsa-lib,
  fontconfig,
  glib,
  openssl,
  sqlite,
  wayland,
  zlib,
  zstd,
  libgit2,
  libxkbcommon,
  libxcb,
  libGL,
  libx11,
  libxext,
  copyDesktopItems,
  nodejs,
  makeWrapper,
  vulkan-loader,
}: let
  targets = {
    "x86_64-linux" = {
      architecture = "x86_64";
      hash = "sha256-n1Y4vfKN0V3Y2C0JJXfoLebNPQ4MltJljiSmPfAlufU=";
    };
    "aarch64-linux" = {
      architecture = "aarch64";
      hash = "sha256-wfVd4tEto8fS6Hv+bUmJdlOk+vykqo8GoZCEOKg0amw=";
    };
  };
  target =
    targets.${stdenv.hostPlatform.system}
      or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
in
  stdenv.mkDerivation rec {
    pname = "zed-editor-bin";
    version = "1.13.1";

    src = fetchurl {
      url = "https://github.com/zed-industries/zed/releases/download/v${version}/zed-linux-${target.architecture}.tar.gz";
      hash = target.hash;
    };
    sourceRoot = "zed.app";

    nativeBuildInputs = [
      copyDesktopItems
      makeWrapper
      autoPatchelfHook
    ];

    buildInputs = [
      stdenv.cc.cc.lib
      libgit2
      sqlite
      zlib
      zstd
      fontconfig
      openssl
      glib
      alsa-lib
      libxkbcommon
      wayland
      libxcb
      libGL
      libx11
      libxext
      vulkan-loader
    ];

    dontConfigure = true;
    dontBuild = true;

    postFixup = ''
        wrapProgram $out/libexec/zed-editor \
          --set ZED_UPDATE_EXPLANATION "Zed has been installed using Nix. Auto-updates have thus been disabled." \
          --set RELEASE_VERSION "${version}" \
          --suffix PATH : ${lib.makeBinPath [nodejs]} \
          --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [
        libxkbcommon
        libGL
        vulkan-loader
        wayland
      ]}


      if [ -f "$out/share/applications/dev.zed.Zed.desktop" ]; then
        substituteInPlace "$out/share/applications/dev.zed.Zed.desktop" \
          --replace "Exec=zed %U" "Exec=$out/bin/zeditor %U"
      fi
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -r ./* $out/
      mv $out/bin/zed $out/bin/zeditor
      runHook postInstall
    '';

    meta = with lib; {
      description = "High-performance, multiplayer code editor (official prebuilt binary)";
      homepage = "https://zed.dev";
      license = with licenses; [gpl3Only agpl3Only asl20];
      platforms = builtins.attrNames targets;
      mainProgram = "zeditor";
      sourceProvenance = with sourceTypes; [binaryNativeCode];
    };
  }
