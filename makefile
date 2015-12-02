FILES :=				\
	.gitignore			\
	README.md			\
	RunGraph.cpp		\
	RunGraph.out		\
	graph.h				\
	USA-road-d.NY.gr	\
	LICENSE				\

CXX			:= g++-4.8
CXXFLAGS	:= -pedantic -std=c++11 -Wall
LDFLAGS		:= -pthread
VALGRIND 	:= valgrind

check:
	@not_found=0;                                 \
    for i in $(FILES);                            \
    do                                            \
        if [ -e $$i ];                            \
        then                                      \
            echo "$$i found";                     \
        else                                      \
            echo "$$i NOT FOUND";                 \
            not_found=`expr "$$not_found" + "1"`; \
        fi                                        \
    done;                                         \
    if [ $$not_found -ne 0 ];                     \
    then                                          \
        echo "$$not_found failures";              \
        exit 1;                                   \
    fi;                                           \
    echo "success";

clean:
	rm -f RunGraph.tmp
	rm -f RunGraph

config:
	git config -l

test: RunGraph.tmp

RunGraph: graph.h RunGraph.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) RunGraph.cpp -o RunGraph

RunGraph.tmp: RunGraph
	./RunGraph simple.gr 1 > simple1.tmp
	./RunGraph simple.gr 2 > simple2.tmp
	./RunGraph simple.gr 4 > simple4.tmp
	./RunGraph simple.gr 8 > simple8.tmp
	./RunGraph simple.gr 16 > simple16.tmp
	./RunGraph rometest.gr 1 > rometest1.tmp
	./RunGraph rometest.gr 2 > rometest2.tmp
	./RunGraph rometest.gr 4 > rometest4.tmp
	./RunGraph rometest.gr 8 > rometest8.tmp
	./RunGraph rometest.gr 16 > rometest16.tmp
	./RunGraph USA-road-d.NY.gr 1 > USA-road-d.NY1.tmp
	./RunGraph USA-road-d.NY.gr 2 > USA-road-d.NY2.tmp
	./RunGraph USA-road-d.NY.gr 4 > USA-road-d.NY4.tmp
	./RunGraph USA-road-d.NY.gr 8 > USA-road-d.NY8.tmp
	./RunGraph USA-road-d.NY.gr 16 > USA-road-d.NY16.tmp
#./RunGraph < USA-road-d.NY.gr > RunGraph.tmp 
#diff RunGraph.tmp RunGraph.out
