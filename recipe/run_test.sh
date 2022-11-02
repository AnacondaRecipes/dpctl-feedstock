#!/bin/bash

set -ex

export OCL_ICD_FILENAMES=libintelocl.so
export SYCL_ENABLE_HOST_DEVICE=1
export SYCL_PI_TRACE=1
${PYTHON} -c "import dpctl; print(dpctl.__version__)"
${PYTHON} -c "import dpctl; dpctl.lsplatform()"
${PYTHON} -m pytest -q -ra --disable-warnings -p no:faulthandler --cov dpctl --cov-report term-missing -k "not test_get_dpcppversion" --pyargs dpctl -vv