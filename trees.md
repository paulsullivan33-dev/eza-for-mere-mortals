# Trees

Outcome: a whole folder structure on one
screen, at a depth you chose — the
listing that answers *how is this
organised?* From
`eza-lab/transcripts/t05-tree.txt`:

```text
$ eza --tree --level=2 garden
garden
├── bin
├── broken-link -> no-such-file
├── budget.csv
├── clip.mp4
├── documents
│   ├── old-draft.txt
│   └── report.md
├── empty-dir
...
├── photos
│   ├── 2023
│   └── 2024
├── private.txt
├── README.md
├── readonly.txt
└── run-backup.sh
```

The drawing is the one the `tree`
program taught a generation: `├──` for
an entry with siblings below it, `└──`
for the last in its folder, `│` carrying
a folder's line down past its children.
Folders that the level limit cuts off —
`photos`, here — appear with nothing
beneath them, not because they are empty
(`empty-dir` shows what a genuinely empty
folder looks like: the same) but because
you asked for two levels. That ambiguity
is the tree's one dishonesty, and
`--level` is its cure: choose the depth
the question needs.

Without a limit, `--tree` descends
everything:

```text
$ eza --tree garden/photos
garden/photos
├── 2023
│   └── barn.jpg
└── 2024
    ├── gate.jpg
    └── river.png
```

On a real project, "everything" can be
thousands of lines including dependency
and build folders; the working habits
are `--level=2` or `3` to start, and
`-I` (chapter 6) to prune the branches
you already know are weeds:
`eza --tree -I 'node_modules|target'`.

## Trees with facts, and trees through links

`--tree` combines with `-l`, and each
entry carries its long-listing facts —
the transcript's third run shows the
2019 draft wearing its real date inside
the tree (`15 Jun  2019`), the form to
use when the question is *how is this
organised, and how old is each part?*

By default the tree does not descend
into symlinked folders: `link-to-photos`
is listed as a link, full stop.
`--follow-symlinks` walks through them
(chapter 11's transcript):

```text
├── link-to-photos -> photos
│   ├── 2023
│   │   └── barn.jpg
│   └── 2024
```

Ask for that deliberately. A followed
tree can show the same folder twice
(here, both `photos` and the path through
its link), can be much larger than the
folder you named, and on a structure
with a link pointing back to an ancestor
it trusts eza's cycle handling rather
than your patience. The plain `-R`
recursion (listing after listing, headed
by folder paths) follows the same rules
and suits scripts better than eyes.

Check: `eza --tree --level=2` on a
project you work in. You should be able
to point at the folders you expected, at
their expected depth — and anything
drawn at the bottom of a `├──` run that
you did *not* expect is a finding, not a
rendering error.
