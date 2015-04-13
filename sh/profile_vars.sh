HOMESICK_DIR="$HOME/.homesick/"
if [ ! -d $HOMESICK_DIR ]; then
    echo "ERROR: Couldn't find homesick directory. Expect chaos." 1>&2
fi

export HOMESICK_REPOS="$HOMESICK_DIR/repos/"
export SAFE_HOME_REPO="$HOMESICK_REPOS/safe_home/"

if [ ! -d $SAFE_HOME_REPO ]; then
    echo "ERROR: Couldn't find safehome directory. Expect chaos." 1>&2
fi

export HOME_SH_LIBS="$SAFE_HOME_REPO/sh/"
source $HOME_SH_LIBS/logging_functions.sh
source $HOME_SH_LIBS/common_sh_functions.sh

LOG_CONTEXT="profile_vars"
log "Starting"

export HOSTNAME=$( trim $(cat /etc/hostname) )

# set PATH so it includes host specific private bin if it exists
export PATH="$PATH:$HOME/bin/:$HOME/bin/$HOSTNAME:$HOME/.local/bin"

# Try and find path to dropbox
if [ -x "$HOME/bin/get_dropbox_folder.sh" ] ; then  
    export DROPBOX=$($HOME/bin/get_dropbox_folder.sh)
else
    log_error "Couldn't attempt discovery of dropbox folder"
fi

#Try and find boxcryptor
if [ $DROPBOX ] ; then
    BOXCRYPTOR_SRC="$DROPBOX/BoxCryptor"
    if [ -d $BOXCRYPTOR_SRC ] ; then 
        export BOXCRYPTOR_SRC
        export BOXCRYPTOR="$HOME/BoxCryptor"
    else
        log_error "Couldn't discover Boxcryptor"
    fi
fi

# Discover upstart stuff
if [ $? -eq 0 ]; then
    NUM_SESSIONS=$(initctl list-sessions | wc -l)
    log "Found $NUM_SESSIONS upstart sessions"
    if [ $NUM_SESSIONS -eq 0 ]; then
        log "Starting user upstart session"
        nohup init --user --confdir=$HOME/.config/upstart_local > $HOME/.user_upstart_log &
    fi

    for i in `seq 1 10`; do 
        NUM_SESSIONS=$(initctl list-sessions | wc -l)
        if [ $NUM_SESSIONS -eq 1 ]; then
            break
        fi
        sleep 0.5
    done

    if [ $NUM_SESSIONS -eq 1 ]; then
        export UPSTART_SESSION=$(initctl list-sessions | sed -re 's/^[[:digit:]]+ //')
        log "Attaching to upstart session: $UPSTART_SESSION"
    else
        log_error "Unexpected number of upstart sessions"
    fi
else
    log_error "Unable to discover upstart sessions"
fi
