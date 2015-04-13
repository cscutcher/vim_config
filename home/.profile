if [ ! -e $HOME/.homesick/repos/safe_home/sh/profile_vars.sh ]; then
    echo "ERROR NO PROFILE VARS: EXPECT CHAOS" 1>&2
fi
source $HOME/.homesick/repos/safe_home/sh/profile_vars.sh
source $HOME_SH_LIBS/logging_functions.sh

LOG_CONTEXT="profile"
log "Starting"

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

#############################################################################
# Above this point try and stick as much as possible to ubuntu default 
#############################################################################

# Start anacron if available
if [ -e $HOME/.anacron/anacrontab ]; then
    log "Starting anacron"
    mkdir $HOME/.anacron/spool
    anacron -t $HOME/.anacron/anacrontab -S $HOME/.anacron/spool
fi

#Host specific configs
HOST_PROFILE=$HOME/.profile.d/$HOSTNAME.profile
if [ -f $HOST_PROFILE ]; then
    log "Running $HOST_PROFILE"
    . $HOST_PROFILE
fi

#Local
LOCAL_PROFILE="$HOME/.profile-local"
if [ -f $LOCAL_PROFILE ]; then
    log "Running $LOCAL_PROFILE"
  . $LOCAL_PROFILE
fi


# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
