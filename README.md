# Eza for Mere Mortals

The first command most people learn on a
Linux machine is `ls` — *show me what is
here*. It works, and it has worked for
fifty years, but what it shows is plain:
names in a column, and in its long form a
row of facts you have to decode letter by
letter. **Eza** is a modern replacement
for `ls` that keeps the shape — list a
folder, read the result — and improves
the reading. Folders stand out in colour.
Files carry small icons. A long listing
says, in a column of its own, how each
file stands with **git**. A tree view
draws the folder's structure instead of
making you hop through it one level at a
time. And where `ls` sorts `page10`
before `page2` because it reads names one
letter at a time, eza reads the numbers
inside names and puts page 2 where you
expected it.

This guide explains how eza's listings
are put together, how to read every
column of the long listing, how to sort
and filter until a crowded folder answers
the question you actually asked — *what
is big, what is new, what changed* — and
how the colour, icon and theme machinery
works, down to the bytes. The limits are
stated plainly, including the honest
ones: the icons are characters from a
special font most machines do not have,
the colour is decoration that disappears
the moment a listing is piped into a
file, and in this version the git column
silently prints nothing until you name
the folder you want listed.

Eza only ever looks. It creates nothing,
changes nothing, deletes nothing — every
command in this guide is safe to run
twice. But looking is not nothing: a
listing shows the names and facts of
files, and on a shared machine those
names may be somebody else's business.
The rule for this guide is the simple
one, stated in chapter 1: **list where
you have a right to look — your own
machines, or where you have permission.**

The lab behind this guide ran the real
thing: **eza 0.23.5**, the official
release binary from the project's GitHub
releases, its checksum matched against
the digest the release page publishes.
Against two fixtures the lab built for
the purpose — a folder of files with
controlled types, ages, sizes,
permissions and links, and a small git
repository put into known states of
modified, staged, untracked and ignored —
the lab captured plain and long listings,
every sort order that matters, tree
views, the git column checked line by
line against `git status` itself, colour
codes made visible, the icon characters
identified codepoint by codepoint, a
theme file applied and proven by the
changed output, five ways of writing a
date, three ways of writing a size, and
the behaviour of a listing pushed through
a pipe — including the three seconds eza
spent waiting for a pipe to close before
it would print anything, measured with a
timer because the lab did not believe it
either.

What the lab could not do, it did not
fake. Its terminal has no **Nerd Font**,
so what icons look like on a properly
equipped terminal is described from the
codepoints the lab captured, not shown as
a screenshot that never happened. The
runs are all on Linux; where macOS or
Windows differ, the text says it is
speaking from the documentation.
`criteria.md` keeps the full ledger of
what was run and what was only read.

## What this guide covers

- [**What eza is**](what-eza-is.md) —
  the mental model: a listing is a
  question and an answer, what eza adds
  to fifty years of `ls`, and the one
  rule about looking
- [**The moving parts**](the-moving-parts.md) —
  the three views (grid, long, tree),
  the colour engine, the git reader, and
  the places configuration can come from
- [**Installing eza**](installing-eza.md) —
  the package managers, the release
  binary, and checking what you got
- [**Your first listing**](your-first-listing.md) —
  a practice folder, the plain listing,
  and the order of names — including
  page 2 coming before page 10
- [**The long listing**](the-long-listing.md) —
  every column taken apart: the
  permission letters, sizes, owners,
  dates, and the symbols eza adds of its
  own
- [**Sorting and filtering**](sorting-and-filtering.md) —
  biggest first, newest first, by
  extension, hidden files, and leaving
  things out on purpose
- [**Trees**](trees.md) — a folder drawn
  as a tree, depth limits, and trees
  that follow links
- [**Git status in the listing**](git-status.md) —
  the two-letter column, checked against
  git itself; ignored files; a view of
  every repo in a folder at once
- [**Colours, icons and themes**](colours-icons-and-themes.md) —
  where the colour comes from, what the
  icons really are byte by byte, and a
  theme file that restyles the listing
- [**Dates and sizes**](dates-and-sizes.md) —
  five ways to write a date, the other
  timestamps, and sizes in units, in
  bytes, and as disk actually used
- [**Links and attributes**](links-and-attributes.md) —
  following symlinks on paper and in
  person, hard links and inodes, and the
  `@` that means a file carries more
  than its contents
- [**Recipes**](recipes.md) — what is
  eating this disk, what changed this
  week, a folder explained to someone
  else, and listings a script can trust
- [**The neighbours**](the-neighbours.md) —
  GNU `ls` itself, the original `exa`,
  `lsd`, and the humble `tree` and
  `find`: what each still does better
- [**Limits**](limits.md) — icons that
  need a font you may not have, colour
  that vanishes in a pipe, a git column
  with a silent mood, and a tool that
  cannot change anything at all
- [**Troubleshooting**](troubleshooting.md) —
  the listing that never arrives, the
  empty git column, boxes where icons
  should be, and the `-F` that ate your
  folder's name
- [**Glossary**](glossary.md) — the
  terms, collected in one place

## What it doesn't cover

Scripting against eza's output as if it
were a stable data format — chapter 13
explains why the pretty listing is for
eyes, and what to use when a program is
the reader. Changing files: eza cannot
rename, move, delete or chmod anything,
and this guide does not pretend
otherwise; the Linux guide in this
series covers the tools that do. Shell
aliases and prompt frameworks get a
recipe, not a chapter. And the colour
and icon themes of other tools are their
own guides' business.

## How to use this guide

Read chapter 1 for the model and the
rule, and chapter 2 before installing
anything — knowing which part produces
which column turns later surprises into
named behaviour. Chapter 4 is your first
listing in the same sitting as the
install, against a practice folder you
can rebuild with the lab's own script;
make the outputs boring before you point
eza at a folder that matters. Chapter 9
is the one to read slowly: once you know
that colour is a claim the terminal may
not honour and icons are characters from
a font, most eza mysteries explain
themselves. The lab's transcripts live
in `eza-lab/transcripts/`; its fixture
builder is `eza-lab/make-fixtures.sh`;
its notes are `examples/lab-notes.txt`.

---

## Part of the series

This guide is one of the [For Mere Mortals](https://paulsullivan33-dev.github.io/mere-mortals/) guides: plain-language guides to the tools programmers and makers use.

Related guides:

- [Linux for Mere Mortals](https://paulsullivan33-dev.github.io/linux-for-mere-mortals/)
- [Finding Files for Mere Mortals](https://paulsullivan33-dev.github.io/finding-files-for-mere-mortals/)
- [Git for Mere Mortals](https://paulsullivan33-dev.github.io/git-for-mere-mortals/)

## License

The writing in this guide is licensed under [CC BY 4.0](https://github.com/paulsullivan33-dev/eza-for-mere-mortals/blob/main/LICENSE). Code examples and lab scripts are licensed under the [MIT License](https://github.com/paulsullivan33-dev/eza-for-mere-mortals/blob/main/LICENSE-CODE).
