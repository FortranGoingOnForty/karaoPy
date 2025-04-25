# setup.py
from numpy.distutils.core import setup, Extension

ext = Extension(
    name="dsp",
    sources=["src/karaoke_dsp/dsp.f90"],
    f2py_options=["--quiet"],
)

setup(
    name="karaoke-dsp",
    version="0.1.0",
    description="Gesture-driven karaoke DSP (mid/side) module",
    package_dir={"": "src"},
    packages=["karaoke_dsp"],
    ext_modules=[ext],
    install_requires=["numpy"],
)
