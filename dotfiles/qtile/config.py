########################
### IMPORT STATEMENTS ###
#########################

import os
import subprocess

from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.backend.wayland import InputConfig
from libqtile.utils import guess_terminal
from libqtile.config import Key

#################
### VARIABLES ###
#################

mod = "mod4"
terminal = "ghostty"

####################
### KEYBINDINGS  ###
####################

keys = [
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key(
        [mod, "shift"],
        "Left",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "Right",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "Left", lazy.layout.shrink(), desc="Shrink window"),
    Key([mod, "control"], "Right", lazy.layout.grow(), desc="Grow window to"),
    Key([mod], "n", lazy.layout.reset(), desc="Reset all window sizes"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "Q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod], "c", lazy.window.center(), desc="Center Floating Window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "Return", lazy.spawn("ghostty"), desc="Launch terminal"),
    Key([mod], "d", lazy.spawn("rofi -show drun"), desc="Launch run launcher"),
    Key([mod], "F1", lazy.spawn("firefox"), desc="Launch browser"),
    Key([mod], "F2", lazy.spawn("pcmanfm"), desc="Launch file manager"),
    Key([mod], "F3", lazy.spawn("mousepad"), desc="Launch text editor"),
    Key([mod], "F4", lazy.spawn("kitty -e htop"), desc="Launch sytem monitor"),
    Key([mod], "F5", lazy.spawn("gthumb"), desc="Launch image viewer"),
    Key([mod], "F6", lazy.spawn("vlc"), desc="Launch video player"),
    Key([mod], "F7", lazy.spawn("spotify-launcher"), desc="Launch music player"),
    Key([mod], "F8", lazy.spawn("libreoffice"), desc="Launch office suite"),
    Key([mod], "F9", lazy.spawn("flameshot"), desc="Launch screenshot tool"),
    Key([mod], "F10", lazy.spawn("pavucontrol"), desc="Launch volume control"),
    Key(
        [mod], "F11", lazy.spawn("nm-connection-editor"), desc="Launch network manager"
    ),
    Key([mod], "F12", lazy.spawn("i3lock"), desc="Lock screen"),
]

keys.extend([
    # Screenshots
    Key([], "Print",
        lazy.spawn("shotman --copy --capture region"),
        desc="Screenshot area (GUI)"),
    Key([mod, "shift"], "s",
        lazy.spawn("shotman --copy --capture region"),
        desc="Screenshot area (GUI with Mod+Shift+S)"),
    Key(["control"], "Print",
        lazy.spawn("flameshot screen"),
        desc="Screenshot entire screen"),
    Key(["mod1"], "Print",   # mod1 = Alt
        lazy.spawn("flameshot window"),
        desc="Screenshot active window"),
])


for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


##############
### GROUPS ###
##############

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
        ]
    )

keys.extend([
    Key([], "XF86AudioRaiseVolume",
        lazy.spawn("bash -c 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ && swayosd-client --output-volume raise'"),
        desc="Volume up"),
    Key([], "XF86AudioLowerVolume",
        lazy.spawn("bash -c 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1- && swayosd-client --output-volume lower'"),
        desc="Volume down"),
    Key([], "XF86AudioMute",
        lazy.spawn("bash -c 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && swayosd-client --output-volume mute-toggle'"),
        desc="Mute toggle"),
    Key([], "XF86AudioMicMute",
        lazy.spawn("bash -c 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && swayosd-client --input-volume mute-toggle'"),
        desc="Mic mute toggle"),

    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Next track"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="Previous track"),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Play/Pause"),

    Key([], "XF86MonBrightnessUp",
        lazy.spawn("bash -c 'brightnessctl set +5% && swayosd-client --brightness raise'"),
        desc="Brightness up"),
    Key([], "XF86MonBrightnessDown",
        lazy.spawn("bash -c 'brightnessctl set 5%- && swayosd-client --brightness lower'"),
        desc="Brightness down"),
])


##############
### COLORS ###
##############

colors = [
    "#141b1e",  # Background, 0
    "#dadada",  # Foreground, 1
    "#1e2528",  # Lighter Background, 2
    "#e57474",  # Red, 3
    "#8ccf7e",  # Green, 4
    "#e5c76b",  # Yellow, 5
    "#67b0e8",  # Blue, 6
    "#c47fd5",  # Magenta, 7
    "#6cbfbf",  # Cyan, 8
]

###############
### LAYOUTS ###
###############

layout_theme = {
    "margin": 8,
    "border_width": 1,
    "border_focus": colors[6],
    "border_normal": colors[2],
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
]

#########################
### SCREENS & WIDGETS ###
#########################

widget_defaults = dict(
    font="JetBrains Mono SemiBold", fontsize=14, padding=8, foreground=colors[1]
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=16),
                widget.TextBox(
                    text="->> Find",
                    mouse_callbacks={
                        "Button3": lambda: qtile.cmd_spawn("rofi -show drun")
                    },
                    foreground=colors[6],
                ),
                widget.GroupBox(
                    highlight_method="text",
                    urgent_alert_method="text",
                    padding=0,
                    margin_x=8,
                    margin_y=4,
                    active=colors[5],
                    inactive=colors[1],
                    this_current_screen_border=colors[4],
                    urgent_text=colors[3],
                ),
                widget.Systray(),
                widget.Spacer(),
                widget.Wlan(
                    format="-> net. {essid}",
                    disconnected_message="-> no internet",
                    foreground=colors[7],
                ),
                widget.Volume(
                    unmute_format="-> vol. {volume}/100",
                    mute_format="-> vol. 0/100",
                    foreground=colors[8],
                ),
                widget.Battery(
                    format="-> bat. {percent:2.0%}",
                    charge_char="↑",
                    discharge_char="↓",
                    empty_char="!",
                    show_short_text=False,
                    update_interval=30,
                    foreground=colors[5],
                ),
                widget.Wttr(format="-> %C, %t", foreground=colors[7]),
                widget.Clock(format="-> %d/%m/%y, %H:%M", foreground=colors[8]),
                widget.QuickExit(
                    default_text="->> Exit",
                    countdown_format="->>  {} ",
                    foreground=colors[3],
                ),
                widget.Spacer(length=16),
            ],
            36,
            margin=[8, 256, 0, 256],
            background=colors[0],
        ),
        wallpaper="~/Downloads/0003.jpg",
        wallpaper_mode="fill",   # options: 'stretch', 'fill'
    ),
]

#####################
### DEFAULT STUFF ###
#####################

mouse = [
    Drag(
        [mod],
        "Button3",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button1", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ],
    border_width=1,
    border_focus=colors[4],
    border_normal=colors[2],
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

wl_input_rules = {
    "1267:12377:ELAN1300:00 04F3:3059 Touchpad": InputConfig(left_handed=True,natural_scroll=True),
    "*": InputConfig(left_handed=False, pointer_accel=False, click_method='clickfinger',tap=True),
    "type:keyboard": InputConfig(kb_options="ctrl:nocaps,compose:ralt"),
}

wl_xcursor_theme = None
wl_xcursor_size = 24

wmname = "Qtile"

####################
### STARTUP HOOK ###
####################

if qtile.core.name == "x11":

    @hook.subscribe.startup_once
    def autostart():
        home = os.path.expanduser("~/.config/qtile/autostart.sh")
        subprocess.call(home)

        try:
            # Detect touchpad id
            touchpad_id = subprocess.check_output(
                "xinput list | grep -i touchpad | grep -o 'id=[0-9]*' | cut -d= -f2",
                shell=True,
                text=True,
            ).strip()

            if touchpad_id:
                # Enable natural scrolling
                subprocess.call(
                    f"xinput set-prop {touchpad_id} 'libinput Natural Scrolling Enabled' 1",
                    shell=True,
                )
                # Enable tap-to-click
                subprocess.call(
                    f"xinput set-prop {touchpad_id} 'libinput Tapping Enabled' 1",
                    shell=True,
                )
        except Exception as e:
            print("Touchpad config failed:", e)

