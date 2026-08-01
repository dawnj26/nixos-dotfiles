{
  lib,
  stdenv,
  fetchurl,
  alsa-lib,
  wayland,
  libGL,
  libx11,
  libxext,
  copyDesktopItems,
  nodejs,
  makeWrapper,
  libxcomposite,
  libxdamage,
  libxfixes,
  libxrandr,
  libdrm,
  libgbm,
  libva,
  pipewire,
  libpulseaudio,
  libxkbcommon,
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
    ];

    buildInputs = [
      alsa-lib
      libGL
      wayland
      libx11
      libxext
      libxcomposite
      libxdamage
      libxfixes
      libxrandr
      libdrm
      libgbm
      libva
      pipewire
      libpulseaudio
      libxkbcommon
    ];

    dontConfigure = true;
    dontBuild = true;

    postFixup = ''
      interpreter="$(cat "$NIX_CC/nix-support/dynamic-linker")"

      rpath="$out/lib:${lib.makeLibraryPath [
        stdenv.cc.cc.lib
        alsa-lib
        libGL
        wayland
        libx11
        libxext
        libxcomposite
        libxdamage
        libxfixes
        libxrandr
        libdrm
        libgbm
        libva
        pipewire
        libpulseaudio
        libxkbcommon
      ]}"

      patchelf --set-interpreter "$interpreter" --add-rpath "$rpath" \
        $out/libexec/zed-editor
      patchelf --set-interpreter "$interpreter" --add-rpath "$rpath" \
        $out/bin/zeditor

      for so in $out/lib/*.so*; do
        patchelf --add-rpath "$rpath" "$so"
      done

      wrapProgram $out/libexec/zed-editor \
        --set ZED_UPDATE_EXPLANATION "Zed has been installed using Nix. Auto-updates have thus been disabled." \
        --set RELEASE_VERSION "${version}" \
        --suffix PATH : ${lib.makeBinPath [nodejs]} \
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [libxkbcommon]}


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
