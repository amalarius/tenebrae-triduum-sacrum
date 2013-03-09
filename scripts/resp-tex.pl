#!/usr/bin/perl -w

# Conversion de la traduction vernaculaire du répons en fichier latex formatté

use strict;
use Getopt::Std;

sub debut_parallele() {
	return "\\begin{Parallel}[v]{\\collectlatin}{\\collectvern}\n";
}

sub fin_parallele() {
	return "\\end{Parallel}\n";
}

sub debut_colonne_gauche {
	#return '\latin{';
	return "{\\fontsize{11.0}{12.5}\\selectfont\\latin{";
}

sub colonne_gauche($) {
	my ($texte) = @_;
	#return "\\latin{$texte}";
	return "{\\fontsize{11.0}{12.5}\\latin{$texte}}";
}

sub debut_colonne_droite {
	#return '\vern{';
	return "{\\fontsize{11.0}{12.5}\\selectfont\\vern{";
}

sub colonne_droite($) {
	my ($texte) = @_;
	#return "\\vern{$texte}";
	return "{\\fontsize{11.0}{12.5}\\selectfont\\vern{$texte}}";
}

sub fin_block() {
	return "}\n";
}

sub debut_block_italique {
	return '\textit{';
}

# Programme principal

sub usage() {
	print STDERR "Usage: ", $0, "[options] <répons latin> <répons vernaculaire>\n\n";
	print STDERR "Options:\n";
	print STDERR "\t-o : fichier de sortie\n";
}

our ($opt_o);
getopt('o');

if ($#ARGV != 1) {
	usage;
	exit(1);
}

my $rep = $ARGV[0];
my $rep_vern = $ARGV[1];
my $rep_tex;

if (defined($opt_o)) {
	$rep_tex = $opt_o;
}
else {
	$rep_tex = $rep;
	$rep_tex =~ s/\.txt$/\.tex/;
}

my ($fh, $fh_vern, $fh_tex);

# Ouverture des fichiers d'entrée
open ($fh, '<', $rep) or die "Echec de l'ouverture du fichier : $rep ", $!;
open ($fh_vern, '<', $rep_vern) or die "Echec de l'ouverture du fichier : $rep_vern ", $!;
open ($fh_tex, '>', $rep_tex) or die "Echec de l'ouverture du fichier : $rep_tex ", $!;

my $ligne;

print $fh_tex debut_parallele();

# Colonne gauche
print $fh_tex debut_colonne_gauche();

while (defined($ligne = <$fh>) && ($ligne !~ /^\s*\n{0,1}$/)) {
	# Remplacement du symbole de verset par un symbole latex
	$ligne =~ s|V/|\\Vbarsmall|;
	# Remplacement du symbole de répons par un symbole latex
	$ligne =~ s|R/|\\Rbar|;
	print $fh_tex $ligne;
}
print $fh_tex fin_block();
print $fh_tex fin_block();

close($fh);

print $fh_tex debut_colonne_droite();
print $fh_tex debut_block_italique();

while (defined($ligne = <$fh_vern>) && ($ligne !~ /^\s*\n{0,1}$/)) {
	# Remplacement du symbole de verset par un symbole latex
	$ligne =~ s|V/|\\Vbarsmall|;
	# Remplacement du symbole de répons par un symbole latex
	$ligne =~ s|R/|\\Rbar|;
	print $fh_tex $ligne;
}

print $fh_tex fin_block();
print $fh_tex fin_block();
print $fh_tex fin_block();


close($fh_vern);

print $fh_tex fin_parallele();

close($fh_tex);

exit(0);
