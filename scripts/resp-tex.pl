#!/usr/bin/perl -w

# Conversion de la traduction vernaculaire du répons en fichier latex formatté

use strict;
use utf8;
use Getopt::Std;

sub debut_block_italique {
	return '\textit{';
}

sub fin_block() {
	return '}';
}

# Programme principal

sub usage() {
	print STDERR "Usage: ", $0, "[options] <répons vernaculaire>\n\n";
	print STDERR "Options:\n";
	print STDERR "\t-o : fichier de sortie\n";
}

our ($opt_o);
getopt('o');

my $rep = $ARGV[0];
my $rep_tex;

if (defined($opt_o)) {
	$rep_tex = $opt_o;
}
else {
	$rep_tex = $rep;
	$rep_tex =~ s/\.txt$/\.tex/;
}

my ($fh, $fh_tex);

# Ouverture des fichiers d'entrée
open ($fh, '<', $rep) or die "Echec de l'ouverture du fichier : $rep ", $!;
open ($fh_tex, '>', $rep_tex) or die "Echec de l'ouverture du fichier : $rep_tex ", $!;

my $ligne;

print $fh_tex debut_block_italique;
while (defined($ligne = <$fh>)) {
	# Remplacement du symbole de verset par un symbole latex
	$ligne =~ s|V/|\\Vbarsmall|;
	# Remplacement du symbole de répons par un symbole latex
	$ligne =~ s|R/|\\Rbar|;
	print $fh_tex $ligne;
}
print $fh_tex fin_block;

close($fh);
close($fh_tex);
