#!/usr/bin/bash

set -e

AWSACCESS=${AWS_ACCESS_KEY}
AWSSECRET=${AWS_SECRET_KEY}

cd /jbrowse/data

AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --recursive s3://agrjbrowse/MOD-jbrowses/SGD/jbrowse/data/seq seq/
curl -O https://stage.dh18454tea1gu.amplifyapp.com/data/trackList.json
curl -O https://stage.dh18454tea1gu.amplifyapp.com/data/tracks.conf
AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --recursive s3://agrjbrowse/MOD-jbrowses/SGD/jbrowse/data/tracks tracks/

# convert absolut templateUrls to relataive
sed -i 's/https:.*SGD\/jbrowse\///g' trackList.json
sed -i 's/https:.*SGD\/jbrowse\/data\///g' tracks.conf

cd ..

# simple index everything command
#bin/generate-names.pl 

#specifying what tracks to index
bin/generate-names.pl -v --tracks \
   "3'UTRs", \
   "5'UTRs", \ 
   "5'and3'UTRs", \
   "TransposonsLTR", \
   "Adr1_and_Cat8_binding_regions", \
   "All Annotated Sequence Features", \
   "AlphaFactor", \
   "Antisense_ncRNA", \
   "Benomyl", \
   "CUTs", \
   "Calcofluor", \
   "CongoRed", \
   "DNADamage", \
   "Digital_genomic_footprinting", \
   "Gal4_ChIP_exo_bound_locations", \
   "GrapeJuice", \
   "H2AZ_Nucleosome_positions", \
   "H3H4_Nucleosome_positions", \
   "HeatShock", \
   "HighCalcium", \
   "Hydroxyurea", \
   "Known_ARS_identified", \
   "Known_Predicted_ACSs", \
   "Known_Predicted_ARSs", \
   "Known_transcripts", \
   "LowNitrogen", \
   "LowPhosphate", \
   "Meiotic_ncRNAs", \
   "Mitotic_transcriptome", \
   "ORC_ACS", \
   "OxidativeStress", \
   "Phd1_ChIP_exo_bound_locations", \
   "Polyadenylation_sites", \
   " RNAs", \
   "Rap1_ChIP_exo_bound_locations", \
   "Reb1_ChIP_exo_bound_locations", \
   "Recombination_hotspots", \
   "SAGE_Tags", \
   "SUTs", \
   "Salt", \
   "ScGlycerolMedia", \
   "ScMedia", \
   "Sorbitol", \
   "StationaryPhase", \
   "Subfeatures", \
   "TATA_elements_ChIP_exo", \
   "TF_ChIP_ChIP", \
   "Transcribed_regions", \
   "Transcribed_regions_polyA_RNA", \
   "Transcribed_regions_total_RNA", \
   "Transcription_start_sites", \
   "TransposableElements", \
   "Unannotated_novel_genes", \
   "Unannotated_transcripts", \
   "Verified_introns", \
   "WT_G1_37C_mononucleosomal_fragments", \
   "WT_G2_37C_mononucleosomal_fragments", \
   "WT_async_23C_mononucleosomal_fragments", \
   "Wacholder_2023_translated_orfs", \
   "Wacholder_2023_translated_orfs_chx", \
   "Wacholder_2023_translated_orfs_nochx", \
   "Wacholder_2023_translated_orfs_sd_media", \
   "Wacholder_2023_translated_orfs_ypd_media", \
   "Wacholder_2023_translated_orfs_ypd_nochx", \
   "Xrn1-sensitive_unstable transcripts_XUTs", \
   "cDNA_transcripts", \
   "class_III_mRNAs", \
   "class_II_transcripts", \
   "class_I_CUTs", \
   "class_I_ncRNAs", \
   "class_I_other", \
   "class_I_pre_mRNAs", \
   "gene_conversions", \
   "longest_full-ORF_transcripts_gal", \
   "longest_full-ORF_transcripts_ypd", \
   "meiotic_crossovers", \
   "most_abundant_full-ORF_transcripts_gal", \
   "most_abundant_full-ORF_transcripts_ypd", \
   "orc1-161_mutant_G2_37C_mononucleosomal_fragments", \
   "uORF_noncanonical", \
   "uORFs_canonical", \
   "unfiltered_full-ORF_transcripts"

AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --recursive --acl public-read data/names s3://agrjbrowse/test/sgd-names/

