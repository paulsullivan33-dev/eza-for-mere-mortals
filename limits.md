# Limits

Outcome: you know the edges — the places
where eza's presentation stops being the
truth, where this version of it has
verified quirks, and what it cannot do
at all. Everything here was either
measured by the lab (and says so) or is
a plain statement of the tool's design.

## Icons are addressed to a font you may not have

Chapter 9's measurement, restated as a
limit: every icon eza prints is a
private-use-area character whose picture
exists only in Nerd Fonts. On a terminal
without one — servers, fresh installs,
most of the world — icons are boxes,
blanks, or nothing. This is not a bug
and cannot be configured away; it is
what the feature *is*. Decide per
terminal, and never let a screenshot
with icons stand as documentation for
someone whose terminal you have not
asked about.

## Colour is a claim, and it does not travel

`--color=auto` paints for terminals only.
The consequences ripple further than
readers expect: a listing saved to a
file is plain; a listing in an email is
plain; your theme (chapter 9) restyles
*your* terminal and nobody else's. Two
people can run the same command on the
same folder and honestly see different
listings. When a listing must mean the
same thing to its reader as to you, send
the plain one (chapter 12 shows how) —
or accept that colour was commentary,
not content.

## The git column's silences

Verified twice over by the lab, and
worth restating where limits are
collected: outside a repository, `--git`
adds no column and raises no error — the
absence of the column is the only
message. And in eza **0.23.5**, `--git`
with no path argument prints nothing at
all while succeeding. Treat both as
properties of the tool as it stands:
state the path, and confirm the
repository with git itself when the
answer matters. A later version may fix
the second; the first is a philosophy
(eza decorates what exists and does not
lecture), and philosophies change
slower than bugs.

## Eza reads its stdin — and waits for it

Measured with a timer in
`eza-lab/transcripts/t90-pipe-and-stdin.txt`:
when standard input is a pipe, eza reads
names from it (that is the documented
`--stdin` behaviour, and it happens
whenever stdin is a pipe) and does not
print until the pipe closes. A listing
fed by a slow or silent pipe therefore
looks hung while being perfectly
healthy — three seconds of a held-open
pipe cost exactly three seconds. In
scripts, give eza `</dev/null` unless
you mean to feed it names. On a
terminal, where stdin is the keyboard,
none of this applies.

## Sizes are edited truths

Every size in a listing is an editorial
choice: rounded units by default, a
folder's size withheld (`-`) until
`--total-size` walks the whole subtree
to earn it, apparent length and
allocated blocks telling different
stories about sparse files (chapter
10). None of these is *the* size; the
limit is believing any single column
settles a disk argument. Eza will show
each variant — choosing is your job.

## It cannot change anything

The design limit, stated once more
because readers keep half-expecting
otherwise: eza has no write operations
at all. No delete, rename, move, copy,
chmod, touch. Where a workflow needs
the listing *and then* the change, eza
is the first half only, and the second
half belongs to tools this series
covers elsewhere. A related honesty:
eza shows the filesystem's recorded
facts — timestamps a tool set falsely
are shown as recorded, permissions are
what the kernel enforces, and a file
mid-write by another program is shown
as of the instant of the listing. The
listing is a photograph, not a
guarantee about the next second.

## One platform's verification

The lab ran eza 0.23.5 on Linux. Eza
also runs on macOS and Windows, where
some facts differ — creation times,
file flags, mount details, the shape of
permissions — and some options are
platform-specific (the manual marks
them). Those differences are described
in this guide from the project's
documentation, not from runs, and
`criteria.md` says so in the ledger.
Likewise the comparison tools of
chapter 13 are characterised, not
benchmarked, and other versions of eza
than 0.23.5 may move any behaviour in
this chapter — which is why the
transcripts name the version they were
captured from.
