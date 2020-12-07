#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""A setuptools based setup module.

See:
https://packaging.python.org/guides/distributing-packages-using-setuptools/
https://github.com/pypa/sampleproject
"""

# Always prefer setuptools over distutils
from setuptools import setup, find_packages, Extension
try:
    from Cython.Build import cythonize
except NameError:
    def cythonize(*args, **kwargs):
        pass
import pathlib

here = pathlib.Path(__file__).parent.resolve()

# Get the long description from the README file
long_description = (here / 'README.rst').read_text(encoding='utf-8')

# Arguments marked as "Required" below must be included for upload to PyPI.
# Fields marked as "Optional" may be commented out.

setup(
    name='parallelworkloads',
    description='A Python Wrapper for the workload model proposed by Lublin',
    long_description=long_description,
    long_description_content_type='text/x-rst',
    url='https://github.com/renatolfc/parallelworkloads',
    author='Renato L. de F. Cunha',
    author_email='renatocunha@acm.org',

    classifiers=[
        'Development Status :: 3 - Alpha',

        # Indicate who your project is intended for
        'Intended Audience :: Developers',
        'Intended Audience :: Information Technology',

        'Topic :: Scientific/Engineering',
        'Topic :: Scientific/Engineering :: Artificial Intelligence',

        # Pick your license as you wish
        'License :: OSI Approved :: MIT License',

        # Specify the Python versions you support here. In particular, ensure
        # that you indicate you support Python 3. These classifiers are *not*
        # checked by 'pip install'. See instead 'python_requires' below.
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3 :: Only',
    ],

    ext_modules = cythonize([
        Extension('swf', ['parallelworkloads/swf.pyx']),
        Extension('lublin99', ['parallelworkloads/lublin99.pyx']),
        Extension('tsafrir05', ['parallelworkloads/tsafrir05.pyx']),
    ], language_level=3),

    keywords='workload, standard workload format, swf',

    package_dir={'': 'parallelworkloads'},
    packages=find_packages(where='parallelworkloads'),
    python_requires='>=3.6, <4',

    # This field lists other packages that your project depends on to run.
    # Any package you put here will be installed by pip when your project is
    # installed, so they must be valid existing projects.
    #
    # For an analysis of "install_requires" vs pip's requirements files see:
    # https://packaging.python.org/en/latest/requirements.html
    install_requires=[
        'cython',
    ],

    # List additional URLs that are relevant to your project as a dict.
    #
    # This field corresponds to the "Project-URL" metadata fields:
    # https://packaging.python.org/specifications/core-metadata/#project-url-multiple-use
    #
    # Examples listed include a pattern for specifying where the package tracks
    # issues, where the source is hosted, where to say thanks to the package
    # maintainers, and where to support the project financially. The key is
    # what's used to render the link text on PyPI.
    project_urls={  # Optional
        'Bug Reports': 'https://github.com/renatolfc/parallelworkloads/issues',
        'Say Thanks!': 'https://saythanks.io/to/renatocunha%40acm.org',
        'Source': 'https://github.com/renatolfc/parallelworkloads',
    },
)
