#!/bin/bash

set -euxo pipefail

cd "${PKG_NAME}-${PKG_VERSION}"

${PYTHON} setup.py clean --all
export CMAKE_GENERATOR="Ninja"
SKBUILD_ARGS="-- -DCMAKE_C_COMPILER:PATH=icx -DCMAKE_CXX_COMPILER:PATH=icpx"

# Perform regular install
${PYTHON} setup.py install --single-version-externally-managed --record=record.txt ${SKBUILD_ARGS}

# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/scripts/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done