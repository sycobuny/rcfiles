#!/usr/bin/env perl

use warnings;
use strict;

my ($section)  = shift;
my ($pattern)  = qr/^\s*\[(.*)\]\s*$/;
my (@lines)    = <>;
my ($current_section);

foreach my $line (@lines) {
    if ($line =~ $pattern) { $current_section = $1 }
    next if ($current_section eq $section);

    print $line;
}
