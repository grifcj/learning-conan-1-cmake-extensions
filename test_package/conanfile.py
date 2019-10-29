from conans import ConanFile, CMake, tools

class TestConan(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "cmake"

    def test(self):
        cmake = CMake(self)
        cmake.configure()
