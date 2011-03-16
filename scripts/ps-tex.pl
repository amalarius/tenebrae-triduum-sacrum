#!/usr/bin/perl -w

use strict;
use Getopt::Std;

#### Fonctions de formattage LaTeX
sub texte_centre($) {
	my ($texte) = @_;
	return "\\begin{center}$texte\\end{center}";
}

sub texte_italique($) {
	my ($texte) = @_;
	return "\\textit{$texte}";
}

sub texte_gras($) {
	my ($texte) = @_;
	return "\\textbf{$texte}";
}

sub espace_vertical($) {
	my ($espace) = @_;
	return "\\vspace{${espace}cm}\n";
}

sub debut_parallele() {
	return "\\begin{Parallel}[v]{\\colpslatin}{\\colpsvern}\n";
}

sub fin_parallele() {
	return "\\end{Parallel}\n";
}

sub colonne_gauche($) {
	my ($texte) = @_;
	return "\\latin{$texte}\n";
}

sub colonne_droite($) {
	my ($texte) = @_;
	return "\\vern{$texte}\n";
}

# Programme principal

sub usage() {
	print STDERR "Usage: ", $0, " <psaume latin> <psaume vernaculaire>\n";
}

our ($opt_o, $opt_2);
getopts('o:2');

my $ps  = $ARGV[0];
my $ps_vern = $ARGV[1];
my $ps_tex;

if (defined($opt_o)) {
	$ps_tex = $opt_o;
}
else {
	$ps_tex = $ps;
	$ps_tex =~ s/\.txt$/\.tex/;
}

my ($fh_ps, $fh_vern, $fh_tex);

# Ouverture des fichiers d'entrée
open ($fh_ps, '<', $ps) or die "Echec de l'ouverture du fichier : $ps ", $!;
open ($fh_vern, '<', $ps_vern) or die "Echec de l'ouverture du fichier : $ps_vern ", $!;

# Ouverture du fichier tex en sortie
open ($fh_tex, '>', $ps_tex) or die "Echec de l'ouverture du fichier : $ps_tex ", $!;

my $nb = 1;
my ($ligne);
# Si on commence au deuxième verset, on affiche le premier verset en
# vernaculaire sur une seule colonne
if (defined($opt_2)) {
	$ligne = <$fh_ps>;
	
	$ligne = <$fh_vern>;
	chomp $ligne;
	print $fh_tex texte_italique($ligne), "\n";
}

## Maintenant, lecture parallèle des deux fichiers et composition de la sortie

# Psaume en double collonne latin/vernaculaire
print $fh_tex debut_parallele();

while (defined($ligne = <$fh_ps>)) {
	chomp $ligne;
	
	last if ($ligne =~ /^\s*$/);
	
	# On indique le début de la psalmodie par une flêche, au deuxième verset
	#if (! defined($opt_2) && $nb == 2) {
	#	$ligne = '\textcolor{red}{\large{\textrightarrow}} ' . $ligne;
	#}
	
	## A gauche, la psalmodie latine	
	# Signe de croix
	$ligne =~ s/\s=\|=/\\textcolor\{red\}\{\\grecross\}/g;
	
	# Flexe
	$ligne =~ s/\s\+/~{\\color\{red\} \\gredagger}/g;
	
	# Mediante, plus passage à la ligne
	$ligne =~ s/\s\*/~{\\color\{red\} \\greheightstar}\\\\\n/g;
	
	# Syllabes préparatoires en italique
	$ligne =~ s|/([^/]*?)/|\\textit{$1}|g;
	
	# Accents en gras
	$ligne =~ s/#([^\#]*?)#/\\textbf{$1}/g;
	
	print $fh_tex colonne_gauche($ligne);
	
	## A droite, la psalmodie vernaculaire
	if (defined($ligne = <$fh_vern>)) {
		chomp $ligne;
		print $fh_tex colonne_droite(texte_italique($ligne));
	}
	
	$nb++;
}

print $fh_tex fin_parallele();

close($fh_tex);

close($fh_ps);
close($fh_vern);

exit(0);

