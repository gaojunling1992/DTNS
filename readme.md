A new drug repositioning method (DTNS) for cancer
=========================================================================================

Introduction
-----------------------------------------------------------------------------------
Computation-based drug repositioning has addressed increasing attention since it can accelerate the traditional drug discovery process significantly. We proposed a new drug-repositioning method based on the drug targets network similarity (DTNS), aiming to provide potential opportunities for cancer therapy. This pipeline could help to understand the molecular mechanism of cancer and provide novel opportunities for cancer therapy. We hope this method could promote drug repositioning for other diseases.

Source
----------------------------------------------------------------------------------
https://github.com/gaojunling1992/DTNS

Contact
------------------------------------------------------------------------------------
You can contact yangtielin@mail.xjtu.edu.cn when you have any questions, suggestions, comments, etc. Please describe in details, and attach your command line and log messages if possible.

Requirements
---------------------------------------------------------------------------------------
awk, R (>= 3.3.2), perl5.10.1, python2.7

Preparation
-----------------------------------------------------------------------------------------
We downloaded the DrugBank (version 5.0.8) XML file which was released on September 20th, 2017 and used an in-house python script to extract the targets and other drug property information for each drug. Gene-gene interactions were obtained from the STRING database which provided a critical assessment and integration of protein-protein interactions. We extracted all the protein direct interactions that were experimentally supported. In order to further explore the relationship between the DTN of cancer drugs and cancer genomics, we collected mutations data in pan-cancer patients from the NCI Genomic Data Commons (GDC) which is an information system for exploiting multidimensional cancer genomics data.

>python xml_script/*.py

>bash run_string.sh


>cancer_drugs_analysis
>bash get_cancer_drugs.sh
>cat cancer_drug.list|xargs -n 1 Rscript kegg.R
>perl every_drug.pl
>perl get_cancer.pl
>perl CancerDrugKeggEnrich.pl
>perl get_top_id_qvalue.pl

The DTNS pipeline
--------------------------------------------------------------------------------------------
>perl pre_score1.pl 9606.protein.actions.v10.5.experiments_uniprot_unfold_cut2_uniq_fold.txt SetA_cancer_freq.tab SetB_cancer_freq.tab
>Rscrpt calculate_score.R

Jaccard Index
--------------------------------------------------------------------------------------------
>perl dataframe.pl

>perl GetSimilarValue.pl

>perl get_atc_first_sub.pl

>Rscript reshape.R

>Rscript pheatmap.R


