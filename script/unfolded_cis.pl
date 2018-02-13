#!usr/bin/perl
use strict;
use warnings;
die $! unless @ARGV == 2;
my ($in,$out) = @ARGV;

open IN,$in or die $!;
open OUT,">$out" or die $!;
while(<IN>){
	chomp;
	my @line=split("\t",$_);
	my @type=split(" ",$line[1]);
	foreach my $type (@type){
		print OUT "$line[0]\t$type\n";
	}
}
