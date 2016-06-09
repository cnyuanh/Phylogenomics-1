#!/usr/bin/perl -w
use strict;
#get_best_blast_result_zz.pl
#purpose is to get the best blast result defined by having the highest bitscore
#blast result may not be always reported by having the first hit as the best hit, because sometimes lower evalue may have the highest bitscore
#so we want to sort the hits by bitscore
my $infile = $ARGV[0] || die "need the blast result\n";
my %hit;
my @hits;
my $count=1;
open IN,"<$infile";
while(<IN>) {
    chomp;
    my @F= split(/\t/,$_);
    my ($query, $hit, $bitscore) = ($F[0], $F[1], $F[5]);
    #print "$query\t$hit\t$bitscore\n";
    $hit{$query}{$bitscore}{$hit} = $_;
}
close IN;

foreach my $query (sort keys %hit) {
    my $num_hits=0;
    foreach my $bitscore (sort {$b<=>$a} keys %{$hit{$query}}) {
        foreach my $hit (sort keys %{$hit{$query}{$bitscore}}) {
            if($num_hits < 1) {
                print "$hit{$query}{$bitscore}{$hit}\n";
                $num_hits++;
            }
        }
        
    }
    
}



