# test-run/tls-test
# test-run/protocol-test
# test-run/ntp-test
# test-run/nmap-test
# test-run/dns-test
# test-run/conn-test
# test-run/baseline-test
# test-run/base-test
# test-run/faux-dev
# test-run/template
# test-run/radius
# test-run/ntp
# test-run/gateway
# test-run/dns
# test-run/dhcp-2
# test-run/dhcp-1
# test-run/base
# test-run/ui

docker save test-run/tls-test | xz -z -1 -T 2 -v -c >tls-test.tar.xz
docker save test-run/protocol-test | xz -z -1 -T 2 -v -c >protocol-test.tar.xz
docker save test-run/ntp-test | xz -z -1 -T 2 -v -c >ntp-test.tar.xz
docker save test-run/nmap-test | xz -z -1 -T 2 -v -c >nmap-test.tar.xz
docker save test-run/dns-test | xz -z -1 -T 2 -v -c >dns-test.tar.xz
docker save test-run/conn-test | xz -z -1 -T 2 -v -c >conn-test.tar.xz
docker save test-run/baseline-test | xz -z -1 -T 2 -v -c >baseline-test.tar.xz
docker save test-run/base-test | xz -z -1 -T 2 -v -c >base-test.tar.xz
docker save test-run/faux-dev | xz -z -1 -T 2 -v -c >faux-dev.tar.xz
docker save test-run/template | xz -z -1 -T 2 -v -c >template.tar.xz
docker save test-run/radius | xz -z -1 -T 2 -v -c >radius.tar.xz
docker save test-run/ntp | xz -z -1 -T 2 -v -c >ntp.tar.xz
docker save test-run/gateway | xz -z -1 -T 2 -v -c >gateway.tar.xz
docker save test-run/dns | xz -z -1 -T 2 -v -c >dns.tar.xz
docker save test-run/dhcp-2 | xz -z -1 -T 2 -v -c >dhcp-2.tar.xz
docker save test-run/dhcp-1 | xz -z -1 -T 2 -v -c >dhcp-1.tar.xz
docker save test-run/base | xz -z -1 -T 2 -v -c >base.tar.xz
docker save test-run/ui | xz -z -1 -T 2 -v -c >ui.tar.xz
docker save 84f566680db9 | xz -z -1 -T 2 -v -c >84f566680db9.tar.xz

for f in *.xz; do xz -d $f -v -c | docker image load; done
