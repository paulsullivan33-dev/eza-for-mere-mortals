# The Long Listing

Outcome: you can read any line of
`eza -l` and say what every field means —
including the two symbols `ls` never
showed you. The lab's folder, both tools,
from `eza-lab/transcripts/t02-long-listing.txt`:

```text
$ eza -l garden
drwxrwx---     - root 28 Oct 11:33 bin
lrwxrwxrwx     - root 28 Oct 11:33 broken-link -> no-such-file
.rw-rw----@   38 root  5 Jan 09:00 budget.csv
.rw-rw----@ 2.6M root 28 Oct 11:33 clip.mp4
...
.rw-rw----@   29 root 20 Oct 12:00 notes.txt
...
.r--r--r--@   23 root 28 Oct 11:33 readonly.txt
.rwxr-xr-x@   26 root 28 Oct 11:33 run-backup.sh
```

## The fields, left to right

**Kind and permissions** — eleven
characters. The first is the file's kind,
and here eza's alphabet differs from
`ls`: a regular file is `.` (ls uses
`-`), a folder is `d`, a symlink is `l`,
a **named pipe** is `|`. The remaining
nine are the familiar permission triplets
— read, write, execute for owner, group
and others, a dash where a right is
absent. Compare the examples above:
`run-backup.sh` is `.rwxr-xr-x`, readable
and runnable by everyone; `private.txt`
is `.rw-------`, its owner alone; and
`readonly.txt` is `.r--r--r--`, a file
even its owner cannot write without
changing the permissions first. On a
colour terminal the letters are painted
by role — reads yellow, writes red,
executes green — so a too-open file
announces itself before you parse it.

**The `@`.** Some lines carry one more
character after the permissions:
`.rw-rw----@`. It means the file carries
**extended attributes** — extra named
facts attached to the file beyond its
contents. The lab did not plant any at
first: its build machine stamps every
file it writes with an attribute of its
own, which is why most of the practice
folder wears the mark. Chapter 11 sets
one deliberately and reads it back with
`--extended`. For now: `@` means "there
is more here than the contents", and
nothing more sinister.

**Size** — humanised by default: exact
bytes under a thousand (`38`, `29`),
then `2.6M`, `1.5G`. A folder's size is
`-`: the honest answer, since the number
`ls` prints there (the directory file's
own size) tells you nothing about the
contents. Chapter 10 covers the other
size modes, including how to get a
folder's true total.

**Owner** — one name, `root` throughout
the lab. Eza shows no group by default;
`-g` adds it, and `-n` swaps both names
for numbers. A listing meant for a report
often wants `--no-user` to drop the
column entirely (chapter 12).

**Date modified** — in a two-faced
format: files changed in the last six
months show day, month and *time*
(`28 Oct 11:33`); older files show day,
month and *year* (`5 Jan 09:00` is this
year's January; the 2019 file in chapter
10 reads `15 Jun  2019`). It is the same
compromise `ls` makes, and it makes
chapter 10's explicit styles worth
knowing when the distinction matters.

**Name** — last, with the symlink
targets appended after `->`, and names
containing spaces quoted so the columns
cannot be misread ( `--no-quotes` turns
the quoting off for names you trust).

## Adding the labels, and the missing columns

`--header` names the columns — worth it
while the format is new, and in any
listing you paste for someone else:

```text
$ eza -la --header --group-directories-first garden
Permissions Size User Date Modified Name
drwxrwx---     - root 28 Oct 11:33  bin
```

(from `eza-lab/transcripts/t03-hidden-and-header.txt`;
the same run shows the hidden file,
courtesy of `-a`, and puts folders first,
courtesy of `--group-directories-first`.)

Against `ls -l`, two columns are absent
until requested. The **hard-link count**
(ls's second column, the `2` beside the
lab's two notes files) is `-H` in eza,
and the **group** is `-g`; both appear in
chapter 11, where they matter. And there
is no `total` line: eza does not sum the
blocks, because its size column for
folders is `-` and a total over fiction
would be fiction too.

Check: pick the line for `notes.txt` in
`t02`. You should be able to say: a
regular file, readable and writable by
its owner and group only, carrying an
extended attribute, 29 bytes, owned by
root, last modified 20 October at noon —
and, from chapter 11's transcript, that
it has a twin.
