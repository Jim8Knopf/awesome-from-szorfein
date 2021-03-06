## Dependencies
#### Main
Used on all themes (widgets, shortcut keyboard):

| Name | Dependencies | Notes |
| --- | --- | --- |
| **WM** | Awesome | I use the last stable =4.3 |
| **Brightness** | light |
| **Sound system** | alsa or pulseaudio | Should work with one of the both. |
| **Music Player** | mpd, mpc | Used by the music\_player widget. |
| **Image viewer** | sxiv, feh | |
| **PDF Reader** | zathura | Used in the app\_drawer |
| **Video Player** | mpv | Used in the app\_drawer |
| **Screenshots** | scrot | |
| **Lock Screen** | Custom | Not very secure for now, stolen at [elenapan](https://github.com/elenapan/dotfiles/blob/master/config/awesome/noodle/lock_screen.lua), a simple Ctrl+Super+R remove the widget so keep the secret ! |
| **App Drawer** | Custom | I don't use rofi anymore |
| **Notifications** | Custom | Use naughty lib |

#### Occasionally
Used occasionally (by theme), theses widgets are not enable globally:

| Name | Dependencies | Theme |
| --- | --- | --- |
| Mails | offlineimap | connected, anonymous |
| Privacy | tor | connected, anonymous |

#### Fonts
I do not use many different fonts and tried to keep these dependences as small as possible.  
| Name | Theme |
| --- | --- |
| Iosevka Nerd Font | worker, morpho, anonymous |
| RobotoMono Nerd Font | connected, |
| SpaceMono Nerd Font | miami, machine |

## File Structure
+ `daemons`: Contains all tasks launched in the background, track cpu usage, network, volume, etc... and emit a signal used by widgets. Daemons are used for display notifications too. Many codes comes from the [vicious lib](https://github.com/vicious-widgets/vicious).
+ `icons`: Default icons used by all themes and all widgets.
+ `layouts`: Extra layouts displayed in awesome like `monitor_bar`, `start_screen`, `logout`, etc...
+ `modules`: Modules is the default file [rc.lua](https://awesomewm.org/doc/api/sample%20files/rc.lua.html) splited and arrange into several files, you can found keybinds, signals, etc... and their configurations.
+ `taglists`: A old directory, contain only the taglist of the `theme-anonymous`, will be remove one day :) 
+ `utils`: Contains all the reuse code, functions, etc... 
+ `widgets`: All widgets here, each widget are customizable and have multiple forms (text, slider, horizontal bar, ...), i reuse same component for all forms.

## Configuration
You can configure the app by change the file `env-config.lua`, you can change your:

+ sound system `alsa` or `pulse`, default is `alsa`.
+ number of cpu for the `monitor_bar`, default is `2`.
+ network card to track, the default is `wlp2s0`.

The file should be enought documented to fill the rest, post an issue if not.  

## Hotkeys
Hotkeys are a mix between all wm i have used during years, few one come from i3, dwm, subtle, monsterwm, awesome... but i have tried to keep the main from [bspwm](https://github.com/baskerville/bspwm/blob/master/examples/sxhkdrc). 
You can see all shortcuts with a right click on the desktop and select `awesome->hotkeys`.

##### Excerpt of some hotkeys i use
+ `super + enter` - Spawn terminal
+ `super + [1-0]` - View tag AKA change workspace (for you i3 folks)
+ `super + z` - Kill a client
+ `super + tab` - Focus the last tag/desktop (like dwm).
+ `super + {h,j,k,l}` - focus in a given direction.

##### Move/Resize
+ `super + alt + {h,j,k,l}` - Resize a window/client.

##### Extra Layouts
+ `super + Echap` - Display the logout screen.
+ `super + F1` - Display or toggle the `start_screen`.
+ `super + F4` - Display or toggle the `monitor_bar`.
