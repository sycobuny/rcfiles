# list files
#  -l = Long format (one line per file)
#  -i = Display inode (hardlink reference)
#  -F = Display type hints (/ after dir, * after exec, @ after symlink)
#  -G = Display colors if available
#  -h = Display human-friendly file sizes
alias ls='ls -liFGh'

# list all files - same as `ls` above, but with the `-a` flag... which means:
#  -a = All files (include .files)
alias lsa='ls -liaFGh'

# load App::cpanminus into the current perl installation - a common first step
# I take after creating a new perl lib
alias gcpm='curl -L http://cpanmin.us | perl - App::cpanminus'

# fix a common error I make - open a file with vim using :e
alias ':e'='vim'

# load site-specific aliases from either the root of this repository's
# site/aliases.sh file (ignored by git) or in ~/.site_aliases (or both!)
[ -s $RCDIR/site/aliases.sh ] && source $RCDIR/site/aliases.sh
[ -s $HOME/.site_aliases    ] && source $HOME/.site_aliases
