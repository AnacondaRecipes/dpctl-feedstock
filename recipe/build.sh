#!/bin/bash

set -euxo pipefail

cd "${PKG_NAME}-${PKG_VERSION}"

${PYTHON} setup.py clean --all
export CMAKE_GENERATOR="Ninja"
SKBUILD_ARGS="-- -DCMAKE_C_COMPILER:PATH=icx -DCMAKE_CXX_COMPILER:PATH=icpx"

# Perform regular install
${PYTHON} setup.py install --single-version-externally-managed --record=record.txt ${SKBUILD_ARGS}
