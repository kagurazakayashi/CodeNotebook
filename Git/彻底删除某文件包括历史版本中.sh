git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch appstoremedia/rec/APPpreview65.mp4' --prune-empty --tag-name-filter cat -- --all
# git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch appstoremedia/rec/APPpreview65.mp4' HEAD~8..HEAD //删除最近8次的提交中带有的appstoremedia/rec/APPpreview65.mp4
git push origin master --force
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now
git gc --aggressive --prune=now