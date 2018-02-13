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
	if($line[1]=~/L/){
		$line[1]="L";
	}elsif($line[1]=~/-/){
		$line[1]="none";
	}else{
		$line[1]="other";
	}
	print OUT "$line[0]\t$line[1]\n";
}
