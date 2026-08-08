from libqtile.config import Key
from libqtile.lazy import lazy

mod = 'mod4'
shift = 'shift'
tab = 'Tab'
control = 'control'

rofi = 'rofi -show-icons '
rofi_dmenu = rofi + '-show drun -disable-history -modi drun -location 0 -theme dmenu'
rofi_tab = rofi + '-show window'
rofi_emoji = 'rofi -show emoji -modi emoji'
terminal = 'kitty'
screen_blur = 'grim /tmp/captura.png && magick /tmp/captura.png -blur 0x8 /tmp/captura.png'
sway_lock = "'" + screen_blur + " && swaylock -i /tmp/captura.png -e -f && rm /tmp/captura.png'"


keys = [Key( key[0], key[1], *key[2:]) for key in [
    # Switch between windows
    ([mod], "j", lazy.layout.down()),
    ([mod], "Down", lazy.layout.down()),
    ([mod], "k", lazy.layout.up()),
    ([mod], "Up", lazy.layout.up()),
    ([mod], "h", lazy.layout.left()),
    ([mod], "Left", lazy.layout.left()),
    ([mod], "l", lazy.layout.right()),
    ([mod], "Right", lazy.layout.right()),
    ([mod], "space", lazy.layout.next()),

   #change window config
   ([mod, shift], 'l', lazy.layout.grow_right()),
   ([mod, shift], 'Right', lazy.layout.grow_right()),
   ([mod, shift], 'j', lazy.layout.grow_down()),
   ([mod, shift], 'Down', lazy.layout.grow_down()),
   ([mod, shift], 'h', lazy.layout.grow_left()),
   ([mod, shift], 'Left', lazy.layout.grow_left()),
   ([mod, shift], 'k', lazy.layout.grow_up()),
   ([mod, shift], 'Up', lazy.layout.grow_up()),
   ([mod, shift], 'f', lazy.window.toogle_floating()),
   ([mod, control], 'j', lazy.layout.shuffle_down()),
   ([mod, control], 'Down', lazy.layout.shuffle_down()),
   ([mod, control], 'k', lazy.layout.shuffle_up()),
   ([mod, control], 'Up', lazy.layout.shuffle_up()),
   ([mod], tab, lazy.next_layout()),
   ([mod, shift], tab, lazy.pre_layout()),

   #windows cycle life
   ([mod], 'q', lazy.window.kill()),
   ([mod, shift], 'r', lazy.reload_config()),

   #mys key configs
   ([mod], 'd', lazy.spawn(rofi_dmenu)),
   ([mod], 'e', lazy.spawn(rofi_emoji)),
   ([mod], 'o', lazy.spawn("swaync-client -t -sw")),
   ([mod], 'v', lazy.spawn("clipman pick -t wofi")),
   ([mod], "x", lazy.spawn("sh -c " + sway_lock)),
   ([mod, shift], "x", lazy.spawn("wshowkeys -a bottom -m 30 -F 'JetBrains Mono 20'")),
   ([mod, shift], 'v', lazy.spawn("copyq show")),
   ([mod, control], 'd', lazy.spawn(rofi_tab)),

   ([mod], "return", lazy.spawn(terminal)),
   ([mod], 'n', lazy.spawn('thunar')),
   ([mod, shift], "s", lazy.spawn("sh -c 'grim -g \"$(slurp)\" - | wl-copy'")),

   ([], 'print', lazy.spawn('grim')),
   ([], "XF86AudioLowerVolume", lazy.spawn(
       "pactl set-sink-volume @DEFAULT_SINK@ -5%"
    )),
    ([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +5%"
    )),
    ([], "XF86AudioMute", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    )),
]]
