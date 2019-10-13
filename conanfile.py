from conans import ConanFile, python_requires, tools

class CMakeExtensionsConanFile(ConanFile):
    name = "cmake_extensions"
    version = "1.0.0-nightly"
    exports_sources = "*.cmake"

    def build(self):
        pass

    def package(self):
        self.copy("*.cmake", "", "")

