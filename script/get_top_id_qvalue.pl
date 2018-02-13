#!/usr/bin/env perl
#统计每种药物kegg富集结果，富集到每种条目中的数目
use strict;
use warnings;

my $dir = "\/home\/gaojl\/result\/project1\/tmp1\/allAB_new\/kegg_out\/";

open FH,"top_non_cancer.list";
my @list = <FH>;
close FH;

my %hash;
my %count;
open OUT,">top_id_qvalue.tab";
foreach my $drug (@list){
	chomp($drug);
	my $file = "$dir$drug";
	open(FILE,$file) or die $!;
	<FILE>;
	while(<FILE>){
		chomp;
		my @line=split(/\t/);
		$hash{$line[0]}=$line[1];
		if($line[6]=~/\d+/){
			if($line[6]<0.001){
				print OUT "$drug\t$line[0]\t$line[6]\n";
			}
		}
	}
	close FILE;
}

close OUT;

