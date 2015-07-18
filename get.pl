#!/usr/bin/perl
use strict;
use warnings;
use Color;

my $norm	= "\033[00m";
my $background	= "\033[07m";
my $brighten	= "\033[01m";
my $underline	= "\033[04m";
my $blink	= "\033[05m";

# Customize colors here...
my $default	= $norm;
my $installed	= $green;
my $upgraded    = $green;
my $removed	= $red;
my $error	= $red;
my $obsolete	= $yellow;
my $suggested	= $yellow;
my $command	= $cyan;
my $bytecol	= $green;

# Get size of terminal
shift @ARGV || 0;
shift @ARGV || 0;

$| = 1;
my $skip = 0;

my $pac = "[a-zA-Z0-9\-:.]*";
my $bytes = "[0-9.,]* [kMG]?B";

while( <STDIN> ){
	my $orgline = $_;

	s/  \+/ /g; # Remove multiple spaces
	s/REMOVED:$/REMOVED:$removed/;
	s/installed:$/installed:$installed/;
	s/^Removing ($pac)/Removing $removed$1$default/;
	s/^Unpacking ($pac)/Unpacking $installed$1$default/;
	s/^Setting up ($pac)/Setting up $installed$1$default/;
	s/($pac) is already/$installed$1$default is already/;
	s/triggers for ($pac) /triggers for $installed$1 $default/;
	s/Package '($pac)'/Package '$error$1$default'/;
	s/unselected package ($pac)/unselected package $installed$1$default/;
	s/\/s\)$/\/s\)\r/;
	s/not upgraded.$/not upgraded.\r/;
	s/of archives.$/of archives.\r/;
	s/will be used.$/will be used.\r/;
	s/will be upgraded:/will be upgraded:$upgraded/;
	s/^E:/$error\0E:/;
	s/Suggested packages:/Suggested packages:$suggested/;
	s/($bytes)/$bytecol$1$default/g;
	s/no longer required:/no longer required:$obsolete/;
	s/apt-get autoremove/$command\0apt-get autoremove$default/;

	if( $_ !~ /^\s+/ ){print $norm, $default}
	print $_;
}

print $norm;
