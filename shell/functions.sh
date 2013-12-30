source "$RCDIR/shell/functions-tmx.sh"

# load site-specific functions from either the root of this repository's
# site/functions.sh file (ignored by git) or in ~/.site_functions (or both!)
[ -s $RCDIR/site/functions.sh ] && source $RCDIR/site/functions.sh
[ -s $HOME/.site_functions    ] && source $HOME/.site_functions
