{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  alsa-lib,
  libdrm,
  libGL,
  libva,
  libpulseaudio,
  mesa,
  pipewire,
  vulkan-loader,
  wayland,
  libX11,
  libXcomposite,
  libXdamage,
  libXext,
  libXfixes,
  libXrandr,
  libxkbcommon,
  glib,
}: let
  perPlatform = {
    x86_64-linux = {
      arch = "x86_64";
      hash = "sha256-xaz/LlKsPGSJDM6FJQc0z3J5wd5W1ZJuT04dTPZ2NZw=";
    };
    aarch64-linux = {
      arch = "aarch64";
      hash = "REPLACE_WITH_REAL_AARCH64_HASH";
    };
  };

  platform = perPlatform.${stdenv.hostPlatform.system}
    or (throw "zed: unsupported platform ${stdenv.hostPlatform.system}, only x86_64-linux/aarch64-linux have official tarballs");
in
  stdenv.mkDerivation rec {
    pname = "zed-editor-bin";
    version = "1.19.2";

    src = fetchurl {
      url = "https://github.com/zed-industries/zed/releases/download/v${version}/zed-linux-${platform.arch}.tar.gz";
      hash = platform.hash;
    };

    sourceRoot = "zed.app";

    nativeBuildInputs = [
      autoPatchelfHook
      makeWrapper
    ];

    buildInputs = [
      alsa-lib
      stdenv.cc.cc.lib
      glib
    ];

    runtimeDependencies = [
      vulkan-loader
      libGL
      mesa
      libdrm
      wayland
      libX11
      libXcomposite
      libXdamage
      libXext
      libXfixes
      libXrandr
      pipewire
      libpulseaudio
      libva
      libxkbcommon
    ];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p "$out"
      cp -r bin "$out/bin"
      cp -r libexec "$out/libexec"
      cp -r lib "$out/lib"
      cp -r share "$out/share"

      mv "$out/bin/zed" "$out/bin/zeditor"

      substituteInPlace "$out/share/applications/dev.zed.Zed.desktop" \
        --replace-fail "Exec=zed %U" "Exec=$out/bin/zeditor %U" \
        --replace-fail "Exec=zed --new %U" "Exec=$out/bin/zeditor --new %U" \
        --replace-fail "TryExec=zed" "TryExec=$out/bin/zeditor"

      runHook postInstall
    '';

    doInstallCheck = true;
    installCheckPhase = ''
      runHook preInstallCheck

      test -x "$out/bin/zeditor"
      test -x "$out/libexec/zed-editor"

      echo "=zi= bin/zed NEEDED =="
      patchelf --print-needed "$out/bin/zeditor"
      echo "== bin/zed ldd =="
      ldd "$out/bin/zeditor"

      echo "== libexec/zed-editor NEEDED =="
      patchelf --print-needed "$out/libexec/zed-editor"
      echo "== libexec/zed-editor ldd =="
      ldd "$out/libexec/zed-editor"

      if ldd "$out/bin/zeditor" "$out/libexec/zed-editor" | grep -q "not found"; then
        echo "zed: unresolved shared library dependency detected, failing build"
        exit 1
      fi

      wrapProgram "$out/libexec/zed-editor" \
        --set ZED_UPDATE_EXPLANATION "Zed has been installed using Nix. Auto-updates are disabled." \
        --set RELEASE_VERSION "${version}"

      runHook postInstallCheck
    '';

    meta = {
      description = "High-performance, multiplayer code editor (official prebuilt binary)";
      longDescription = ''
        Zed is a GPU-accelerated, multiplayer code editor from the creators
        of Atom and Tree-sitter. This package repackages the official
        zed-industries/zed prebuilt Linux tarball release rather than
        building Zed from source.
      '';
      homepage = "https://zed.dev";
      changelog = "https://github.com/zed-industries/zed/releases/tag/v${version}";
      license = with lib.licenses; [agpl3Only gpl3Only];
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      platforms = builtins.attrNames perPlatform;
      mainProgram = "zed";
    };
  }
