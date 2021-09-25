#!/bin/bash

set -e -o pipefail
PROG_URL="https://downloads.rclone.org/v1.56.1/rclone-v1.56.1-linux-arm.zip"
PROG_TMP_FOLDER="/tmp/"
PROG_TMP_FILE="${PROG_TMP_FOLDER}/rclone.zip"
PROG_PY_UNZIP="/tmp/unzip_rclone.py"
PROG_DEST_FOLDER="${PROG_TMP_FOLDER}/rclone/rclone-v1.56.1-linux-arm"
PROG_DEST_FILE="${PROG_DEST_FOLDER}/rclone"

cat << EOF > ${PROG_PY_UNZIP}
import zipfile

with zipfile.ZipFile('/tmp/rclone.zip', "r") as z:
   z.extractall("/tmp/rclone")
EOF

install() {
   mount -o remount,rw /
   mount -o remount,rw /boot
   rm -f /usr/bin/rclone
   curl ${PROG_URL} -o ${PROG_TMP_FILE}
   python ${PROG_PY_UNZIP}
   chmod ugo+x ${PROG_DEST_FILE}
   cp ${PROG_DEST_FILE} /usr/bin
}

case "$1" in
    install)
        FORCE_INIT="1"
        install
        ;;
    *)
        echo "Usage: $0 {install}"
        exit 1
        ;;
esac

exit $?
