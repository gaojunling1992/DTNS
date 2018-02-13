
#9606.protein.links.detailed.v10.5.experiments.txt
cat download_data/9606.protein.links.detailed.v10.5.txt|sed 's/ /\t/g'|awk '$7!=0' >9606.protein.links.detailed.v10.5.experiments.txt

cat 9606.protein.links.detailed.v10.5.experiments.txt|sed 1d|cut -f1,2|sort|uniq >9606.protein.links.detailed.v10.5.experiments_protein.tab


#9606.protein.actions.v10.5.experiments.txt
perl extract_experiments.pl 9606.protein.links.detailed.v10.5.experiments_protein.tab download_data/9606.protein.actions.v10.5.txt 9606.protein.actions.v10.5.experiments.txt


cat download_data/9606_reviewed_uniprot_2_string.04_2015.tsv|sed 's/|/\t/g'|cut -f2,4|sed 1d|sed 's/ENSP/9606.ENSP/' >uniprot2string.tab
perl folded.pl uniprot2string.tab string2uniprot_fold.tab
perl STRING2otherID_tran.pl string2uniprot_fold.tab 9606.protein.actions.v10.5.experiments.txt 9606.protein.actions.v10.5.experiments_uniprot.txt
cat 9606.protein.actions.v10.5.experiments_uniprot.txt|grep -v 'ENSP' >tmp
mv tmp 9606.protein.actions.v10.5.experiments_uniprot.txt
perl unfolded_first.pl 9606.protein.actions.v10.5.experiments_uniprot.txt out
perl unfolded_second.pl out 9606.protein.actions.v10.5.experiments_uniprot_unfold.txt


#9606.protein.actions.v10.5.experiments_uniprot_unfold_cut2_uniq.txt
cat 9606.protein.actions.v10.5.experiments_uniprot_unfold.txt|cut -f1,2|sort|uniq >9606.protein.actions.v10.5.experiments_uniprot_unfold_cut2_uniq.txt


cat 9606.protein.actions.v10.5.experiments_uniprot_unfold.txt|awk '$7>600' >9606.protein.actions.v10.5.experiments_uniprot_unfold_score600.txt
cat 9606.protein.actions.v10.5.experiments_uniprot_unfold_score600.txt|cut -f1,2|sort|uniq >9606.protein.actions.v10.5.experiments_uniprot_unfold_score600_cut2_uniq.txt


perl folded_cis.pl 9606.protein.actions.v10.5.experiments_uniprot_unfold_cut2_uniq.txt 9606.protein.actions.v10.5.experiments_uniprot_unfold_cut2_uniq_fold.txt
