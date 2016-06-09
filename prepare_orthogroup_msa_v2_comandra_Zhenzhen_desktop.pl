#!/usr/local/perl -w

use strict;

if (!$ARGV[0]) {
    print "USAGE: prepare_orthogroup_msa.pl <ids_formated_orthogroup_dir>\n";
    exit(1);
}


# initialize variables
my $dir = $ARGV[0];

print "Start "; system "date";

&prep_aln($dir);

my $iterator = 0;
my $file = "needMoreAlnRounds.log";
while(-e $file) {
    print "$file file exits...\n";
    if(-z $file){
	print "$file file empty, deleting...\n";
	system "rm $file";
    }
    else{
	print "$file file not empty,next iteration...\n";
	$iterator++;
	&get_new_fasta($file, $dir);
	&prep_aln($dir);
    }
} 
print "Took $iterator iterations to complete filtering alignments\n";

print "Stop "; system "date";

exit(0);

sub prep_aln {
    my $orthodir = shift @_;
    my @files;
	
    my $dirname = "$orthodir/alignments";
    mkdir $dirname, 0755;

    opendir(DIR, "$orthodir") or die $!;
    while(my $filename = readdir(DIR)) {
	if($filename =~ /\.fasta\.faa$/){
	    push (@files, $filename) ;
	}
    }
    closedir(DIR);

    open (LOG, ">needMoreAlnRounds.log") or die $!; 
	
    my $ortho;
    foreach my $file (@files) {
	$file =~ /(\w+)\.fasta\.faa/; #11844And11101.fasta.faa
    	$ortho = $1;
    	system "~/software/mafft-mac/mafft.bat --maxiterate 1000 --thread 7 --localpair $orthodir/$file > $dirname/$file.aln";
    	system "perl ~/Dropbox/BACKUP/Bioinformatics_journal/force_dna_aln.pl $dirname/$file.aln $orthodir/$ortho.fasta.fna $dirname/$ortho.fasta.fna.aln";
    	system "~/software/trimAl/source/trimal -in $dirname/$ortho.fasta.fna.aln -gt 0.1 -out temp.fasta.fna.aln";
    	
    	open (OUT, ">temp.fasta.fna.aln.trim") or die $!;
    	
    	open (IN, "temp.fasta.fna.aln") or die $!;
    	my @seq_order;
    	my %seq;
    	my $id;
    	while (<IN>){
	    chomp;
            if (/^>(\S+)/){
		$id = $1;
		push(@seq_order, $id);
            }
            else {
		s/\s+//g;
            	$seq{$id} .= $_;
            }
    	}
    	close IN;
    	
    	my $sequence;
    	my $count = 0;
    	foreach my $gene(@seq_order) {
	    if ($gene !~ /^gnl/){
		$sequence = $seq{$gene};
		$sequence =~ s/-//g;
		if ((length($sequence)/length($seq{$gene})) >= 0.5){
		    print OUT ">$gene\n$seq{$gene}\n";
		}
            	else{ $count++; }
	    }
            else {
		print OUT ">$gene\n$seq{$gene}\n";
       	    }
	}
    	close OUT;
    	if ($count != 0){
	    print LOG "$ortho.fasta.fna.aln.trim\n";
    	}
    	system "mv temp.fasta.fna.aln.trim $dirname/$ortho.fasta.fna.aln.trim";
    	system "rm temp.fasta.fna.aln";
    }
    close LOG;
} #end prep_aln subroutine


sub get_new_fasta {
    my ($filenames, $orthodir) = @_;
    my @files;
    my $dirname = "$orthodir/addtional_rounds_fasta";
    mkdir $dirname, 0755;
	
    open(IN, "$filenames") or die $!;
    while(<IN>) {
	chomp;
	push (@files, $_);
    }
    close IN;
	
    foreach my $file (@files) {
	$file =~ /(\w+)\.fasta\.fna\.aln\.trim/; # 9900And7400.fasta.fna.aln.trim
    	my $prefix = $1;
    	open(OUT, ">temp.ids") or die $!;
    	open(IN, "$orthodir/alignments/$file") or die $!;
    	while(<IN>){
	    if(/^>(\S+)/){ 
		print OUT "$1\n";
	    }
    	}
    	close IN;
    	close OUT;
    	system "perl ~/Dropbox/BACKUP/Bioinformatics_journal/retrieve_seqs_from_file.pl temp.ids $orthodir/$prefix.fasta.faa $dirname/$prefix.fasta.faa";
    	system "perl ~/Dropbox/BACKUP/Bioinformatics_journal/retrieve_seqs_from_file.pl temp.ids $orthodir/$prefix.fasta.fna $dirname/$prefix.fasta.fna";
    }
    system "rm $orthodir/*.fasta.*";
    system "mv $dirname/*.fasta.*  $orthodir/";
    system "rm -r $dirname";
    system "rm temp.ids";
} # end get_new_fasta subroutine
