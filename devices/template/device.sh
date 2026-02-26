# This file contains information about the device associated with this repo,
# and other
# This file is meant to be used as follows:
#   cat myscript
#   #!/usr/bin/env sh
#   . device.sh
#   echo "Nice ${DEV_NAME} you have there."

export DEV_MFR=GizmoTek
export DEV_NAME=Gizmo
export DEV_PN=1234
export DEV_VER=1

export DEV_TAG=GizmoTek_Gizmo_1234_v1
export DEV_TAG_SC=gizmotek_gizmo_1234_v1

export FW_RESET_FILENAME=${DEV_TAG_SC}.reset.bin
export FW_FILENAME=${DEV_TAG_SC}.bin
export FW_UPDATE_FILENAME=${DEV_TAG_SC}.update.bin

export FW_RESET_PATH=firmware-images/${FW_RESET_FILENAME}
export FW_PATH=firmware-images/${FW_FILENAME}
export FW_UPDATE_PATH=firmware-images/${FW_UPDATE_FILENAME}
