#!/bin/bash
# Make a PDF of the lectures after quarto render.
# A deck's PDF is only rebuilt if the .qmd changed since the last PDF.

OUT="_site"   # Quarto output folder

echo "$QUARTO_PROJECT_OUTPUT_FILES" | while read -r html; do
  case "$html" in
    *lecture.html) ;;
    *) continue ;;
  esac

  rel="${html#*$OUT/}"          # e.g. ngs/qc_lecture.html
  qmd="${rel%.html}.qmd"        # source:  ngs/qc_lecture.qmd
  pdf="${rel%.html}.pdf"        # kept at: ngs/qc_lecture.pdf

  if command -v decktape >/dev/null && { [ ! -f "$pdf" ] || [ "$qmd" -nt "$pdf" ]; }; then
    echo "Making $pdf"
    decktape reveal --size 1050x700 "$html" "$pdf"
  fi

  [ -f "$pdf" ] && cp "$pdf" "$OUT/$pdf"

  cp "$pdf" "$OUT/$pdf"         # put it on the site
done