# Your First Listing

Outcome: a plain eza listing of a folder
you understand, read with confidence —
including why the names sit in the order
they do. The lab's practice folder is
used throughout the guide; rebuild it
yourself with `eza-lab/make-fixtures.sh`
and every transcript can be reproduced
on your machine. Its folder, `garden`,
holds twenty-one entries chosen to be
interesting: folders, an executable, a
video, a huge sparse backup, three
symlinks (one of them broken), a named
pipe, three nearly identical page files,
and a hidden file you will not see yet.

## The plain listing

```text
$ eza garden           # the same folder with eza, no options
bin          clip.mp4   full-backup.tar  named-pipe      page1.txt   photos       readonly.txt
broken-link  documents  link-to-notes    notes-copy.txt  page2.txt   private.txt  run-backup.sh
budget.csv   empty-dir  link-to-photos   notes.txt       page10.txt  README.md
```

(from `eza-lab/transcripts/t01-first-look.txt`)

On your terminal, colour separates what
this page cannot: folders bold blue,
links cyan, the broken link red, the
video and the archive in media colours,
the executable green, and the named pipe
yellow. The arrangement is a **grid**:
names fitted into as many columns as the
terminal's width allows, read *downwards*
— `bin`, `broken-link`, `budget.csv` is
the first column, not the first row.
`--across` swaps the reading order to
along the rows, the way `ls` fills its
grid (chapter 6's neighbour in
`eza-lab/transcripts/t14-layout.txt`).

Beside it in the transcript sits plain
`ls` on the same folder: one skinny
column because its output was being
written to a file, not a terminal — a
first lesson in how much of what a
listing looks like is decided by *where
the output is going*, a theme chapter 14
returns to. On two facing terminals the
plain listings of `ls` and eza differ
mostly in colour and the order below.

## The order of names

Eza's default order is alphabetical with
one humane correction, already met in
chapter 1: digit runs are numbers.

```text
$ eza -1 garden | grep page   # eza reads the numbers in names
page1.txt
page2.txt
page10.txt
```

The same rule rescues photograph names,
version numbers, and dated logs from the
scrambled order `ls` gives them. Three
sorting keys change it deliberately —
`--sort=Name` (chapter 6) restores a
stricter case-sensitive order, capitals
before lowercase, which is why the lab's
grid shows `README.md` last among the
names rather than first: default sorting
ignores case, so `README` files under
*r*, between `private.txt` and
`readonly.txt`, not above `bin` as ASCII
would put it.

## One per line, and the width of things

`-1` (that is a digit one) prints one
name per line:

```text
$ eza -1 garden
bin
broken-link -> no-such-file
...
```

Note that even in this plainest view a
symlink is shown with its target —
`broken-link -> no-such-file` — and the
target's absence is the whole story of
that entry: a **broken link**, a pointer
to a file that is not there. Eza shows
the arrow in every view. GNU `ls` shows
it only in the long view.

The grid's width comes from the terminal.
`--width=40` (or a narrow window) refits
the same names into fewer columns;
chapter 6's `t14` transcript shows the
practice folder at width 40, two columns
where seven stood. Eza is never offended
by a narrow terminal — it just has less
to say per row.

## What you are not seeing

Two absences to register now, because
both are questions readers ask within the
hour. **The hidden file** (`.hidden`)
is not in the listing: names beginning
with a dot are left out unless asked
for, exactly as with `ls` — chapter 6
asks, with `--all`. And **the insides**:
nothing in this view says what `photos`
contains. Eza lists the folder you name,
one level deep; chapters 7 (`--tree`)
and 6 (`-R`) are the ways to see deeper
without changing directory.

Check: run `eza` in a folder you know
well. Every name should be one you
recognise, in an order you can now
explain — and if your folder has numbered
names, page 2 should precede page 10.
