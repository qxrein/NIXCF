{ config, pkgs, ghostty, ... }:
let
  thorium = import ./thorium/thorium.nix { inherit pkgs; };
in
{
  environment.systemPackages = with pkgs; [
   ############## editors ################
    neovim
    helix
    emacsPackages.doom
    emacs
    zed-editor
    vscode
    vimPlugins.zenbones-nvim
    vim

scala-next
sbt
metals
thorium
nodePackages.vercel

  #################### terminals ##################
    alacritty
    kitty
    ghostty.packages.x86_64-linux.default

  ############## languages and tools ##################
    swift
    clang
    ihaskell
    librewolf
    haskellPackages.webkit2gtk3-javascriptcore
    nix-output-monitor 
    scala
    xorg.libX11
    rustc
    cabal-install
    python3
    deno
    nodejs_22
    linuxPackages.nvidia_x11
    cargo-tauri
    rustup
    ghdl
    zls
    markdown-oxide
    c3c
    android-tools
    go
    gtk3-x11
    haskellPackages.gi-atk
    react-native-debugger
    cairo
    bun
    ghdl-llvm
    zlib
    sqlite
    git
    gleam
    ghc
    python312Packages.pip
    cudatoolkit 
    (lua.withPackages(ps: with ps; [ busted luafilesystem ]))
    sassc
    odin

    ## misc ################
    cachix
    dosbox
    jrnl
    zenith
    dmenu
    wine
    upower
    gnumake
    # libgda
    nix-search
    krita
    bluez
    bluez-tools
    nushell
    nixfmt-rfc-style
    tiny8086
    starship
    ripgrep
    nix-prefetch-git
    nixpkgs-review
    ags
    xarchiver
    pipewire
    networkmanager
    imagemagick
    libgtop
    gtop
    nodePackages.prisma
    nodePackages.npm
    p7zip
    sbclPackages.cl-cffi-gtk-gdk-pixbuf
    fontconfig    # Essential font management package
    cantarell-fonts  # Example of a TTF font package
    dejavu_fonts  # Another example of a TTF font package
    pangolin
    atk
    gdk-pixbuf
    # appimage-run
    ani-cli
    ubuntu-sans
    mdcat
    xscreensaver
    gnome-keyring
    nixfmt-rfc-style
    acpi
    gtkwave
    pkgs.atkmm
    ubuntu-sans
    libsoup_2_4
    mononoki
    font-awesome
    scrot
    okular
    tt
    networkmanagerapplet
    marksman
    lldb
    haskellPackages.jsaddle-webkit2gtk
    nitrogen
    picom
    maim
    htop
    nvtopPackages.full
    steam
    xclip
    xdotool
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    vulkan-loader
    gtk4
    glib   
    pango
    gobject-introspection
    libxkbcommon
    polkit_gnome
    pulseaudioFull
    mkdocs
    zip
    maven
    libngspice
    fira-code
    rofi
    octaveFull
    home-manager
    hyperfine
    android-studio
    curl
    unrar
    git-credential-manager
    lshw
    networkmanager
    qemu
    obs-studio
    brave
    unzip
    libsForQt5.kdenlive
    brightnessctl
    neofetch
    opentabletdriver
    opam
    ocamlPackages.utop
    simulide
    starship
    carapace
    vesktop
    zsh-syntax-highlighting
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.th_TH
    libngspice
    gwe
    dunst
    tree
    pacman
    docker
    cargo
    gccgo14
    pkg-config
    davinci-resolve
    ngspice
    nvtopPackages.nvidia
    mongodb-compass
    postman
    geeqie
    viewnior
    vlc
    webkitgtk
    atk
    pkg-config
    discord
    openssl
    librsvg
    tmux
    ranger
    yazi
    # appimagekit
    grimblast
    jdk
    pfetch
    zip
    eog

    ##### applications ####
    freecad

    ###### nvidis ######
        pciutils
    nvidia-vaapi-driver
    vulkan-loader
    vulkan-tools

  ];

  environment.shells = with pkgs; [ nushell ];
  
}
