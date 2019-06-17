#!/usr/bin/env python

import os
import subprocess

target_path = "project/bin"
target_name = "lib"

godot_headers_path = "godot-cpp/godot_headers/"
cpp_bindings_path = "godot-cpp/"
cpp_library_path = "godot-cpp/bin"

target = ARGUMENTS.get("target", "debug")
platform = ARGUMENTS.get("p", "windows")
platform = ARGUMENTS.get("platform", platform)

env = Environment()
cpp_library = ""

def add_sources(sources, directory):
    for file in os.listdir(directory):
        if file.endswith('.cpp'):
            sources.append(directory + '/' + file)

def find_library():
    global cpp_library
    for file in os.listdir(cpp_library_path):
        cpp_library = file

# Code below stolen from somewhere idk
if platform == "windows":
    env = Environment(ENV = os.environ)

if ARGUMENTS.get("use_llvm", "no") == "yes":
    env["CXX"] = "clang++"

if platform == "osx":
    env.Append(CCFLAGS = ['-g','-O3', '-arch', 'x86_64'])
    env.Append(LINKFLAGS = ['-arch', 'x86_64'])

if platform == "linux":
    env.Append(CCFLAGS = ['-fPIC', '-g','-O3', '-std=c++14'])

if platform == "windows":
    env.Append(CCFLAGS = ['-DWIN32', '-D_WIN32', '-D_WINDOWS', '-W3', '-GR', '-D_CRT_SECURE_NO_WARNINGS'])
    if target == "debug":
        env.Append(CCFLAGS = ['-EHsc', '-D_DEBUG', '-MDd'])
    else:
        env.Append(CCFLAGS = ['-O2', '-EHsc', '-DNDEBUG', '-MD'])

find_library()

env["LIBSUFFIX"] = ""

env.Append(CPPPATH=['.', 'src/', godot_headers_path, cpp_bindings_path + 'include/', cpp_bindings_path + 'include/core/', cpp_bindings_path + 'include/gen/'])
env.Append(LIBPATH=[ cpp_library_path ])
env.Append(LIBS=[ cpp_library ])

sources = []
add_sources(sources, "src")

library = env.SharedLibrary(target=target_path + "/" + target_name, source=sources)
Default(library)