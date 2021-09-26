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
PROG_CONF="${PROG_BIN_FOLDER}/rclone.config"
RCLONE_DEST=""
RCLONE_OP=""

cat << EOF > ${PROG_PY_UNZIP}
import zipfile

with zipfile.ZipFile('/tmp/rclone.zip', "r") as z:
   z.extractall("/tmp/rclone")
EOF

run() {
    if [ ! -f "${PROG_LOCAL_CONF}" ] || [ ! -f "${PROG_CONF}" ];
    then
        echo "Missing configuration files. Plese run command: 'rclone_tool config'."
        exit 1
    fi
    if [ "${RCLONE_OP}" = "" ]
    then
        echo "Missing Rclone type action ('copy' or 'move')."
        exit 1
    fi
    if [ "${RCLONE_DEST}" = "" ]
    then
        echo "Missing Rclone destination name."
        exit 1
    fi

    echo Moving files to remote folder...
    source ${PROG_LOCAL_CONF}
    if [ "${RCLONE_OP}" = "move" ]
    then
        ${PROG_DEST_FILE} ${RCLONE_OP} ${CAM_FOLDER} ${RCLONE_DEST}:${REMOTE_FOLDER} --delete-empty-src-dirs --skip-links --log-file /var/log/rclone.log --log-level INFO --config ${PROG_CONF}
    fi
    if [ "${RCLONE_OP}" = "copy" ]
    then
        ${PROG_DEST_FILE} ${RCLONE_OP} ${CAM_FOLDER} ${RCLONE_DEST}:${REMOTE_FOLDER} --skip-links --log-file /var/log/rclone.log --log-level INFO --config ${PROG_CONF}
    fi
}

install() {
   mount -o remount,rw /
   mount -o remount,rw /boot
   rm -f ${PROG_DEST_FILE}
   curl ${PROG_URL} -o ${PROG_TMP_FILE}
   python ${PROG_PY_UNZIP}
   chmod ugo+rx ${PROG_DEST_FILE}
   cp ${PROG_DEST_FILE} /usr/bin

   chmod ugo+rx ${PROG_TMP_FOLDER}/rclone_tool.sh
   cp ${PROG_TMP_FOLDER}/rclone_tool.sh ${PROG_BIN_FOLDER}/rclone_tool.sh
}

config() {
   echo
   echo Configure rclone tool.
   echo
   ${PROG_DEST_FILE} config --config ${PROG_CONF}
   echo
   echo Configure local folders.
   echo
   echo Local data output Camera Folder \(if empty default: /data/output/Camera1\)?
   read CAM_FOLDER

    if [ "${CAM_FOLDER}" = "" ]
    then
        CAM_FOLDER=/data/output/Camera1
    fi
    echo Output Camera Folder is: ${CAM_FOLDER}

    TMP="/Motioneyeos/${HOSTNAME}"
    echo Remote folder \(if empty default: ${TMP}\)?
    read REMOTE_FOLDER
    if [ "${REMOTE_FOLDER}" = "" ]
    then
        REMOTE_FOLDER=${TMP}
    fi
    echo Remote Folder is: ${REMOTE_FOLDER}

    echo CAM_FOLDER=${CAM_FOLDER} > ${PROG_LOCAL_CONF}
    echo REMOTE_FOLDER=${REMOTE_FOLDER} >> ${PROG_LOCAL_CONF}

    chmod ug+r ${PROG_LOCAL_CONF}
    chmod ug+r ${PROG_CONF}
    chmod ugo+rx ${PROG_BIN_FOLDER}/rclone_tool.sh
    chmod ugo+rx ${PROG_BIN_FOLDER}/rclone
}

case "$1" in
    run)
        RCLONE_OP=${2}
        RCLONE_DEST=${3}
        run
        ;;

    config)
        config
        ;;

    install)
        install
        config
        ;;
    *)
        echo "Usage: $0 {install|config|run <copy|move> <RCLONE_NAME_DEST>}"
        exit 1
        ;;
esac

exit $?
