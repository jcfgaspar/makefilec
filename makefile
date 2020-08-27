# Name of the project
PROJ_NAME=runner

# .c files
C_SOURCE=$(wildcard ./source/*.c)

# .h files
H_SOURCE=$(wildcard ./project/project/*.h)

# Object files
OBJ=$(subst .c,.o,$(subst source,build,$(C_SOURCE)))

# Compiler and linker
CC=gcc

# Flags for compiler
CC_FLAGS=-c         \
         -W         \
         -Wall      \
         -std=c99   \
         -pedantic

# Command used at clean target
RM = rm -rf

#
# Compilation and linking
#
all: objFolder $(PROJ_NAME)

$(PROJ_NAME): $(OBJ)
	@ clear
	@ echo -e
	@ echo 'Building binary using GCC linker: $@'
	$(CC) $^ -o $@
	@ echo 'Construção do binário terminada!: $@'
	@ echo ' '
	@ echo 'Execute o comando: ./$@ ou make run'
	@ echo ' '

./build/%.o: ./source/%.c ./include/project/%.h
	@ echo 'Building target using GCC compiler: $<'
	$(CC) $< $(CC_FLAGS) -o $@
	@ echo ' '

./build/main.o: ./source/main.c $(H_SOURCE)
	@ echo 'Building target using GCC compiler: $<'
	$(CC) $< $(CC_FLAGS) -o $@
	@ echo ' '

objFolder:
	@ mkdir -p build

clean:
	@ $(RM) ./build/*.o $(PROJ_NAME) *~
	@ rmdir build

.PHONY: all clean

run:
	@ make
	@ clear
	@ echo -e
	@ ./runner
	@ echo -e
	@ echo -e

file: 
	@ clear
	@ echo 'Criando arquivo...'
	@ echo 'local: include/project/$$name.h'
	@ echo 'local: source/$$name.c'
	@ touch include/project/$$name.h
	@ touch source/$$name.c
	@ echo -e

remove:
	@ rm include/project/$$name.h
	@ rm source/$$name.c

	