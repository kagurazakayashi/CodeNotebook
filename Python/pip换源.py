#pip换源

# 临时换源
pip install numpy -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
pip install numpy -i https://mirrors.aliyun.com/pypi/simple some-package

# 设为默认，先升级 pip 到最新的版本 (>=10.0.0) 后进行配置
python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 配置多个镜像源平衡负载，继续添加
pip config set global.extra-index-url https://mirrors.aliyun.com/pypi/simple

# https://mirrors.tuna.tsinghua.edu.cn/help/pypi/
