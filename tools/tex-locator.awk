# Prints the number that a line of a paper's TeX gets in the compiled paper,
# so that a TeX line can be cited as, for example, [GLC1] Conj. 1.6.7.
#
#   awk -v line=1861 -f tools/tex-locator.awk references/papers/2405.03599v3/src/functor.tex
#   → 1.6.7
#
# It counts \section, \subsection and \subsubsection (and their short forms \ssec, \sssec),
# and every theorem environment that shares the subsubsection counter
# (\newtheorem{env}[subsubsection]{...}), as the papers in docs/references.bib do.
# An unnumbered introduction (\section*) gives 0, and sections after \appendix give A, B, ...
# The number printed is that of the innermost numbered unit open at the line.

{ text = $0; sub(/(^|[^\\])%.*/, "", text) }

match(text, /\\newtheorem\{[A-Za-z]+\}\[subsubsection\]/) {
  env = substr(text, RSTART + 12, RLENGTH - 12)
  sub(/\}.*/, "", env)
  shared[env] = 1
}

text ~ /\\appendix/ { appendix = 1; sec = 0 }
text ~ /\\section[ \t]*\{/ { sec++; ssec = 0; sssec = 0 }
text ~ /\\(ssec|subsection)[ \t]*\{/ { ssec++; sssec = 0 }
text ~ /\\(sssec|subsubsection)[ \t]*\{/ { sssec++ }

{
  rest = text
  while (match(rest, /\\begin\{[A-Za-z]+\}/)) {
    env = substr(rest, RSTART + 7, RLENGTH - 8)
    if (env in shared) sssec++
    rest = substr(rest, RSTART + RLENGTH)
  }
}

NR == line {
  printf "%s.%d.%d\n", (appendix ? sprintf("%c", 64 + sec) : sec), ssec, sssec
  exit
}
