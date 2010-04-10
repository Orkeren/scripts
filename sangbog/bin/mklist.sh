#!/bin/sh

###############################################################################
# mklist.sh
# ---------
#
# Dette lille script gennems��ger en masse enkelte single-song chord-filer i
# underkataloget src/ og laver en simpel "playlist" ved at kalde ./info.pl p��
# hver af dem.
#
# Skrevet i forbindelse med en hel suite af sm�� dumme scripts til brug for
# konstruktion af sangbog i rusturssammenh��ng(TM).
#
###############################################################################

for file in src/*; do
	bin/info.pl "$file"
done
