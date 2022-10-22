git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch 1.mp4' --prune-empty --tag-name-filter cat -- --all
# git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch 1.mp4' HEAD~8..HEAD //删除最近8次的提交中带有的1.mp4
git push origin master --force # git push origin main --force
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now
git gc --aggressive --prune=now