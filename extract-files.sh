#!/bin/bash
#
# Copyright (C) 2017-2019 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

VENDOR=samsung
DEVICE_COMMON=universal7580-common

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

LINEAGE_ROOT="${MY_DIR}"/../../..

HELPER="${LINEAGE_ROOT}/vendor/lineage/build/tools/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

SECTION=
KANG=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

# Initialize the helper
setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${LINEAGE_ROOT}" true "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" \
        "${KANG}" --section "${SECTION}"

extract "${MY_DIR}/proprietary-files-bsp.txt" "${SRC}" \
        "${KANG}" --section "${SECTION}"

# Fix proprietary blobs
BLOB_ROOT="$LINEAGE_ROOT"/vendor/"$VENDOR"/"$DEVICE_COMMON"/proprietary
patchelf --replace-needed libgui.so libsensor.so $BLOB_ROOT/bin/gpsd
patchelf --replace-needed libprotobuf-cpp-full.so libprotobuf-cpp-fl26.so $BLOB_ROOT/lib/libsec-ril.so
patchelf --replace-needed libprotobuf-cpp-full.so libprotobuf-cpp-fl26.so $BLOB_ROOT/lib/libsec-ril-dsds.so

# replace SSLv3_client_method with SSLv23_method
c=`hexdump -ve '1/1 "%.2X"' $BLOB_ROOT/bin/gpsd`; echo -n "$c" | sed 's/53534C76335F636C69656E745F6D6574686F6400/53534C7632335F6D6574686F6400000000000000/g' | xxd -r -p > $BLOB_ROOT/bin/gpsd

"${MY_DIR}/setup-makefiles.sh"
