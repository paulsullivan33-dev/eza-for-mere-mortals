# Dates and Sizes

Outcome: you can make a listing state a
date or a size in the exact terms your
question needs — a log-friendly
timestamp, an honest byte count, a
folder's true weight — instead of the
defaults' polite approximations. Every
number below is the lab's; transcripts
are `eza-lab/transcripts/t10-times.txt`
and `t11-sizes.txt`.

## Five ways to write a date

The long listing's date column answers
to `--time-style`. The lab ran all five
styles over the same two files — a draft
last touched in 2019 and a report from
that morning:

```text
$ eza -l --time-style=default garden/documents
.rw-rw----@ 37 root 15 Jun  2019 old-draft.txt
.rw-rw----@ 17 root 28 Oct 11:33 report.md

$ eza -l --time-style=iso garden/documents
.rw-rw----@ 37 root 2019-06-15  old-draft.txt
.rw-rw----@ 17 root 10-28 11:33 report.md

$ eza -l --time-style=long-iso garden/documents
.rw-rw----@ 37 root 2019-06-15 10:30 old-draft.txt
.rw-rw----@ 17 root 2026-10-28 11:33 report.md

$ eza -l --time-style=full-iso garden/documents
.rw-rw----@ 37 root 2019-06-15 10:30:00.000000000 +0000 old-draft.txt
.rw-rw----@ 17 root 2026-10-28 11:33:30.146058484 +0000 report.md

$ eza -l --time-style=relative garden/documents
.rw-rw----@ 37 root 7 years   old-draft.txt
.rw-rw----@ 17 root 4 minutes report.md
```

Read them as answers to different
questions. **default** is the scanning
format — compact, and two-faced about
the year, as chapter 5 warned.
**long-iso** is the one to reach for:
every date complete and sortable, the
same width for a file from 2019 and one
from today. **full-iso** adds nanoseconds
and the timezone offset — forensic,
delightfully excessive, and the only
style that says out loud which timezone
the bare times were in (the lab's
machine keeps UTC, `+0000`; yours may
not). **iso** is the trap of the set: it
quietly mixes the two habits, full date
for old files, month-day and time for
recent ones. **relative** ("7 years",
"4 minutes") reads beautifully and sorts
meaninglessly — use it for a human
glance, never for a record. A sixth
possibility, `--time-style="+%Y-%m-%d"`,
hands the format to `strftime`-style
codes, for houses with a house format.

## A file has four clocks

The date shown is the **modification**
time by default. Files carry three more
timestamps, and `-t`/`--time` chooses
which one the column shows, or the
shortcuts add columns of their own:
`-u` for **accessed** (last read),
`--changed` for the metadata **change**
time (permissions, ownership, contents —
the clock `touch` cannot fake backwards,
which makes it the honest one in an
argument), and `-U` for **created** (the
birth time, where the filesystem keeps
one). Combined, they print side by side:

```text
$ eza -l -m -u --changed garden/documents | head -3
.rw-rw----@ 37 root 15 Jun  2019 28 Oct 11:33 15 Jun  2019 old-draft.txt
```

— modified, accessed, changed, in that
order, for a file that was written in
2019 and not touched since. Sorting
follows the same fields: `--sort=accessed`
and friends exist for the day the
question is *what has been read lately*
rather than *what has changed*.

## Sizes: units, bytes, and the truth about folders

The default size column rounds for
reading — `2.6M` — which is right for
eyes and wrong for arithmetic. The
alternatives, from `t11`:

```text
$ eza -l --bytes garden | head -6
...
.rw-rw----@    2600000 root 28 Oct 11:33 clip.mp4

$ eza -l --binary garden | grep -E "clip|full-backup"
.rw-rw----@ 2.5Mi root 28 Oct 11:33 clip.mp4
.rw-rw----  1.4Gi root 28 Oct 11:33 full-backup.tar
```

`--bytes` is the exact count, no unit, no
rounding. `--binary` keeps the tidy
form but counts in powers of 1024 and
says so (`Mi`, `Gi`) where the default
counts in powers of 1000 (`M`, `G`) —
the same file is `2.6M` and `2.5Mi`, and
both are telling the truth in different
currencies. Know which one a colleague's
number is in before you compare them.

Folders need `--total-size` before their
size means anything:

```text
$ eza -l --total-size garden | grep -E "photos|documents|empty"
drwxrwx---    54 root 28 Oct 11:33 documents
drwxrwx---     0 root 28 Oct 11:33 empty-dir
drwxrwx---  3.2k root 28 Oct 11:33 photos
```

`documents` weighs 54 bytes of contents,
`photos` 3.2k, `empty-dir` an honest 0.
The price is a walk of everything under
each folder — on a home directory with a
media library inside, that walk is the
command's whole runtime, and chapter 12
treats `--total-size` with the respect a
recursive measurement deserves.

## Apparent size, allocated size

One more pair, and it is the pair that
settles arguments about disks. `-S`
(`--blocksize`) adds the size of the
blocks actually allocated:

```text
$ eza -l -S garden | grep -E "clip|full-backup|notes.txt"
.rw-rw----@ 2.6M 2.6M root 28 Oct 11:33 clip.mp4
.rw-rw----  1.5G    0 root 28 Oct 11:33 full-backup.tar
.rw-rw----@   29 4.1k root 20 Oct 12:00 notes.txt
```

The lab's backup is a **sparse file**:
1.5G long on paper, zero blocks on disk
— it claims almost nothing, and any
"the disk is full of backups" theory
dies on this line. The 29-byte note, in
the other direction, occupies a full
4.1k block, as every small file does.
Length and footprint are different
facts; eza will show you either, and
now you know which one a "disk full"
question is about.

Check: `eza -l --time-style=long-iso
--bytes` on a folder you know. Every
date should be complete, every size an
integer — a listing with no polite
approximations left in it.
