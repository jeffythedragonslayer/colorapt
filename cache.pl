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

my $in = 'unknown';
$| = 1;
my $skip = 0;

my $pac = "[a-zA-Z0-9\-:]*";
my $bytes = "[0-9.,]* [kMG]?B";

my $command = shift @ARGV;
my $package = shift @ARGV;

my $thisline;

while( <> ){
	my $orgline = $thisline = $_;

	$thisline =~ s/  \+/ /g; # Remove multiple spaces 
	$thisline =~ s/^E:/$red$1E:/; 

	if( $command == "search" ){
		$thisline =~ s/$package/$magenta$package$default/;
	}

	if( $thisline !~ /^\s+/ ){print $norm, $default;}
	print $thisline;
}

print $norm;
