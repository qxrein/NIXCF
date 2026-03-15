{ config, nur, pkgs-unstable, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
   ############## editors ################
    lld
    # kiro
    neovim
    helix
    wayland
    librelane
    lxappearance
    darling-dmg
    # nur.legacyPackages."${system}".repos.lonerOrz.helium
    libnotify
    # awscli
    # kazam
    gpu-screen-recorder
    # nur.legacyPackages."${system}".repos.iuricarras.ciscoPacketTracer9
    # ciscoPacketTracer8
    # libglvnd
    # magic-vlsi
    btop
    distrobox
    pkgs-unstable.protonvpn-gui
    chezmoi
    # libsoup2
    # rquickshare
    xdg-desktop-portal-gnome
    # pkgs-unstable.windsurf
    pkgs-unstable.antigravity
    # openems
    # plasma-panel-colorizer
    # python312Packages.numpy
    # shotman
    banana-cursor
    # jq

    #here
    fastfetch
    
    # ns-3
    # btop
    # bonnmotion
    rofi
    # python312Packages.meep
    onlyoffice-desktopeditors
    # probe-rs-tools
    # libreoffice-qt
    # libreoffice
    libxkbcommon
    dmenu-wayland
    slstatus
    # iw
    # appcsxcad
    quickshell


  #to here
    
    # eww
    # pnpm
    

    #here

   # python312Packages.venvShellHook
   #  cowsay
    swaybg
    # albert
    google-chrome
    # csxcad
    # python312Packages.west
    vscode-extensions.platformio.platformio-vscode-ide
    # devenv
    # mesa
    # wine64
      # mesa
    # gradle
    swayosd
    pkgs.temurin-bin-21
    # 
    # un-comment above
    
    niri
    # kicad
    # wmenu
    # pkgs.ktlint
    clapboard
    jdk17
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})
    # zulu17
    # ollama
    # wayneko
    xwayland-satellite
    # rofi-wayland
      # pkgs.qt5.qtgraphicaleffects
      # python312Packages.pip
      # pipx
    libinput
    # zed-editor
    # evtest
    # waydroid
    jujutsu
    mdbook-pdf
    # vimPlugins.zenbones-nvim
    vim
    appimage-run
    # bazel
    # linuxPackages.cpupower
    # wabt 

    # bazelisk
    xinit
    # rquickshare-legacy
    pkgs-unstable.code-cursor
    # flix
    waybar
    # fzf
    # clang
    lightdm
    # tldr
    # steam-run
    hplip
    cups
    # sane-backends
    libusb1
    # avahi
    wl-clipboard-rs
    clipman
    dbus
  
    # steamcmd
    # scala-next
    # lutris
    # scala-cli
    # sbt
    steam
    # go-sct
    lsof
    # esptool
    # mkspiffs-presets.esp-idf
    # cni-plugins
    # nodePackages.vercel
    # winetricks

    # wasmtime
    # wasm-pack
    # wasm-tools
    # wasmer


    ####################### virtual machine ####################
    # qemu


  #################### terminals ##################
    alacritty
    # kitty
    ghostty

  ############## languages and tools ##################
    # clang
    # ihaskell
    # scala
    libX11
    # rustc
    # cabal-install
    python3
    pkgs-unstable.deno
    # pkgs-unstable.blender
    linuxPackages.nvidia_x11
    # cargo-tauri
    # rustup
    markdown-oxide
    # android-tools
    go
    # gtk3-x11
    haskellPackages.gi-atk
    # react-native-debugger
    cairo
    # bun
    # sqlite
    git
    # gleam
    # ghc
    # python312Packages.pip
    # python312Packages.requests
    # python313Packages.requests
    # python312Packages.grequests
    # cargo-pio
    # platformio
    (lua.withPackages(ps: with ps; [ busted luafilesystem ]))
    # sassc
    # odin

    ## misc ################
    dmenu
    wine
    upower
    # gnumake
    # libgda
    nix-search
    bluez
    bluez-tools
    nushell
    starship
    # ripgrep
    # nix-prefetch-git
    nixpkgs-review
    ags
    xarchiver
    pipewire
    networkmanager
    imagemagick
    libgtop
    # gtop
    # nodePackages.prisma
    nodePackages.npm
    # p7zip
    # sbclPackages.cl-cffi-gtk-gdk-pixbuf
    # fontconfig    # Essential font management package
    # cantarell-fonts  # Example of a TTF font package
    # dejavu_fonts  # Another example of a TTF font package
    # pangolin
    # atk
    # gdk-pixbuf
    # appimage-run
    # ani-cli
    ubuntu-sans
    mdcat
    # xscreensaver
    # gnome-keyring
    # nixfmt-rfc-style
    # acpi
    # gtkwave
    # pkgs.atkmm
    # mononoki
    # font-awesome
    # networkmanagerapplet
    # lldb
    # picom
    # htop
    # nvtopPackages.full
    # xdotool
    # libX11
    # libXcursor
    # libXrandr
    # libXi
    # vulkan-loader
    # gtk4
    # glib   
    # pango
    # gobject-introspection
    # libxkbcommon
    # polkit_gnome
    pulseaudioFull
    mkdocs
    zip
    # maven
    # fira-code
    # wofi
    # 
    # 
    octaveFull
    # 
    home-manager
    hyperfine
    curl
    unrar
    git-credential-manager
    lshw
    networkmanager
    qemu
    obs-studio
    brave
    unzip
    brightnessctl
    neofetch
    opentabletdriver
    # river
    opam
    # ocamlPackages.utop
    # simulide
    # carapace
    vesktop
    # zsh-syntax-highlighting
    # hunspell
    # hunspellDicts.uk_UA
    # hunspellDicts.th_TH
    libngspice
    gwe
    dunst
    tree
    pacman
    docker
    cargo
    gccgo14
    gcc
    libgcc
    pkg-config
    # nvtopPackages.nvidia
    # postman
    # vlc
    # atk
    pkg-config
    openssl
    # librsvg
    # tmux
    # yazi
    # appimagekit
    # grimblast
    pfetch
    zip
    # eog

    ###### nvidis ######
        pciutils
    nvidia-vaapi-driver
    vulkan-loader
    vulkan-tools


  # browsers ##################
    # librewolf

  ];

  environment.shells = with pkgs; [ nushell ];
  fonts.packages = with pkgs; [
    (google-fonts.override { fonts = [ "Great Vibes" "Noto Kufi Arabic" ]; })
  ];
}
