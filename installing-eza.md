# Installing Eza

Outcome: eza on your machine, from a
source you can name, with the version
confirmed on the screen. Every route
below ends at the same check.

## The package managers (the usual route)

Eza is packaged for most systems, and a
package is the right choice for most
readers — it updates with everything
else:

- **Debian and Ubuntu:** `sudo apt
  install eza` on recent releases. (On
  older ones the package may not exist;
  use the release binary below.)
- **Fedora:** `sudo dnf install eza`.
- **Arch:** `sudo pacman -S eza`.
- **macOS with Homebrew:** `brew install
  eza`.
- **Windows:** `winget install
  eza-community.eza`, or Scoop and
  Chocolatey packages of the same name.

Versions from distributions can lag the
project's releases by months. Nothing in
this guide needs the newest eza — but
chapter 8's git behaviour and chapter 9's
theme file are described as of 0.23, so
if a chapter's command is refused, check
the version before doubting the chapter.

## The release binary (the route the lab took)

The project publishes ready-made binaries
on its GitHub releases page, one per
platform. The lab downloaded
`eza_x86_64-unknown-linux-gnu.tar.gz` for
release **v0.23.5**, unpacked it, and had
a single `eza` file — no installer, no
dependencies. Two checks are worth the
minute they take:

1. **The checksum.** The releases page
   lists a SHA-256 digest for each file.
   The lab computed its download's digest
   and matched it against the one
   published beside the file:
   `35c70c5c…f339b4`. Same number, same
   file — that is the whole test.
2. **The version.** `./eza --version`:

```text
$ eza --version
eza eza - A modern, maintained replacement for ls
v0.23.5 [+git]
https://github.com/eza-community/eza
```

(from `eza-lab/transcripts/t00-version.txt`)

The `[+git]` matters: it means this build
includes the git reader of chapter 8.
Builds without it exist (some minimal
packages), and on those `--git` has
nothing to say. If your version line
lacks `[+git]`, that chapter's silence is
explained before you start.

To keep a hand-downloaded binary, put it
somewhere on your `PATH` that you
control — `~/.local/bin/eza` is the
customary spot — and remember it will not
update itself; a release binary is a
snapshot, and replacing it is a manual
chore you have chosen.

## Building from source

With a Rust toolchain, `cargo install
eza` builds the current release. This is
documented-only in this guide: the lab
used the official binary, and the
transcripts are evidence for that build.
The result is the same program; only the
delivery differs.

## The alias question, early

Sooner or later every eza user types
this into their shell configuration:

```bash
alias ls='eza'
```

It is comfortable, and this guide does
not forbid it — but know the trade before
you make it. Scripts and other users
still get the real `ls`; your own habits
slowly stop working on machines without
eza; and when a listing looks wrong at
2 a.m., one suspect ("is this even ls?")
is a suspect you created. A middle path
keeps both honest: alias the *extras* —
`alias ll='eza -l'`, `alias lt='eza
--tree'` — and leave `ls` meaning `ls`.
Chapter 12 has a small set of such
recipes. Whichever you choose, the
check below is the same.

Check: `eza --version` prints a version
you can state, with `[+git]` if you want
chapter 8 — and `eza` in a folder you
know lists that folder's real names.
