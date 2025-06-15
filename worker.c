#include "worker.h"
#include <stdio.h>
#include <signal.h>
#include <unistd.h>

void worker_handle_signals() {
    signal(SIGHUP, [](int signum) {
        printf("Odpoczywam\n");
    });
    
    signal(SIGUSR1, [](int signum) {
        printf("Startuję!\n");
    });
    
    signal(SIGINT, [](int signum) {
        printf("Kończę\n");
        exit(0);
    });
}

