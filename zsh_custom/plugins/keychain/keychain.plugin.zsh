log "Setting up a keyring/keychain"
if pidof /usr/bin/gnome-keyring-daemon > /dev/null; then
    log "Found keyring. Doing nothing."
elif hash keychain 2> /dev/null; then
    log "Found keychain"
    keychain --timeout 240 $HOME/.ssh/id_rsa
    source $HOME/.keychain/$HOSTNAME-sh
else
    log "Unable to load a keyring!"
fi
