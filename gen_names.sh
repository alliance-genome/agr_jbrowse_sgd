#!/usr/bin/bash

set -e

AWSACCESS=${AWS_ACCESS_KEY}
AWSSECRET=${AWS_SECRET_KEY}

cd /jbrowse/data

AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --recursive s3://agrjbrowse/MOD-jbrowses/SGD/jbrowse/data/seq seq/
curl -O https://stage.dh18454tea1gu.amplifyapp.com/data/trackList.json
curl -O https://stage.dh18454tea1gu.amplifyapp.com/data/tracks.conf

# could limit this download to just the tracks needed for generate_names 
AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --recursive s3://agrjbrowse/MOD-jbrowses/SGD/jbrowse/data/tracks tracks/

# convert absolut templateUrls to relataive
sed -i 's/https:.*SGD\/jbrowse\///g' trackList.json
sed -i 's/https:.*SGD\/jbrowse\/data\///g' tracks.conf

cd ..

bin/flatfile-to-json.pl --gff /saccharomyces_cerevisiae.gff --trackLabel S288C --trackType CanvasFeatures
bin/flatfile-to-json.pl --gff /saccharomyces_cerevisiae.gff --trackLabel "All Annotated Sequence Features" --trackType CanvasFeatures --type ARS,non_transcribed_region,blocked_reading_frame,centromere,chromosome,gene,long_terminal_repeat,LTR_retrotransposon,mating_type_region,ncRNA_gene,origin_of_replication,pseudogene,rRNA_gene,silent_mating_type_cassette_array,snoRNA_gene,snRNA_gene,telomerase_RNA_gene,telomere,transposable_element_gene,tRNA_gene
bin/flatfile-to-json.pl --gff /saccharomyces_cerevisiae.gff --trackLabel Protein-Coding-Genes --trackType CanvasFeatures --type CDS,five_prime_UTR_intron,gene,intein_encoding_region,mRNA,plus_1_translational_frameshift,transposable_element_gene
bin/flatfile-to-json.pl --gff /saccharomyces_cerevisiae.gff --trackLabel Non-Coding-RNA-Genes --trackType CanvasFeatures --type ncRNA_gene,rRNA_gene,snoRNA_gene,snRNA_gene,tRNA_gene
bin/flatfile-to-json.pl --gff /saccharomyces_cerevisiae.gff --trackLabel Subfeatures --trackType CanvasFeatures --type ARS_consensus_sequence,CDS,centromere_DNA_Element_I,centromere_DNA_Element_II,centromere_DNA_Element_III,external_transcribed_spacer_region,five_prime_UTR_intron,intein_encoding_region,internal_transcribed_spacer_region,intron,noncoding_exon,non_transcribed_region,plus_1_translational_frameshift,telomeric_repeat,W_region,X_element,X_element_combinatorial_repeat,X_region,Y_prime_element,Y_region,Z1_region,Z2_region



# simple index everything command
#bin/generate-names.pl 


#specifying what tracks to index
bin/generate-names.pl --tracks \
"All Annotated Sequence Features",\
"cDNA_transcripts",\
"longest_full-ORF_transcripts_ypd",\
"longest_full-ORF_transcripts_gal",\
"most_abundant_full-ORF_transcripts_gal",\
"most_abundant_full-ORF_transcripts_ypd",\
"unfiltered_full-ORF_transcripts",\
"cryptic_unstable_transcripts",\
"open_reading_frame_transcripts",\
"other_transcripts",\
"stable_unannotated_transcripts"


echo "uploading to s3"

AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --quiet --recursive --acl public-read "data/tracks/All Annotated Sequence Features" "s3://agrjbrowse/test/sgd_tracks/All Annotated Sequence Features"
AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --quiet --recursive --acl public-read data/tracks/Protein-Coding-Genes s3://agrjbrowse/test/sgd_tracks/Protein-Coding-Genes
AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --quiet --recursive --acl public-read data/tracks/Non-Coding-RNA-Genes s3://agrjbrowse/test/sgd_tracks/Non-Coding-RNA-Genes
AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --quiet --recursive --acl public-read data/tracks/Subfeatures s3://agrjbrowse/test/sgd_tracks/Subfeatures
AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --quiet --recursive --acl public-read data/names s3://agrjbrowse/test/sgd-names/

