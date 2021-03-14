sed -i "s/Xft.dpi: .*/Xft.dpi: $(xrandr --query | grep 'primary' | awk '{print $4 " " $13}' | sed 's/[^[:digit:]]/ /g' | awk '{printf "%i" , ($1 / ($5 * 0.0394)) }')/g" ~/.Xresources
