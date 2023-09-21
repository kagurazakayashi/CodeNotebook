# go get私有库失败
# fatal: could not read Username for 'https://github.com': terminal prompts disabled

# Linux
export GOPRIVATE=github.com/xxx

# Windows
set GOPRIVATE=github.com/xxx


go get


# 另一种方案 改 .gitconfig
#+ url.git@github.com:.insteadof=https://github.com/