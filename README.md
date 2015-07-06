# 81-xposed_framework.sh
Backup and restore Xposed Framework during a Cyanogenmod upgrade.

Drop the script into /system/addon.d, set owner and group to root, and make it executable:

mount -o remount,rw /system
mv /sdcard/81-xposed_framework.sh /system/addon.d/81-xposed_framework.sh
chown root:root /system/addon.d/81-xposed_framework.sh
chmod 755 /system/addon.d/81-xposed_framework.sh
mount -o remount,ro /system
