#!/bin/bash

set -e

${PYTHON} -c "import dpctl; print(dpctl.__version__)"
${PYTHON} -c "import dpctl; dpctl.lsplatform()"
${PYTHON} -m pytest -q -ra --disable-warnings -p no:faulthandler --cov dpctl --cov-report term-missing -k "not test_get_dpcppversion" --pyargs dpctl -vv