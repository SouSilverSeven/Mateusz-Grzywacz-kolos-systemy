#include "manager.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <string.h>

#define NUM_WORKERS 4

// Funkcja tworząca procesy
void manager_create_processes() {
    pid_t pids[NUM_WORKERS];
    const char *names[NUM_WORKERS] = {"Alice", "Bob", "Eve", "Tom"};
    
    for (int i = 0; i < NUM_WORKERS; i++) {
        pid_t pid = fork();
        
        if (pid == 0) {
            // Proces dziecka
            printf("%s: Gotowy do pracy\n", names[i]);

            char input[256];
            while (1) {
                printf("Podaj komendę: ");
                fgets(input, sizeof(input), stdin);

                if (strncmp(input, "Podaj imię", 11) == 0) {
                    printf("My name is %s\n", names[i]);
                } else if (strncmp(input, "PID?", 5) == 0) {
                    printf("%s: My PID is %d\n", names[i], getpid());
                }
            }
            
            exit(0); // zakończenie procesu dziecka
        } else if (pid > 0) {
            pids[i] = pid; // zapisanie pid procesu rodzica
        } else {
            perror("Fork failed");
            exit(1);
        }
    }
    
    // Proces rodzica czeka na zakończenie wszystkich procesów
    for (int i = 0; i < NUM_WORKERS; i++) {
        waitpid(pids[i], NULL, 0);
    }
}

