#!/usr/bin/perl -w

# Formattage du titre de psaume

use strict;
use Getopt::Std;

# Programme principal

sub usage() {
	print STDERR "Usage: ", $0, "[options] <fichier de titre de psaume>\n\n";
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

# Nom du psaume

my $ligne = <$fh>;
chomp $ligne;
print $fh_tex "\\begin{center}\\uppercase{\\Large{$ligne}}\\end{center}\n"; 

# Résumé
$ligne = <$fh>;
chomp $ligne;
print $fh_tex "\\begin{center}\\uppercase{\\large{$ligne}}\\end{center}\n";

# Citation
$ligne = <$fh>;
chomp $ligne;
print $fh_tex "\\begin{center}\\textit{$ligne}\\end{center}\n";

close($fh);
close($fh_tex);
