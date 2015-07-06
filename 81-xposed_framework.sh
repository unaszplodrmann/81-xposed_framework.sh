#!/sbin/sh
#
# /system/addon.d/81-xposed_framework.sh
# During a CM upgrade, this script backs up Xposed Framework,
# /system is formatted and reinstalled, then the file is restored.
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
xposed.prop
framework/XposedBridge.jar
bin/app_process32_xposed
bin/dex2oat
bin/oatdump
bin/patchoat
lib/libart.so
lib/libart-compiler.so
lib/libart-disassembler.so
lib/libsigchain.so
lib/libxposed_art.so
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    chcon u:object_r:zygote_exec:s0 /system/bin/app_process32_xposed
    chcon u:object_r:dex2oat_exec:s0 /system/bin/{dex2,patch}oat
    mv /system/bin/app_process32 /system/bin/app_process32_original
    ln -s /system/bin/app_process32_xposed /system/bin/app_process32
  ;;
esac
