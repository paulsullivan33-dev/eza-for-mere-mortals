# Writing criteria for this guide

Every "for Mere Mortals" guide is written to the same nine-point
standard, so a reader who trusts one can trust the rest. Here it
is, with the verification notes for this particular guide below.

1. **Fix it first.** Reader outcomes lead, not action items: each
   chapter opens by naming the outcome it delivers, shows a check
   the reader can run to confirm they got it, and a reasonable
   reader finishes able to state what was done, what it means,
   and what to try next.
2. **Plain language.** Short sentences, everyday vocabulary,
   technical terms defined on first use. No slang, and no
   idioms that only make sense in one country — the reader may
   be translating as they go.
3. **No dead ends.** A guide never tells the reader to do
   something it cannot show them how to verify. Every claim a
   reader relies on — an install, a command, an output — is
   something this guide demonstrates or clearly labels
   documented-only below.
4. **Live-verified where it matters.** Procedures are run for
   real in the guide's lab wherever the build machine allows it,
   and the transcripts kept in the repository are the evidence.
   What could not be run is listed honestly below, never
   presented as if it had been.
5. **General audiences.** Nothing in this guide — examples,
   fixtures, names, addresses — is modelled on any particular
   reader or author's real life, network, or organisations.
   The lab's traffic is the lab talking to itself.
6. **Standalone.** A reader needs this guide, its lab, and
   nothing else. Where another guide would genuinely help, it
   is pointed to once, by name, and the chapter still completes
   without it.
7. **Honest about limits.** Chapter 14 names what the tool
   cannot do: show its icons on a terminal with no Nerd Font
   to draw them, keep its colour once a listing leaves the
   terminal, weigh a folder without walking everything under
   it, or change any file in any way — and it names this
   version's two git silences, both reproduced in the lab
   rather than repeated from elsewhere.
8. **The one rule is in the text, early.** Chapter 1 and the
   README state it plainly — *list where you have a right to
   look: your own files, your own machines, or where the
   owner has given you permission* — before any procedure
   depends on it, and chapter 14 points back to it, because a
   tool that changes nothing can still show a reader names
   that were not theirs to read.
9. **Builds clean.** The site builds with MkDocs in strict mode
   with no warnings, and a fresh reader following the chapters
   in order reaches the stated outcome of each.

## Verification notes for this guide

The build machine is a 2-CPU, 7.7 GB Ubuntu sandbox. Eza
**0.23.5** was run from the project's official release binary
(`eza_x86_64-unknown-linux-gnu.tar.gz`, GitHub releases); its
SHA-256 was computed locally and matched against the digest
published in the release's own asset list
(`35c70c5c…f339b4`). The version line reports `[+git]`, and the
git features below were exercised against that build. Two
fixtures were created for the guide by a script kept in the
repository (`eza-lab/make-fixtures.sh`): a folder whose files'
kinds, ages, sizes, permissions, links and attributes are all
controlled, and a git repository placed in known states. All
transcripts live in `eza-lab/transcripts/`.

Run for real, with transcripts as evidence:

- Version and build flags; the plain grid against plain `ls`
  on the same folder, including the natural sort of numbered
  names (t00, t01).
- The long listing field by field against `ls -l`; hidden
  files with `-a` and `-aa`; `--header`;
  `--group-directories-first` (t02, t03).
- Sorting by size, extension and modification time, with
  `--reverse`; trees at levels 1–3, trees with `-l` (t04, t05).
- The git column against a fixture repository, checked line
  by line against `git status --short`: unstaged and staged
  modifications, a staged new file, an untracked file, an
  ignored file (`-I`), `--git-ignore` filtering, and
  `--git-repos` over a folder of folders (t06).
- Colour as bytes: `--color=always` output with the escape
  codes made visible; an `LS_COLORS` per-extension rule and
  an `EZA_COLORS` override each changing exactly one thing
  (t07).
- Icons as bytes: `--icons=always` output, then every icon in
  the fixture identified by Unicode codepoint with a small
  Python inspection — all twenty listed entries, nine distinct
  glyphs, every one in the private use area (t08).
- A theme: a two-rule `theme.yml` under `EZA_CONFIG_DIR`,
  with directory and symlink colours proven changed by the
  truecolor escape codes in the after listing (t09).
- All five `--time-style` values over the same two files;
  accessed and changed timestamps as columns; sizes in
  `--bytes` and `--binary`; `--total-size` over folders; `-S`
  block sizes, including a 1.5G sparse file occupying 0 blocks
  (t10, t11).
- Links and attributes: inode and hard-link columns exposing
  a planted hard-linked pair; `-X` dereferencing a symlink;
  `--follow-symlinks` in a tree; an extended attribute set by
  the lab (`user.lab_note`) and read back with `--extended`
  (t12).
- OSC 8 hyperlinks under `--hyperlink=always`, captured with
  the sequences made visible (t13); `--classify=always`,
  `--across`, `--width`, `-d` (t14).
- The failure modes, reproduced rather than described: eza
  printing nothing for `--git` with no path argument on
  0.23.5; eza waiting on a held-open stdin pipe (3.002 s
  against 0.003 s with stdin closed); the `-F` optional-value
  error; grid collapse through a pipe with no width (t90).

Documented only — described from the project's documentation,
not run, and the text does not claim otherwise:

- What the icons look like as pictures. The verification
  terminal has no Nerd Font; the guide verified the
  codepoints eza emits and describes the rendered result from
  the Nerd Fonts project's documentation, saying so wherever
  the pictures are discussed.
- Package-manager installations (apt, dnf, Homebrew, winget
  and friends) and building from source with cargo; the lab
  verified the official release binary only.
- The git status eza assigns to folders inside a repository,
  derived from their contents. The lab's fixture repository
  is flat, so its transcripts verify files only; the folder
  behaviour is described from the manual and labelled as
  such in chapter 8.
- Behaviour on macOS and Windows, including creation times,
  file flags, mount details and security contexts.
- Whether terminals that support OSC 8 turn hyperlinks into
  clicks; the guide captured the emitted sequences only.
- The comparison tools in chapter 13 (lsd, the `tree`
  program, exa's history) are characterised, not benchmarked.

Fixtures are this guide's own and deliberately generic: a
garden folder of invented documents, photographs and backups,
and a four-file practice repository with an invented sentence
of code. No example is modelled on any real person, network,
service or organisation, and nothing was listed that the lab
did not itself create. One machine artifact appears in the
evidence and is disclosed wherever it surfaces: the build
machine stamps files it writes with an extended attribute
(`user.hatch_tainted`), which is why the `@` mark is common in
the transcripts; the attribute the lab set deliberately, for
chapter 11, is `user.lab_note`.
