# Glossary

**ANSI escape codes** — the byte
sequences a program emits to ask a
terminal for colour and emphasis:
`[ESC][1;34m` and friends. Colour in a
listing is these codes wrapped around
names (chapter 9).

**Birth time** — see *created*.

**Block** — the filesystem's unit of
storage, commonly 4 KiB. A file's length
and the blocks it occupies are different
facts (chapter 10).

**Broken link** — a symlink whose target
does not exist. Eza shows the target
anyway and paints the link red
(chapter 11).

**Created time** — when a file was
brought into existence, where the
filesystem records it; eza's `-U`. Not
portable across filesystems, and copying
a file makes a new one.

**Extended attributes** — named extra
facts attached to a file beside its
contents; their presence is the `@` in a
long listing, and `--extended` reads
them (chapter 11).

**Grid** — eza's default view: names in
columns, read downwards (chapter 4).

**Hard link** — a second name for the
same file body. Two names, one inode,
one link count of 2 (chapter 11).

**Hidden file** — a name beginning with
a dot, omitted from listings unless
`--all` asks for it.

**Hyperlink (OSC 8)** — a terminal
escape sequence that makes text
clickable, carrying a `file://` address;
eza's `--hyperlink` (chapter 9).

**Index** — git's staging area: the
proposed next commit. The first of the
git column's two letters reports on it
(chapter 8).

**Inode** — a file's identity number
within its filesystem, printed by `-i`.
Same inode, same file, however many
names it has.

**Long view** — the `-l` listing: one
entry per line, facts as columns
(chapter 5).

**LS_COLORS / EZA_COLORS** — the
environment variables that carry colour
rules: the traditional one from `ls`,
honoured by eza, and eza's own, which
wins where they overlap (chapter 9).

**Named pipe** — a file that is a
channel between programs rather than
stored data; kind letter `|` in eza's
long view.

**Natural sort** — ordering that reads
runs of digits as numbers, so `page2`
precedes `page10` (chapter 4).

**Nerd Font** — a family of fonts that
draw pictures at the private-use-area
codepoints eza's icons use (chapter 9).

**Private use area** — the ranges of
Unicode reserved for fonts and systems
to define privately. Eza's icons live
there, which is why they need a
particular font to be seen.

**Sparse file** — a file whose empty
stretches are not stored: long on paper,
small in allocated blocks (chapter 10).

**Symlink** — a file whose contents are
a path to another file; the arrow in
every eza view. See also *broken link*.

**Theme** — eza's `theme.yml`: one file
of rules restyling colours, permission
letters, the git column and icon glyphs
(chapter 9).

**Tree** — the `--tree` view: a folder
and its descendants drawn as one
diagram (chapter 7).

**Untracked / ignored** — git's two
kinds of not-committed: a file git has
never been told about (eza's `-N`), and
one a `.gitignore` rule tells it to
disregard (eza's `-I`).
