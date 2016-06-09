#!/usr/bin/perl -w
use strict;
#hmmsearch_agst_1ortho_aln.pl

my $pep_aln = $ARGV[0] ; 
my $query_pep = $ARGV[1] ;

my $arg_size = @ARGV;
if ($arg_size != 2 ) {
	print "\nUsage:  perl hmmsearch_agst_1ortho_aln.pl peptide_alignment_for_hmm quer_pep_seq \n\n";
	exit;
}

my $db_hmm = "$pep_aln".".hmm";

my $db_pep = "";
if ($pep_aln =~ /(\S+)\.aln/) {$db_pep = $1;}
my $query_plus_db_pep = $db_pep."_plus_".$query_pep;
my $hmm_out = $query_pep."_agst_query_plus_db_hmm_out.txt";

system "cat $db_pep $query_pep > $query_plus_db_pep";
system "~/software/hmmer-3.1b2-macosx-intel/binaries/hmmsearch --tblout $hmm_out --noali --cpu 1 -E 1e-5 $db_hmm $query_plus_db_pep ";
system "rm $query_plus_db_pep";