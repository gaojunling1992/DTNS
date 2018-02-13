cat all_information.tab |cut -f1,6|grep -f all_cancer_drug_189_approved.list >tmp
perl ~/script/perl/unfolded_cis.pl tmp tmp1
perl ~/script/perl/folded_trans.pl tmp1 tmp2
cat tmp2|sort -k2 -nr >SetA_cancer_freq.tab
rm tmp tmp1 tmp2
