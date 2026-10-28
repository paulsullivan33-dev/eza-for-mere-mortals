# What Eza Is

Every session at a Linux terminal begins
the same way: you arrive somewhere you
cannot see, and you ask what is here.
The command that answers is `ls`, and it
has answered since the 1970s — a grid of
names, or with `-l` a table of facts
written in a shorthand of letters and
digits that newcomers have to memorise
before it tells them anything.

**Eza is a modern replacement for `ls`.**
It lists the same folders and reads the
same facts from the same filesystem —
nothing is stored, indexed or cached —
but it presents the answer for a reader
of today: folders in bold colour, a small
icon beside each name, dates a person can
scan, sizes in units a person can
compare, and, when you ask, a column
showing each file's standing in its
**git repository**. It is one program,
free and open source, maintained by the
eza community; it began as a continuation
of an earlier, much-loved tool called
`exa` (chapter 13 tells that story).

A useful way to think about any listing
tool: **a listing is a question and an
answer.** The plain grid answers *what is
here?* The long listing answers *what is
here, and what is each thing like?* Sort
orders change the question — *what is
here, biggest first? newest first?* —
and filters narrow it: *only folders*,
*not the backups*. Most of this guide is
learning to ask those questions on
purpose instead of taking the default
answer to a question you did not ask.

## What eza adds to ls

Four things, in the order you will meet
them:

- **Colour with a memory.** Like `ls`,
  eza colours by kind: folders one colour,
  executables another, links another,
  archives and media by their names. It
  also reads the `LS_COLORS` settings you
  may already have, and adds two levers of
  its own (chapter 9).
- **Icons.** A small picture per file
  kind or extension — a folder glyph for
  folders, a page for text, a camera-ish
  mark for images. Chapter 9 shows what
  those pictures physically are: single
  characters from a special font, with
  consequences the lab measured byte by
  byte.
- **A git column.** With `--git`, the
  long listing gains two letters per file
  — modified, staged, new, ignored —
  read from the repository itself.
  Chapter 8 checks those letters against
  `git status` until they agree.
- **A tree.** `--tree` draws the folder
  and everything under it as one diagram,
  the job people used to install a second
  tool for.

And one quiet improvement that sells many
people in the first minute: eza sorts
names the way people mean them. Given
`page1.txt`, `page2.txt` and `page10.txt`,
`ls` answers 1, 10, 2 — it compares
character by character, and `1` beats `2`
before the `0` is ever reached. Eza reads
the run of digits as a number and answers
1, 2, 10. The lab's first transcript
shows both, three lines apart:

```text
$ ls -1 garden | grep page    # how ls orders the page files
page1.txt
page10.txt
page2.txt

$ eza -1 garden | grep page   # eza reads the numbers in names
page1.txt
page2.txt
page10.txt
```

(from `eza-lab/transcripts/t01-first-look.txt`)

## The rule, stated before everything else

Eza never changes anything. It has no
delete, no rename, no chmod — you cannot
hurt a file with it, and every command in
this guide can be run twice with the same
result. That makes it one of the safest
tools you will ever install.

Looking, though, is still an action. A
listing reveals names, sizes, dates and
ownership — on your own machine that is
your business; on a shared machine, in
someone else's home folder, it is theirs.
So the guide's one rule:

> **List where you have a right to
> look — your own files, your own
> machines, or where the owner has given
> you permission.**

Everything in the lab obeys it without
trying: the folders listed are fixtures
the lab built for the purpose, on the
machine the lab ran on. Chapter 14
returns to the point, because a tool this
easy to point at things deserves the
reminder in writing.

## A first taste

After installing (chapter 3), in any
folder:

```bash
eza
eza -l
eza --tree --level=2
```

The first is the grid of names. The
second is the long listing — permissions,
size, owner, date, name. The third draws
two levels of the folder as a tree. On
the lab's practice folder the tree begins:

```text
garden
├── bin
├── broken-link -> no-such-file
├── budget.csv
├── clip.mp4
├── documents
│   ├── old-draft.txt
│   └── report.md
```

(from `eza-lab/transcripts/t05-tree.txt`)

Check: the names, colours aside, are your
folder's names — eza invents nothing. If
an entry surprises you, it was already
there; `ls -a` will agree with eza about
its existence even when the two tools
present it differently.

## Who it is for

Anyone who lives at a terminal and reads
folders all day: the developer asking
*what did that build just write?*, the
administrator asking *what is filling
this disk?*, the newcomer who finds
`-rw-r--r--` an unnecessary password to
knowledge that should be free. The common
thread is reading, quickly and correctly.

## What it is not

Eza is not a file manager: it does not
browse interactively, copy, move or open
anything. It is not a search tool: it
lists the folder you name (its tree and
recursion aside), while the finding of
files across a whole disk belongs to
`find` and friends — the Finding Files
guide in this series covers that ground.
It is not a backup, a synchroniser, or a
disk-usage analyser, though chapter 12
borrows its sizes for a first pass at
*what is eating this disk*. And it is
not `ls` with a new hat for scripting
purposes: chapter 13 explains why its
pretty output is a surface for eyes, and
why programs should keep reading the
plainer tools — or eza's own plainer
modes, chosen deliberately.
