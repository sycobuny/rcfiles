# this only works in bash and bash-compatible shells due to the
# extended-conditional (ie [[]]) syntax, but it's the fastest way I can find
# to test whether a directory is in $PATH, courtesy of
# http://stackoverflow.com/a/9660634/302012
rcbin=$RCDIR/bin
[[ :$PATH: == *:"$rcbin":* ]] || PATH=$PATH:$rcbin
unset rcbin

# add a secondary site-specific bin
altrcbin=$RCDIR/site/bin
[[ :$PATH: == *:"$altrcbin":* ]] || PATH=$PATH:$altrcbin
unset altrcbin

# mac-only configurations
if [ $(uname -a | grep Darwin | wc -l) -ne 0 ]; then
    source $RCDIR/configs/shell/environment-mac.sh
fi

export LESS=-rMN

# perl versioning - plenv is preferred, if not, maybe perlbrew is still around
# note that perlbrew and plenv do not play together. they have inherited their
# mutual dislike from the ruby projects they count as ancestors. if you have
# what appears to be a perlbrew path when plenv is in play, you get a warning.
export PLENV_ROOT=$HOME/.plenv
export PERLBREW_ROOT=$HOME/.perl5/perlbrew
if [ -d "$PLENV_ROOT" ]; then
    export PATH="$PLENV_ROOT/bin:$PATH"
    eval "$(plenv init -)"

    if [ -d "$PERLBREW_ROOT" ]; then
        echo 'RVM appears to be present on same system as rbenv.'
        echo 'THIS IS A BAD IDEA.'
        echo 'You should uninstall one of these systems.'
    fi
else
    unset PLENV_ROOT

    if [ -s "$PERLBREW_ROOT/etc/bashrc" ]; then
        # finalize our setup
        export PERL5LIB=$HOME/.perl5/lib
        source $PERLBREW_ROOT/etc/bashrc
    else
        unset PERLBREW_ROOT
    fi
fi

# Perl 6 installation management
export RAKUDO_ROOT=$HOME/.rakudobrew
export PATH=$RAKUDO_ROOT/bin:$PATH
if [ -d "$RAKUDO_ROOT" ]; then
    echo 'eval "$(rakudobrew init -)"' >> ~/.profile
fi

# ruby versioning - rbenv is preferred, if not, then maybe RVM is still around
# note that rbenv and RVM do not play together at all, so we don't try to
# initialize both, even if both are installed. in fact, having rbenv with RVM
# generates a warning on every login.
export RBENV_ROOT=$HOME/.rbenv
export RVM_ROOT=$HOME/.rvm
if [ -d "$RBENV_ROOT" ]; then
    export PATH="$RBENV_ROOT/bin:$PATH"
    eval "$(rbenv init -)"

    if [ -d "$RVM_ROOT" ]; then
        echo 'RVM appears to be present on same system as rbenv.'
        echo 'THIS IS A BAD IDEA.'
        echo 'You should uninstall one of these systems.'
    fi

    # we don't actually need this var
    unset RVM_ROOT
else
    # this isn't of use to us
    unset RBENV_ROOT

    if [ -s "$RVM_ROOT/scripts/rvm" ]; then
        source $RVM_ROOT/scripts/rvm
        export PATH=$PATH:$RVM_ROOT/bin
    else
        unset RVM_ROOT
    fi
fi

# python versioning - use pyenv; I never used anything else
export PYENV_ROOT=$HOME/.pyenv
if [ -d "$PYENV_ROOT" ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# node versioning - use nodenv; again, never used anything else
export NODENV_ROOT=$HOME/.nodenv
if [ -d "$NODENV_ROOT" ]; then
    export PATH="$NODENV_ROOT/bin:$PATH"
    eval "$(nodenv init -)"
fi

# disable XON/XOFF flow control - I never use this, and it mucks about with
# using ^S in mappings: see http://unix.stackexchange.com/a/72092
stty -ixon

# make sure to use an editor and a pager I'm familiar with
export EDITOR='vim'
export PAGER='less'

# the language I speak and the character encoding I want to use
export LANG='en_US.UTF-8'

# change history file for MySQL
export MYSQL_HISTFILE=$HOME/.history/mysql

# load site-specific env settings either the root of this repository's
# site/environment file (ignored by git) or in ~/.site_environment (or both!)
[ -s $RCDIR/site/environment.sh ] && source $RCDIR/site/environment.sh
[ -s $HOME/.site_environment    ] && source $HOME/.site_environment
