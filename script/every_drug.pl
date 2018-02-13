#!/usr/bin/perl
#perl every_drug.pl drug2uniprot_indication.tab 9606.protein.actions.v10.5.experiments_uniprot_unfold_cut2_uniq_fold.txt out
use strict;
use warnings;
die $! unless @ARGV == 3;
my($setA,$setB,$out) = @ARGV;

open SETA,$setA or die $!;
open SETB,$setB or die $!;
open OUT,">$out" or die $!;

my %hashA;
my %hashB;

while(<SETA>){
	chomp;
	my @list_line = split("\t",$_);
	$hashA{$list_line[0]}=$list_line[2];
}

while(<SETB>){
	chomp;
	my @list_line = split("\t",$_);
	$hashB{$list_line[0]}=$list_line[1];
}

foreach my $drug (keys(%hashA)){
	my @targetA = split(" ",$hashA{$drug});
	my %mapping;
	foreach my $targetA (@targetA){
		$mapping{$targetA} = 1;
		if(exists $hashB{$targetA}){
			my @targetB1 = split(" ",$hashB{$targetA});
			foreach my $targetB1 (@targetB1){
				$mapping{$targetB1} = 1;	
			}
		}
	}
	my @AB = keys(%mapping);
	my $ll_AB = scalar(@AB);
	if($ll_AB>0){
		open FILEOUT,">$drug";
		foreach(@AB){
			print FILEOUT  "$_\n";
		}
		close FILEOUT;
	}
	print OUT "$drug\t$ll_AB\t@AB\n";
}
