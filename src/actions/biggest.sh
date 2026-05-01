gits:biggest() {
    git rev-list --objects --all | git cat-file --batch-check='%(objectsize) %(rest)' | sed -n 's/^//p' | sort -rn | head -n 10 | numfmt --to=iec-i --suffix=B --field=1
}
