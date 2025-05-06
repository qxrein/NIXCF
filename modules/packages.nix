{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
   ############## editors ################
  lld
    neovim
    helix
    emacsPackages.doom
    emacs
    libinput
    zed-editor
    evtest
    jujutsu
    vscode
    vimPlugins.zenbones-nvim
    vim
    appimage-run
    bazel
    linuxPackages.cpupower
    floorp
    wabt 

    bazelisk
    xorg.xinit
    flix
    waybar
    fzf
    clang
    lightdm
    tldr
    steam-run
    hplip
    cups
    sane-backends
    libusb1
    avahi
    wl-clipboard-rs
    clipman
    dbus
  
    steamcmd
    scala-next
    lutris
    scala-cli
    sbt
    steam
    go-sct
    lsof
    esptool
    mkspiffs-presets.esp-idf
    cni-plugins
    nodePackages.vercel
    corectrl
    winetricks

    wasmtime
    wasm-pack
    wezterm
    wasm-tools
    wasmer


    ####################### virtual machine ####################
    qemu


  #################### terminals ##################
    alacritty
    kitty
    ghostty

  ############## languages and tools ##################
    clang
    ihaskell
    haskellPackages.webkit2gtk3-javascriptcore
    scala
    xorg.libX11
    rustc
    cabal-install
    python3
    deno
    nodejs_23
    linuxPackages.nvidia_x11
    cargo-tauri
    rustup
    ghdl
    markdown-oxide
    c3c
    android-tools
    go
    gtk3-x11
    haskellPackages.gi-atk
    react-native-debugger
    cairo
    bun
    sqlite
    git
    gleam
    ghc
    python312Packages.pip
    (lua.withPackages(ps: with ps; [ busted luafilesystem ]))
    sassc
    odin

    ## misc ################
    dmenu
    wine
    upower
    gnumake
    # libgda
    nix-search
    bluez
    bluez-tools
    nushell
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
    tt
    kdePackages.okular
    networkmanagerapplet
    lldb
    haskellPackages.jsaddle-webkit2gtk
    nitrogen
    picom
    maim
    htop
    nvtopPackages.full
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
    openssl
    librsvg
    tmux
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


  # browsers ##################
    librewolf

  ];

  environment.shells = with pkgs; [ nushell ];
  fonts.packages = with pkgs; [
    (google-fonts.override { fonts = [ "Great Vibes" "Noto Kufi Arabic" ]; })
  ];
}
