#include "types.h"
#include "user.h"


void thread_func(void* arg1, void* arg2) {

  int pid = getpid();
printf(1,"child thread pid is %d\n", pid);     
printf(1,"arg1 = %d, arg2 = %d\n", (int*)arg1, (int*)arg2);
exit();
}

int main(void) {
  int arg1 = 11;
  int arg2 = 22;
  thread_create((void(*)(void*,void*))&thread_func, &arg1, &arg2);
  thread_join();
  int pid = getpid();
  printf(1,"parent pid is %d\n", pid);
}

