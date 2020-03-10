#
#
#


CXXFLAGS =  -std=c++17
compilers = g++-7 g++-8 g++-9 clang++-6.0 clang++-7 clang++-8 clang++-9

test-with-compilers:
	for cxx in $(compilers); do mkdir -p $$cxx ; $(MAKE) compile CXX=$$cxx > $$cxx/output.txt 2>&1; done

compile: h5cpp_e45.cpp
	$(CXX) $(INCLUDES) -o $(CXX)/h5cpp_e45.o  $(CXXFLAGS) -c h5cpp_e45.cpp

test: h5cpp_e45.cpp
	clang++-9 $(INCLUDES) -o h5cpp_e45.o  $(CXXFLAGS) -c h5cpp_e45.cpp

clean:
	@$(RM) *.o h5cpp_e45

.PHONY: test-with-compilers

