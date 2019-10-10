from conans import ConanFile, CMake, tools

class TestConan(ConanFile):
    settings = "os", "compiler", "build_type", "arch"

    def test(self):
        cmake = CMake(self)
        modulesPath = self.deps_cpp_info["cmake_modules"].rootpath
        cmake.definitions["CMAKE_MODULE_PATH"] = modulesPath
        cmake.configure()
