#!/bin/bash

set -euxo pipefail

cd "${PKG_NAME}-${PKG_VERSION}"

# Workaround to Klocwork overwriting LD_LIBRARY_PATH that was modified
# by DPC++ compiler conda packages. Will need to be added to DPC++ compiler
# activation scripts.
export LDFLAGS="$LDFLAGS -Wl,-rpath,$PREFIX/lib"

${PYTHON} setup.py clean --all
export CMAKE_GENERATOR="Ninja"
SKBUILD_ARGS="-- -DCMAKE_C_COMPILER:PATH=icx -DCMAKE_CXX_COMPILER:PATH=icpx"
echo "${PYTHON} setup.py install ${SKBUILD_ARGS}"

# Workaround for:
# DPC++ launched by cmake does not see components of `dpcpp_cpp_rt`,
# because conda build isolates LD_LIBRARY_PATH to only $PREFIX subfolders.
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$BUILD_PREFIX/lib

# Perform regular install
${PYTHON} setup.py install ${SKBUILD_ARGS}
