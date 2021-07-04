# "/Library/Application Support/Nemu/Startup.sh"

#!/bin/sh


if false; then
    . /etc/rc.common
else
    # Fake the startup item functions we're using.

    ConsoleMessage()
    {
        if [ "$1" != "-f" ]; then
            echo "$@"
        else
            shift
            echo "Fatal error: $@"
            exit 1;
        fi
    }

    RunService()
    {
        case "$1" in
            "start")
                StartService
                exit $?;
                ;;
            "stop")
                StopService
                exit $?;
                ;;
            "restart")
                RestartService
                exit $?;
                ;;
            "launchd")
                if RestartService; then
                    while true;
                    do
                        sleep 3600
                    done
                fi
                exit $?;
                ;;
             **)
                echo "Error: Unknown action '$1'"
                exit 1;
        esac
    }
fi


StartService()
{
    NEMU_RC=0
    NEMUDRV="NemuDrv"

    #
    # Check that all the directories exist first.
    #
    if [ ! -d "/Library/Application Support/Nemu/${NEMUDRV}.kext" ]; then
        ConsoleMessage "Error: /Library/Application Support/Nemu/${NEMUDRV}.kext is missing"
        NEMU_RC=1
    fi

    #
    # Check that no drivers are currently running.
    # (Try stop the service if this is the case.)
    #
    if [ $NEMU_RC -eq 0 ]; then
        if kextstat -lb com.netease.nemu.kext.NemuDrv 2>&1 | grep -q com.netease.nemu.kext.NemuDrv; then
            ConsoleMessage "Error: ${NEMUDRV}.kext is already loaded"
            NEMU_RC=1
        fi
    fi

    #
    # Load the drivers.
    #
    if [ $NEMU_RC -eq 0 ]; then
        ConsoleMessage "Loading ${NEMUDRV}.kext"
        if ! kextload "/Library/Application Support/Nemu/${NEMUDRV}.kext"; then
            ConsoleMessage "Error: Failed to load /Library/Application Support/Nemu/${NEMUDRV}.kext"
            NEMU_RC=1
        fi

        if [ $NEMU_RC -ne 0 ]; then
            # unload the drivers (ignoring failures)
            kextunload -b com.netease.nemu.kext.NemuDrv
        fi
    fi

    #
    # Set the error on failure.
    #
    if [ "$NEMU_RC" -ne "0" ]; then
        ConsoleMessage -f Nemu
        exit $NEMU_RC
    fi
}


StopService()
{
    NEMU_RC=0
    NEMUDRV="NemuDrv"
    NEMUUSB="NemuUSB"

    # This must come last because of dependencies.
    if kextstat -lb com.netease.nemu.kext.NemuDrv 2>&1 | grep -q com.netease.nemu.kext.NemuDrv; then
        ConsoleMessage "Unloading ${NEMUDRV}.kext"
        if ! kextunload -m com.netease.nemu.kext.NemuDrv; then
            ConsoleMessage "Error: Failed to unload NemuDrv.kext"
            NEMU_RC=1
        fi
    fi

    # Set the error on failure.
    if [ "$NEMU_RC" -ne "0" ]; then
        ConsoleMessage -f Nemu
        exit $NEMU_RC
    fi
}


RestartService()
{
    StopService
    StartService
}


RunService "$1"