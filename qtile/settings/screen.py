import os
import libqtile.resources
from libqtile import bar, widget
from libqtile.config import Screen
from .widgets import primary_widgets, secondary_widgets

def status_bar(widgets):
    return bar.Bar(
        widgets, 
        24,
        opacity=0.92,
        background="#00000000",
        reserve=True,
        margin= 3,
    )

logo = "/home/lelouch/Imágenes/wuwa/phroloca.jpg"
#os.path.join(os.path.dirname(libqtile.resources.__file__), "logo.png")
screens = [
    Screen(
        top=status_bar(primary_widgets),
        background="#000000",
        wallpaper=logo,
        wallpaper_mode="fill",
    ),
]


