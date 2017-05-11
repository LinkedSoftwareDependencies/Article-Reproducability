#!/bin/bash
# dvisvgm requires ghostlib
if [ -z "$LIBGS"]; then
    LIBGS="/usr/local/Cellar/ghostscript/9.21_1/lib/libgs.dylib"
fi

# compile tex -> dvi -> svg
basename=$(echo "$1" | sed "s/^\(.*\/\)*\([^\/]*\)\.tex$/\2/")
targetdir=$(echo "$1" | sed "s/^\(.*\/\)*\([^\/]*\)\.tex$/\1/")
pdflatex -interaction=nonstopmode -halt-on-error $1
latex    -interaction=nonstopmode -halt-on-error $1 
dvisvgm --libgs=$LIBGS --no-fonts $basename.dvi $basename.svg
mv $basename.svg $targetdir

# cleanup
rm $basename.aux $basename.dvi $basename.log $basename.pdf
