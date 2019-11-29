# vim /usr/bin/pip
# 替换为
from pip import __main__
if __name__ == '__main__':
    sys.exit(__main__._main())
# 升级pip
# python -m pip install --upgrade pip