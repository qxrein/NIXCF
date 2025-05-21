{ pkgs ? import <nixpkgs> {} }:

let
  fetchurl = pkgs.fetchurl;
  wrapGAppsHook = pkgs.wrapGAppsHook;
  dpkg = pkgs.dpkg;
  makeWrapper = pkgs.makeWrapper;
in

pkgs.stdenv.mkDerivation rec {
  pname = "thorium";
  version = "130.0.6723.174";

  src = fetchurl (import ./src.nix);

  nativeBuildInputs = [
    dpkg
    makeWrapper
    wrapGAppsHook
  ];

  buildInputs = with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    libdrm
    libnotify
    pulseaudio
    util-linux
    xorg.libxcb
    xorg.libxshmfence
    mesa
    nspr
    nss
    pango
    udev
    libxkbcommon
  ];

  unpackPhase = ''
    dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions --no-same-owner
  '';

  dontPatchELF = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/opt/chromium.org/thorium

    if [ -d ./opt/chromium.org/thorium ]; then
      cp -a ./opt/chromium.org/thorium/* $out/opt/chromium.org/thorium/
    elif [ -d ./opt/thorium ]; then
      cp -a ./opt/thorium/* $out/opt/chromium.org/thorium/
    fi

    makeWrapper "$out/opt/chromium.org/thorium/thorium" "$out/bin/thorium" \
      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}" \
      --prefix PATH : "${pkgs.xdg-utils}/bin"

    if [ -f $out/opt/chromium.org/thorium/chromedriver ]; then
      makeWrapper "$out/opt/chromium.org/thorium/chromedriver" "$out/bin/chromedriver" \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}"
    fi

    if [ -f $out/opt/chromium.org/thorium/thorium-shell ]; then
      makeWrapper "$out/opt/chromium.org/thorium/thorium-shell" "$out/bin/thorium-shell" \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}"
    fi

    if [ -d ./usr/share/applications ]; then
      mkdir -p $out/share/applications
      cp ./usr/share/applications/thorium*.desktop $out/share/applications/ || true
      
      for file in $out/share/applications/*.desktop; do
        if [ -f "$file" ]; then
          substituteInPlace $file \
            --replace-warn "/opt/chromium.org/thorium/thorium" "$out/bin/thorium" \
            --replace-warn "/opt/chromium.org/thorium/" "$out/opt/chromium.org/thorium/" \
            --replace-warn "/opt/thorium/thorium" "$out/bin/thorium" \
            --replace-warn "/opt/thorium/" "$out/opt/chromium.org/thorium/"
        fi
      done
    fi

    if [ -d ./usr/share/icons ]; then
      mkdir -p $out/share/icons
      cp -r ./usr/share/icons/* $out/share/icons/ || true
    fi

    if [ ! -f $out/share/applications/thorium.desktop ] && [ -f $out/opt/chromium.org/thorium/product_logo_256.png ]; then
      mkdir -p $out/share/applications
      cat > $out/share/applications/thorium.desktop << EOF
    [Desktop Entry]
    Type=Application
    Name=Thorium Browser
    Exec=$out/bin/thorium %U
    Icon=$out/opt/chromium.org/thorium/product_logo_256.png
    Comment=Chromium fork with various patches and optimizations
    Categories=Network;WebBrowser;
    MimeType=x-scheme-handler/http;x-scheme-handler/https;
    StartupNotify=true
    EOF
    fi

    runHook postInstall
  '';

  postFixup = ''
    for file in $(find $out/opt/chromium.org/thorium -type f -executable); do
      if [ -f "$file" ]; then
        patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$file" || true
      fi
    done
  '';

  meta = with pkgs.lib; {
    description = "Chromium fork with JPEG XL support, performance and privacy patches";
    homepage = "https://thorium.rocks/";
    license = licenses.bsd3;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    maintainers = with maintainers; [ qxrein ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "thorium";
  };
}
