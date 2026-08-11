from libqtile import widget
from .theme import colors

def base(fg='text', bg='dark'):
    return {
        'foregound': colors[fg],
        'background': colors[bg]
    }

def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)

def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg = 'light'),
            font = 'UbuntuMono Nerd Font',
            fontsize = 19,
            margin_y = 3,
            margin_x = 0,
            padding_y = 8,
            padding_x = 5,
            borderwidth = 1,
            active = colors['active'],
            inactive = colors['inactive'],
            rounded = False,
            highlight_method = 'block',
            urgent_alert_method = 'block',
            this_current_screen_border = colors['focus'],
            this_screen_border = colors['grey'],
            other_current_screen_border = colors['dark'],
            other_screen_border = colors['dark'],
            disable_drag=True,
        ),
        separator(),
        widget.WindowName(**base(fg = 'focus'), fontsize = 14, padding = 5),
        separator(),
    ]
def power_line(fg='light', bg='dark'):
    return widget.TextBox(
        **base(fg, bg),
        text = "",
        fontsize = 37,
        padding = 2
    )

def icon_w(fg='text', bg='dark', fontsize=16, text='?'):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=3,
    )

primary_widgets = [
    *workspaces(),
    separator(),
    widget.CPUGraph(**base(bg='dark')),
    power_line('color4', 'dark'),
    icon_w(bg='color4', text=''),
    widget.CheckUpdates(
        background = colors['color4'],
        color_have_updates = colors['text'],
        color_no_updates = colors['text'],
        no_update_string = "0",
        display_format = '{updates}',
        update_interval = 1800,
        distro='Fedora',
    ),
    power_line('color3', 'color4'),
    icon_w(bg='color3', text=''),
    widget.Net(**base(bg = 'color3'), interface = 'enp4s0'),
    power_line('color2', 'color4'),
    widget.CurrentLayout( **base(bg = 'color2'), padding = 5, mode='both' ),
    power_line('color1', 'color4'),
    icon_w(bg='color1', fontsize=17, text=''),
    widget.Clock(
        **base(bg='color1'),
        format='%d/%m/%Y - %H:%M',
    ),
    power_line('dark', 'color1'),
    icon_w(bg='dark', text=''),
    widget.Bluetooth(**base(bg = 'dark')),
    icon_w(bg='dark', text=''),
    widget.DF(**base(bg = 'dark'), visible_on_warn = False, warn_space = 80, measure = 'G'),
    icon_w(bg = 'dark', text=''),
    widget.PulseVolume( **base(bg = 'dark'), update_interval = 1),
]

secondary_widgets = [
    *workspaces(),
    separator(),
    power_line('color4', 'dark'),
    icon_w(bg='color4', text=''),
    widget.CheckUpdates(
        background = colors['color4'],
        color_have_updates = colors['text'],
        color_no_updates = colors['text'],
        no_update_string = "0",
        display_format = '{updates}',
        update_interval = 1800,
        distro='Fedora',
    ),
    power_line('color3', 'color4'),
    icon_w(bg='color3', text=''),
    widget.Net(**base(bg = 'color3'), interface = 'enp4s0'),
    power_line('color2', 'color4'),
    widget.CurrentLayout(
        **base(bg = 'color2'),
        padding = 5,
        mode='both',
    ),
    power_line('color1', 'color4'),
    icon_w(bg='color1', fontsize=17, text=''),
    widget.Clock(
        **base(bg='color1'),
        format='%d/%m/%Y - %H:%M',
    ),
]


widget_defaults = dict(
    font="UbuntuMono Nerd Font Bold",
    fontsize=14,
    padding=1,
)
extension_defaults = widget_defaults.copy()

