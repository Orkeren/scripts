#!/usr/bin/env perl

###############################################################################
# splitit.pl 
# ----------
#
# Dette lille script splitter en multi-song chord-fil op i mange sm� chord-filer
# i et underkatalog der hedder src/. S�rg for at kataloget eksisterer og er tomt
# f�r du kalder dette script. 
#
# Hvis der er eksotiske tegn blandt titler og/eller melodi angivelser i
# chord-sangene, s� kan det kr�ve lidt tilretning af sidste searchreplace linie
# hvor $filename konstrueres.
#
# Skrevet i forbindelse med en hel suite af sm� dumme scripts til brug for
# konstruktion af sangbog i rusturssammenh�ng(TM).
#
# Slamkodet af: Uffe Friis Lichtenberg (uffefl@diku.dk)
#               DIKU, 2. juli 2000
###############################################################################

@lines = <>;

$song = "";
$title = "";
$author = "";
foreach $line (@lines)
{
#    chomp $line;
    if ($line =~ m/.*\{t:([^}]*)\}.*/)
    {
	$title = $1;
	$title =~ s/^\s*//;
	$title =~ s/\s*$//;
    }
    if ($line =~ m/.*\{st:Mel:\s*([^}]*)\}.*/)
    {
        $author = $1;
	$author =~ s/^\s*//;
	$author =~ s/\s*$//;
    }
    if ($line =~ m/.*\{\s*ns\s*\}.*/)
    {
        $filename = "$title";
        $filename .= " ($author)" if (!($author eq ""));
        $filename =~ s/(.*)/\L\1/;
        $filename =~ s/�|�/ae/g;
        $filename =~ s/�|�/oe/g;
        $filename =~ s/�|�/aa/g;
        $filename =~ s/ +/_/g;
        $filename =~ s/(--)|\//-/g;
        $filename =~ s/\&/og/g;
        $filename =~ s/[.()"',:!]//g;
        $filename .= ".chord";
#        print "src/$filename\n";
        open(FIL,">src/$filename");
        print FIL $song;
        close FIL;
        $title = "";
        $author = "";
        $song = "";
    }
    else
    {
        $song = $song . $line;
    }
}
