# Recipes

Outcome: a page to raid. Each recipe is
a question, the listing that answers it,
and the caveat that keeps the answer
honest. All are built from chapters
already proven; the flags are the lab's.

## What is eating this disk?

```bash
eza -l --total-size --sort=size --reverse ~/Downloads
```

Folders with real totals, biggest first.
Caveat: `--total-size` walks everything
beneath each folder — on a whole home
directory this is a minute's patience,
not a second's, and the dedicated tool
(`du`, or the disk-usage guide's
instruments) is better below the first
level. Eza's job here is the triage:
which folder deserves the deeper look.

## What changed this week?

```bash
eza -l --sort=modified --reverse --time-style=long-iso ~/project
```

Newest first, dates complete enough to
compare at a glance. In a git repository
add `--git .` and the same listing shows
which of the changed files the project
itself has noticed.

## Which of my projects did I leave dirty?

```bash
eza -l --git-repos ~/src
```

One row per folder, branch and `+` for
uncommitted work (chapter 8). The
morning-after listing for anyone with
more checkouts than memory.

## A folder, explained to someone else

```bash
eza --tree --level=2 project
eza -l --header --no-user --time-style=long-iso project
```

The tree for the shape, the labelled
long listing for the facts. Send them as
plain text: leave `--color` and
`--icons` at their defaults so nothing
in the message depends on the reader's
terminal or fonts — the listing that
survives being pasted into a ticket is
the one with no paint on it.

## When colour is not available

```bash
eza --classify=always
```

On a terminal without colour — a serial
console, a dull SSH session, a printed
page — `--classify` restores the kind
marks as characters: `/` after folders,
`*` after executables, `@` after links,
`|` after pipes. It is the oldest
legibility trick `ls` had (`-F`), kept.
(Mind chapter 15: write it
`--classify=always`, not `-F folder`,
whose optional value swallows the
folder's name.)

## Aliases that keep ls honest

Chapter 3's middle path, as a set:

```bash
alias ll='eza -l'
alias la='eza -la'
alias lt='eza --tree --level=2'
alias lg='eza -l --git'
```

`ls` keeps meaning `ls` — for scripts,
for other people's machines, and for
your own muscle memory at 2 a.m. — while
the four listings you actually read get
two-letter names.

## A listing a script can trust

```bash
eza -1 --color=never --icons=never folder
```

Names only, one per line, no paint, no
pictures — the least surprising output
eza has. Even so, read chapter 13 before
building on it: names can contain almost
any character, and the tools designed
for enumeration (`find` with `-print0`)
exist because a list of names is a
weaker contract than it looks. For a
human checking a script's work, though,
this line is the one to reach for.
