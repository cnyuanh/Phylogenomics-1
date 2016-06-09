#!/usr/bin/perl -w
use strict;
#from_fasta2phylip_pipeline.pl

#the script is to produce a phylip file by running peptide alignment, forcing it onto cds to get cds alignment, trim the cds alignment, and produce a phylip file read for phylogenetic analysis

if (!$ARGV[0]) {
	print "Usage: from_fasta2phylip_pipeline.pl <fasta_dir>\n\n";
	print "Please make sure that you are inside the current directory that has the AA fasta and cds fasta files\n\n";
	print "Please give full paths to input directories\n\n";
	exit(1);
}
print "Start "; system "date";



my $fastadir = $ARGV[0];
opendir (DIR,"$fastadir");
while( my $infile = readdir(DIR)) {
	#my $outfile = "commands2run.tree.on.comandra.txt";
	#open OUT,">$outfile";
	my $aa_file ="";

	my $prefix ="";
	if ($infile=~ /(.+)\.faa$/) {
		$prefix = $1;
		$aa_file = $infile;
	}
	$prefix =~ s/\s+//g;;
	#print "$prefix\n";
	if ($prefix) {
		my $aa_aln ="$prefix.fasta.faa.aln";
		my $cds_aln = "$prefix.fasta.fna.aln";
		my $cds_trim="$prefix.fasta.fna.aln.trim";
		my $cds_file ="$prefix.fna";
		#print "$aa_file\t$aa_aln\t$cds_file\t$cds_aln\t$cds_trim\n";
		system "mafft --maxiterate 1000 --thread 1 --localpair $aa_file > $aa_aln";
		system "perl ~/Dropbox/BACKUP/Bioinformatics_journal/force_dna_aln_Eric.pl $aa_aln $cds_file $cds_aln";
		system "~/software/trimAl/source/trimal -in $cds_aln -gt 0.1 -out $cds_trim";
		system "perl ~/Dropbox/BACKUP/Bioinformatics_journal/fasta2relaxedPhylip_Eric_zz.pl $cds_trim"

		# print OUT "scp *.phylip zzy5028@10.102.32.23:/scratch/users/zhenzhen/Test";
		# print OUT "/Users/Shared/software/RAxML/RAxML-7.2.1/raxmlHPC-PTHREADS-SSE3  -T 6 -f a -x 12345 -p 12345 -# 100 -m GTRGAMMA -s 226.1node.fasta.fna.aln.trim.phylip -n 226.1node.tree -o gnl_Bradi1.2_Bradi1g22370.1";
		# close OUT;

	}
	

	

}
