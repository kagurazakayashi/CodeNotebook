git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch appstoremedia/rec/APPpreview65.mp4' --prune-empty --tag-name-filter cat -- --all
git push origin master --force
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now
git gc --aggressive --prune=now