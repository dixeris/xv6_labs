#include "types.h"
#include "user.h"


int main(void) {
  uint ret;
  ret = mmap(4096);
  char *addr = (char *) ret;

  addr[0] = 'a';
  printf(1,"addr[0] = %c\n", addr[0]);
}

