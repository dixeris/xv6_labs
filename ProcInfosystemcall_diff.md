diff --git a/defs.h b/defs.h
index 1afa245..c725eeb 100644
--- a/defs.h
+++ b/defs.h
@@ -9,6 +9,7 @@ struct spinlock;
 struct sleeplock;
 struct stat;
 struct superblock;
+struct processInfo;
 
 // bio.c
 void            binit(void);
@@ -122,6 +123,9 @@ void            wakeup(void*);
 void            yield(void);
 int		clone(void (*)(void*, void*), void*, void*, void*);
 int		join(void**);
+int		getNumProc(void);
+int		getMaxPid(void);
+int		getProcInfo(int, struct processInfo*);
 
 // swtch.S
 void            swtch(struct context**, struct context*);
diff --git a/proc.c b/proc.c
index 74f2856..68a8235 100644
--- a/proc.c
+++ b/proc.c
@@ -6,6 +6,7 @@
 #include "x86.h"
 #include "proc.h"
 #include "spinlock.h"
+#include "processInfo.h"
 
 struct {
   struct spinlock lock;
@@ -88,6 +89,7 @@ allocproc(void)
 found:
   p->state = EMBRYO;
   p->pid = nextpid++;
+  p->cscnt = 0;
 
   release(&ptable.lock);
 
@@ -342,6 +344,7 @@ scheduler(void)
       c->proc = p;
       switchuvm(p);
       p->state = RUNNING;
+      p->cscnt++;
 
       swtch(&(c->scheduler), p->context);
       switchkvm(); //scheduler context starts from here 
@@ -632,3 +635,49 @@ join(void** stack)
   }
 }
 
+int getNumProc(void) {
+  int n = 0;
+  struct proc *p;
+
+  acquire(&ptable.lock);
+  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
+    if(p->state != UNUSED) n++;
+  }
+
+  release(&ptable.lock);
+  return n;
+}
+
+int getMaxPid(void) {
+  int n = 0;
+  struct proc *p;
+
+  acquire(&ptable.lock);
+  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
+    if(p->state != UNUSED && p->pid > n){
+     n = p->pid;
+    }
+  }
+  release(&ptable.lock);
+  return n;
+}
+
+int getProcInfo(int pid, struct processInfo *pinfo) {
+
+ struct proc *p;
+
+  acquire(&ptable.lock);
+  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
+    if(p->pid == pid){
+      if(pid == 1) pinfo->ppid = 0; //parent pid of the init process is 0 by convention 
+      else  pinfo->ppid = p->parent->pid;
+      pinfo->psize = p->sz;
+      pinfo->numberContextSwitches = p->cscnt;
+      release(&ptable.lock);
+      return 0;
+    }
+  }
+      release(&ptable.lock);
+      return -1;
+  
+}
diff --git a/proc.h b/proc.h
index 02b6abe..f6aa770 100644
--- a/proc.h
+++ b/proc.h
@@ -50,6 +50,7 @@ struct proc {
   struct inode *cwd;           // Current directory
   char name[16];               // Process name (debugging)
   void *usp; 			//user stack pointer 
+  int cscnt;			//number of context switched 
 };
 
 // Process memory is laid out contiguously, low addresses first:
diff --git a/syscall.c b/syscall.c
index e603105..10ea2ae 100644
--- a/syscall.c
+++ b/syscall.c
@@ -107,6 +107,9 @@ extern int sys_mprotect(void);
 extern int sys_munprotect(void);
 extern int sys_clone(void);
 extern int sys_join(void);
+extern int sys_getNumProc(void);
+extern int sys_getMaxPid(void);
+extern int sys_getProcInfo(void);
 
 static int (*syscalls[])(void) = {
 [SYS_fork]    sys_fork,
@@ -134,6 +137,9 @@ static int (*syscalls[])(void) = {
 [SYS_munprotect] sys_munprotect,
 [SYS_clone]	sys_clone,
 [SYS_join]	sys_join,
+[SYS_getNumProc]	sys_getNumProc,
+[SYS_getMaxPid]		sys_getMaxPid,
+[SYS_getProcInfo]	sys_getProcInfo,
 };
 
 void
diff --git a/syscall.h b/syscall.h
index 8771554..2847768 100644
--- a/syscall.h
+++ b/syscall.h
@@ -24,3 +24,6 @@
 #define SYS_munprotect 23
 #define SYS_clone 24
 #define SYS_join 25
+#define SYS_getNumProc 26
+#define SYS_getMaxPid 27
+#define SYS_getProcInfo 28
diff --git a/sysproc.c b/sysproc.c
index 186be57..5480b45 100644
--- a/sysproc.c
+++ b/sysproc.c
@@ -6,6 +6,7 @@
 #include "memlayout.h"
 #include "mmu.h"
 #include "proc.h"
+#include "processInfo.h"
 
 int
 sys_fork(void)
@@ -111,3 +112,22 @@ sys_join(void)
       return -1;
   return join(&stack);
 }
+
+int sys_getNumProc(void)
+{
+  return getNumProc();
+}
+int sys_getMaxPid(void)
+{
+  return getMaxPid();
+}
+
+int sys_getProcInfo(void) {
+  int pid;
+  struct processInfo *pinfo;
+
+  if(argint(0, &pid) < 0 || argptr(1, (void*)&pinfo, sizeof(*pinfo))  < 0 )
+    return -1;
+  
+  return getProcInfo(pid, pinfo);
+}
diff --git a/test.c b/test.c
index e48a89d..cffeec9 100644
--- a/test.c
+++ b/test.c
@@ -1,21 +1,24 @@
 #include "types.h"
 #include "user.h"
+#include "processInfo.h"
 
 
-void thread_func(void* arg1, void* arg2) {
+int main(void) {
+  struct processInfo pinfo;  
+  
+  printf(1,"number of processes = %d\n", getNumProc());
+  int maxpid  = getMaxPid(); 
+  printf(1,"MaxPid among the processes = %d\n", maxpid);
 
-  int pid = getpid();
-printf(1,"child thread pid is %d\n", pid);     
-printf(1,"arg1 = %d, arg2 = %d\n", (int*)arg1, (int*)arg2);
-exit();
-}
+  if(getProcInfo(maxpid,&pinfo) == -1) {
+    printf(1,"Error: maxpid %d not found\n", maxpid);    
+  }
+  printf(1,"cscnt = %d\n", pinfo.numberContextSwitches);
 
-int main(void) {
-  int arg1 = 11;
-  int arg2 = 22;
-  thread_create((void(*)(void*,void*))&thread_func, &arg1, &arg2);
-  thread_join();
-  int pid = getpid();
-  printf(1,"parent pid is %d\n", pid);
+  printf(1,"size = %d\n", pinfo.psize);
+  printf(1,"ppid = %d\n", pinfo.ppid);
+  
+
+  
 }
 
diff --git a/user.h b/user.h
index 81e4890..0977107 100644
--- a/user.h
+++ b/user.h
@@ -1,5 +1,7 @@
+
 struct stat;
 struct rtcdate;
+struct processInfo;
 
 // system calls
 int fork(void);
@@ -27,6 +29,9 @@ int mprotect(void*, int);
 int munprotect(void*, int);
 int clone(void(*)(void*, void*), void*, void*, void*);
 int join(void**);
+int getNumProc(void);
+int getMaxPid(void);
+int getProcInfo(int, struct processInfo*);
 
 // ulib.c
 int stat(const char*, struct stat*);
