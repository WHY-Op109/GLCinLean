# The papers

The TeX of each paper in `docs/references.bib` is in the git-ignored
`references/papers/<id>v<version>/src/` (`prompts/setup.md` fetches it). One line per paper, to
choose which one to search:

| Key | Main file | Lines | What it covers |
|---|---|---|---|
| [GLC1] | `2405.03599v3/src/functor.tex` | 4.6k | construction of `𝕃_G` (de Rham and Betti); the conjecture (Conj. 1.6.7, label `c:GLC dR`); equivalent forms of it |
| [GLC2] | `2405.03648v3/src/Loc.tex` | 39.7k | Kac–Moody localization, the FLE; the conventions for `k`, `X`, `G` (§0.4) |
| [GLC3] | `2409.07051v1/src/Eis.tex` | 27.7k | compatibility of `𝕃_G` with Eisenstein series and constant terms |
| [GLC4] | `2409.08670v1/src/ambidex.tex` | 6.4k | GLC for `GL_n`; ambidexterity of `𝕃_G` on the cuspidal part |
| [GLC5] | `2409.09856v3/src/multone.tex` | 6.8k | the multiplicity one theorem, ending the proof |
| [AGKRRV] | `2010.01906v2/src/text.tex` | 31.5k | local systems with restricted variation; nilpotent singular support; conventions GLC I cites (§0.9) |
| [ArinkinGaitsgory] | `1201.6343v4/src/singsupp.tex` | 11.8k | singular support of coherent sheaves; `IndCoh_Nilp`; the original statement of GLC |
| [IndCoh] | `1105.4857v7/src/IndCohtext.tex` | 9.4k | ind-coherent sheaves on schemes and stacks; the functor `Ψ` |

## Searching

- Search one file with `grep -n`: by label (`\label{c:GLC dR}`), by the name of a theorem, or by a
  symbol's TeX macro (`\BL_G`, `\LS`). Labels are named `s:`, `ss:`, `sss:` (sections),
  `t:`, `p:`, `c:`, `l:` (results). Cross-references read `\thmref{t:...}`, `\propref{p:...}`.
- The TeX does not contain the numbers of the compiled paper. To cite a line as AGENTS.md asks,
  for example [GLC1] Conj. 1.6.7, get its number with

      awk -v line=1861 -f tools/tex-locator.awk references/papers/2405.03599v3/src/functor.tex

  which prints `1.6.7`. Cite numbers, never TeX file names or line numbers.
