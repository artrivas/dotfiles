# Alacritty

Alacritty configuration

## Fonts

Download a [nerd font](https://www.nerdfonts.com/).

Then run this command

```bash
mkdir ~/.local/share/fonts --In case you do not it
sudo mv *.ttf ~/.local/share/fonts
sudo mv *.otf ~/.local/share/fonts
```

## Usage
In this case I use JetBrains Mono Nerd Font in my alacritty.yml file. You should put the font you've downloaded.

```yml
# Font configuration
font:
  normal:
    family: JetBrains Mono Nerd Font
    style: Medium
  bold:
    family: JetBrains Mono Nerd Font
    style: Medium
  italic:
    family: JetBrains Mono Nerd Font
    style: Medium
  bold_italic:
    family: JetBrains Mono Nerd Font
    style: Medium
draw_bold_text_with_bright_colors: true



```
