#!/bin/bash
set -e -u -x

function repair_wheel {
    wheel="$1"
    if ! auditwheel show "$wheel"; then
        echo "Skipping non-platform wheel $wheel"
    else
        auditwheel repair "$wheel" --plat "$PLAT" -w /io/wheelhouse/
    fi
}

UNSUPPORTED="(27|34|35)"

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    if ! echo $PYBIN | egrep -v $UNSUPPORTED > /dev/null; then
        echo "Ignoring unsupported python $PYBIN"
    else
        "${PYBIN}/pip" install -r /io/requirements.txt
        "${PYBIN}/python" -c 'import pathlib' || "${PYBIN}/pip" install pathlib2
        "${PYBIN}/pip" wheel /io/ --no-deps -w wheelhouse/
    fi
done

# Bundle external shared libraries into the wheels
for whl in wheelhouse/*.whl; do
    repair_wheel "$whl"
done

# Test installation
for PYBIN in /opt/python/*/bin/; do
    "${PYBIN}/pip" install parallelworkloads --no-index -f /io/wheelhouse
done
