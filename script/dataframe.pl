#!usr/bin/perl 
use strict;
use warnings;

die $! unless @ARGV==4;
my($list1,$list2,$target,$out)=@ARGV;

#$list1=gene_pvalue;
#$list2=km_pvalue;
#$target=just_in_cancer_high_but_lower_increase_KM_min_pvalue.tab
#$out

my %m_hash1;
my %m_hash2;

open LIST1 ,$list1 or die $!;
my $header1 = <LIST1>;
chomp($header1);
my @name1 = split("\t",$header1);

while(<LIST1>){
	chomp;
	my @array = split(/\t/);
	my $i=0;
	foreach my $name (@name1){
		$m_hash1{$array[0]}->{$name}=$array[$i];
		$i++;
	}
}

open LIST2 ,$list2 or die $!;
my $header2 = <LIST2>;
chomp($header2);
my @name2 = split("\t",$header2);

while(<LIST2>){
	chomp;
	my @array = split(/\t/);
	my $i=0;
	foreach my $name (@name2){
		$m_hash2{$array[0]}->{$name}=$array[$i];
		$i++;
	}
}
open TARGET,$target or die $!;
open OUT,">$out" or die $!;
while(<TARGET>){
	chomp;
	my @array = split(/\t/);
	print OUT "$array[0]\t$array[1]\t$array[2]\t$array[3]\t$m_hash1{$array[0]}->{$array[1]}\t$m_hash2{$array[0]}->{$array[1]}\n"
}
