# firewalld 修复 ModuleNotFoundError: No module named 'six'
cp /usr/local/lib/python3.6/site-packages/six.py /usr/lib/python3.6/site-packages/
# 为了能让代码同时运行在python2与python3上，这个模块是必不可少的
# https://www.kawabangga.com/posts/2360