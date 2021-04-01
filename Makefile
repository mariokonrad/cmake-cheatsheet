CMAKE_FILES=$(shell find src -name "CMakeLists.txt")
CXX=g++

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
	rm -f cmake-*.txt
	rm -f sheet-*.txt

%.pdf : %.tex
	pdflatex $<


# following targets are to list parts of the cheatsheet in order to compare
# them to the cmake help output. Example:
#
# $ make prepare-diff
# $ gvimdiff cmake-module.txt sheet-module.txt
#

list = @grep -E "cmake$(1)$(2)" cmake-cheatsheet.tex \
		| grep -Ev "newcommand" \
		| sed -e 's/^.*cmake$(1)$(2){\(.*\)}.*/\1/' \
		| sort -u

listcmd = @grep -E "cmake$(1)" cmake-cheatsheet.tex \
		| grep -Ev "newcommand" \
		| sed -e 's/^.*cmake$(1){\([a-zA-Z0-9\_]*\)}.*/\1/' \
		| sed -e 's/\\_/_/g' \
		| sort -u

# ignore deprecated commands
cmakelist-command = @cmake --help-command-list \
		| sort -u \
		| grep -Ev "\<(build_name|exec_program|export_library_dependencies|install_files|install_programs|install_targets|load_command|make_directory|output_required_files|remove|subdir_depends|subdirs|use_mangled_mesa|utility_source|variable_requires|write_file)\>"

# ignore deprecated modules
cmakelist-module = @cmake --help-module-list \
		| sort -u \
		| grep -Ev "\<(CPackArchive|CPackBundle|CPackCygwin|CPackDeb|CPackDMG|CPackFreeBSD|CPackNSIS|CPackNuGet|CPackPackageMaker|CPackProductBuild|CPackRPM|CPackWIX)\>"

# ignore deprecated properties
cmakelist-property = @cmake --help-property-list \
		| sort -u \
		| grep -Ev "\<COMPILE_DEFINITIONS_<CONFIG>|\<(TEST_INCLUDE_FILE|POST_INSTALL_SCRIPT|PRE_INSTALL_SCRIPT)\>"

cmakelist-variable = @cmake --help-variable-list \
		| sort -u

prepare-diff :
	@$(call cmakelist-command)  > cmake-command.txt
	@$(call cmakelist-module)   > cmake-module.txt
	@$(call cmakelist-property) > cmake-property.txt
	@$(call cmakelist-variable) > cmake-variable.txt

	@$(call listcmd,command)          >  sheet-command.txt
	@$(call list,module)              >  sheet-module.txt
	@$(call list,prop,gbl)            >  sheet-property.tmp.txt
	@$(call list,prop,dir)            >> sheet-property.tmp.txt
	@$(call list,prop,sourcefiles)    >> sheet-property.tmp.txt
	@$(call list,prop,cache)          >> sheet-property.tmp.txt
	@$(call list,prop,installedfiles) >> sheet-property.tmp.txt
	@$(call list,prop,target)         >> sheet-property.tmp.txt
	@$(call list,prop,test)           >> sheet-property.tmp.txt
	@sort -u sheet-property.tmp.txt   >  sheet-property.txt
	@rm sheet-property.tmp.txt
	@$(call list,variable)            >  sheet-variable.txt

	@-diff cmake-command.txt  sheet-command.txt  1>/dev/null && rm cmake-command.txt  sheet-command.txt  ; true
	@-diff cmake-module.txt   sheet-module.txt   1>/dev/null && rm cmake-module.txt   sheet-module.txt   ; true
	@-diff cmake-property.txt sheet-property.txt 1>/dev/null && rm cmake-property.txt sheet-property.txt ; true
	@-diff cmake-variable.txt sheet-variable.txt 1>/dev/null && rm cmake-variable.txt sheet-variable.txt ; true

