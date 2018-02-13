#!/usr/bin/perl
#perl two.pl 9606.protein.actions.v10.5.experiments_uniprot_unfold_cut2_uniq_fold.txt Set_A_Antineoplastic_Agents_xml.list drug2uniprot_xml.tab out1

use strict;
use warnings;

die $! unless @ARGV == 5;
my($list,$cancer,$cancerB,$target,$out) = @ARGV;

open LIST,$list or die $!;
open CANCER,$cancer or die $!;
open CANCERB,$cancerB or die $!;
open TARGET,$target or die $!;
open OUT,">$out" or die $!;

my %hash;
my %cancer;
my %cancer_priority;
my %cancerB;
my %cancerB_priority;

#获取每个蛋白对应的互作蛋白
while(<LIST>){
	chomp;
	my @list_line = split("\t",$_);
	$hash{$list_line[0]}=$list_line[1];
}

#获取癌症药物直接靶标A，及该靶标出现的频率
while(<CANCER>){
	chomp;
	my @line = split("\t",$_);
	$cancer{$line[0]}=1;
	$cancer_priority{$line[0]}=$line[1];
}
#获取癌症药物间接靶标B，及其出现的频率
while(<CANCERB>){
	chomp;
	my @line = split("\t",$_);
	$cancerB{$line[0]}=1;
	$cancerB_priority{$line[0]}=$line[1];
}

print OUT "Drug\tc_target_A\tc_target_cancer_direct_A\tc_target_cancer_direct_A_scoreA\tc_target_cancer_second_A\tc_target_cancer_B\tc_target_cancer_degree_B\tc_target_cancer_degree_B_scoreA\tc_target_cancerB_B\tc_target_cancerB_degree_B\tc_target_cancerB_degree_B_scoreB\tc_target_B\n";

#读取每种药物的药物ID、直接靶标数目、直接靶标
while(<TARGET>){
	chomp;
	my @target_line = split("\t",$_);
	my @target_A = split(" ",$target_line[2]); #将药物X直接靶标存进数组
	my @target_A_in_cancer;
	my %merge_all;
	my $degree = 0;
	my $target_A_in_cancer = 0;
	my @target_A_in_cancer_direct=grep($cancer{$_},@target_A);#药物直接靶标与癌症直接靶标的交集
	my $score1 = 0;
	my $score2 = 0;
	my $score3 = 0;
	my $ll_B1_in_cancerB=0;

	#计算每个属于癌症药物直接靶标的权重
	foreach (@target_A_in_cancer_direct){
		$score1=$score1+$cancer_priority{$_};
	}

	my $ll_target_A_in_cancer_direct = scalar(@target_A_in_cancer_direct); #计算属于癌症直接靶标的个数
	#循环药物X的每一个直接靶标
	foreach my $target_A (@target_A){
		#对每个直接靶标，如果存在互作蛋白，计算每个元素A1所对应的数组B1
		if(exists $hash{$target_A}){
			my @target_B1 = split(" ",$hash{$target_A});
			#循环B中每个元素，最终会得到药物X的直接靶标集合A的全部间接靶标B
			foreach my $B (@target_B1){
				$merge_all{$B}=1;	
			}
			#计算药物每个直接靶标的间接靶标属于癌症药物直接靶标的数组，考虑了重复，计算的是度
			#1
			my @B1_in_cancer = grep($cancer{$_},@target_B1);

			foreach my $B1_in_cancer(@B1_in_cancer){
				$score2=$score2+$cancer_priority{$B1_in_cancer};
			}
			#2
			my @B1_in_cancerB = grep($cancerB{$_},@target_B1);
			foreach my $B1_in_cancerB(@B1_in_cancerB){
				$ll_B1_in_cancerB++;
				$score3=$score3+$cancerB_priority{$B1_in_cancerB};
			}
			#对于每个A的B集合，其与癌症交集为B1_in_cancer，如果该集合不为零，将元素A推进数组@target_A_in_cancer
			my $ll_B1_in_cancer = scalar(@B1_in_cancer);
			if($ll_B1_in_cancer){
				push(@target_A_in_cancer,$target_A);
				$target_A_in_cancer++;
			}
			$degree = $degree+scalar(@B1_in_cancer);
		}
	}
	my @target_B = keys (%merge_all);
	my $ll_target_B = scalar(@target_B);
	
	
	#计算药物所有间接靶标与癌症药物直接靶标的交集
	my @target_B_in_cancer = grep($cancer{$_},@target_B);
	my $ll_in_cancer = scalar(@target_B_in_cancer);
	
	#计算药物所有间接靶标与癌症药物间接靶标的交集
	my @target_B_in_cancerB = grep($cancerB{$_},@target_B);
	my $ll_in_cancerB = scalar(@target_B_in_cancerB);

	print OUT "$target_line[0]\t$target_line[1]\t$ll_target_A_in_cancer_direct\t$score1\t$target_A_in_cancer\t$ll_in_cancer\t$degree\t$score2\t$ll_in_cancerB\t$ll_B1_in_cancerB\t$score3\t$ll_target_B\t@target_B\n";
}

