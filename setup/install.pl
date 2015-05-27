#!/usr/bin/env perl

use warnings;
use strict;

use File::Basename qw(dirname);
use File::Spec;

use constant DEFAULT_RCDIR  => File::Spec->catfile($ENV{HOME}, '.rc');
use constant DEFAULT_REMOTE => 'https://github.com/sycobuny/rcfiles.git';

sub verify_tools {
    my (@required) = qw(perl bash);
    my (@optional) = qw(git zsh);
    my ($failed)   = 0;
    my ($missing)  = 0;

    print "=> Checking for missing tools...\n";

    foreach my $required (@required) {
        $ENV{TOOL} = $required;
        `which "\$TOOL" 2>&1`;

        if ($?) {
            warn "Could not find required tool `$required` in your \$PATH\n";
            $failed++;
        }
    }

    die "fatal: missing $failed required tool(s)\n" if $failed;

    foreach my $optional (@optional) {
        $ENV{TOOL} = $optional;
        `which "\$TOOL"`;

        if ($?) {
            warn "Could not find recommended tool `$optional` in your " .
                 "\$PATH\n";
            $failed++;
        }
    }

    if ($failed) {
        warn "Missing $failed optional tools, attempting to continue...\n";
    }
    else {
        print "=> All tools found\n";
    }
}

sub resolve_dir {
    my ($breakout) = sub {
        $ENV{RCDIR} = shift;
        print "=> Resolved \$RCDIR to $ENV{RCDIR}\n";

        if (shift && $ENV{RCDIR} ne DEFAULT_RCDIR) {
            $ENV{FILE} = File::Spec->catfile($ENV{HOME}, '.rcdir');

            print "=> Saving \$RCDIR to $ENV{FILE}\n";
            `echo "\$RCDIR" > "\$FILE"`;
        }

        $ENV{RCDIR};
    };

    return $breakout->($ENV{RCDIR}, 1) if $ENV{RCDIR};
    return $breakout->(DEFAULT_RCDIR)  if (__FILE__ eq '-');

    # we'll assume we're being run from inside the proper git repo, then.
    chdir(dirname(__FILE__));
    my ($rcdir) = `git rev-parse --show-toplevel 2>/dev/null`;
    chomp($rcdir);

    # but maybe we don't have git, or otherwise can't resolve it? use the
    # default if we failed to get the root of the repo for whatever reason.
    return $breakout->(DEFAULT_RCDIR) unless $rcdir;

    # resolve the given rcdir to an absolute path and use that
    $breakout->(File::Spec->rel2abs($rcdir), 1);
}

sub clone_repository {
    $ENV{RC_GIT_REMOTE} ||= DEFAULT_REMOTE;

    print "=> Attempting to clone repository...\n";
    my ($output) = `git clone "\$RC_GIT_REMOTE" "\$RCDIR" 2>&1`;

    if ($? && $output =~ /already exists and is not an empty directory/) {
        warn "Directory $ENV{RCDIR} already exists, attempting to " .
             "continue...\n";

        switch_to_repository();

        `git init .`;
        die "Could not init $ENV{RCDIR} as a git repository: $!\n" if $?;

        my ($url) = `git config remote.origin.url`;
        chomp($url) if $url;

        if (!$url) {
            `git remote add origin "\$RC_GIT_REMOTE" 2>/dev/null`;
            die "fatal: Could not add remote $ENV{RC_GIT_REMOTE}\n" if $?;

            print "=> Set remote 'origin' to $ENV{RC_GIT_REMOTE}\n";
        }
        elsif ($url ne $ENV{RC_GIT_REMOTE}) {
            die "fatal: Remote 'origin' already set to $url\n";
        }

        `git fetch origin master 2>/dev/null`;
        die "fatal: Could not synchronize from 'origin'\n" if $?;
        print "=> Pulled all remote changes\n";

        `git merge --ff-only origin/master`;
        if ($?) {
            die "fatal: Could not merge upstream changes from " .
                "'origin/master'\n";
        }
        print "=> Updated repository to latest changes\n";
    }
}

sub switch_to_repository {
    chdir($ENV{RCDIR})
        or die "fatal: Failed to change directory to $ENV{RCDIR}: $!\n";
}

sub load_library {
    do './bin/rcfiles';
    die "fatal: Failed to load bin/rcfiles library: $@\n" if $@;
    die "fatal: Failed to load bin/rcfiles library: $!\n" if $!;
}


# check for required (mostly) tools
verify_tools();

# figure out where we need to put the repository
resolve_dir();

# bootstrap the base repository and switch into it for more work
clone_repository();
switch_to_repository();

# load the command line library
load_library();

# set up local repository configuration
RCFiles::autoconfig();
