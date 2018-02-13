cat Drug_indication.tab|grep -i '\btumor\b'|cut -f1 |sort >all/tumor.list
cat Drug_indication.tab|grep -i '\btumors\b'|cut -f1 |sort >all/tumors.list
cat Drug_indication.tab|grep -i '\bcancer\b'|cut -f1 |sort >all/cancer.list
cat Drug_indication.tab|grep -i '\bcancers\b'|cut -f1 |sort >all/cancers.list
cat Drug_indication.tab|grep -i '\bleukemia\b'|cut -f1 |sort >all/leukemia.list
cat Drug_indication.tab|grep -i '\bleukemias\b'|cut -f1 |sort >all/leukemias.list
cat Drug_indication.tab|grep -i '\blymphoma\b'|cut -f1 |sort >all/lymphoma.list
cat Drug_indication.tab|grep -i '\blymphomas\b'|cut -f1 |sort >all/lymphomas.list
cat Drug_indication.tab |grep -i '\bcarcinoma\b'|cut -f1|sort >all/carcinoma.list
cat Drug_indication.tab |grep -i '\bcarcinomas\b'|cut -f1|sort >all/carcinomas.list

cat all/*.list|sort|uniq |grep -v -f no_cancer.txt >tmp.list
perl get_cancer_drugs_tran.pl Drug_group_fold.tab tmp.list drug_type.tab
cat drug_type.tab|grep -v 'withdrawn'|cut -f1 >all_cancer_drug.list
rm tmp.list drug_type.tab
