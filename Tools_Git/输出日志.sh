# 一般输出
git log

# 只想输出 hash
git log --pretty=format:"%h" 
# 81a0b69
# 2c4e955
# 20fed13

# 输出 CSV
git log --pretty=format:name,%H,%T,%P,%ae,%ai,%s >log.csv

# %H: commit hash
# %h: 缩短的 commit hash
# %T: tree hash
# %t: 缩短的 tree hash
# %P: parent hashes
# %p: 缩短的 parent hashes
# %an: 作者名字
# %aN: mailmap 的作者名字 (.mailmap 对应，详情参照git-shortlog(1)或者git-blame(1))
# %ae: 作者邮箱
# %aE: 作者邮箱 (.mailmap 对应，详情参照git-shortlog(1)或者git-blame(1))
# %ad: 日期 (--date= 制定的格式)
# %aD: 日期, RFC2822 格式
# %ar: 日期, 相对格式 (1 day ago)
# %at: 日期, UNIX timestamp
# %ai: 日期, ISO 8601 格式
# %cn: 提交者名字
# %cN: 提交者名字 (.mailmap 对应，详情参照git-shortlog(1)或者git-blame(1))
# %ce: 提交者 email
# %cE: 提交者 email (.mailmap 对应，详情参照git-shortlog(1)或者git-blame(1))
# %cd: 提交日期 (--date= 制定的格式)
# %cD: 提交日期, RFC2822 格式
# %cr: 提交日期, 相对格式 (1 day ago)
# %ct: 提交日期, UNIX timestamp
# %ci: 提交日期, ISO 8601 格式
# %d: ref 名称
# %e: encoding
# %s: commit 信息标题
# %f: sanitized subject line, suitable for a filename
# %b: commit 信息内容
# %N: commit notes
# %gD: reflog selector, e.g., refs/stash@{1}
# %gd: shortened reflog selector, e.g., stash@{1}
# %gs: reflog subject
# %Cred: 切换到红色
# %Cgreen: 切换到绿色
# %Cblue: 切换到蓝色
# %Creset: 重设颜色
# %C(...): 制定颜色, as described in color.branch.* config option
# %m: left, right or boundary mark
# %n: 换行
# %%: a raw %
# %x00: print a byte from a hex code
# %w([[,[,]]]): switch line wrapping, like the -w option of git-shortlog(1).