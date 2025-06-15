CC=gcc
CFLAGS=-Wall -g

LIBRARY_MANAGER=libmanager.a
LIBRARY_WORKER=libworker.a
TARGET=projekt

# Ścieżki do katalogów
OBJ_DIR=obj
SRC_DIR=.

# Pliki źródłowe
SRC_MANAGER=$(SRC_DIR)/manager.c
SRC_WORKER=$(SRC_DIR)/worker.c
SRC_MAIN=$(SRC_DIR)/main.c

# Pliki nagłówków
HEADER_MANAGER=$(SRC_DIR)/manager.h
HEADER_WORKER=$(SRC_DIR)/worker.h

# Cele

all: $(TARGET)

# Tworzymy katalog obj, jeśli nie istnieje
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(TARGET): $(LIBRARY_MANAGER) $(LIBRARY_WORKER) $(SRC_MAIN) | $(OBJ_DIR)
	$(CC) $(CFLAGS) $(OBJ_DIR)/manager.o $(OBJ_DIR)/worker.o $(SRC_MAIN) -o $(TARGET)

$(LIBRARY_MANAGER): $(OBJ_DIR)/manager.o
	ar rcs $(LIBRARY_MANAGER) $(OBJ_DIR)/manager.o

$(LIBRARY_WORKER): $(OBJ_DIR)/worker.o
	ar rcs $(LIBRARY_WORKER) $(OBJ_DIR)/worker.o

$(OBJ_DIR)/manager.o: $(SRC_MANAGER) $(HEADER_MANAGER) | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $(SRC_MANAGER) -o $(OBJ_DIR)/manager.o

$(OBJ_DIR)/worker.o: $(SRC_WORKER) $(HEADER_WORKER) | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $(SRC_WORKER) -o $(OBJ_DIR)/worker.o

clean:
	rm -f $(OBJ_DIR)/*.o $(TARGET) $(LIBRARY_MANAGER) $(LIBRARY_WORKER)

