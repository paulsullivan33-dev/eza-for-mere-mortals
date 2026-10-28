# Links and Attributes

Outcome: links stop being a mystery in
your listings — you can tell a link from
its target, see when two names are one
file, and read the extra facts a file
can carry. The evidence is
`eza-lab/transcripts/t12-links-and-extended.txt`.

## Symlinks: the arrow is the default

A **symbolic link** is a small file whose
contents are a path; open it and the
system quietly substitutes the target.
Eza shows the substitution in every view:
`link-to-notes -> notes.txt`. It also
shows when the arrow points at nothing —
`broken-link -> no-such-file`, painted
red on a colour terminal. A broken link
is not an error in the folder; it is a
fact about it, often the first symptom
of a half-finished tidy-up, and eza is
unusually good at putting it in front of
you. `--no-symlinks` (chapter 6) hides
links when they are noise; `-d` on a
link lists the link itself.

By default eza reports the **link's**
facts. `-X` (`--dereference`) reports
the **target's**:

```text
$ eza -lX garden/link-to-notes    # -X shows the target's facts, not the link's
lrw-rw----@ 29 root 20 Oct 12:00 garden/link-to-notes
```

The name still says link (the leading
`l`), but the permissions, the 29 bytes
and the October date are `notes.txt`'s.
The distinction matters whenever a link
is young and its target is old, or the
reverse — a backup script's freshness,
judged by the link, would lie to you.
Trees follow links only when told
(`--follow-symlinks`, chapter 7), for
the same reason: following is a
decision, not a default.

## Hard links: two names, one file

A **hard link** is not a pointer but a
second name for the same file body. The
practice folder has one pair, made with
`ln notes.txt notes-copy.txt`, and three
columns conspire to expose it:

```text
$ eza -liH garden | grep -E "notes"    # inode and hard-link counts
1325587 lrwxrwxrwx  1    - root 28 Oct 11:33 link-to-notes -> notes.txt
1325572 .rw-rw----@ 2   29 root 20 Oct 12:00 notes-copy.txt
1325572 .rw-rw----@ 2   29 root 20 Oct 12:00 notes.txt
```

`-i` prints the **inode** — the file's
identity number in its filesystem — and
the pair shares `1325572`, because they
are one file. `-H` prints the link
count: `2`, the number of names this
body has. (Read the columns in the
order eza prints them; the symlink's
1325587 is a different inode entirely,
its own small file.) The working
consequences follow from the identity:
edit either name and both change;
delete either name and the file
survives under the other; the file is
gone only when the count reaches zero.
A listing that shows inodes is also the
quickest way to prove that a "copy" a
tool made is not a copy at all.

## The @: extended attributes

Chapter 5 met the `@` after the
permissions — the mark of **extended
attributes**, named facts (`user.` ones
are yours to set) attached to a file
beside its contents: where a download
came from, a checksum, a label of your
own. The lab set one deliberately and
read the whole set back with `-@`
(`--extended`):

```text
$ eza -l --extended garden/notes.txt garden/README.md
.rw-rw----@ 29 root 20 Oct 12:00 garden/notes.txt
                                 ├── user.hatch_tainted: "1"
                                 └── user.lab_note: "checked by the lab"
.rw-rw----@ 14 root  1 Oct 17:45 garden/README.md
                                 └── user.hatch_tainted: "1"
```

Two attributes on the notes file: the
lab's own `user.lab_note`, set for this
chapter, and `user.hatch_tainted`, which
the build machine stamps on files of its
own accord — the same stamp that put an
`@` on nearly every file in this guide's
transcripts, visible in full here
because `--extended` hides nothing.
Your machine's stamps will differ (a
Mac's downloads carry their origin; some
backup tools annotate as they go), and
that is the reading skill: `@` is not a
warning, it is an invitation to ask
`--extended` what is attached. Note also
what attributes are *not*: they are not
portable promises — copy a file carelessly
(some tools, some filesystems) and the
attributes stay behind, which is why
nothing important should live *only* in
one.

Check: in the practice folder,
`eza -liH garden` should show the two
notes files sharing an inode and a link
count of 2, and `eza -l --extended
garden/notes.txt` should list the lab
note by name and value.
