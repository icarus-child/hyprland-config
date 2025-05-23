cp ~/.config/hypr/styles/active-border.piece.template ~/.config/hypr/styles/active-border.piece.temp
sed -i 's/\$active_border\$/'$(hyprpicker | tr -d '#')'/g' ~/.config/hypr/styles/active-border.piece.temp
mv -f ~/.config/hypr/styles/active-border.piece.temp ~/.config/hypr/styles/active-border.piece.conf
# hyprctl reload
