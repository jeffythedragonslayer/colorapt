#!/usr/bin/perl
package Color;

use strict;
use warnings;

#use base qw(Exporter);

use Exporter 'import';

our @ISA = qw(Exporter);
our @EXPORT = qw($black $red $green $yellow $blue $magenta $cyan $ltgray $drkgray);

our $black        = "\033[30m";
our $red          = "\033[31m";
our $green        = "\033[32m";
our $yellow       = "\033[33m";
our $blue         = "\033[34m";
our $magenta      = "\033[35m";
our $cyan         = "\033[36m";
our $ltgray       = "\033[37m";
our $drkgray      = "\033[1;30m";
