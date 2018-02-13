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
	$hash{$id[0]} = $id[1];
}

while(<TARGET>){
	chomp;
	my @line = split("\t",$_);
	print OUT "$line[1]\t$hash{$line[1]}\t$line[0]\t$line[2]\n";
}
