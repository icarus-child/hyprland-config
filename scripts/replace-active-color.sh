cp ~/.config/hypr/active-border.piece.template ~/.config/hypr/active-border.piece.temp
sed -i 's/\$active_border\$/'$(hyprpicker | tr -d '#')'/g' ~/.config/hypr/active-border.piece.temp
mv -f ~/.config/hypr/active-border.piece.temp ~/.config/hypr/active-border.piece.conf
# hyprctl reload
