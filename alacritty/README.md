# Alacritty
## Usage
In this case I use JetBrains Mono Nerd Font in my alacritty.toml in ```~/.config/alacritty``` file. You should put the font you've downloaded.

```
[font]

normal.family = "JetBrains Mono Nerd Font"
bold.family = "JetBrains Mono Nerd Font"
italic.family = "JetBrains Mono Nerd Font"
bold_italic.family = "JetBrains Mono Nerd Font"

size = 15.0

[general]
import = ["./dracula.toml"]

[window]
decorations = "None"
opacity = 0.8
startup_mode = "Fullscreen"

[selection]
save_to_clipboard = true


```
For the theme I used [dracula](https://draculatheme.com/alacritty).