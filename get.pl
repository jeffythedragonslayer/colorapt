#!/usr/bin/perl
$black        = "\033[30m";
$red          = "\033[31m";
$green        = "\033[32m";
$yellow       = "\033[33m";
$blue         = "\033[34m";
$magenta      = "\033[35m";
$cyan         = "\033[36m";
$ltgray       = "\033[37m";
$drkgray      = "\033[1;30m";

$norm         = "\033[00m";
$background   = "\033[07m";
$brighten     = "\033[01m";
$underline    = "\033[04m";
$blink        = "\033[05m";

# Customize colors here...
$default      = $ltgray;
$gcc          = $magenta . $brighten;
$make         = $cyan;
$filename     = $yellow;
$linenum      = $cyan;
$trace        = $yellow;
$warning      = $green;
$comment      = $drkgray;
$tag_error    = "";
$error        = $tag_error . $yellow . $brighten;
$error_highlight = $brighten;

# Get size of terminal
$lines = shift @ARGV || 0;
$cols  = shift @ARGV || 0;
$cols -= 19;

$in = 'unknown';
$| = 1;
$skip = 0;

$pac = "[a-zA-Z0-9\-:]*";
$bytes = "[0-9.,]* [kMG]?B";

while( <> ){
	$orgline = $thisline = $_;

	$thisline =~ s/  \+/ /g; # Remove multiple spaces

	# skip lines
	$skip--;
	if( $skip < 0 ) {$skip = 0;}

	# Truncate lines.
	if( $cols ){
		$thisline =~ s/^(.{$cols}).....*(.{15})$/$1 .. $2/;
	}

	$thisline =~ s/REMOVED:$/REMOVED:$red$1/;
	$thisline =~ s/installed:$/installed:$blue$1/;
	$thisline =~ s/^Removing ($pac)/Removing $red$1$default/;
	$thisline =~ s/^Unpacking ($pac)/Unpacking $blue$1$default/;
	$thisline =~ s/^Setting up ($pac)/Setting up $blue$1$default/;
	$thisline =~ s/($pac) is already/$blue$1$default is already/;
	$thisline =~ s/triggers for ($pac) /triggers for $blue$1 $default/;
	$thisline =~ s/Package '($pac)'/Package '$red$1$default'/;
	$thisline =~ s/unselected package ($pac)/unselected package $blue$1$default/;
	$thisline =~ s/not upgraded.$/not upgraded.\r/;
	$thisline =~ s/of archives.$/of archives.\r/;
	$thisline =~ s/will be used.$/will be used.\r/;
	$thisline =~ s/will be upgraded:/will be upgraded:$blue/;
	$thisline =~ s/^E:/$red$1E:/;
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
