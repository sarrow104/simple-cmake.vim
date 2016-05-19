function! g:CMakeSimpleGenerator() " {{{2
	let l:cmake_path = expand("%:p:h")."/CMakeLists.txt"
	if !filereadable(l:cmake_path)
		call writefile(["cmake_minimum_required(VERSION 2.6)",
					\ "add_definitions(-std=c++11)",
					\ "add_definitions(-W -fexceptions -Wunused-variable -Wfatal-errors)",
					\ "",
					\ "set(target_name \"".expand("%:p:h:t")."\")",
					\ "if (\"${CMAKE_BUILD_TYPE}\" STREQUAL \"Release\")",
                    \ "	add_definitions(-DNODEBUG -O2 -s)",
					\ "else()",
					\ "	set(target_name \"${target_name}D\")",
                    \ "	add_definitions(-O0 -g -ggdb)",
					\ "endif()",
                    \ "",
					\ "project(${target_name})",
					\ "set(EXECUTABLE_OUTPUT_PATH \"${CMAKE_SOURCE_DIR}\")",
					\ "#set(LIBRARY_OUTPUT_PATH \"${CMAKE_SOURCE_DIR}\")",
					\ "#file(GLOB_RECURSE SRC \"**/*.cpp\")",
					\ "aux_source_directory(. SRC)",
					\ "add_executable(${target_name} ${SRC})",
                    \ "set(TARGET_OUTPUT_FULL_PATH ${EXECUTABLE_OUTPUT_PATH}/${target_name})",
                    \ "if (\"${CMAKE_BUILD_TYPE}\" STREQUAL \"Release\")",
                    \ "	add_custom_command(",
                    \ "		TARGET ${target_name}",
                    \ "		POST_BUILD",
                    \ "		COMMAND ${CMAKE_STRIP} ${TARGET_OUTPUT_FULL_PATH})",
                    \ "endif()",
					\ "#include_directories(~/extra/sss/include)",
					\ "#link_directories(~/extra/sss/lib/)",
					\ "target_link_libraries(${target_name} sss) # must below the bin target definition!",
					\ ""], l:cmake_path)
	endif

	let l:makefile_path = expand("%:p:h")."/Makefile"
	if !filereadable(l:makefile_path)
		call writefile([".PHONY: all release debug clean install clean-debug clean-release",
					\"",
					\"all: release",
					\"release:",
					\"	@mkdir -p Release",
					\"	cd Release && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=~/bin .. && make",
					\"",
					\"debug:",
					\"	@mkdir -p Debug",
					\"	@cd Debug && cmake -DCMAKE_BUILD_TYPE=Debug .. && make",
					\"",
                    \"install:",
                    \"	@cd Release && make install",
                    \"",
                    \"clean: clean-debug clean-release",
                    \"clean-release:",
                    \"	@if [ -f Release/Makefile ]; then cd Release && make clean; fi",
                    \"	@if [ -d Release ]; then rm -rf Release; fi",
                    \"",
                    \"clean-debug:",
                    \"	@if [ -f Debug/Makefile ]; then cd Debug && make clean; fi",
                    \"	@if [ -d Debug ]; then rm -rf Debug; fi"], l:makefile_path)
	endif

endfunction

command! -nargs=0 GenCMakeSimple     call g:CMakeSimpleGenerator()

