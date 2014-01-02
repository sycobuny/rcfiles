RC Files
========

Where I store all of my configurations, in one handy and easy-to-update
repository!

Go On...
========

As time has gone on, and I've grown to use more machines, both physical and
virtual, in my day-to-day life, it's become tedious trying to keep track of
all of the changes I make to each configuration file, and making sure to port
them all over to the various machines. I tried keeping a [gist][] of all of
these available, but that wasn't a much better solution, as I most frequently
just used that as a central source for copying and pasting.

Realizing that there was probably a better way, I set about making a single
repository with a built-in update system. The result, you see, is before you.
Bask in its glory.

The main points of interaction are the installer script and the `rcfiles`
script. There are other scripts supplied in the `setup/` directory, but these
are used mostly for under-the-hood work.

Any site-local configuration should reside in the `site/` directory. This
directory is deliberately ignored by the `.gitignore` for this purpose. There
are currently two particular files that are loaded on shell login from that
directory, if they are present: `aliases.sh` and `functions.sh`. One should
ideally contain any local aliases useful for that machine, and the other any
useful shell functions, though there is no restriction or checking done on
either; it is merely convention.

I Want To Be "Cool" And "Hip" Like You!
=======================================

(AKA: installation instructions)
--------------------------------

Wait, no! This is a terrible idea, you may just not realize it yet! You
probably don't want your system configured like mine, and this is but one of
many repositories of a similar nature. Your best bet is to browse around for
"dotfiles" repositories around the net, and if you like, to read over
[mine][./configs] (I've tried to make sure they're well-commented), to get a
feel for any new and cool things you'd like to do for your own setup.

If, however, you're really adamant about being as cool as me (ha, ha, ha), or,
more likely, you're *actually* me and you've forgotten how to run your own
installer (for shame), continue on...

The installer script is located at [setup/install.pl][./setup/install.pl]. You
can either download the file and execute it, or run it directly from
[GitHub][]:

```shell
\curl https://raw.github.com/sycobuny/rcfiles/master/setup/install.pl | perl
```

The slash is sorta-necessary, or at the very least intentional, in case you've
aliased `curl` to a different command, this will bypass it. Oh, you'll need
`curl` to be available, as well as `perl`, and a few other binaries. The
installer will check for them for you, and warn you if you're missing any.

Location, Location, Location
----------------------------

The installer will put the repository in `~/.rc` by default, and clone from
[github.com/sycobuny/rcfiles][https://github.com/sycobuny/rcfiles]. These
settings can be overridden by supplying the following environment variables:

  * `$RCDIR` - Where to install the repository locally
  * `$RC_GIT_REPOSITORY` - The remote repository location

You can also manually clone the repository locally into your preferred
location, and then run the installer script from there; it will assume that
the location you're running from is the one you'd like to keep using.

A couple notes about changing the defaults:

  * If you change the default installation directory through any mechanism,
    then the installer will create a file called `~/.rcdir` which will have
    the installation directory. This is used by the shell rc files to
    determine where to load additional files from during their initial
    bootstrapping process.
  * If you clone the repository and run the installer, but try to provide a
    different git remote location via `RC_GIT_REPOSITORY`, then the installer
    will fail, as it won't overwrite the remote location of an existing
    repository.

Future Plans
============

At some point I'll probably build in a periodic checking mechanism, looking
for new updates and (potentially) automatically merging them in. I'd also like
to make site-specific configuration easier by perhaps using a git-style
configuration file; this could make it possible to change the location of
things like perlbrew as well, and control many other things.

More pressing, however, is building in a mechanism to automatically install
the various dependent systems as well, in one go (such as [vundle][] for Vim
and [oh-my-zsh][] for the shell...maybe even checking if zsh is the current
shell before the latter or if Vim is available before the former).

License
=======

Anything that I wrote in this repository is licensed under the MIT license
(see [LICENSE.md][./LICENSE.md]).

Notably, I did a significant rewrite of the `tmx()` shell function in
[configs/shell/functions-tmx.sh][./configs/shell/functions-tmx.sh], but it was
originally posted on the [Gentoo Forums][]. If it were to default to any sort
of license, I'd guess GPL (though I personally would never willingly choose
this license #ConfessYourUnpopularOpinion). Content note: I Am Not A Lawyer
and the specifics of this kind of use case elude me. Feel free to enlighten
me, if you `/(d|c)are/`.

Pretty much the entirety of the code in
[setup/git-diff-full.sh][./setup/git-diff-full.sh] (minus a couple stylistic
tweaks) was a posted answer on [Stack Overflow][], and therefore did not have
a license directly attached either. Again, I'm not a lawyer but I believe this
means it's, by default, under [Creative Commons][] per the
[Stack Exchange TOS][].

=====

[gist]:      https://gist.github.com/sycobuny/3427408
[vundle]:    https://github.com/gmarik/vundle
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh

[GitHub]:             https://github.com/
[Gentoo Forums]:      http://forums.gentoo.org/
[Stack Overflow]:     http://stackoverflow.com/
[Stack Exchange TOS]: http://stackexchange.com/legal
