# Integration Guide for Compression Detection Project on ns-3

## 📌 Overview
This document explains how to integrate the modified files from the compression detection project into an `ns-3` clone. These changes are intended to support simulation and detection logic for compressed traffic flows, primarily modifying parts of the network stack.

## 🧱 Prerequisites
- A working clone of the ns-3 repository (e.g. `https://github.com/xiuhuiwang/ns-3-dev.git`)
- A working build environment for ns-3 (C++ compiler, Python, waf)

## 📂 File Placement Instructions
The following files should be copied into their corresponding relative paths inside your ns-3 repo (after cloning it).

Assuming you cloned ns-3 into `~/ns-3-dev`, copy files like this:

```bash
cd ~/ns-3-dev
# Repeat for each file listed below or you can manually add them to ns-3-dev
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Build.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Build.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/ConfigSet.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/ConfigSet.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Configure.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Configure.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Context.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Context.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Errors.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Errors.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Logs.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Logs.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Node.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Node.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Options.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Options.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Runner.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Runner.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Scripting.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Scripting.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Task.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Task.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/TaskGen.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/TaskGen.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/__init__.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/__init__.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/ar.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/ar.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/asm.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/asm.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/bison.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/bison.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/c.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/c.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/c_aliases.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/c_aliases.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/c_config.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/c_config.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/c_osx.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/c_osx.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/c_preproc.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/c_preproc.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/c_tests.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/c_tests.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/ccroot.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/ccroot.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/clang.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/clang.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/clangxx.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/clangxx.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/compiler_c.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/compiler_c.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/compiler_cxx.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/compiler_cxx.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/compiler_d.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/compiler_d.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/compiler_fc.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/compiler_fc.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/cs.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/cs.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/cxx.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/cxx.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/d.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/d.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/d_config.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/d_config.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/d_scan.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/d_scan.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/dbus.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/dbus.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/dmd.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/dmd.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/errcheck.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/errcheck.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/fc.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/fc.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/fc_config.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/fc_config.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/fc_scan.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/fc_scan.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/flex.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/flex.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/g95.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/g95.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/gas.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/gas.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/gcc.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/gcc.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/gdc.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/gdc.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/gfortran.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/gfortran.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/glib2.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/glib2.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/gnu_dirs.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/gnu_dirs.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/gxx.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/gxx.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/icc.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/icc.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/icpc.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/icpc.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/ifort.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/ifort.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/intltool.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/intltool.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/irixcc.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/irixcc.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/javaw.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/javaw.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/ldc2.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/ldc2.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/lua.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/lua.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/md5_tstamp.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/md5_tstamp.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/msvc.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/msvc.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/nasm.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/nasm.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/nobuild.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/nobuild.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/perl.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/perl.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/python.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/python.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/qt5.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/qt5.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/ruby.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/ruby.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/suncc.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/suncc.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/suncxx.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/suncxx.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/tex.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/tex.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/vala.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/vala.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/waf_unit_test.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/waf_unit_test.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/winres.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/winres.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/xlc.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/xlc.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/xlcxx.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Tools/xlcxx.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Utils.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/Utils.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/__init__.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/__init__.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/ansiterm.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/ansiterm.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/extras/__init__.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/extras/__init__.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/extras/compat15.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/extras/compat15.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/fixpy2.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/fixpy2.py
cp [your_zip_dir]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/processor.py ./[ns-3-root]/.waf-2.0.20-36f5354d605298f6a89c09e0c7ef6c1d/waflib/processor.py
cp [your_zip_dir]/=1.8.2 ./[ns-3-root]/=1.8.2
cp [your_zip_dir]/cal_lossrate.py ./[ns-3-root]/cal_lossrate.py
cp [your_zip_dir]/capacity ./[ns-3-root]/capacity
cp [your_zip_dir]/compression_link_output ./[ns-3-root]/compression_link_output
cp [your_zip_dir]/contrib/experiment/helper/compression-sender-receiver-helper.cc ./[ns-3-root]/contrib/experiment/helper/compression-sender-receiver-helper.cc
cp [your_zip_dir]/contrib/experiment/model/compression-receiver.cc ./[ns-3-root]/contrib/experiment/model/compression-receiver.cc
cp [your_zip_dir]/contrib/experiment/model/compression-sender.h ./[ns-3-root]/contrib/experiment/model/compression-sender.h
cp [your_zip_dir]/countSpLossRate.py ./[ns-3-root]/countSpLossRate.py
cp [your_zip_dir]/get-pip.py ./[ns-3-root]/get-pip.py
cp [your_zip_dir]/getDelay.py ./[ns-3-root]/getDelay.py
cp [your_zip_dir]/getSimuRes.py ./[ns-3-root]/getSimuRes.py
cp [your_zip_dir]/getSuperPacket.py ./[ns-3-root]/getSuperPacket.py
cp [your_zip_dir]/lossrate_output ./[ns-3-root]/lossrate_output
cp [your_zip_dir]/multiSYN_lossrate.py ./[ns-3-root]/multiSYN_lossrate.py
cp [your_zip_dir]/multiSYN_output_loss_rate_h.txt ./[ns-3-root]/multiSYN_output_loss_rate_h.txt
cp [your_zip_dir]/multiSYN_output_loss_rate_l.txt ./[ns-3-root]/multiSYN_output_loss_rate_l.txt
cp [your_zip_dir]/multi_syn_output.txt ./[ns-3-root]/multi_syn_output.txt
cp [your_zip_dir]/output.txt ./[ns-3-root]/output.txt
cp [your_zip_dir]/output/capacity_output_h_0.5_1 ./[ns-3-root]/output/capacity_output_h_0.5_1
cp [your_zip_dir]/output/capacity_output_h_0.5_60 ./[ns-3-root]/output/capacity_output_h_0.5_60
cp [your_zip_dir]/output/capacity_output_h_1.5_1 ./[ns-3-root]/output/capacity_output_h_1.5_1
cp [your_zip_dir]/output/capacity_output_h_1.5_60 ./[ns-3-root]/output/capacity_output_h_1.5_60
cp [your_zip_dir]/output/capacity_output_h_10.5_1 ./[ns-3-root]/output/capacity_output_h_10.5_1
cp [your_zip_dir]/output/capacity_output_h_10.5_60 ./[ns-3-root]/output/capacity_output_h_10.5_60
cp [your_zip_dir]/output/capacity_output_h_10_1 ./[ns-3-root]/output/capacity_output_h_10_1
cp [your_zip_dir]/output/capacity_output_h_10_60 ./[ns-3-root]/output/capacity_output_h_10_60
cp [your_zip_dir]/output/capacity_output_h_1100_1 ./[ns-3-root]/output/capacity_output_h_1100_1
cp [your_zip_dir]/output/capacity_output_h_11_1 ./[ns-3-root]/output/capacity_output_h_11_1
cp [your_zip_dir]/output/capacity_output_h_11_60 ./[ns-3-root]/output/capacity_output_h_11_60
cp [your_zip_dir]/output/capacity_output_h_1_1 ./[ns-3-root]/output/capacity_output_h_1_1
cp [your_zip_dir]/output/capacity_output_h_1_60 ./[ns-3-root]/output/capacity_output_h_1_60
cp [your_zip_dir]/output/capacity_output_h_2.5_1 ./[ns-3-root]/output/capacity_output_h_2.5_1
cp [your_zip_dir]/output/capacity_output_h_2.5_60 ./[ns-3-root]/output/capacity_output_h_2.5_60
cp [your_zip_dir]/output/capacity_output_h_2_1 ./[ns-3-root]/output/capacity_output_h_2_1
cp [your_zip_dir]/output/capacity_output_h_2_60 ./[ns-3-root]/output/capacity_output_h_2_60
cp [your_zip_dir]/output/capacity_output_h_3.5_1 ./[ns-3-root]/output/capacity_output_h_3.5_1
cp [your_zip_dir]/output/capacity_output_h_3.5_60 ./[ns-3-root]/output/capacity_output_h_3.5_60
cp [your_zip_dir]/output/capacity_output_h_3_1 ./[ns-3-root]/output/capacity_output_h_3_1
cp [your_zip_dir]/output/capacity_output_h_3_60 ./[ns-3-root]/output/capacity_output_h_3_60
cp [your_zip_dir]/output/capacity_output_h_4.5_1 ./[ns-3-root]/output/capacity_output_h_4.5_1
cp [your_zip_dir]/output/capacity_output_h_4.5_60 ./[ns-3-root]/output/capacity_output_h_4.5_60
cp [your_zip_dir]/output/capacity_output_h_4_1 ./[ns-3-root]/output/capacity_output_h_4_1
cp [your_zip_dir]/output/capacity_output_h_4_60 ./[ns-3-root]/output/capacity_output_h_4_60
cp [your_zip_dir]/output/capacity_output_h_5.5_1 ./[ns-3-root]/output/capacity_output_h_5.5_1
cp [your_zip_dir]/output/capacity_output_h_5.5_60 ./[ns-3-root]/output/capacity_output_h_5.5_60
cp [your_zip_dir]/output/capacity_output_h_50_1 ./[ns-3-root]/output/capacity_output_h_50_1
cp [your_zip_dir]/output/capacity_output_h_5_1 ./[ns-3-root]/output/capacity_output_h_5_1
cp [your_zip_dir]/output/capacity_output_h_5_60 ./[ns-3-root]/output/capacity_output_h_5_60
cp [your_zip_dir]/output/capacity_output_h_6.5_1 ./[ns-3-root]/output/capacity_output_h_6.5_1
cp [your_zip_dir]/output/capacity_output_h_6.5_60 ./[ns-3-root]/output/capacity_output_h_6.5_60
cp [your_zip_dir]/output/capacity_output_h_7.5_1 ./[ns-3-root]/output/capacity_output_h_7.5_1
cp [your_zip_dir]/output/capacity_output_h_7.5_60 ./[ns-3-root]/output/capacity_output_h_7.5_60
cp [your_zip_dir]/output/capacity_output_h_7_1 ./[ns-3-root]/output/capacity_output_h_7_1
cp [your_zip_dir]/output/capacity_output_h_7_60 ./[ns-3-root]/output/capacity_output_h_7_60
cp [your_zip_dir]/output/capacity_output_h_8.5_1 ./[ns-3-root]/output/capacity_output_h_8.5_1
cp [your_zip_dir]/output/capacity_output_h_8.5_60 ./[ns-3-root]/output/capacity_output_h_8.5_60
cp [your_zip_dir]/output/capacity_output_h_8_1 ./[ns-3-root]/output/capacity_output_h_8_1
cp [your_zip_dir]/output/capacity_output_h_8_60 ./[ns-3-root]/output/capacity_output_h_8_60
cp [your_zip_dir]/output/capacity_output_h_9.5_1 ./[ns-3-root]/output/capacity_output_h_9.5_1
cp [your_zip_dir]/output/capacity_output_h_9.5_60 ./[ns-3-root]/output/capacity_output_h_9.5_60
cp [your_zip_dir]/output/capacity_output_h_9_1 ./[ns-3-root]/output/capacity_output_h_9_1
cp [your_zip_dir]/output/capacity_output_h_9_60 ./[ns-3-root]/output/capacity_output_h_9_60
cp [your_zip_dir]/output/capacity_output_l_0.5_1 ./[ns-3-root]/output/capacity_output_l_0.5_1
cp [your_zip_dir]/output/capacity_output_l_0.5_60 ./[ns-3-root]/output/capacity_output_l_0.5_60
cp [your_zip_dir]/output/capacity_output_l_1.5_1 ./[ns-3-root]/output/capacity_output_l_1.5_1
cp [your_zip_dir]/output/capacity_output_l_1.5_60 ./[ns-3-root]/output/capacity_output_l_1.5_60
cp [your_zip_dir]/output/capacity_output_l_10.5_1 ./[ns-3-root]/output/capacity_output_l_10.5_1
cp [your_zip_dir]/output/capacity_output_l_10.5_60 ./[ns-3-root]/output/capacity_output_l_10.5_60
cp [your_zip_dir]/output/capacity_output_l_10_1 ./[ns-3-root]/output/capacity_output_l_10_1
cp [your_zip_dir]/output/capacity_output_l_10_60 ./[ns-3-root]/output/capacity_output_l_10_60
cp [your_zip_dir]/output/capacity_output_l_11_1 ./[ns-3-root]/output/capacity_output_l_11_1
cp [your_zip_dir]/output/capacity_output_l_11_60 ./[ns-3-root]/output/capacity_output_l_11_60
cp [your_zip_dir]/output/capacity_output_l_1_1 ./[ns-3-root]/output/capacity_output_l_1_1
cp [your_zip_dir]/output/capacity_output_l_1_60 ./[ns-3-root]/output/capacity_output_l_1_60
cp [your_zip_dir]/output/capacity_output_l_2.5_1 ./[ns-3-root]/output/capacity_output_l_2.5_1
cp [your_zip_dir]/output/capacity_output_l_2.5_60 ./[ns-3-root]/output/capacity_output_l_2.5_60
cp [your_zip_dir]/output/capacity_output_l_2_1 ./[ns-3-root]/output/capacity_output_l_2_1
cp [your_zip_dir]/output/capacity_output_l_2_60 ./[ns-3-root]/output/capacity_output_l_2_60
cp [your_zip_dir]/output/capacity_output_l_3.5_1 ./[ns-3-root]/output/capacity_output_l_3.5_1
cp [your_zip_dir]/output/capacity_output_l_3.5_60 ./[ns-3-root]/output/capacity_output_l_3.5_60
cp [your_zip_dir]/output/capacity_output_l_3_1 ./[ns-3-root]/output/capacity_output_l_3_1
cp [your_zip_dir]/output/capacity_output_l_3_60 ./[ns-3-root]/output/capacity_output_l_3_60
cp [your_zip_dir]/output/capacity_output_l_4.5_1 ./[ns-3-root]/output/capacity_output_l_4.5_1
cp [your_zip_dir]/output/capacity_output_l_4.5_60 ./[ns-3-root]/output/capacity_output_l_4.5_60
cp [your_zip_dir]/output/capacity_output_l_4_1 ./[ns-3-root]/output/capacity_output_l_4_1
cp [your_zip_dir]/output/capacity_output_l_4_60 ./[ns-3-root]/output/capacity_output_l_4_60
cp [your_zip_dir]/output/capacity_output_l_5.5_1 ./[ns-3-root]/output/capacity_output_l_5.5_1
cp [your_zip_dir]/output/capacity_output_l_5.5_60 ./[ns-3-root]/output/capacity_output_l_5.5_60
cp [your_zip_dir]/output/capacity_output_l_5_1 ./[ns-3-root]/output/capacity_output_l_5_1
cp [your_zip_dir]/output/capacity_output_l_5_60 ./[ns-3-root]/output/capacity_output_l_5_60
cp [your_zip_dir]/output/capacity_output_l_6.5_1 ./[ns-3-root]/output/capacity_output_l_6.5_1
cp [your_zip_dir]/output/capacity_output_l_6.5_60 ./[ns-3-root]/output/capacity_output_l_6.5_60
cp [your_zip_dir]/output/capacity_output_l_7.5_1 ./[ns-3-root]/output/capacity_output_l_7.5_1
cp [your_zip_dir]/output/capacity_output_l_7.5_60 ./[ns-3-root]/output/capacity_output_l_7.5_60
cp [your_zip_dir]/output/capacity_output_l_7_1 ./[ns-3-root]/output/capacity_output_l_7_1
cp [your_zip_dir]/output/capacity_output_l_7_60 ./[ns-3-root]/output/capacity_output_l_7_60
cp [your_zip_dir]/output/capacity_output_l_8.5_1 ./[ns-3-root]/output/capacity_output_l_8.5_1
cp [your_zip_dir]/output/capacity_output_l_8.5_60 ./[ns-3-root]/output/capacity_output_l_8.5_60
cp [your_zip_dir]/output/capacity_output_l_8_1 ./[ns-3-root]/output/capacity_output_l_8_1
cp [your_zip_dir]/output/capacity_output_l_8_60 ./[ns-3-root]/output/capacity_output_l_8_60
cp [your_zip_dir]/output/capacity_output_l_9.5_1 ./[ns-3-root]/output/capacity_output_l_9.5_1
cp [your_zip_dir]/output/capacity_output_l_9.5_60 ./[ns-3-root]/output/capacity_output_l_9.5_60
cp [your_zip_dir]/output/capacity_output_l_9_1 ./[ns-3-root]/output/capacity_output_l_9_1
cp [your_zip_dir]/output/capacity_output_l_9_60 ./[ns-3-root]/output/capacity_output_l_9_60
cp [your_zip_dir]/output/packet_number_output_h_10 ./[ns-3-root]/output/packet_number_output_h_10
cp [your_zip_dir]/output/packet_number_output_h_100 ./[ns-3-root]/output/packet_number_output_h_100
cp [your_zip_dir]/output/packet_number_output_h_1000 ./[ns-3-root]/output/packet_number_output_h_1000
cp [your_zip_dir]/output/packet_number_output_h_10000 ./[ns-3-root]/output/packet_number_output_h_10000
cp [your_zip_dir]/output/packet_number_output_h_10000_1 ./[ns-3-root]/output/packet_number_output_h_10000_1
cp [your_zip_dir]/output/packet_number_output_h_10000_60 ./[ns-3-root]/output/packet_number_output_h_10000_60
cp [your_zip_dir]/output/packet_number_output_h_1000_1 ./[ns-3-root]/output/packet_number_output_h_1000_1
cp [your_zip_dir]/output/packet_number_output_h_1000_60 ./[ns-3-root]/output/packet_number_output_h_1000_60
cp [your_zip_dir]/output/packet_number_output_h_1500_1 ./[ns-3-root]/output/packet_number_output_h_1500_1
cp [your_zip_dir]/output/packet_number_output_h_1500_60 ./[ns-3-root]/output/packet_number_output_h_1500_60
cp [your_zip_dir]/output/packet_number_output_h_200 ./[ns-3-root]/output/packet_number_output_h_200
cp [your_zip_dir]/output/packet_number_output_h_2000 ./[ns-3-root]/output/packet_number_output_h_2000
cp [your_zip_dir]/output/packet_number_output_h_2000_1 ./[ns-3-root]/output/packet_number_output_h_2000_1
cp [your_zip_dir]/output/packet_number_output_h_2000_60 ./[ns-3-root]/output/packet_number_output_h_2000_60
cp [your_zip_dir]/output/packet_number_output_h_2500_1 ./[ns-3-root]/output/packet_number_output_h_2500_1
cp [your_zip_dir]/output/packet_number_output_h_2500_60 ./[ns-3-root]/output/packet_number_output_h_2500_60
cp [your_zip_dir]/output/packet_number_output_h_300 ./[ns-3-root]/output/packet_number_output_h_300
cp [your_zip_dir]/output/packet_number_output_h_3000 ./[ns-3-root]/output/packet_number_output_h_3000
cp [your_zip_dir]/output/packet_number_output_h_3000_1 ./[ns-3-root]/output/packet_number_output_h_3000_1
cp [your_zip_dir]/output/packet_number_output_h_3000_60 ./[ns-3-root]/output/packet_number_output_h_3000_60
cp [your_zip_dir]/output/packet_number_output_h_3500_1 ./[ns-3-root]/output/packet_number_output_h_3500_1
cp [your_zip_dir]/output/packet_number_output_h_3500_60 ./[ns-3-root]/output/packet_number_output_h_3500_60
cp [your_zip_dir]/output/packet_number_output_h_400 ./[ns-3-root]/output/packet_number_output_h_400
cp [your_zip_dir]/output/packet_number_output_h_4000 ./[ns-3-root]/output/packet_number_output_h_4000
cp [your_zip_dir]/output/packet_number_output_h_4000_1 ./[ns-3-root]/output/packet_number_output_h_4000_1
cp [your_zip_dir]/output/packet_number_output_h_4000_60 ./[ns-3-root]/output/packet_number_output_h_4000_60
cp [your_zip_dir]/output/packet_number_output_h_4500_1 ./[ns-3-root]/output/packet_number_output_h_4500_1
cp [your_zip_dir]/output/packet_number_output_h_4500_60 ./[ns-3-root]/output/packet_number_output_h_4500_60
cp [your_zip_dir]/output/packet_number_output_h_50 ./[ns-3-root]/output/packet_number_output_h_50
cp [your_zip_dir]/output/packet_number_output_h_500 ./[ns-3-root]/output/packet_number_output_h_500
cp [your_zip_dir]/output/packet_number_output_h_5000 ./[ns-3-root]/output/packet_number_output_h_5000
cp [your_zip_dir]/output/packet_number_output_h_5000_1 ./[ns-3-root]/output/packet_number_output_h_5000_1
cp [your_zip_dir]/output/packet_number_output_h_5000_60 ./[ns-3-root]/output/packet_number_output_h_5000_60
cp [your_zip_dir]/output/packet_number_output_h_500_1 ./[ns-3-root]/output/packet_number_output_h_500_1
cp [your_zip_dir]/output/packet_number_output_h_500_60 ./[ns-3-root]/output/packet_number_output_h_500_60
cp [your_zip_dir]/output/packet_number_output_h_5500_1 ./[ns-3-root]/output/packet_number_output_h_5500_1
cp [your_zip_dir]/output/packet_number_output_h_5500_60 ./[ns-3-root]/output/packet_number_output_h_5500_60
cp [your_zip_dir]/output/packet_number_output_h_600 ./[ns-3-root]/output/packet_number_output_h_600
cp [your_zip_dir]/output/packet_number_output_h_6000 ./[ns-3-root]/output/packet_number_output_h_6000
cp [your_zip_dir]/output/packet_number_output_h_6000_1 ./[ns-3-root]/output/packet_number_output_h_6000_1
cp [your_zip_dir]/output/packet_number_output_h_6000_60 ./[ns-3-root]/output/packet_number_output_h_6000_60
cp [your_zip_dir]/output/packet_number_output_h_6500_1 ./[ns-3-root]/output/packet_number_output_h_6500_1
cp [your_zip_dir]/output/packet_number_output_h_6500_60 ./[ns-3-root]/output/packet_number_output_h_6500_60
cp [your_zip_dir]/output/packet_number_output_h_700 ./[ns-3-root]/output/packet_number_output_h_700
cp [your_zip_dir]/output/packet_number_output_h_7000 ./[ns-3-root]/output/packet_number_output_h_7000
cp [your_zip_dir]/output/packet_number_output_h_7000_1 ./[ns-3-root]/output/packet_number_output_h_7000_1
cp [your_zip_dir]/output/packet_number_output_h_7000_60 ./[ns-3-root]/output/packet_number_output_h_7000_60
cp [your_zip_dir]/output/packet_number_output_h_7500_1 ./[ns-3-root]/output/packet_number_output_h_7500_1
cp [your_zip_dir]/output/packet_number_output_h_7500_60 ./[ns-3-root]/output/packet_number_output_h_7500_60
cp [your_zip_dir]/output/packet_number_output_h_800 ./[ns-3-root]/output/packet_number_output_h_800
cp [your_zip_dir]/output/packet_number_output_h_8000 ./[ns-3-root]/output/packet_number_output_h_8000
cp [your_zip_dir]/output/packet_number_output_h_8000_1 ./[ns-3-root]/output/packet_number_output_h_8000_1
cp [your_zip_dir]/output/packet_number_output_h_8000_60 ./[ns-3-root]/output/packet_number_output_h_8000_60
cp [your_zip_dir]/output/packet_number_output_h_8500_1 ./[ns-3-root]/output/packet_number_output_h_8500_1
cp [your_zip_dir]/output/packet_number_output_h_8500_60 ./[ns-3-root]/output/packet_number_output_h_8500_60
cp [your_zip_dir]/output/packet_number_output_h_900 ./[ns-3-root]/output/packet_number_output_h_900
cp [your_zip_dir]/output/packet_number_output_h_9000 ./[ns-3-root]/output/packet_number_output_h_9000
cp [your_zip_dir]/output/packet_number_output_h_9000_1 ./[ns-3-root]/output/packet_number_output_h_9000_1
cp [your_zip_dir]/output/packet_number_output_h_9000_60 ./[ns-3-root]/output/packet_number_output_h_9000_60
cp [your_zip_dir]/output/packet_number_output_h_9500_1 ./[ns-3-root]/output/packet_number_output_h_9500_1
cp [your_zip_dir]/output/packet_number_output_h_9500_60 ./[ns-3-root]/output/packet_number_output_h_9500_60
cp [your_zip_dir]/output/packet_number_output_l_10 ./[ns-3-root]/output/packet_number_output_l_10
cp [your_zip_dir]/output/packet_number_output_l_100 ./[ns-3-root]/output/packet_number_output_l_100
cp [your_zip_dir]/output/packet_number_output_l_1000 ./[ns-3-root]/output/packet_number_output_l_1000
cp [your_zip_dir]/output/packet_number_output_l_10000 ./[ns-3-root]/output/packet_number_output_l_10000
cp [your_zip_dir]/output/packet_number_output_l_10000_1 ./[ns-3-root]/output/packet_number_output_l_10000_1
cp [your_zip_dir]/output/packet_number_output_l_10000_60 ./[ns-3-root]/output/packet_number_output_l_10000_60
cp [your_zip_dir]/output/packet_number_output_l_1000_1 ./[ns-3-root]/output/packet_number_output_l_1000_1
cp [your_zip_dir]/output/packet_number_output_l_1000_60 ./[ns-3-root]/output/packet_number_output_l_1000_60
cp [your_zip_dir]/output/packet_number_output_l_1500_1 ./[ns-3-root]/output/packet_number_output_l_1500_1
cp [your_zip_dir]/output/packet_number_output_l_1500_60 ./[ns-3-root]/output/packet_number_output_l_1500_60
cp [your_zip_dir]/output/packet_number_output_l_200 ./[ns-3-root]/output/packet_number_output_l_200
cp [your_zip_dir]/output/packet_number_output_l_2000 ./[ns-3-root]/output/packet_number_output_l_2000
cp [your_zip_dir]/output/packet_number_output_l_2000_1 ./[ns-3-root]/output/packet_number_output_l_2000_1
cp [your_zip_dir]/output/packet_number_output_l_2000_60 ./[ns-3-root]/output/packet_number_output_l_2000_60
cp [your_zip_dir]/output/packet_number_output_l_2500_1 ./[ns-3-root]/output/packet_number_output_l_2500_1
cp [your_zip_dir]/output/packet_number_output_l_2500_60 ./[ns-3-root]/output/packet_number_output_l_2500_60
cp [your_zip_dir]/output/packet_number_output_l_300 ./[ns-3-root]/output/packet_number_output_l_300
cp [your_zip_dir]/output/packet_number_output_l_3000 ./[ns-3-root]/output/packet_number_output_l_3000
cp [your_zip_dir]/output/packet_number_output_l_3000_1 ./[ns-3-root]/output/packet_number_output_l_3000_1
cp [your_zip_dir]/output/packet_number_output_l_3000_60 ./[ns-3-root]/output/packet_number_output_l_3000_60
cp [your_zip_dir]/output/packet_number_output_l_3500_1 ./[ns-3-root]/output/packet_number_output_l_3500_1
cp [your_zip_dir]/output/packet_number_output_l_3500_60 ./[ns-3-root]/output/packet_number_output_l_3500_60
cp [your_zip_dir]/output/packet_number_output_l_400 ./[ns-3-root]/output/packet_number_output_l_400
cp [your_zip_dir]/output/packet_number_output_l_4000 ./[ns-3-root]/output/packet_number_output_l_4000
cp [your_zip_dir]/output/packet_number_output_l_4000_1 ./[ns-3-root]/output/packet_number_output_l_4000_1
cp [your_zip_dir]/output/packet_number_output_l_4000_60 ./[ns-3-root]/output/packet_number_output_l_4000_60
cp [your_zip_dir]/output/packet_number_output_l_4500_1 ./[ns-3-root]/output/packet_number_output_l_4500_1
cp [your_zip_dir]/output/packet_number_output_l_4500_60 ./[ns-3-root]/output/packet_number_output_l_4500_60
cp [your_zip_dir]/output/packet_number_output_l_50 ./[ns-3-root]/output/packet_number_output_l_50
cp [your_zip_dir]/output/packet_number_output_l_500 ./[ns-3-root]/output/packet_number_output_l_500
cp [your_zip_dir]/output/packet_number_output_l_5000 ./[ns-3-root]/output/packet_number_output_l_5000
cp [your_zip_dir]/output/packet_number_output_l_5000_1 ./[ns-3-root]/output/packet_number_output_l_5000_1
cp [your_zip_dir]/output/packet_number_output_l_5000_60 ./[ns-3-root]/output/packet_number_output_l_5000_60
cp [your_zip_dir]/output/packet_number_output_l_500_1 ./[ns-3-root]/output/packet_number_output_l_500_1
cp [your_zip_dir]/output/packet_number_output_l_500_60 ./[ns-3-root]/output/packet_number_output_l_500_60
cp [your_zip_dir]/output/packet_number_output_l_5500_1 ./[ns-3-root]/output/packet_number_output_l_5500_1
cp [your_zip_dir]/output/packet_number_output_l_5500_60 ./[ns-3-root]/output/packet_number_output_l_5500_60
cp [your_zip_dir]/output/packet_number_output_l_600 ./[ns-3-root]/output/packet_number_output_l_600
cp [your_zip_dir]/output/packet_number_output_l_6000 ./[ns-3-root]/output/packet_number_output_l_6000
cp [your_zip_dir]/output/packet_number_output_l_6000_1 ./[ns-3-root]/output/packet_number_output_l_6000_1
cp [your_zip_dir]/output/packet_number_output_l_6000_60 ./[ns-3-root]/output/packet_number_output_l_6000_60
cp [your_zip_dir]/output/packet_number_output_l_6500_1 ./[ns-3-root]/output/packet_number_output_l_6500_1
cp [your_zip_dir]/output/packet_number_output_l_6500_60 ./[ns-3-root]/output/packet_number_output_l_6500_60
cp [your_zip_dir]/output/packet_number_output_l_700 ./[ns-3-root]/output/packet_number_output_l_700
cp [your_zip_dir]/output/packet_number_output_l_7000 ./[ns-3-root]/output/packet_number_output_l_7000
cp [your_zip_dir]/output/packet_number_output_l_7000_1 ./[ns-3-root]/output/packet_number_output_l_7000_1
cp [your_zip_dir]/output/packet_number_output_l_7000_60 ./[ns-3-root]/output/packet_number_output_l_7000_60
cp [your_zip_dir]/output/packet_number_output_l_7500_1 ./[ns-3-root]/output/packet_number_output_l_7500_1
cp [your_zip_dir]/output/packet_number_output_l_7500_60 ./[ns-3-root]/output/packet_number_output_l_7500_60
cp [your_zip_dir]/output/packet_number_output_l_800 ./[ns-3-root]/output/packet_number_output_l_800
cp [your_zip_dir]/output/packet_number_output_l_8000 ./[ns-3-root]/output/packet_number_output_l_8000
cp [your_zip_dir]/output/packet_number_output_l_8000_1 ./[ns-3-root]/output/packet_number_output_l_8000_1
cp [your_zip_dir]/output/packet_number_output_l_8000_60 ./[ns-3-root]/output/packet_number_output_l_8000_60
cp [your_zip_dir]/output/packet_number_output_l_8500_1 ./[ns-3-root]/output/packet_number_output_l_8500_1
cp [your_zip_dir]/output/packet_number_output_l_8500_60 ./[ns-3-root]/output/packet_number_output_l_8500_60
cp [your_zip_dir]/output/packet_number_output_l_900 ./[ns-3-root]/output/packet_number_output_l_900
cp [your_zip_dir]/output/packet_number_output_l_9000 ./[ns-3-root]/output/packet_number_output_l_9000
cp [your_zip_dir]/output/packet_number_output_l_9000_1 ./[ns-3-root]/output/packet_number_output_l_9000_1
cp [your_zip_dir]/output/packet_number_output_l_9000_60 ./[ns-3-root]/output/packet_number_output_l_9000_60
cp [your_zip_dir]/output/packet_number_output_l_9500_1 ./[ns-3-root]/output/packet_number_output_l_9500_1
cp [your_zip_dir]/output/packet_number_output_l_9500_60 ./[ns-3-root]/output/packet_number_output_l_9500_60
cp [your_zip_dir]/output/packet_size_output_h_1000_1 ./[ns-3-root]/output/packet_size_output_h_1000_1
cp [your_zip_dir]/output/packet_size_output_h_1000_60 ./[ns-3-root]/output/packet_size_output_h_1000_60
cp [your_zip_dir]/output/packet_size_output_h_100_1 ./[ns-3-root]/output/packet_size_output_h_100_1
cp [your_zip_dir]/output/packet_size_output_h_100_60 ./[ns-3-root]/output/packet_size_output_h_100_60
cp [your_zip_dir]/output/packet_size_output_h_1100_1 ./[ns-3-root]/output/packet_size_output_h_1100_1
cp [your_zip_dir]/output/packet_size_output_h_1100_60 ./[ns-3-root]/output/packet_size_output_h_1100_60
cp [your_zip_dir]/output/packet_size_output_h_500_1 ./[ns-3-root]/output/packet_size_output_h_500_1
cp [your_zip_dir]/output/packet_size_output_h_500_60 ./[ns-3-root]/output/packet_size_output_h_500_60
cp [your_zip_dir]/output/packet_size_output_h_50_1 ./[ns-3-root]/output/packet_size_output_h_50_1
cp [your_zip_dir]/output/packet_size_output_h_50_60 ./[ns-3-root]/output/packet_size_output_h_50_60
cp [your_zip_dir]/output/packet_size_output_h_600_1 ./[ns-3-root]/output/packet_size_output_h_600_1
cp [your_zip_dir]/output/packet_size_output_h_600_60 ./[ns-3-root]/output/packet_size_output_h_600_60
cp [your_zip_dir]/output/packet_size_output_h_700_1 ./[ns-3-root]/output/packet_size_output_h_700_1
cp [your_zip_dir]/output/packet_size_output_h_700_60 ./[ns-3-root]/output/packet_size_output_h_700_60
cp [your_zip_dir]/output/packet_size_output_h_800_1 ./[ns-3-root]/output/packet_size_output_h_800_1
cp [your_zip_dir]/output/packet_size_output_h_800_60 ./[ns-3-root]/output/packet_size_output_h_800_60
cp [your_zip_dir]/output/packet_size_output_h_900_1 ./[ns-3-root]/output/packet_size_output_h_900_1
cp [your_zip_dir]/output/packet_size_output_h_900_60 ./[ns-3-root]/output/packet_size_output_h_900_60
cp [your_zip_dir]/output/packet_size_output_l_1000_1 ./[ns-3-root]/output/packet_size_output_l_1000_1
cp [your_zip_dir]/output/packet_size_output_l_1000_60 ./[ns-3-root]/output/packet_size_output_l_1000_60
cp [your_zip_dir]/output/packet_size_output_l_100_1 ./[ns-3-root]/output/packet_size_output_l_100_1
cp [your_zip_dir]/output/packet_size_output_l_100_60 ./[ns-3-root]/output/packet_size_output_l_100_60
cp [your_zip_dir]/output/packet_size_output_l_1100_1 ./[ns-3-root]/output/packet_size_output_l_1100_1
cp [your_zip_dir]/output/packet_size_output_l_1100_60 ./[ns-3-root]/output/packet_size_output_l_1100_60
cp [your_zip_dir]/output/packet_size_output_l_500_1 ./[ns-3-root]/output/packet_size_output_l_500_1
cp [your_zip_dir]/output/packet_size_output_l_500_60 ./[ns-3-root]/output/packet_size_output_l_500_60
cp [your_zip_dir]/output/packet_size_output_l_50_1 ./[ns-3-root]/output/packet_size_output_l_50_1
cp [your_zip_dir]/output/packet_size_output_l_50_60 ./[ns-3-root]/output/packet_size_output_l_50_60
cp [your_zip_dir]/output/packet_size_output_l_600_1 ./[ns-3-root]/output/packet_size_output_l_600_1
cp [your_zip_dir]/output/packet_size_output_l_600_60 ./[ns-3-root]/output/packet_size_output_l_600_60
cp [your_zip_dir]/output/packet_size_output_l_700_1 ./[ns-3-root]/output/packet_size_output_l_700_1
cp [your_zip_dir]/output/packet_size_output_l_700_60 ./[ns-3-root]/output/packet_size_output_l_700_60
cp [your_zip_dir]/output/packet_size_output_l_800_1 ./[ns-3-root]/output/packet_size_output_l_800_1
cp [your_zip_dir]/output/packet_size_output_l_800_60 ./[ns-3-root]/output/packet_size_output_l_800_60
cp [your_zip_dir]/output/packet_size_output_l_900_1 ./[ns-3-root]/output/packet_size_output_l_900_1
cp [your_zip_dir]/output/packet_size_output_l_900_60 ./[ns-3-root]/output/packet_size_output_l_900_60
cp [your_zip_dir]/output/test_output_l_1100_1 ./[ns-3-root]/output/test_output_l_1100_1
cp [your_zip_dir]/output/test_output_l_1100_60 ./[ns-3-root]/output/test_output_l_1100_60
cp [your_zip_dir]/output/traffic_shaper_output_ ./[ns-3-root]/output/traffic_shaper_output_
cp [your_zip_dir]/output/traffic_shaper_output_l_1 ./[ns-3-root]/output/traffic_shaper_output_l_1
cp [your_zip_dir]/output/traffic_shaper_output_l_10000_1 ./[ns-3-root]/output/traffic_shaper_output_l_10000_1
cp [your_zip_dir]/output/traffic_shaper_output_l_1000_1 ./[ns-3-root]/output/traffic_shaper_output_l_1000_1
cp [your_zip_dir]/output/traffic_shaper_output_l_1500_1 ./[ns-3-root]/output/traffic_shaper_output_l_1500_1
cp [your_zip_dir]/output/traffic_shaper_output_l_2000_1 ./[ns-3-root]/output/traffic_shaper_output_l_2000_1
cp [your_zip_dir]/output/traffic_shaper_output_l_2500_1 ./[ns-3-root]/output/traffic_shaper_output_l_2500_1
cp [your_zip_dir]/output/traffic_shaper_output_l_3000_1 ./[ns-3-root]/output/traffic_shaper_output_l_3000_1
cp [your_zip_dir]/output/traffic_shaper_output_l_3500_1 ./[ns-3-root]/output/traffic_shaper_output_l_3500_1
cp [your_zip_dir]/output/traffic_shaper_output_l_4000_1 ./[ns-3-root]/output/traffic_shaper_output_l_4000_1
cp [your_zip_dir]/output/traffic_shaper_output_l_4500_1 ./[ns-3-root]/output/traffic_shaper_output_l_4500_1
cp [your_zip_dir]/output/traffic_shaper_output_l_5000_1 ./[ns-3-root]/output/traffic_shaper_output_l_5000_1
cp [your_zip_dir]/output/traffic_shaper_output_l_500_1 ./[ns-3-root]/output/traffic_shaper_output_l_500_1
cp [your_zip_dir]/output/traffic_shaper_output_l_5500_1 ./[ns-3-root]/output/traffic_shaper_output_l_5500_1
cp [your_zip_dir]/output/traffic_shaper_output_l_6000_1 ./[ns-3-root]/output/traffic_shaper_output_l_6000_1
cp [your_zip_dir]/output/traffic_shaper_output_l_6500_1 ./[ns-3-root]/output/traffic_shaper_output_l_6500_1
cp [your_zip_dir]/output/traffic_shaper_output_l_7000_1 ./[ns-3-root]/output/traffic_shaper_output_l_7000_1
cp [your_zip_dir]/output/traffic_shaper_output_l_7500_1 ./[ns-3-root]/output/traffic_shaper_output_l_7500_1
cp [your_zip_dir]/output/traffic_shaper_output_l_8000_1 ./[ns-3-root]/output/traffic_shaper_output_l_8000_1
cp [your_zip_dir]/output/traffic_shaper_output_l_8500_1 ./[ns-3-root]/output/traffic_shaper_output_l_8500_1
cp [your_zip_dir]/output/traffic_shaper_output_l_9000_1 ./[ns-3-root]/output/traffic_shaper_output_l_9000_1
cp [your_zip_dir]/output/traffic_shaper_output_l_9500_1 ./[ns-3-root]/output/traffic_shaper_output_l_9500_1
cp [your_zip_dir]/packet_number ./[ns-3-root]/packet_number
cp [your_zip_dir]/packet_numer ./[ns-3-root]/packet_numer
cp [your_zip_dir]/packet_size ./[ns-3-root]/packet_size
cp [your_zip_dir]/rst_delay_results_link.txt ./[ns-3-root]/rst_delay_results_link.txt
cp [your_zip_dir]/rst_delay_results_packetNum.txt ./[ns-3-root]/rst_delay_results_packetNum.txt
cp [your_zip_dir]/rst_delay_results_qsize.txt ./[ns-3-root]/rst_delay_results_qsize.txt
cp [your_zip_dir]/scratch/compression-link/compression-exp.cc ./[ns-3-root]/scratch/compression-link/compression-exp.cc
cp [your_zip_dir]/simu_comp_link_capacity.sh ./[ns-3-root]/simu_comp_link_capacity.sh
cp [your_zip_dir]/simu_comp_multi_syn.sh ./[ns-3-root]/simu_comp_multi_syn.sh
cp [your_zip_dir]/simu_packet_number.sh ./[ns-3-root]/simu_packet_number.sh
cp [your_zip_dir]/simu_payload.sh ./[ns-3-root]/simu_payload.sh
cp [your_zip_dir]/simu_queue_size.sh ./[ns-3-root]/simu_queue_size.sh
cp [your_zip_dir]/simu_traffic_shaper.sh ./[ns-3-root]/simu_traffic_shaper.sh
cp [your_zip_dir]/src/internet/model/tcp-header.h ./[ns-3-root]/src/internet/model/tcp-header.h
cp [your_zip_dir]/src/internet/model/tcp-socket-base.h ./[ns-3-root]/src/internet/model/tcp-socket-base.h
cp [your_zip_dir]/src/internet/model/tcp-socket.h ./[ns-3-root]/src/internet/model/tcp-socket.h
cp [your_zip_dir]/superpacket_output ./[ns-3-root]/superpacket_output
cp [your_zip_dir]/test ./[ns-3-root]/test
cp [your_zip_dir]/traffic_shaper ./[ns-3-root]/traffic_shaper
cp [your_zip_dir]/waf ./[ns-3-root]/waf
```

Replace `[your_zip_dir]` with the extracted directory and `[ns-3-root]` with your ns-3 project root.

## ⚙️ Build Instructions
After copying the files into place, rebuild ns-3:

```bash
./waf clean
./waf build
```

## 📝 Notes
- Most changes appear under the `.waf-*` directory and likely affect waf configuration or build scripts.
- If any modules or simulations were added, ensure they are registered in `wscript` files or `scratch/` if you added new simulation files.

---
For further questions or debugging, refer to the original GitHub repo: https://github.com/arbie333/ns-3-dev

## 🔧 How to Run Simulations
This project provides a set of Bash scripts for running simulations related to compression detection. You can find them in the project root or scripts directory (depending on where you place them).

### 📜 Available Simulation Scripts
- `simu_comp_link_capacity.sh`
- `simu_comp_multi_syn.sh`
- `simu_packet_number.sh`
- `simu_payload.sh`
- `simu_queue_size.sh`
- `simu_traffic_shaper.sh`

### ▶️ How to Run
1. Ensure the scripts are executable:

   ```bash
   chmod +x simu_*.sh
   ```

2. Run any script like this:

   ```bash
   ./simu_packet_number.sh
   ```

3. The output of the simulations will typically be printed in the terminal, and may also generate output files depending on how each script is written.

📌 If you encounter permission issues or environment errors, make sure you're in the correct ns-3 root directory and that `waf` has been built before running these scripts.