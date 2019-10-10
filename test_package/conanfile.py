from conans import ConanFile, CMake, tools

class TestConan(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "cmake_find_package"

    def imports(self):
        self.copy("*.cmake")

    def test(self):
        cmake = CMake(self)
        cmake.configure()
