git clone https://gitlab.com/m2crypto/m2crypto.git
cd m2crypto
cp -r /c/tools/msys64/mingw64/include/openssl /usr/include/openssl
python setup.py build
python setup.py install
