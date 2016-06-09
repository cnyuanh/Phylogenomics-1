#!/usr/bin/perl -w
use strict;

#print "This script will convert your DNA sequence to PROTEIN Sequence\n\n";

#my $DNAfilename = <STDIN>;
#chomp $DNAfilename;
#unless ( open(DNAFILE, $DNAfilename) ) {
#    print "Cannot open file \"$DNAfilename\"\n\n";
#}
#@DNA = <DNAFILE>;
#close DNAFILE;
#$DNA = join( '', @DNA);
#print " \nThe original DNA file is:\n$DNA \n";
#$DNA =~ s/\s//g;
#my $protein='';
#my $codon;
#for(my $i=0;$i<(length($DNA)-2);$i+=3)
#{
#$codon=substr($DNA,$i,3);
#$protein.=&codon2aa($codon);
#}
#print "The translated protein is :\n$protein\n";
#<STDIN>;

my $phylip_infile = $ARGV[0] || die "need the input phylip file\n";
my @F ;
my @M;
my %seq;
open IN,"<$phylip_infile";
while(<IN>) {
    chomp;
    if (/^\d+/) {
        next;
    }
    else {
        @F = split(/\s+/,$_);
        print ">$F[0]\n";
        my $value = $F[1];
        my $protein ='';
        my $codon;
        for (my $i = 0; $i < length($value)-2; $i+=3) {
            $codon = substr($value,$i,3);
            $protein .=&codon2aa($codon);
        }
        print "$protein\n";
    }
}

close IN;



sub codon2aa{
my($codon)=@_;
$codon=uc $codon;
my(%g)=('---' => '-','NNN' => 'X','ATN' => 'X','ACN' => 'X','AGN' => 'X','TCN' => 'X','TGN' => 'X','CGN' => 'X','TAN' => 'X','CAN' => 'X','GAN' => 'X','CTN' => 'X','GTN' => 'X','GCN' => 'X','ANT' => 'X','ANC' => 'X','ANG' => 'X','TNC' => 'X','TNG' => 'X','CNG' => 'X','TNA' => 'X','CNA' => 'X','GNA' => 'X','CNT' => 'X','GNT' => 'X','GNC' => 'X','NAT' => 'X','NAC' => 'X','NAG' => 'X','NTC' => 'X','NTG' => 'X','NCG' => 'X','NTA' => 'X','NCA' => 'X','NGA' => 'X','NCT' => 'X','NGT' => 'X','NGC' => 'X','AAN' => 'X','TTN' => 'X','CCN' => 'X','GGN' => 'X','ANA' => 'X','TNT' => 'X','CNC' => 'X','GNG' => 'X','NAA' => 'X','NTT' => 'X','NCC' => 'X','NGG' => 'X','NNA' => 'X','NNT' => 'X','NNC' => 'X','NNG' => 'X','NAN' => 'X','NTN' => 'X','NCN' => 'X','NGN' => 'X','ANN' => 'X','TNN' => 'X','CNN' => 'X','GNN' => 'X','TCA'=>'S','TCC'=>'S','TCG'=>'S','TCT'=>'S','TTC'=>'F','TTT'=>'F','TTA'=>'L','TTG'=>'L','TAC'=>'Y','TAT'=>'Y','TAA'=>'_','TAG'=>'_','TGC'=>'C','TGT'=>'C','TGA'=>'_','TGG'=>'W','CTA'=>'L','CTC'=>'L','CTG'=>'L','CTT'=>'L','CCA'=>'P','CCC'=>'P','CCG'=>'P','CCT'=>'P','CAC'=>'H','CAT'=>'H','CAA'=>'Q','CAG'=>'Q','CGA'=>'R','CGC'=>'R','CGG'=>'R','GCA'=>'A','CGT'=>'R','ATA'=>'I','ATC'=>'I','ATT'=>'I','ATG'=>'M','ACA'=>'T','ACC'=>'T','ACG'=>'T','ACT'=>'T','AAC'=>'N','AAT'=>'N','AAA'=>'K','AAG'=>'K','AGC'=>'S','AGT'=>'S','AGA'=>'R','AGG'=>'R','GTA'=>'V','GTC'=>'V','GTG'=>'V','GTT'=>'V','GCA'=>'A','GCC'=>'A','GCG'=>'A','GCT'=>'A','GAC'=>'D','GAT'=>'D','GAA'=>'E','GAG'=>'E','GGA'=>'G','GGC'=>'G','GGG'=>'G','GGT'=>'G');
if(exists $g{$codon})
{
return $g{$codon};
}
else
{
print STDERR "Bad codon \"$codon\"!!\n";
exit;
}
}
                                           

