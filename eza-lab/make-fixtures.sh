#!/bin/bash
# Builds the guide's fixture tree and fixture git repo, deterministically.
# Usage: make-fixtures.sh <parent-dir>
set -eu
P="$1"
G="$P/garden"
R="$P/repo"
mkdir -p "$G/documents" "$G/photos/2023" "$G/photos/2024" "$G/bin" "$G/empty-dir"

echo "# Field notes" > "$G/README.md"
printf 'date,task,hours\n2026-01-05,tomatoes,2\n' > "$G/budget.csv"
echo "remember the spare batteries" > "$G/notes.txt"
echo "top secret shopping list" > "$G/private.txt"
echo "read only, do not edit" > "$G/readonly.txt"
echo '#!/bin/sh' > "$G/run-backup.sh"
echo 'echo backing up' >> "$G/run-backup.sh"
printf 'JPEGDATA' > "$G/photos/2024/gate.jpg"
head -c 2400 /dev/zero > "$G/photos/2024/river.png"
head -c 800 /dev/zero > "$G/photos/2023/barn.jpg"
echo "the old write-up, kept for reference" > "$G/documents/old-draft.txt"
echo "current write-up" > "$G/documents/report.md"
head -c 2600000 /dev/zero > "$G/clip.mp4"
truncate -s 1500000000 "$G/full-backup.tar"
echo "hidden" > "$G/.hidden"
echo "page one" > "$G/page1.txt"
echo "page two" > "$G/page2.txt"
echo "page ten" > "$G/page10.txt"

chmod 600 "$G/private.txt"
chmod 444 "$G/readonly.txt"
chmod 755 "$G/run-backup.sh"
ln "$G/notes.txt" "$G/notes-copy.txt"
ln -s notes.txt "$G/link-to-notes"
ln -s photos "$G/link-to-photos"
ln -s no-such-file "$G/broken-link"
mkfifo "$G/named-pipe"

touch -d "2019-06-15 10:30" "$G/documents/old-draft.txt"
touch -d "2024-02-29 08:15" "$G/photos/2023/barn.jpg"
touch -d "2026-01-05 09:00" "$G/budget.csv"
touch -d "2026-10-01 17:45" "$G/README.md"
touch -d "2026-10-20 12:00" "$G/notes.txt" "$G/notes-copy.txt"

mkdir -p "$R"
cd "$R"
git init -q
git config user.email lab@example.invalid
git config user.name "Lab"
cat > app.py <<'PY'
print("hello from the fixture")
PY
echo "# Fixture repo" > README.md
printf 'a,b\n1,2\n' > data.csv
echo "*.tmp" > .gitignore
git add -A
git commit -qm "first commit"
# worktree modification (unstaged)
echo 'print("changed after commit")' >> app.py
# staged modification
printf 'a,b\n1,2\n3,4\n' > data.csv
git add data.csv
# staged new file
echo "brand new module" > feature.py
git add feature.py
# untracked file
echo "scratch notes" > scratch.log
# ignored file
echo "ignored" > cache.tmp
echo "fixtures built in $P"
