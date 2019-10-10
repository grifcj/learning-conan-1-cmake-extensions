from conans import ConanFile, python_requires

base = python_requires("conanbase/[*]@grifcj/stable")

class CMakeModulesConanFile(ConanFile):
    name = "cmake_modules"
    version = base.get_version()
    exports_sources = "*.cmake"

    def build(self):
        pass

    def package(self):
        self.copy("*.cmake", "", "")

