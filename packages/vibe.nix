{
  lib,
  stdenv,
  fetchurl,
  fetchFromGitHub,
  dpkg,
  autoPatchelfHook,
  gtk3,
  ffmpeg,
  alsa-lib,
  webkitgtk_4_1,
  xdotool,
  libsoup_3,
  openssl,
  vulkan-loader,
  wrapGAppsHook3,
  openblas,
  yt-dlp,
  libayatana-appindicator,
  gst_all_1,
}: let
  xdotool3 = xdotool.overrideAttrs (old: rec {
    version = "3.20211022.1";
    src = fetchFromGitHub {
      owner = "jordansissel";
      repo = "xdotool";
      tag = "v${version}";
      hash = "sha256-XFiaiHHtUSNFw+xhUR29+2RUHOa+Eyj1HHfjCUjwd9k=";
    };
  });
in
  stdenv.mkDerivation (finalAttrs: rec {
    pname = "vibe";
    version = "3.2.2";
    __structuredAttrs = true;
    strictDeps = true;

    src = fetchurl {
      url = "https://github.com/thewh1teagle/vibe/releases/download/v${finalAttrs.version}/vibe_${finalAttrs.version}_amd64.deb";
      hash = "sha256-N1n1/0Y4hoL76ORAEjzBIdx7eYTyxi1Zl0A6eYS9gnM=";
    };

    dontConfigure = true;
    dontBuild = true;

    nativeBuildInputs = [
      dpkg
      autoPatchelfHook
      wrapGAppsHook3
    ];

    gstPlugins = with gst_all_1; [
      gstreamer
      gst-plugins-base
      gst-plugins-good
      gst-plugins-bad
      gst-libav
    ];

    buildInputs =
      [
        stdenv.cc.cc.lib
        gtk3
        alsa-lib
        webkitgtk_4_1
        xdotool3
        libsoup_3
        openssl
      ]
      ++ gstPlugins;

    runtimeDependencies = [
      vulkan-loader
      openblas
      libayatana-appindicator
    ];

    unpackCmd = "dpkg-deb -x $curSrc source";

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin $out/share
      cp -r usr/bin/* $out/bin/
      cp -r usr/share/* $out/share/

      substituteInPlace "$out/share/applications/vibe.desktop" \
              --replace-fail "Exec=vibe" "Exec=$out/bin/vibe"

      runHook postInstall
    '';

    preFixup = ''
      gappsWrapperArgs+=(
          --prefix PATH : ${lib.makeBinPath [ffmpeg yt-dlp]}
      )
    '';

    meta = {
      description = "Transcribe on your own";
      homepage = "https://github.com/thewh1teagle/vibe";
      changelog = "https://github.com/thewh1teagle/vibe/releases/tag/${finalAttrs.src.tag}";
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [dawnj26];
      mainProgram = "vibe";
      platforms = lib.platforms.all;
    };
  })
