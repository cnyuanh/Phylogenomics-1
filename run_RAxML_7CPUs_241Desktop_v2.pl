#!/usr/bin/perl

use strict;
#difference of v2 is that the RAXML tree output file adds .tree automatically
if (!$ARGV[0]) {
    print "USAGE: run_RAxML.pl <alndir>\n\n";
    print "Note: Its advisable to run this script inside the phylip alignments directory\n";
    print "so that the trees ouput sub-directory is created within the alignments directory\n\n";
    exit(1);
}

print "Start "; system "date";

my $alndir = $ARGV[0];
my @files;

my $dirname = "$alndir/treedir";
mkdir $dirname, 0755;
 
opendir (DIR, "$alndir") or die $!;
while (my $file = readdir(DIR)) {
    if ($file !~ /\.phylip$/){next;} # change pattern to match your files
    push (@files, $file);
}
closedir(DIR);

open (OUT, ">$dirname/completed_ortho_trees.txt") or die $!;
foreach my $aln_file (@files) {
    print "$aln_file\n";
    $aln_file =~ /^(\w+)(.*)/;
    my $orthogroup = $1;
    my @orthotaxa;
    my $outgroup;
    my $raxml_name = "$orthogroup".".tree";
    my @taxa = qw(Phypa Selmo Ambtr Phoda Musac Sorbi Bradi Orysa Aquco Nelnu Vitvi Carpa Thepa Theca Arath Poptr Medtr Glyma Frave Soltu Solly Mimgu); # change the order of outgroup selection array
    open (IN, "$alndir/$aln_file") or die $!;
    while (<IN>) {
    	chomp;
	my @F = split(/\s+/, $_);
        push (@orthotaxa, $F[0]);
    }
    close IN;

    foreach my $species (@taxa) {
	foreach my $id (@orthotaxa) {
	    if ($id =~ /$species/) {$outgroup = $id; last}
	}
	if ($outgroup) {last;}
    }
    print "$outgroup\n";
    # on comandra (make you change -T option (CPUs) to the available processors)
    system "/Users/Shared/software/RAxML/RAxML-7.2.1/raxmlHPC-PTHREADS-SSE3 -T 7 -f a -x 12345 -p 12345 -# 100 -m GTRGAMMA -s $alndir/$aln_file -n $raxml_name -o $outgroup";
    # on ubuntu shared
    #system "/home/shared/Software/RAxML-7.2.8-ALPHA/raxmlHPC-PTHREADS-SSE3 -T 10 -f a -x 12345 -p 12345 -# 100 -m GTRGAMMA -s $alndir/$aln_file -n $orthogroup -o $outgroup";
    #system "/home/shared/Software/RAxML-7.2.8-ALPHA/raxmlHPC-PTHREADS-SSE3 -T 10 -f a -x 12345 -p 12345 -# 100 -m PROTGAMMAJTT -s $alndir/$aln_file -n $orthogroup -o $outgroup";
    system "rm *.reduced RAxML_bestTree.* RAxML_bipartitionsBranchLabels.* RAxML_bootstrap.* RAxML_info.*";
    system "mv RAxML_bipartitions.* $dirname";
    
    print OUT "$orthogroup\n";
}    
close OUT;

print "Stop "; system "date";
