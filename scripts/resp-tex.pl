#!/usr/bin/perl -w

# Conversion de la traduction vernaculaire du répons en fichier latex formatté

use strict;
use utf8;

sub debut_block_italique {
	return '\textit{';
}

sub fin_block() {
	return '}';
}

# Programme principal

sub usage() {
	print STDERR "Usage: ", $0, " <répons vernaculaire>\n";
}

if ($#ARGV != 0) {
	usage;
	exit(1);
}

my $rep = $ARGV[0];
my $rep_tex = $vers;

$rep_tex =~ s/\.txt$/\.tex/;

my ($fh, $fh_tex);

# Ouverture des fichiers d'entrée
open ($fh, '<', $rep) or die "Echec de l'ouverture du fichier : $ps ", $!;
open ($fh_tex, '>', $rep_tex) or die "Echec de l'ouverture du fichier : $ps_vern ", $!;

my $ligne;

print $fh_tex debut_block_italique;
while (defined($ligne = <$fh>)) {
	# Remplacement du symbole de verset par un symbole latex
	$ligne =~ s|V/|\\Vbarsmall|;
	print $fh_tex $ligne;
}
print $fh_tex fin_block;

close($fh);
close($fh_tex);
