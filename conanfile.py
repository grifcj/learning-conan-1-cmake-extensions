from conans import ConanFile, python_requires

base = python_requires("conanbase/[*]@grifcj/stable")

class CMakeModulesConanFile(ConanFile):
    name = "cmake-modules"
    version = base.get_version()
    exports_sources = "FindSourcePackage.cmake"

    def package(self):
        self.copy("*.cmake", "", "")

