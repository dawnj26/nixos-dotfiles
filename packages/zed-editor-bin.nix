{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeBinaryWrapper,
  versionCheckHook,
  alsa-lib,
  glib,
  libGL,
  libdrm,
  libgbm,
  libpulseaudio,
  libva,
  libx11,
  libxcb,
  libxcomposite,
  libxdamage,
  libxext,
  libxfixes,
  libxkbcommon,
  libxrandr,
  pipewire,
  vulkan-loader,
  wayland,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "zed-editor-bin";
  version = "1.23.3";

  src =
    finalAttrs.passthru.sources.${stdenv.hostPlatform.system}
      or (throw "zed-editor-bin: unsupported system ${stdenv.hostPlatform.system}");

  sourceRoot = "zed.app";

  __structuredAttrs = true;
  strictDeps = true;

  nativeBuildInputs = [
    autoPatchelfHook
    makeBinaryWrapper
  ];

  buildInputs = [
    alsa-lib
    glib
    libx11
    libxcb
    libxkbcommon
    stdenv.cc.cc.lib
  ];

  runtimeDependencies = map lib.getLib [
    libGL
    libdrm
    libgbm
    libpulseaudio
    libva
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    pipewire
    vulkan-loader
    wayland
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"
    cp -r share "$out/share"

    install -Dm755 bin/zed "$out/bin/zeditor"
    install -Dm755 libexec/zed-editor "$out/libexec/zed-editor"
    install -Dm644 licenses.md "$out/share/doc/zed-editor-bin/licenses.md"

    substituteInPlace "$out/share/applications/dev.zed.Zed.desktop" \
    --replace-fail "Exec=zed %U" "Exec=$out/bin/zeditor %U" \
    --replace-fail "Exec=zed --new %U" "Exec=$out/bin/zeditor --new %U" \
    --replace-fail "TryExec=zed" "TryExec=$out/bin/zeditor"

    wrapProgram "$out/libexec/zed-editor" \
      --set ZED_UPDATE_EXPLANATION "Zed has been installed using Nix. Auto-updates are disabled." \

    runHook postInstall
  '';

  doInstallCheck = true;
  nativeInstallCheckInputs = [versionCheckHook];
  versionCheckProgram = "${placeholder "out"}/bin/${finalAttrs.meta.mainProgram}";

  passthru.sources = let
    fetchRelease = arch: hash:
      fetchurl {
        url = "https://github.com/zed-industries/zed/releases/download/v${finalAttrs.version}/zed-linux-${arch}.tar.gz";
        inherit hash;
      };
  in {
    x86_64-linux = fetchRelease "x86_64" "sha256-9xkSlClWmbtayBCkxQ+CkK09AZHD5QYRT7FKcjaSGmE=";
    aarch64-linux = fetchRelease "aarch64" "sha256-IkMbvRXhsY7kKXk5WyQtMmF41KX21mCP9ftFIMU1ock=";
  };

  meta = {
    description = "High-performance, multiplayer code editor (official prebuilt binary)";
    longDescription = ''
      Zed is a GPU-accelerated, multiplayer code editor from the creators
      of Atom and Tree-sitter. This package repackages the official
      zed-industries/zed prebuilt Linux tarball release rather than
      building Zed from source.
    '';
    homepage = "https://zed.dev";
    changelog = "https://github.com/zed-industries/zed/releases/tag/v${finalAttrs.version}";
    license = [
      lib.licenses.agpl3Only
      lib.licenses.gpl3Only
    ];
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    platforms = lib.attrNames finalAttrs.passthru.sources;
    mainProgram = "zeditor";
  };
})
