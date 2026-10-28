# Colours, Icons and Themes

Outcome: you can say where every colour
in a listing came from, what an icon
physically is, and how to restyle the
whole output with one file. This is the
chapter where the guide stops describing
appearances and shows bytes, because
appearances are exactly what cannot be
trusted here: this page cannot show you
the lab's colours, so the lab captured
the instructions that *produce* colours —
the escape codes — and printed those.

## Where colour comes from

A coloured name in a terminal is the
name wrapped in **ANSI escape codes**:
`[ESC][1;34m` before it (start bold blue)
and `[ESC][0m` after (reset). The lab
made them visible by rewriting the ESC
character as the text `[ESC]`
(`eza-lab/transcripts/t07-colours.txt`):

```text
$ eza --color=always -1 garden | sed "s/ESC/[ESC]/g" | grep -E "documents|budget"
budget.csv
[ESC][1;34mdocuments[ESC][0m
```

`documents`, a folder, wears the default
bold blue. `budget.csv` wears nothing in
particular — plain files are the
terminal's own colour. Two override
levers, both proven in the same
transcript:

**`LS_COLORS`** — the venerable variable
from the `ls` world. Eza honours it,
including its per-extension rules:

```text
$ LS_COLORS="*.csv=35" eza --color=always -1 garden | sed "s/ESC/[ESC]/g" | grep budget
[ESC][35mbudget.csv[ESC][0m
```

Code 35 is magenta: every `.csv` in the
listing now stands out, using a setting
a long-time `ls` user may already own.

**`EZA_COLORS`** — eza's own variable,
keyed by two-letter codes for the parts
of a listing (`di` directories, `ln`
links, `ex` executables, and many more,
listed in eza's manual page):

```text
$ EZA_COLORS="di=33" eza --color=always -1 garden | sed "s/ESC/[ESC]/g" | grep documents
[ESC][33mdocuments[ESC][0m
```

Code 33 is yellow, and directories alone
changed. Between the two variables, when
both speak, `EZA_COLORS` wins for the
parts it names.

**When colour happens at all** is
`--color`: `auto` (the default) paints
only when the output is a terminal;
`always` paints even into a pipe — which
is how the lab captured these codes, and
how you produce a listing file with the
paint left in, deliberately; `never`
keeps everything plain even on a
terminal.

One more instrument belongs here:
`--color-scale` shades values instead of
painting them flat — sizes or ages on a
gradient (or fixed steps with
`--color-scale-mode`), so in a long
listing the biggest files are literally
the reddest. It decorates judgement, not
identity, and the lab left it off in its
transcripts so the facts could be read
undisturbed.

## What an icon is, byte by byte

With `--icons=always`, each name gains a
leading picture. The lab listed the
practice folder with colour off, then
fed the output through a small Python
inspection that prints the first
character of each line with its Unicode
codepoint (`eza-lab/transcripts/t08-icons.txt`):

```text
  U+F115  (no Unicode name: private use area)  -> bin
  U+F086F  (no Unicode name: private use area)  -> broken-link -> no-such-file
  U+EEFC  (no Unicode name: private use area)  -> budget.csv
  U+F03D  (no Unicode name: private use area)  -> clip.mp4
  U+E5FF  (no Unicode name: private use area)  -> documents
  U+F410  (no Unicode name: private use area)  -> full-backup.tar
  U+F15C  (no Unicode name: private use area)  -> notes.txt
  U+F00BA  (no Unicode name: private use area)  -> README.md
  U+F489  (no Unicode name: private use area)  -> run-backup.sh
```

Every icon in the folder — twenty
entries listed, nine distinct glyphs
among them — is a
single character in Unicode's **private
use area**, the range set aside for
fonts to define among themselves. The
characters have no standard meaning; the
meanings live in one family of fonts,
the **Nerd Fonts**, which draw a folder,
a page, a film frame at those
codepoints. Three consequences, none of
them eza's fault and all of them worth
stating plainly:

- **With a Nerd Font installed** (and
  the terminal told to use it), you see
  the little pictures this feature is
  famous for.
- **Without one** — the lab's terminal,
  and most servers, most SSH sessions,
  most of the world's terminals — you
  see whatever your font keeps at those
  codepoints: usually an empty box, a
  blank space, or nothing. The listing
  is not broken; the pictures were
  addressed to a font that is not
  present.
- **The choice of picture is sensible**
  even when invisible: folders share a
  glyph (empty folders get an open
  folder, U+F115, non-empty ones
  U+E5FF), text files a page, archives a
  box, video a frame, links and the pipe
  the link glyph (U+F086F), `README.md`
  an information mark of its own.

`--icons` takes the same
`always`/`auto`/`never` as colour, and
in `auto` the icons, like the colour,
appear only for a terminal. Whether to
adopt them is a per-terminal decision,
not a per-user one: gorgeous at your own
desk, boxes on the server you SSH into —
unless the server session uses your
local terminal's font, which SSH does,
so the font that matters is always the
one on the machine *in front of you*.

## Themes: restyling everything at once

Where the variables adjust a colour or
two, a **theme** replaces the rulebook.
Eza reads `theme.yml` from its
configuration folder — `~/.config/eza/`
by default, or the folder named by the
`EZA_CONFIG_DIR` variable. The lab wrote
a two-rule theme
(`eza-lab/transcripts/t09-theme.txt`):

```yaml
filekinds:
  directory:
    foreground: "#ff00ff"
    is_bold: true
  symlink:
    foreground: "#ffa500"
```

and listed the folder before and after
pointing `EZA_CONFIG_DIR` at it. Before,
the defaults: directories `[1;34m`,
links `[36m`. After:

```text
[ESC][1;38;2;255;0;255mdocuments[ESC][0m
[ESC][38;2;255;165;0mlink-to-notes[ESC][0m [ESC][1;90m->[ESC][0m notes.txt
```

The theme's hex colours arrive as
**truecolor** codes — `38;2;255;0;255`
is red 255, green 0, blue 255, a magenta
no 8-colour palette could name — and
directories picked up the requested
bold. A theme file can go much further:
permission letters, sizes, the git
column, per-extension colours, and
replacement icon glyphs all have
sections in the format, which the
project's own example file documents.
Two cautions the lab's run makes
concrete: a theme is *yours* — none of
it travels with a listing you save or
send — and a theme nobody else has makes
your screenshots a dialect only you can
read.

## Names that are links

One last display trick: `--hyperlink`
wraps each name in the terminal's
**OSC 8** hyperlink sequence, making
files clickable in terminals that
support it. Forced on and made visible
(`eza-lab/transcripts/t13-hyperlinks.txt`),
each name arrives wrapped like this:

```text
^[]8;;file:///…/garden/bin^[\bin^[]8;;^[\
```

— an opening sequence carrying a
`file://` address built from the file's
absolute path, the name, and a closing
sequence. In a supporting terminal
(iTerm2, kitty, WezTerm and others) the
name *is* the link a file manager would
give you. Elsewhere the sequences are
invisible and harmless. The lab captured
the bytes; whether your terminal turns
them into clicks is, like the icons, a
question about the terminal, not about
eza.

Check: run `eza --color=always -1` in a
folder and make the codes visible with
the transcript's `sed` line. You should
be able to name the code on a folder,
then change exactly that code — and
nothing else — with one `EZA_COLORS`
setting.
