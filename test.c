#include "types.h"
#include "user.h"
#include "processInfo.h"


int main(void) {
  struct processInfo pinfo;  
  
  printf(1,"number of processes = %d\n", getNumProc());
  int maxpid  = getMaxPid(); 
  printf(1,"MaxPid among the processes = %d\n", maxpid);

  if(getProcInfo(maxpid,&pinfo) == -1) {
    printf(1,"Error: maxpid %d not found\n", maxpid);    
  }
  printf(1,"cscnt = %d\n", pinfo.numberContextSwitches);

  printf(1,"size = %d\n", pinfo.psize);
  printf(1,"ppid = %d\n", pinfo.ppid);
  

  
}

