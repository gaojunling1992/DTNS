#!/usr/bin/env perl
#统计每种药物kegg富集结果，富集到每种条目中的数目
use strict;
use warnings;

my $dir = "\/home\/gaojl\/result\/project1\/tmp1\/allAB_new\/kegg_out\/";

open FH,"top_non_cancer.list";
my @list = <FH>;
close FH;
my %hash1;
open FH1, "all_kegg_id.list";
while(<FH1>){
	chomp;
	$hash1{$_}="drugs:";
}
my %hash;
my %count;
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
			#qvalue
			if($line[6]<0.001){
				$count{$line[0]}++;
				$drug=~s/.tab//;
				$hash1{$line[0]}=$hash1{$line[0]}." $drug";
			}
		}
	}
	close FILE;
}

open OUT,">top_non_cancer_KeggEnrich.tab";
foreach my $id (keys(%count)){
	print OUT "$id\t$count{$id}\t$hash{$id}\t$hash1{$id}\n";
}
close OUT;

