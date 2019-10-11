from conans import ConanFile, CMake, tools

class TestConan(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "cmake_paths"

    def test(self):
        cmake = CMake(self)
        cmake.configure()
