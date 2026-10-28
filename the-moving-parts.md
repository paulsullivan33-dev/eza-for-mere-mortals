# The Moving Parts

Eza is a single small program — the
release the lab ran is under three
megabytes — but its output is assembled
from several independent parts, and most
confusion about eza is really confusion
about which part produced what. This
chapter names the parts so later chapters
can point at them.

## The lister

The core reads a folder (or several, or
one file named directly) using the same
system calls `ls` uses. There is no
database and no background service: every
run asks the filesystem fresh, which is
why eza's answer is never stale — and why
listing a huge or network-mounted folder
costs what it costs on any tool. For each
entry the lister gathers the standard
facts: name, kind, size, permissions,
owner, group, timestamps, link count,
inode. Everything else in this chapter
decorates or rearranges those facts.

## The three views

The same facts can be presented three
ways, and the choice is the first thing
to learn:

- **The grid** (default): names fitted
  into columns, read downwards. Made for
  the question *what is here?* at a
  glance. Chapter 4 lives here.
- **The long view** (`-l`): one entry per
  line, the facts as columns. Made for
  *what is each thing like?* Chapters 5,
  8, 10 and 11 all work in this view,
  because its columns are where the facts
  live.
- **The tree** (`--tree`): the folder and
  its descendants drawn with connecting
  lines, depth limited by `--level`.
  Chapter 7.

Two cousins complete the family: `-1`
(one entry per line, names only) for
pipelines and slow connections, and `-R`
(recurse: listing after listing, headed
by path, the way `ls -R` does it).

## The colour engine

Colour is a layer of paint over the
names, applied by rules: this *kind* of
file gets this colour; this *extension*
gets that one; this *permission letter*
in the long view gets another. The rules
come from several places, in an order
that matters (chapter 9 walks it):

1. Eza's built-in defaults.
2. The traditional `LS_COLORS` variable,
   if your shell sets one — eza honours
   the settings an `ls` user already has.
3. Eza's own `EZA_COLORS` variable, for
   quick overrides.
4. A **theme file**, `theme.yml`, in
   eza's configuration folder, which can
   restyle everything at once, icons
   included.

The engine also decides *when* to paint:
`--color=auto`, the default, paints only
when the output is a terminal. Down a
pipe the paint is not applied at all —
chapter 14 is blunt about what that means
for listings saved to files.

## The icon set

Beside each name the grid and long views
can print one icon character, chosen from
a built-in table by kind and extension.
The characters live in the **private use
area** of Unicode — codepoints set aside
for fonts to define privately — and the
font that defines them is called a
**Nerd Font**. Eza prints the characters
whether or not your terminal has that
font; what you *see* depends entirely on
the font. Chapter 9 prints the actual
codepoints the lab captured, so you can
see precisely what is sent and judge what
your terminal will make of it.

## The git reader

With `--git`, eza asks the repository —
the same `.git` folder git itself keeps —
how each listed file stands: tracked and
clean, modified in the working tree,
modified in the **index** (the staging
area, chapter 8 explains), newly added,
untracked, or ignored. It renders the
answer as two letters beside the name.
With `--git-repos`, listing a folder of
folders, it reports each subfolder that
is a repository: its branch and whether
it has uncommitted work. The reader never
writes to the repository; like everything
else in eza, it only looks.

## The sorter and the filter

Before anything is printed, the entries
are filtered (hidden files in or out,
patterns excluded, only folders, only
files) and sorted — by name with numbers
read as numbers, or by size, date,
extension, kind, inode. Filtering and
sorting are chapter 6. One habit worth
forming early: the sort is part of the
question. `eza -l` and `eza -l
--sort=size` list the same folder, but
they answer different people.

## Where the facts come from — and stop

Two columns deserve a warning here,
because readers trust them too far.
**Sizes of folders** are, by default, the
size of the folder's own directory entry
— a few bytes of bookkeeping — not the
sum of what is inside; `--total-size`
(chapter 10) computes the sum, at the
cost of walking everything. And
**timestamps** are whatever the
filesystem recorded: chapter 10 shows the
four clocks a file carries and the five
ways eza can write one down.
