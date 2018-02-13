cat SetA_cancer_freq.tab|cut -f1|sed 's/^/^/' >tmp
cat 9606.protein.actions.v10.5.experiments_uniprot_unfold_cut2_uniq_fold.txt |grep -f tmp >tmp1
perl ~/script/perl/unfolded_cis.pl tmp1 tmp2
perl ~/script/perl/folded_trans.pl tmp2 tmp3
cat tmp3|sort -k2 -nr >SetB_cancer_freq.tab
rm tmp tmp1 tmp2 tmp3
