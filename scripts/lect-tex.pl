#!/usr/bin/perl -w

# Programme de formattage de texte latin/vernaculaire sur deux colonnes

use strict;
use utf8;

# Programme principal

sub usage() {
	print STDERR "Usage: ", $0, " <leçon latine> <leçon vernaculaire>\n";
}

if ($#ARGV != 1) {
	usage;
	exit(1);
}

my $lect  = $ARGV[0];
my $lect_vern = $ARGV[1];

my $lect_tex = $lect;
$ps_tex =~ s/^(.+)_[^\.]+?\.txt$/$1\.tex/;

my ($fh_ps, $fh_vern, $fh_tex);

# Ouverture des fichiers d'entrée
open ($fh_ps, '<', $ps) or die "Echec de l'ouverture du fichier : $ps ", $!;
open ($fh_vern, '<', $ps_vern) or die "Echec de l'ouverture du fichier : $ps_vern ", $!;

# Ouverture du fichier tex en sortie
open ($fh_tex, '>', $ps_tex) or die "Echec de l'ouverture du fichier : $ps_tex ", $!;
