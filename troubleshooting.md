# Troubleshooting

Outcome: the six failures a new eza user
actually meets, each with the evidence
and the fix. The lab met four of them
while capturing this guide's
transcripts, which is where
`eza-lab/transcripts/t90-pipe-and-stdin.txt`
came from.

## Eza hangs and prints nothing

**Symptom:** in a script, a pipeline, or
an editor's shell, eza sits silently;
at your terminal it is instant.

**Cause, measured:** eza reads standard
input whenever it is a pipe, and waits
for the end of it before printing
(chapter 14). A caller that holds the
pipe open — a script framework, a parent
process, `sleep` in the lab's own test —
holds the listing with it:

```text
$ time (sleep 3 | eza -1 garden >/dev/null)
real    0m3.002s
$ time (eza -1 garden </dev/null >/dev/null)
real    0m0.003s
```

**Fix:** redirect stdin from `/dev/null`
in scripts (`eza -l </dev/null`), or
close the pipe you are feeding it. If
you *want* to feed it names, that is
`--stdin`, a feature — feed it and close
the pipe when done. Two look-alikes to
rule out first: `--total-size` on a huge
tree is slow for honest reasons, and a
network filesystem can make any listing
slow; both still print *eventually*,
and neither is fixed by stdin.

## --git prints nothing at all

**Symptom:** `eza -l --git` in a
repository: no listing, no error, exit
code 0.

**Cause, verified:** in eza 0.23.5 the
flag needs the folder named. `eza -l
--git .` lists normally, column and all
(`t06`). Check the neighbours of this
bug before concluding: a build without
`[+git]` in `eza --version` has no git
reader at all (chapter 3), and outside
a repository the column is absent by
design — git itself will tell you which
case you are in (`git status` errors in
a non-repository; eza will not).

## The icons are boxes, blanks, or gaps

**Symptom:** `--icons` on, and every
name is preceded by a rectangle or a
suspicious space.

**Cause:** chapter 9's codepoints —
the pictures live in a Nerd Font your
terminal is not using. **Fix:** install
a Nerd Font and set the *terminal* (not
the shell, not eza) to use it — for SSH
sessions, the terminal is the one on
your desk, so the fix is local. Or set
`--icons=never` and lose nothing but
decoration. There is no third outcome
where the server provides the font.

## The colour vanished

**Symptom:** colour at the terminal,
none in the file, the ticket, the CI
log.

**Cause:** `--color=auto` paints for
terminals only. **Fix:** `--color=always`
when the paint is the point and the
destination understands escape codes;
accept plain output when it does not
(a log file full of `[ESC][1;34m` is
worse than plain — `t07` shows what you
would be embedding). If colour is gone
*at* a terminal, check `TERM` (a `dumb`
terminal gets none) and whether an alias
or `NO_COLOR`-style setting is in play.

## -F ate my folder

**Symptom:** `eza -F garden` —
`ls`-shaped muscle memory — fails with
`error: invalid value 'garden' for
'--classify [<WHEN>]'` (exit 2, `t90`).

**Cause:** in eza 0.23, `-F` is
`--classify` with an *optional* value,
and an optional value reaches for the
next word: your folder's name became
the value, and `garden` is not a valid
one. **Fix:** say what you mean —
`eza --classify=always garden`, or
`eza garden -F` if `auto` is enough.
The general lesson travels: any eza
flag whose help shows `[<WHEN>]` or
`[=<MODE>]` in brackets wants its value
attached with `=`, or left off entirely.

## The grid became one-per-line

**Symptom:** a piped or scripted listing
arrives as a single column where your
terminal shows a neat grid.

**Cause:** the grid needs a width; a
pipe provides none, and with no
`COLUMNS` in the environment eza falls
back to one per line (`t90`'s first
section). **Fix:** `--width=100`, or
export `COLUMNS`, when a consumer
really wants the grid — and consider
whether it should: one-per-line is the
grid's honest form for anything that is
not a screen.

## My theme is ignored

**Symptom:** a `theme.yml` written with
care, and the listing does not change.

**Causes, in the order to check:**
the file must be named exactly
`theme.yml` and live in the folder eza
reads — `~/.config/eza/`, or the folder
`EZA_CONFIG_DIR` names (the lab's `t09`
proves the mechanism with that variable,
which is also the quick test: point it
at your folder explicitly). YAML is
picky about indentation; the project's
example file (`docs/theme.yml` in the
repository) is the reference shape.
And the change must be *looked for*
with colour on — a theme evaluated
through a pipe with `--color=auto`
changes nothing visible, for chapter
14's reasons.
