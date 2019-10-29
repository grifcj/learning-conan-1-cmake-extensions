from conans import ConanFile, python_requires, tools

class CMakeExtensionsConanFile(ConanFile):
    name = "cmake_extensions"
    version = "1.0.0-nightly"
    exports_sources = (
            "CMakeExtensions.cmake",
            "target-cpp-info-template.json.in")

    def build(self):
        pass

    def package(self):
        for s in self.exports_sources:
            self.copy(s)

