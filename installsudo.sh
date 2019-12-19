#!/system/bin/sh

clear
echo "Android-Sudo v1.1 by MasterDevX. Made in Ukraine."
echo "-------------------------------------------------"
if [ "`id | grep =0`" ]; then
    echo "[sudo] Installing sudo..."
    printf "[sudo] Enter new password for root (leave empty for none): "
    read pass
    if [ "$pass" == "" ]; then
        nopswd=1
    else
        printf "[sudo] Confirm password: "
        read passconf
        if [ "$pass" == "$passconf" ]; then
            nopswd=0
        else
            echo "[sudo] Passwords do not match, exiting..."
            exit 1
        fi
    fi
    echo "[sudo] Remounting system as rw..."
    mount -o rw,remount /system > /dev/null 2>&1
    if [ "$?" == "0" ]; then
        if [ "$nopswd" == "0" ]; then
            echo "[sudo] Creating configuration file..."
            echo "$pass" > /etc/sudo.conf
            chmod 0600 /etc/sudo.conf
            echo "[sudo] Creating wrapper script..."
            echo "#!/system/bin/sh

cmd=\"\$@\"
su -c \"mount -o rw,remount /system > /dev/null 2>&1\"
su -c \"chmod 0644 /etc/sudo.conf\"
rootpass=\"\$(cat /etc/sudo.conf)\"
su -c \"chmod 0600 /etc/sudo.conf\"
su -c \"mount -o ro,remount /system > /dev/null 2>&1\"
printf \"[sudo] Enter password for root: \"
read inputpass
if [ \"\$inputpass\" == \"\$rootpass\" ]; then
    su -c \"\$cmd\"
else
    echo \"[sudo] Authentication failed!\"
    exit 1
fi" > /system/bin/sudo
        else
            echo "[sudo] Creating wrapper script..."
            echo "#!/system/bin/sh

cmd=\"\$@\"
su -c \"\$cmd\"" > /system/bin/sudo
        fi
        chmod 0755 /system/bin/sudo
        echo "[sudo] Remounting system as ro..."
        mount -o ro,remount /system > /dev/null 2>&1
        if [ "$?" == "0" ]; then
            :
        else
            echo "[sudo] Mounting failed, ignoring..."
        fi
        echo "[sudo] Installation finished!"
    else
        echo "[sudo] Mounting failed, exiting..."
        exit 1
    fi
else
    echo "[sudo] Installer should be ran as root, exiting..."
    exit 1
fi

