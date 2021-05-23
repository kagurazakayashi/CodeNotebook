# Fedora
    # Fedora 21:
        # Python 2:
            sudo yum upgrade python-setuptools
            sudo yum install python-pip python-wheel
        # Python 3:
            sudo yum install python3 python3-wheel
    # Fedora 22:
        # Python 2:
            sudo dnf upgrade python-setuptools
            sudo dnf install python-pip python-wheel
        # Python 3:
            sudo dnf install python3 python3-wheel
# CentOS/RHEL
    # EPEL 6 and EPEL7
        sudo yum install python-pip
    # EPEL 7 (but not EPEL 6)
        sudo yum install python-wheel
    # Enable the PyPA Copr Repo using these instructions
        sudo yum install python-pip python-wheel
        sudo yum upgrade python-setuptools
# openSUSE
    # Python 2:
        sudo zypper install python-pip python-setuptools python-wheel
    # Python 3:
        sudo zypper install python3-pip python3-setuptools python3-wheel
# Debian/Ubuntu
    # Python 2:
        sudo apt install python-pip
    # Python 3:
        sudo apt install python3-venv python3-pip
# Arch Linux
    # Python 2:
        sudo pacman -S python2-pip
    # Python 3:
        sudo pacman -S python-pip