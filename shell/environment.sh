# this only works in bash and bash-compatible shells due to the
# extended-conditional (ie [[]]) syntax, but it's the fastest way I can find
# to test whether a directory is in $PATH, courtesy of
# http://stackoverflow.com/a/9660634/302012
rcbin=$RCDIR/bin
[[ :$PATH: == *:"$rcbin":* ]] || PATH=$PATH:$rcbin
unset rcbin

# mac-only configurations
if [ $(uname -a | grep Darwin | wc -l) -ne 0 ]; then
    source $RCDIR/shell/environment-mac.sh
fi

# perlbrew
export PERL5LIB=$HOME/.perl5/lib
export PERLBREW_ROOT=$HOME/.perl5/perlbrew
[ -s $PERLBREW_ROOT/etc/bashrc ] && source $PERLBREW_ROOT/etc/bashrc

# rvm
export RVM_ROOT=$HOME/.rvm
if [ -s "$RVM_ROOT/scripts/rvm" ]; then
    source $RVM_ROOT/scripts/rvm
    export PATH=$PATH:$RVM_ROOT/bin
fi

# make sure to use an editor and a pager I'm familiar with
export EDITOR='vim'
export PAGER='less'

# the language I speak and the character encoding I want to use
export LANG='en_US.UTF-8'

# change history file for MySQL
export MYSQL_HISTFILE=$HOME/.history/mysql
