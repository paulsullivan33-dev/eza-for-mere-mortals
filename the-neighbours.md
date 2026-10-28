# The Neighbours

Outcome: you can place eza in its family
and name the job each relative still
does better. These tools are
characterised from their documentation
and general knowledge, not benchmarked —
the lab ran eza, and this chapter does
not pretend otherwise.

## GNU ls — the neighbour who owns the street

`ls` is everywhere: every machine, every
rescue shell, every container, forty
years of scripts written against its
exact output. Keep it for: scripts
(chapter 12's warning applies to eza,
not to the tool whose output formats
were frozen by POSIX), other people's
machines, and the day eza is not
installed. Eza's defaults deliberately
echo it — same hidden-file rule, same
two-faced dates — so the knowledge
transfers both ways. The differences
that matter are presentation (colour
rules, icons, tree, git) and the natural
sort; the facts underneath are the
same filesystem's.

## exa — the parent

Eza began as the continuation of
**exa**, the Rust tool that first made
`ls` beautiful — colour, git column,
tree, all of it started there. Exa's own
development stopped (its repository was
archived after its maintainer stepped
back), and eza is the community fork
that carried the work on, compatible in
spirit and most flags, diverging where
the new maintainers chose (themes are
eza's, for instance). Practical advice
is one line: install eza. Guides and
dotfiles written for exa mostly work;
where they don't, you have found one of
the divergences, and eza's manual is
the arbiter.

## lsd — the other moderniser

**lsd** ("LSDeluxe") covers much of the
same ground — colour, icons, tree —
with its own taste: icons are central
rather than optional, its configuration
is a single YAML file, and its long view
arranges columns in its own order.
Choosing between eza and lsd is largely
choosing which defaults annoy you less;
the honest differences are eza's git
column depth, theme file and
`LS_COLORS` loyalty against lsd's
config-in-one-place. A household can
standardise on either; mixing them per
machine buys nothing.

## tree — the specialist

The venerable `tree` program does one
thing and does it with more knobs than
eza's tree mode: patterns for inclusion
and exclusion, sizes and dates in the
drawing, HTML and JSON output, links
handled half a dozen ways. For a quick
map of a project, eza's `--tree` is
already in your hand. For a structural
report — a directory census for a
document — `tree` earns its install.

## find and du — the instruments

When the reader of the listing is a
program, or the question is *everywhere
on this disk*, the neighbours are
`find` (enumerate by any test, act on
the results, survive hostile filenames
with `-print0`) and `du` (disk usage
summed properly, the tool chapter 12's
first recipe defers to). The Finding
Files guide in this series is their
home. Eza's tree and totals are for the
folder in front of you; pretending
otherwise is how a quick look turns
into a slow, wrong audit.

## The shell itself

A last neighbour, often forgotten:
globbing (`echo */`, `for f in *.log`)
lists files with no tool at all, and in
scripts is usually the right amount of
machinery. Eza is for eyes. The moment
a listing's consumer has no eyes, you
are in a neighbour's house — visit
deliberately.
