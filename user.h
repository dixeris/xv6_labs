
struct stat;
struct rtcdate;
struct processInfo;

// system calls
int fork(void);
int exit(void) __attribute__((noreturn));
int wait(void);
int pipe(int*);
int write(int, const void*, int);
int read(int, void*, int);
int close(int);
int kill(int);
int exec(char*, char**);
int open(const char*, int);
int mknod(const char*, short, short);
int unlink(const char*);
int fstat(int fd, struct stat*);
int link(const char*, const char*);
int mkdir(const char*);
int chdir(const char*);
int dup(int);
int getpid(void);
char* sbrk(int);
int sleep(int);
int uptime(void);
int mprotect(void*, int);
int munprotect(void*, int);
int clone(void(*)(void*, void*), void*, void*, void*);
int join(void**);
int getNumProc(void);
int getMaxPid(void);
int getProcInfo(int, struct processInfo*);
int setprio(int);
int  getprio(void);
int welcomeFunction(void (*) (void));
int welcomeDone(void);
int numpp(void);
int numvp(void);
int mmap(int);
// ulib.c
int stat(const char*, struct stat*);
char* strcpy(char*, const char*);
void *memmove(void*, const void*, int);
char* strchr(const char*, char c);
int strcmp(const char*, const char*);
void printf(int, const char*, ...);
char* gets(char*, int max);
uint strlen(const char*);
void* memset(void*, int, uint);
void* malloc(uint);
void free(void*);
int atoi(const char*);
int thread_create(void (*)(void*, void*), void*, void*);
int thread_join(void);

