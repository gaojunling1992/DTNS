#!/usr/bin/perl
use strict;
use warnings;

die $! unless @ARGV == 2;
my($list,$out) = @ARGV;

open LIST,$list or die $!;
open OUT,">$out" or die $!;

my %hash;
my %count;
my %merge;
my %score;
while(<LIST>){
	chomp;
	my @line=split("\t",$_);
	$hash{$line[0]} = $line[2];
	$count{$line[0]} = $line[1];
	my @array = split(" ",$line[2]);
	foreach(@array){
		$merge{$_}=1;
	}
}

foreach(keys(%merge)){
	if(exists $count{$_}){
		my $haha=1;
	}else{
		$count{$_}=1;
	}
}

foreach my $one (keys(%hash)){
	my @a = split(" ",$hash{$one});
	my %hash_a;
	foreach my $a (@a){
		$hash_a{$a}=1;
	}
	foreach my $two (keys(%hash)){
		my @b = split(" ",$hash{$two});
		my %merge_all;
		foreach my $every (@a,@b){
			$merge_all{$every}=1;
		}
		my @setI = grep {$hash_a{$_}} @b;
		my @setU = keys(%merge_all);
		my $scoreI = 0;
		my $scoreU = 0;
		foreach my $tmp1 (@setI){
			my $num1 = 1/$count{$tmp1};
			print "$count{$tmp1}\t$num1\n";
			$scoreI = $scoreI+$num1;
		}
		foreach my $tmp2(@setU){
			my $num2 = 1/$count{$tmp2};
			$scoreU = $scoreU+$num2;
		}
		my $final=$scoreI/$scoreU;
		$score{$one}->{$two} = $final;
	}
}

foreach my $one (keys(%hash)){
	foreach my $two (keys(%hash)){
		print OUT "$one\t$two\t$score{$one}->{$two}\n";
	}
	
}
