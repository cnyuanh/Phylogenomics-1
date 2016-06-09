#!/usr/bin/perl -w
use strict;
#run_mafft.pl
my $pep = $ARGV[0] || die "need the input peptide file\n";
my $pep_aln =  $pep.".aln";
system "~/software/mafft-mac/mafft.bat --maxiterate 1000 --thread 6 --localpair $pep >  $pep_aln";
