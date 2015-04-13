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

LOG_CONTEXT="profile_vars"
log "Starting"

