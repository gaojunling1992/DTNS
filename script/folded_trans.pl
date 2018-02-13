#!usr/bin/perl
use strict;
use warnings;
die $! unless @ARGV==2;
my ($in,$out) = @ARGV;

my %hash;
my %count;
open IN,$in or die $!;

open OUT,">$out" or die $!;
while(<IN>){
	chomp;
	my @line=split("\t",$_);
	if(exists $hash{$line[1]}){
		$hash{$line[1]} = $hash{$line[1]}." $line[0]";
		$count{$line[1]}++;
	}else{
		$hash{$line[1]} = $line[0];
		$count{$line[1]}++;
	}
}

foreach(keys(%hash)){
	print OUT "$_\t$count{$_}\t$hash{$_}\n";
}
