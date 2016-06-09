#!/usr/bin/perl -w
# ===============================================
# This scripts splits a big fasta file into small
# fasta files
# 
# Eric Wafula
# 11/01/2010
# ===============================================

use strict;

# ============= Check for input parameters =========
if (!$ARGV[1]) {
    print "USAGE: split_fasta.pl <input fasta file> <number of sequences per output file>\n";
    exit(1);
}

# ============ Initialize varibles ============
my $big_file = $ARGV[0]; 
my $split_seqs=$ARGV[1]; 
my $out_template="$ARGV[0]_NUMBER.fasta";
my $count=0; 
my $filenum=0; 
my $len=0; 
my $filename;
open (IN, "<$big_file") or die $!;
while (<IN>) { 
	s/\r?\n//;
	if (/^>/) { 
		if ($count % $split_seqs == 0) { 
			$filenum++; 
			$filename = $out_template; 
			$filename =~ s/NUMBER/$filenum/g; 
			if ($filenum > 1) { 
				close SHORT 
			} 
			open (SHORT, ">$filename") or die $!; 
		} 
		$count++; 
	} 
	else { 
		$len += length($_) 
	} 
	print SHORT "$_\n"; 
} 
close(SHORT); 
close(IN);
warn "\nSplit $count FASTA records in $. lines, with total sequence length $len\nCreated $filenum files like $filename\n\n";