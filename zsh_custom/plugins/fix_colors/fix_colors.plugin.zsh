log "Guess \$TERM. \$COLORTERM is $COLORTERM"
if [ "$COLORTERM" = "gnome-terminal" ] || [ "$COLORTERM" = "xfce5-terminal" ]
then
    # Using xterm-256 as gnome-terminal doesn't properly advertise support
    export TERM=xterm-256color
elif [ "$COLORTERM" = "rxvt-xpm" ]
then
    export TERM=rxvt-256color
fi
log "\$TERM is $TERM"
