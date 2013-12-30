#!/usr/bin/env perl

use warnings;
use strict;

my ($filename) = shift;
my ($section)  = shift;
my ($pattern)  = qr/^\s*\[(.*)\]\s*$/;
my ($handle, $current_section, @lines);

die "fatal: file does not exist: $filename\n"  unless (-e $filename);
die "fatal: file is not readable: $filename\n" unless (-r $filename);
die "fatal: not a filename: $filename\n"       unless (-f $filename);
die "fatal: could not open $filename for reading\n"
    unless (open($handle, $filename));

@lines = <$handle>;
close($handle);

foreach my $line (@lines) {
    if ($line =~ $pattern) { $current_section = $1 }
    next if ($current_section eq $section);

    print $line;
}
