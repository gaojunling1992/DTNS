#!/usr/bin/perl
use strict;
use warnings;

die $! unless @ARGV == 3;
my($list,$target,$out) = @ARGV;

open LIST,$list or die $!;
open TARGET,$target or die $!;
open OUT,">$out" or die $!;

my %hash;
while(<LIST>){
	chomp;
	my @id=split("\t",$_);
	$hash{$id[0]} = "cancer";
}

while(<TARGET>){
	chomp;
	my @line = split("\t",$_);
	if(exists $hash{$line[0]}){
		print OUT "$line[0]\t$line[1]\t$hash{$line[0]}\n";
	}else{
		print OUT "$line[0]\t$line[1]\tnon_cancer\n";
	}
}
