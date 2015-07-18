#!/usr/bin/perl
use strict;
use warnings;
use Color;

my $norm         = "\033[00m";
my $background   = "\033[07m";
my $brighten     = "\033[01m";
my $underline    = "\033[04m";
my $blink        = "\033[05m";

# Customize colors here...
my $default      = $ltgray;
my $gcc          = $magenta . $brighten;
my $make         = $cyan;
my $filename     = $yellow;
my $linenum      = $cyan;
my $trace        = $yellow;
my $warning      = $green;
my $comment      = $drkgray;
my $tag_error    = "";
my $error        = $tag_error . $yellow . $brighten;
my $error_highlight = $brighten;

# Get size of terminal
shift @ARGV || 0;
shift @ARGV || 0;

my $in = 'unknown';
$| = 1;
my $skip = 0;

my $pac = "[a-zA-Z0-9\-:.]*";
my $bytes = "[0-9.,]* [kMG]?B";

while( <> ){
	my $orgline = $_;

	s/  \+/ /g; # Remove multiple spaces
	s/REMOVED:$/REMOVED:$red/;
	s/installed:$/installed:$blue/;
	s/^Removing ($pac)/Removing $red$1$default/;
	s/^Unpacking ($pac)/Unpacking $blue$1$default/;
	s/^Setting up ($pac)/Setting up $blue$1$default/;
	s/($pac) is already/$blue$1$default is already/;
	s/triggers for ($pac) /triggers for $blue$1 $default/;
	s/Package '($pac)'/Package '$red$1$default'/;
	s/unselected package ($pac)/unselected package $blue$1$default/;
	s/\/s\)$/\/s\)\r/;
	s/not upgraded.$/not upgraded.\r/;
	s/of archives.$/of archives.\r/;
	s/will be used.$/will be used.\r/;
	s/will be upgraded:/will be upgraded:$blue/;
	s/^E:/$red\0E:/;
	s/Suggested packages:/Suggested packages:$yellow$1/;
	s/($bytes)/$green$1$default/g;
	s/no longer required:/no longer required:$yellow/;
	s/apt-get autoremove/$cyan$1apt-get autoremove$default/;

	if( $_ !~ /^\s+/ ){print $norm, $default}
	print $_;
}

print $norm;
