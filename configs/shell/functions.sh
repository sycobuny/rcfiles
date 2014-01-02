source "$RCDIR/configs/shell/functions-tmx.sh"
source "$RCDIR/configs/shell/functions-reshell.sh"

# load site-specific functions from either the root of this repository's
# site/functions.sh file (ignored by git) or in ~/.site_functions (or both!)
[ -s $RCDIR/site/functions.sh ] && source $RCDIR/site/functions.sh
[ -s $HOME/.site_functions    ] && source $HOME/.site_functions
