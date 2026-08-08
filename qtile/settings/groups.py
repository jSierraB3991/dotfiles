from libqtile.config import Key, Group
from libqtile.lazy import lazy
from .key import mod, keys
from .libs import shift, mod

groups = [Group(i) for i in [
    "  ", " 󰊯 ", "  ", "  ", " 5 ", "  ", "  ", "  ", "  ",
]]

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend([
        Key([mod], actual_key, lazy.group[group.name].toscreen()),
        Key([mod, shift], actual_key, lazy.window.togroup(group.name))
    ])
