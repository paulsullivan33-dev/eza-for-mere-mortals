# Git Status in the Listing

Outcome: standing in a **git repository**,
you can read each file's standing from
the listing itself — and you will know
exactly how far to trust it, because this
chapter checks eza's letters against
git's own report on a repository the lab
put into known states.

The lab's second fixture is a small
repository (`eza-lab/make-fixtures.sh`
builds it) containing one file in each
interesting state: committed and then
edited, edited and **staged**, newly
created and staged, never added at all,
and one file the repository's
`.gitignore` tells git to pretend is not
there. Git's own summary is the ground
truth (`eza-lab/transcripts/t06-git-status.txt`):

```text
$ git status --short     # the ground truth, from git itself
 M app.py
M  data.csv
A  feature.py
?? scratch.log
```

## The two letters

```text
$ eza -l --git .         # name the folder: with no path argument, eza 0.23.5 prints nothing here
.rw-rw----@ 62 root 28 Oct 11:33 -M app.py
.rw-rw----@  8 root 28 Oct 11:33 -I cache.tmp
.rw-rw----@ 12 root 28 Oct 11:33 M- data.csv
.rw-rw----@ 17 root 28 Oct 11:33 N- feature.py
.rw-rw----@ 15 root 28 Oct 11:33 -- README.md
.rw-rw----@ 14 root 28 Oct 11:33 -N scratch.log
```

The column sits between the date and the
name, and it is two characters wide
because git's truth is two questions:
*what does the index (the staging area)
say?* and *what does the working tree
say?* Eza's first letter answers for the
index, the second for the working tree.
The alphabet:

- `-` — nothing to report on that side.
- `M` — modified.
- `N` — new: in git's short report the
  staged-new file is `A` and the
  untracked one is `??`; eza calls both
  `N`, told apart by which letter slot
  they occupy.
- `I` — ignored: present on disk, named
  in `.gitignore`.
- `--` — tracked, staged nowhere, changed
  nowhere: the clean file's two dashes.

Read the lab's rows against git's and
they agree line for line: `app.py` is
untouched in the index and modified in
the tree (`-M` to git's ` M`), `data.csv`
is modified in the index and clean in
the tree (`M-` to git's `M `),
`feature.py` is staged-new (`N-` to
git's `A`), `scratch.log` is untracked
(`-N` to git's `??`). And `cache.tmp`,
which git status does not mention at
all, eza lists with `-I` — the listing
shows you the file *and* its exile in
one glance, which is this column's whole
argument.

A folder inside such a listing is given
a status of its own, derived from what
is under it — a folder containing a
modified file is itself marked `-M`,
"something below here". The lab's
fixture repository is flat, so that
behaviour is the manual's word rather
than a transcript's; treat it as
documented-only, and let the tree view
of chapter 7 with `--git` be the way you
walk down to the file responsible.

## When the lens should match git's exactly

`--git-ignore` filters the listing by
the repository's `.gitignore`, as
chapter 6 promised:

```text
$ eza -l --git --git-ignore .
...
```

`cache.tmp` is gone from the output —
this is the view of the folder that a
`git add .` shares. Keep both views in
your repertoire: the unfiltered one for
*what is on this disk*, the filtered one
for *what this project thinks it is*.

## Every repository in a folder

`--git-repos` answers a different
question. Run in a folder whose children
include repositories, it reports each
one's branch and dirtiness:

```text
$ eza -l --git-repos .
drwxrwx---     - root 28 Oct 11:33 - -      garden
.rwxrwx---@ 2.2k root 28 Oct 11:33 - -      make-fixtures.sh
drwxrwx---     - root 28 Oct 11:33 + master repo
drwxrwx---     - root 28 Oct 11:37 - -      theme-config
```

`-` for things that are not repositories,
the branch name and a `+` for one with
uncommitted changes (`repo`, on `master`,
dirty). For a home folder full of
checkouts this is the morning question —
*which of my projects did I leave
mid-thought?* — answered in one listing.
`--git-repos-no-status` prints the branch
only and runs much faster, since it never
opens the working trees.

## The two silences

This column has two quiet failure modes,
both verified by the lab and both worth
knowing before they cost you an hour
(chapter 15 tells the same stories as
troubleshooting):

- **Outside a repository**, `--git` does
  not error: the column simply is not
  there. A clean-looking listing of a
  folder you *believed* was a checkout
  may just be a folder.
- **With no path argument**, eza 0.23.5
  in a repository prints *nothing at
  all* — no listing, no error, exit code
  0. Name the folder (`eza -l --git .`)
  and the listing appears, column and
  all. The lab hit this within minutes
  of first using the flag; it is the
  kind of bug that gets fixed, so check
  your version's behaviour once and know
  which eza you have.

And the boundary of the whole feature:
eza reads the repository's *state*, it
does not run git for you — nothing here
stages, commits, or so much as fetches.
The state shown is the state on disk at
that moment; a file being edited in
another window owes you no warning.

Check: in a repository of your own, run
`git status --short` and `eza -l --git .`
and read them against each other. Every
line of one should be explainable from
the other — and now you know which of
the two to believe when they disagree
about an ignored file.
