#!/usr/bin/perl

use strict;

if (!$ARGV[0]) {
    print "USAGE: newick2nexml_dendroscope_source_generator.pl <newick_tree_dir>\n\n";
    print "Please give full paths to input directories\n\n";
    exit(1);
}

print "Start "; system "date";

my $tree_dir = $ARGV[0];
my %color = (Phypa => '0 0 0', Selmo  => '0 0 0', Ambtr => '0 0 255', basalAngiosperm=> '0 0 255', Pinta => '0 0 0',Spipo => '255 153 0', Musac => '255 153 0', Sorbi => '255 153 0', 
         Phyllostachys => '255 153 0', Triticum => '255 153 0',Bradi => '255 153 0',Phoda => '255 153 0', Orysa => '255 153 0', 
	     Elagu => '255 153 0', Orysa => '255 153 0',Oryza => '255 153 0', Zea_mays => '255 153 0',Brachypodium => '255 153 0', Aegilops=> '255 153 0',Setaria => '255 153 0',sorghum=> '255 153 0',
         Acorus => '255 153 0', Dioscorea => '255 153 0',equestris => '255 153 0', duckweed => '255 153 0',Typha => '255 153 0',monocot => '255 153 0',Yucca=> '255 153 0',
         Elaeis => '255 153 0',Phoenix => '255 153 0', Zostera=> '255 153 0',
         Aquco => '204 0 204',basalEudicot => '204 0 204',
         Nelnu => '204 0 204', Nelumbo => '204 0 204', Vitvi => '255 0 0', Eucgr => '255 0 0',Phavu => '255 0 0', Medtr => '255 0 0',Glyma => '255 0 0', 
         Vigna_angularis => '255 0 0', Prupe => '255 0 0', Carpa => '255 0 0', Malus => '255 0 0', Arabis => '255 0 0', Eutrema => '255 0 0',Tarenaya => '255 0 0',
         Theobroma => '255 0 0', Pyrus => '255 0 0', Rosid => '255 0 0',
	     Manes => '255 0 0', Theca => '255 0 0', Arath => '255 0 0', Frave => '255 0 0', Poptr => '255 0 0',Populus => '255 0 0', Prunus => '255 0 0',Arabidopsis => '255 0 0', Vitis => '255 0 0', 
         Malus_domestica => '255 0 0', Fragaria => '255 0 0', Brassica => '255 0 0', Camelina => '255 0 0', Thepa => '255 0 0',Fragaria=> '255 0 0',Citrus => '255 0 0',
         cucumber => '255 0 0',Jatropha => '255 0 0', orange => '255 0 0', eucalyptus => '255 0 0', cotton => '255 0 0', Glycine => '255 0 0', Cicer => '255 0 0',
         Gossypium => '255 0 0', Ricinus => '255 0 0', Populus => '255 0 0',  Cannabis => '255 0 0', Capsella => '255 0 0', Capsella_rubella => '255 0 0',
         lotus => '255 0 0', cassava => '255 0 0', Morus => '255 0 0', primrose => '255 0 0', Phaseolus => '255 0 0',Cucumis => '255 0 0',Medicago => '255 0 0', Quercus => '255 0 0',
         Passiflora => '255 0 0', prunus => '255 0 0', Pvulgaris => '255 0 0', Quercus => '255 0 0',Staphylea => '255 0 0',
         Stras => '0 255 0',asiatica => '0 255 0',Striga => '0 255 0', Triphysaria => '0 255 0',Striga_gesneroides => '0 255 0',Triphysaria_eriantha => '0 255 0',Triphysaria_pusilla => '0 255 0',
         Phelipanche_mutelii => '0 255 0',Phelipanche_aegyptiaca => '0 255 0', Phelipanche_ramosa => '0 255 0',Orobanche_californica => '0 255 0',Orobanche_minor => '0 255 0',Alectra_vogelii => '0 255 0',
         TrVeBC3 => '0 255 0',StHeBC3 => '0 255 0',OrAeBC5 => '0 255 0',PhAeBC5 => '0 255 0',
         Mimgu => '0 204 0', Erythranthe_guttatus => '0 204 0',Utrgi => '0 204 0', Solly => '0 204 0', Nicotiana=> '0 204 0', Betvu => '0 204 0',Beta_vulgaris => '0 204 0',
         Wrightia_natalensis => '0 204 0', Lactuca_sativa => '0 204 0', Saponaria_officianalis => '0 204 0',
          Achn => '0 204 0', Utrgi => '0 204 0', Sesamum => '0 204 0', kiwi => '0 204 0',Solly => '0 204 0',Soltu => '0 204 0',LiPh => '0 204 0',
          Paulawniaceae => '0 204 0', Lamiaceae => '0 204 0', Verbenaceae => '0 204 0',Oleaceae => '0 204 0', gnl_Utrgi => '0 204 0', Betvu => '0 204 0',
          Spinacia_oleracea => '0 204 0', coffea => '0 204 0', Mimulus => '0 204 0', Caryophyllales => '0 204 0',
         Acanthaceae => '0 204 0', Bignoniaceae => '0 204 0', Gesneriaceae => '0 204 0', Lamiaceae => '0 204 0',Oleaceae => '0 204 0', Paulawniaceae => '0 204 0',
         Plantaginaceae => '0 204 0', Rehmannia => '0 204 0',Verbenaceae => '0 204 0', Ipomoea => '0 204 0',Cuscuta => '0 255 0',
         Stras => '0 255 0', Epifagus => '0 255 0',
         LaSa => '0 204 0',  HeAn => '0 204 0', Solanum => '0 204 0', asterid => '0 204 0'
          );
my %fillColor = (Stras => '153 153 153', asiatica => '153 153 153',Striga => '153 153 153', Triphysaria => '153 153 153',
           
            OrAeBC5 => '153 153 153',PhAeBC5 => '153 153 153',TrVeBC3 => '153 153 153',StHeBC3 => '153 153 153',
            PhAeBC5 => '153 153 153', Striga_gesneroides => '153 153 153',Triphysaria_eriantha => '153 153 153',
            Triphysaria_pusilla => '153 153 153', Phelipanche_mutelii => '153 153 153',Phelipanche_ramosa => '153 153 153',
            Orobanche_californica => '153 153 153', Orobanche_minor => '153 153 153',Alectra_vogelii => '153 153 153',
            Epifagus => '153 153 153',Phelipanche_aegyptiaca => '153 153 153',Cuscuta => '153 153 153'
    );



opendir (DIR, "$tree_dir") or die $!;
while (my $file = readdir(DIR)) {
    #if ($file !~ /^(\d+)\.fna\.aln\.trim(\.filter)*\.tree$/) {next;} # change pattern matching 
    if ($file !~ /^RAxML_bipartitions\.(.+)\.tree$/) {next;} # change pattern matching
    my $ortho = $1;

    
    my $ortho = $1;
    open (OUT, ">$tree_dir/$ortho.dendroscope.source") or die $!;
    print OUT "open file=$tree_dir/$file;\n"; # change file strings patterns
    foreach my $taxa (keys %color){
	print OUT "find searchtext=$taxa;\n";
	print OUT "set labelcolor=$color{$taxa};\n";
	if ($fillColor{$taxa}){
	    print OUT "set labelfillcolor=$fillColor{$taxa};\n";
	}    
	print OUT "deselect all;\n";
    } 
    print OUT "save format=nexml file=$tree_dir/$ortho.RAxML.nexml;\n"; # change file strings pattern 
    #print OUT "save format=nexml file=$tree_dir/$ortho.FastTree.nexml;\n"; # change file strings pattern
    close OUT;
}
closedir(DIR);

print "Stop "; system "date";
exit(0);
