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
my $thisline;

while( <> ){
	my $orgline = $thisline = $_;

	$thisline =~ s/  \+/ /g; # Remove multiple spaces
	$thisline =~ s/REMOVED:$/REMOVED:$red/;
	$thisline =~ s/installed:$/installed:$blue/;
	$thisline =~ s/^Removing ($pac)/Removing $red$1$default/;
	$thisline =~ s/^Unpacking ($pac)/Unpacking $blue$1$default/;
	$thisline =~ s/^Setting up ($pac)/Setting up $blue$1$default/;
	$thisline =~ s/($pac) is already/$blue$1$default is already/;
	$thisline =~ s/triggers for ($pac) /triggers for $blue$1 $default/;
	$thisline =~ s/Package '($pac)'/Package '$red$1$default'/;
	$thisline =~ s/unselected package ($pac)/unselected package $blue$1$default/;
	$thisline =~ s/\/s\)$/\/s\)\r/;
	$thisline =~ s/not upgraded.$/not upgraded.\r/;
	$thisline =~ s/of archives.$/of archives.\r/;
	$thisline =~ s/will be used.$/will be used.\r/;
	$thisline =~ s/will be upgraded:/will be upgraded:$blue/;
	$thisline =~ s/^E:/$red\0E:/;
	$thisline =~ s/Suggested packages:/Suggested packages:$yellow$1/;
	$thisline =~ s/($bytes)/$green$1$default/g;
	$thisline =~ s/no longer required:/no longer required:$yellow/;
	$thisline =~ s/apt-get autoremove/$cyan$1apt-get autoremove$default/;

	if( $thisline !~ /^\s+/ ){
		print $norm, $default;
	}
	print $thisline;
}

print $norm;
