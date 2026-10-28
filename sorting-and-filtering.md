# Sorting and Filtering

Outcome: given a question about a
folder — *what is big, what is new, what
is a log, what is even in here* — you can
shape the listing that answers exactly
it. All examples are the lab's folder;
the transcript is
`eza-lab/transcripts/t04-sorting.txt`,
with hiding from `t03`.

## Sorting: the question chooses the order

`--sort` takes the field to order by.
The four a reader will use weekly:

**By size** — the disk-full question:

```text
$ eza -l --sort=size garden
...
.rw-rw----@ 2.6M root 28 Oct 11:33 clip.mp4
.rw-rw----  1.5G root 28 Oct 11:33 full-backup.tar
```

Ascending, smallest first, so the answer
to "what is big" accumulates at the
bottom; add `--reverse` (`-r`) to put the
giants at the top where your eye lands
first. Folders sort by their `-` — they
have no size to sort by — and chapter
10's `--total-size` gives them one if the
question needs it.

**By modification time** — the what-just-
happened question: `--sort=modified`
(oldest first; `-r` for newest first).
The lab's run begins with the January
budget file and ends with the links made
minutes before the capture. Its aliases
`--sort=date` and `--sort=age` mean the
same field.

**By extension** — the sort-the-pile
question: `--sort=extension` groups
extensionless entries first (folders,
links, the pipe), then `.csv`, `.md`,
`.mp4`, `.sh`, `.tar`, `.txt` — every
kind together, so a folder of mixed
downloads reads as a set of small
same-kind lists.

**By name, strictly** — `--sort=name` is
the default natural order of chapter 4.
`--sort=Name` (capital N) is the strict
byte order, capitals first, for when you
must match another tool exactly.

Two more exist for narrower questions:
`--sort=type` (by file kind) and
`--sort=inode` (chapter 11's territory).
`--sort=none` prints the filesystem's own
order, unsorted — occasionally the
truth you want about a directory's raw
state, and a reminder that every other
order is an editorial decision.

## Filtering: leaving things out on purpose

**Hidden files.** `-a` / `--all` admits
names beginning with a dot: the practice
folder's `.hidden` appears (t03). Given
twice, `-aa`, eza adds the `.` and `..`
entries themselves — the folder and its
parent as listable things, a view that is
occasionally the only way to see their
permissions. `-A` (`--almost-all`) is
`ls`'s compromise: everything except `.`
and `..`.

**Only some kinds.** `-D` lists only
directories; `-f` only files (with
`--show-symlinks` if links should count);
`--no-symlinks` hides links from any
view — the listing to run when links are
noise, and a dangerous one when a link is
the story.

**By pattern.** `-I` / `--ignore-glob`
takes patterns to exclude, separated by
`|`: `eza -l -I '*.tmp|*.log' folder`
shows the folder without its scratch
files. Inside a git repository,
`--git-ignore` applies the repository's
own `.gitignore` rules instead —
chapter 8 uses it to make an ignored
file vanish, and the contrast is the
lesson: a file can be present, listed by
plain eza, and still honestly absent
from the project's own view of itself.

## Grouping folders

`--group-directories-first` moves folders
to the top of whatever order the sort
produced (its `--group-directories-last`
sibling exists for the opposite taste).
Combined with `-l` it gives the practice
folder the shape of t03: the folders —
and the link to one, sorted with them —
first, then everything else in name
order. It
is a presentation choice, not a sort —
the files below the folders are still in
the order `--sort` chose.

Check: on the practice folder,
`eza -l --sort=size --reverse | head -4`
should open with `full-backup.tar` at
1.5G and `clip.mp4` at 2.6M (t04, last
section) — the two files a "what is big
here?" was ever about, with no reading
of the other nineteen required.
