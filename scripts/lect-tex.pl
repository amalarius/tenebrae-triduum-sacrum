#!/usr/bin/perl -w

# Programme de formattage de texte latin/vernaculaire sur deux colonnes

use strict;
use Getopt::Std;

sub debut_parallele() {
	return "\\begin{Parallel}[v]{\\collectlatin}{\\collectvern}\n";
}

sub fin_parallele() {
	return "\\end{Parallel}\n";
}

sub debut_colonne_gauche {
	return '\latin{';
}

sub colonne_gauche($) {
	my ($texte) = @_;
	return "\\latin{$texte}";
}

sub debut_colonne_droite {
	return '\vern{';
}

sub colonne_droite($) {
	my ($texte) = @_;
	return "\\vern{$texte}";
}

sub fin_block() {
	return "}\n";
}

sub commentaire($) {
	my ($texte) = @_;
	return "\\commentary{\\color{red}{\\emph{$texte}}}\n";
}

sub texte_centre($) {
	my ($texte) = @_;
	return "\\begin{center}$texte\\end{center}";
}

sub texte_large($) {
	my ($texte) = @_;
	return "\\large{$texte}";
}

sub debut_texte_centre {
	return '\begin{center}';
}

sub fin_texte_centre {
	return '\end{center}';
}

sub debut_texte_italique {
	return '{\itshape ';
}

sub debut_texte_gras {
	return '{\bfseries ';
}

sub texte_gras($) {
	my ($texte) = @_;
	return "\\textbf{$texte}";
}

sub texte_italique($) {
	my ($texte) = @_;
	return "\\textit{$texte}";
}

sub espace_deux_colonnes($) {
	my ($dim) = @_;
	return "\\twocolspace{$dim}\n";
}

sub minipage_gauche($) {
	my ($texte) = @_;
	return "\\begin{minipage}{\\ParallelLWidth}$texte\\end{minipage}";
}

sub minipage_droite($) {
	my ($texte) = @_;
	return "\\begin{minipage}{\\ParallelRWidth}$texte\\end{minipage}";
}

# Programme principal

sub usage() {
	print STDERR "Usage: ", $0, "[options] <leçon latine> <leçon vernaculaire>\n";
}

our ($opt_t, $opt_o);
getopts('to:');

if ($#ARGV != 1) {
	usage;
	exit(1);
}

my $lect  = $ARGV[0];
my $lect_vern = $ARGV[1];
my $lect_tex;

if (defined($opt_o)) {
	$lect_tex = $opt_o;
}
else {
	$lect_tex = $lect;
	$lect_tex =~ s/\.txt$/\.tex/;
}

my ($fh, $fh_vern, $fh_tex);

# Ouverture des fichiers d'entrée
open ($fh, '<', $lect) or die "Echec de l'ouverture du fichier : $lect ", $!;
open ($fh_vern, '<', $lect_vern) or die "Echec de l'ouverture du fichier : $lect_vern ", $!;

# Ouverture du fichier tex en sortie
open ($fh_tex, '>', $lect_tex) or die "Echec de l'ouverture du fichier : $lect_tex ", $!;

my $ligne;

# Référence textuelle
$ligne = <$fh>;
$ligne = <$fh_vern>;
chomp $ligne;
print $fh_tex commentaire($ligne);

## Maintenant, lecture parallèle des deux fichiers et composition de la sortie
print $fh_tex debut_parallele();

# Titre
if (defined($opt_t)) {
	# Titre
	$ligne = <$fh>;
	chomp $ligne;
	print $fh_tex colonne_gauche(minipage_gauche(texte_centre(texte_gras(texte_large($ligne))))), "\n";
	
	$ligne = <$fh_vern>;
	chomp $ligne;
	print $fh_tex colonne_droite(minipage_droite(texte_centre(texte_gras(texte_large($ligne))))), "\n";
}

# Sous-titre s'il y en a
if (defined($opt_t)) {
	$ligne = <$fh>;
	chomp $ligne;
	if ($ligne !~ /^\s*$/) {
		print $fh_tex espace_deux_colonnes("0.4cm"), "\n";
		print $fh_tex colonne_gauche(minipage_gauche(texte_centre(texte_italique($ligne)))), "\n";
	
		$ligne = <$fh_vern>;
		chomp $ligne;
		print $fh_tex colonne_droite(minipage_droite(texte_centre(texte_italique($ligne)))), "\n";
		
		# Ligne vide
		$ligne = <$fh>;
		$ligne = <$fh_vern>;
	}
	else {
		$ligne = <$fh_vern>;
	}
}
else {
	# Ligne vide
	$ligne = <$fh>;
	$ligne = <$fh_vern>;
}

print $fh_tex espace_deux_colonnes("0.2cm");

while (defined($ligne = <$fh>)) {
	
	# Colonne gauche
	print $fh_tex debut_colonne_gauche();
	do {
		chomp $ligne;
		
		$ligne =~ s/'æ/\\'æ/g;
		$ligne =~ s/'œ/\\'œ/g;
		
		print $fh_tex $ligne, "\n";
	}
	while (defined($ligne = <$fh>) && ($ligne !~ /^\s*\n{0,1}$/));
	print $fh_tex fin_block();
	
	# Colonne droite
	print $fh_tex debut_colonne_droite();
	print $fh_tex debut_texte_italique();
	while (defined($ligne = <$fh_vern>) && ($ligne !~ /^\s*\n{0,1}$/)) {
		chomp $ligne;
		print $fh_tex $ligne, "\n";
	}
	print $fh_tex fin_block();
	print $fh_tex fin_block();
	
	if (defined($ligne)) {
		print $fh_tex espace_deux_colonnes("0.3cm");
	}
}

print $fh_tex fin_parallele();

exit(0);
