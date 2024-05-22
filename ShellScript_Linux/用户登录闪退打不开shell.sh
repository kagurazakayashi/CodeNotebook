# su: failed to execute /usr/bin/bash: Permission denied
chattr -i /bin/bash
chmod a+rx /bin/bash
chmod 555 /