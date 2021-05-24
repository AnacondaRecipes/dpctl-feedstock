#!/bin/bash

# We need dpcpp to compile dpctl_sycl_interface
if [ ! -z "${ONEAPI_ROOT}" ]; then
    # Suppress error b/c it could fail on Ubuntu 18.04
    source ${ONEAPI_ROOT}/compiler/latest/env/vars.sh || true
else
    echo "DPCPP is needed to build DPCTL. Abort!"
    exit 1
fi

${PYTHON} setup.py clean --all
${PYTHON} setup.py install

