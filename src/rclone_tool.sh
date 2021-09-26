#!/bin/bash

set -e -o pipefail
PROG_URL="https://downloads.rclone.org/v1.56.1/rclone-v1.56.1-linux-arm.zip"
PROG_TMP_FOLDER="/tmp"
PROG_BIN_FOLDER="/usr/bin"
PROG_TMP_FILE="${PROG_TMP_FOLDER}/rclone.zip"
PROG_PY_UNZIP="${PROG_TMP_FOLDER}/unzip_rclone.py"
PROG_DEST_FOLDER="${PROG_TMP_FOLDER}/rclone/rclone-v1.56.1-linux-arm"
PROG_DEST_FILE="${PROG_DEST_FOLDER}/rclone"
PROG_LOCAL_CONF="${PROG_BIN_FOLDER}/rclone_local.config"


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
   chmod ugo+rx ${PROG_DEST_FILE}
   cp ${PROG_DEST_FILE} /usr/bin

   chmod ugo+rx ${PROG_TMP_FOLDER}/rclone_tool.sh
   cp ${PROG_TMP_FOLDER}/rclone_tool.sh ${PROG_BIN_FOLDER}/rclone_tool.sh
}

config() {
   echo Local data output Camera Folder \(if empty default: /data/output/Camera1\)?
   read CAM_FOLDER

    if [ "${CAM_FOLDER}" = "" ]
    then
        CAM_FOLDER=/data/output/Camera1
    fi
    echo Output Camera Folder is: ${CAM_FOLDER}

    while true; do
        echo Remote folder?
        read REMOTE_FOLDER
        if [ "${REMOTE_FOLDER}" = "" ]
        then
            continue
        else
            echo Remote Folder is: ${REMOTE_FOLDER}
            break
        fi
    done

    echo CAM_FOLDER=${CAM_FOLDER} > ${PROG_LOCAL_CONF}
    echo REMOTE_FOLDER=${REMOTE_FOLDER} >> ${PROG_LOCAL_CONF}
}

case "$1" in
    config)
        config
        ;;

    install)
        install
        config
        ;;
    *)
        echo "Usage: $0 {install|config}"
        exit 1
        ;;
esac

exit $?
