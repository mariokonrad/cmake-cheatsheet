CMAKE_FILES=$(shell find src -name "CMakeLists.txt")
CXX=g++-8

.PHONY: all
all : cmake-cheatsheet.pdf

cmake-cheatsheet.pdf : cmake-cheatsheet.tex $(CMAKE_FILES)


.PHONY: examples
examples : \
	simple_executable \
	static_library \
	shared_library \
	object_library \
	find_package \
	add_test \
	headeronly_library \
	import_library \
	externalproject \
	app_qt5 \
	lib_install \
	package

.PHONY: simple_executable
simple_executable :
	(mkdir -p build/$@ ; cd build/$@ ; cmake -DCMAKE_CXX_COMPILER=$(CXX) ../../src/$@ ; cmake --build .)

.PHONY: static_library
static_library :
	(mkdir -p build/$@ ; cd build/$@ ; cmake -DCMAKE_CXX_COMPILER=$(CXX) ../../src/$@ ; cmake --build .)

.PHONY: shared_library
shared_library :
	(mkdir -p build/$@ ; cd build/$@ ; cmake -DCMAKE_CXX_COMPILER=$(CXX) ../../src/$@ ; cmake --build .)

.PHONY: object_library
object_library :
	(mkdir -p build/$@ ; cd build/$@ ; cmake -DCMAKE_CXX_COMPILER=$(CXX) ../../src/$@ ; cmake --build .)

.PHONY: find_package
find_package :
	(mkdir -p build/$@ ; cd build/$@ ; cmake -DCMAKE_CXX_COMPILER=$(CXX) ../../src/$@ ; cmake --build .)

.PHONY: add_test
add_test :
	(mkdir -p build/$@ ; cd build/$@ ; cmake -DCMAKE_CXX_COMPILER=$(CXX) ../../src/$@ ; cmake --build .)

.PHONY: headeronly_library
headeronly_library :
	(mkdir -p build/$@ ; cd build/$@ ; cmake -DCMAKE_CXX_COMPILER=$(CXX) ../../src/$@ ; cmake --build .)

.PHONY: import_library
import_library :
	(mkdir -p build/$@ ; cd build/$@ ; cmake -DCMAKE_CXX_COMPILER=$(CXX) ../../src/$@ ; cmake --build .)

.PHONY: externalproject
externalproject :
	(mkdir -p build/$@ ; cd build/$@ ; cmake -DCMAKE_CXX_COMPILER=$(CXX) ../../src/$@ ; cmake --build .)

.PHONY: app_qt5
app_qt5 :
	(mkdir -p build/$@ ; cd build/$@ ; cmake -DCMAKE_CXX_COMPILER=$(CXX) ../../src/$@ ; cmake --build .)

.PHONY: lib_install
lib_install :
	(mkdir -p build/$@ ; cd build/$@ ; cmake -DCMAKE_CXX_COMPILER=$(CXX) -DCMAKE_INSTALL_PREFIX=`pwd`/local -B build ../../src/$@ ; cmake --build build ; cmake --build build --target install)

.PHONY: package
package :
	(mkdir -p build/$@ ; cd build/$@ ; cmake -DCMAKE_CXX_COMPILER=$(CXX) ../../src/$@ ; cmake --build . ; cpack -G ZIP)

.PHONY: clean
clean :
	rm -f *.aux
	rm -f *.log
	rm -f *.out
	rm -f *.pdf
	rm -fr build

%.pdf : %.tex
	pdflatex $<
