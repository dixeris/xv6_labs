
_zombie:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	51                   	push   %ecx
    100e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
    1011:	e8 db 02 00 00       	call   12f1 <fork>
    1016:	85 c0                	test   %eax,%eax
    1018:	7e 0d                	jle    1027 <main+0x27>
    sleep(5);  // Let child exit before parent.
    101a:	83 ec 0c             	sub    $0xc,%esp
    101d:	6a 05                	push   $0x5
    101f:	e8 65 03 00 00       	call   1389 <sleep>
    1024:	83 c4 10             	add    $0x10,%esp
  exit();
    1027:	e8 cd 02 00 00       	call   12f9 <exit>
    102c:	66 90                	xchg   %ax,%ax
    102e:	66 90                	xchg   %ax,%ax

00001030 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"
char*
strcpy(char *s, const char *t)
{
    1030:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1031:	31 c0                	xor    %eax,%eax
{
    1033:	89 e5                	mov    %esp,%ebp
    1035:	53                   	push   %ebx
    1036:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1039:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    1040:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    1044:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    1047:	83 c0 01             	add    $0x1,%eax
    104a:	84 d2                	test   %dl,%dl
    104c:	75 f2                	jne    1040 <strcpy+0x10>
    ;
  return os;
}
    104e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1051:	89 c8                	mov    %ecx,%eax
    1053:	c9                   	leave  
    1054:	c3                   	ret    
    1055:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    105c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1060:	55                   	push   %ebp
    1061:	89 e5                	mov    %esp,%ebp
    1063:	53                   	push   %ebx
    1064:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1067:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    106a:	0f b6 01             	movzbl (%ecx),%eax
    106d:	0f b6 1a             	movzbl (%edx),%ebx
    1070:	84 c0                	test   %al,%al
    1072:	75 1d                	jne    1091 <strcmp+0x31>
    1074:	eb 2a                	jmp    10a0 <strcmp+0x40>
    1076:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    107d:	8d 76 00             	lea    0x0(%esi),%esi
    1080:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    1084:	83 c1 01             	add    $0x1,%ecx
    1087:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    108a:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    108d:	84 c0                	test   %al,%al
    108f:	74 0f                	je     10a0 <strcmp+0x40>
    1091:	38 d8                	cmp    %bl,%al
    1093:	74 eb                	je     1080 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1095:	29 d8                	sub    %ebx,%eax
}
    1097:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    109a:	c9                   	leave  
    109b:	c3                   	ret    
    109c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    10a2:	29 d8                	sub    %ebx,%eax
}
    10a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10a7:	c9                   	leave  
    10a8:	c3                   	ret    
    10a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000010b0 <strlen>:

uint
strlen(const char *s)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    10b6:	80 3a 00             	cmpb   $0x0,(%edx)
    10b9:	74 15                	je     10d0 <strlen+0x20>
    10bb:	31 c0                	xor    %eax,%eax
    10bd:	8d 76 00             	lea    0x0(%esi),%esi
    10c0:	83 c0 01             	add    $0x1,%eax
    10c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    10c7:	89 c1                	mov    %eax,%ecx
    10c9:	75 f5                	jne    10c0 <strlen+0x10>
    ;
  return n;
}
    10cb:	89 c8                	mov    %ecx,%eax
    10cd:	5d                   	pop    %ebp
    10ce:	c3                   	ret    
    10cf:	90                   	nop
  for(n = 0; s[n]; n++)
    10d0:	31 c9                	xor    %ecx,%ecx
}
    10d2:	5d                   	pop    %ebp
    10d3:	89 c8                	mov    %ecx,%eax
    10d5:	c3                   	ret    
    10d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10dd:	8d 76 00             	lea    0x0(%esi),%esi

000010e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	57                   	push   %edi
    10e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ed:	89 d7                	mov    %edx,%edi
    10ef:	fc                   	cld    
    10f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10f2:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10f5:	89 d0                	mov    %edx,%eax
    10f7:	c9                   	leave  
    10f8:	c3                   	ret    
    10f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001100 <strchr>:

char*
strchr(const char *s, char c)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	8b 45 08             	mov    0x8(%ebp),%eax
    1106:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    110a:	0f b6 10             	movzbl (%eax),%edx
    110d:	84 d2                	test   %dl,%dl
    110f:	75 12                	jne    1123 <strchr+0x23>
    1111:	eb 1d                	jmp    1130 <strchr+0x30>
    1113:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1117:	90                   	nop
    1118:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    111c:	83 c0 01             	add    $0x1,%eax
    111f:	84 d2                	test   %dl,%dl
    1121:	74 0d                	je     1130 <strchr+0x30>
    if(*s == c)
    1123:	38 d1                	cmp    %dl,%cl
    1125:	75 f1                	jne    1118 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1127:	5d                   	pop    %ebp
    1128:	c3                   	ret    
    1129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    1130:	31 c0                	xor    %eax,%eax
}
    1132:	5d                   	pop    %ebp
    1133:	c3                   	ret    
    1134:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    113b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    113f:	90                   	nop

00001140 <gets>:

char*
gets(char *buf, int max)
{
    1140:	55                   	push   %ebp
    1141:	89 e5                	mov    %esp,%ebp
    1143:	57                   	push   %edi
    1144:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1145:	31 f6                	xor    %esi,%esi
{
    1147:	53                   	push   %ebx
    1148:	89 f3                	mov    %esi,%ebx
    114a:	83 ec 1c             	sub    $0x1c,%esp
    114d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1150:	eb 2f                	jmp    1181 <gets+0x41>
    1152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1158:	83 ec 04             	sub    $0x4,%esp
    115b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    115e:	6a 01                	push   $0x1
    1160:	50                   	push   %eax
    1161:	6a 00                	push   $0x0
    1163:	e8 a9 01 00 00       	call   1311 <read>
    if(cc < 1)
    1168:	83 c4 10             	add    $0x10,%esp
    116b:	85 c0                	test   %eax,%eax
    116d:	7e 1c                	jle    118b <gets+0x4b>
      break;
    buf[i++] = c;
    116f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    1173:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    1176:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1179:	3c 0a                	cmp    $0xa,%al
    117b:	74 23                	je     11a0 <gets+0x60>
    117d:	3c 0d                	cmp    $0xd,%al
    117f:	74 1f                	je     11a0 <gets+0x60>
  for(i=0; i+1 < max; ){
    1181:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    1184:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    1186:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1189:	7c cd                	jl     1158 <gets+0x18>
    118b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    118d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1190:	c6 03 00             	movb   $0x0,(%ebx)
}
    1193:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1196:	5b                   	pop    %ebx
    1197:	5e                   	pop    %esi
    1198:	5f                   	pop    %edi
    1199:	5d                   	pop    %ebp
    119a:	c3                   	ret    
    119b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    119f:	90                   	nop
  buf[i] = '\0';
    11a0:	8b 75 08             	mov    0x8(%ebp),%esi
}
    11a3:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    11a6:	01 de                	add    %ebx,%esi
    11a8:	89 f3                	mov    %esi,%ebx
    11aa:	c6 03 00             	movb   $0x0,(%ebx)
}
    11ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11b0:	5b                   	pop    %ebx
    11b1:	5e                   	pop    %esi
    11b2:	5f                   	pop    %edi
    11b3:	5d                   	pop    %ebp
    11b4:	c3                   	ret    
    11b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000011c0 <stat>:

int
stat(const char *n, struct stat *st)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	56                   	push   %esi
    11c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11c5:	83 ec 08             	sub    $0x8,%esp
    11c8:	6a 00                	push   $0x0
    11ca:	ff 75 08             	pushl  0x8(%ebp)
    11cd:	e8 67 01 00 00       	call   1339 <open>
  if(fd < 0)
    11d2:	83 c4 10             	add    $0x10,%esp
    11d5:	85 c0                	test   %eax,%eax
    11d7:	78 27                	js     1200 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    11d9:	83 ec 08             	sub    $0x8,%esp
    11dc:	ff 75 0c             	pushl  0xc(%ebp)
    11df:	89 c3                	mov    %eax,%ebx
    11e1:	50                   	push   %eax
    11e2:	e8 6a 01 00 00       	call   1351 <fstat>
  close(fd);
    11e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    11ea:	89 c6                	mov    %eax,%esi
  close(fd);
    11ec:	e8 30 01 00 00       	call   1321 <close>
  return r;
    11f1:	83 c4 10             	add    $0x10,%esp
}
    11f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11f7:	89 f0                	mov    %esi,%eax
    11f9:	5b                   	pop    %ebx
    11fa:	5e                   	pop    %esi
    11fb:	5d                   	pop    %ebp
    11fc:	c3                   	ret    
    11fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1200:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1205:	eb ed                	jmp    11f4 <stat+0x34>
    1207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    120e:	66 90                	xchg   %ax,%ax

00001210 <atoi>:

int
atoi(const char *s)
{
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	53                   	push   %ebx
    1214:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1217:	0f be 02             	movsbl (%edx),%eax
    121a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    121d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1220:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1225:	77 1e                	ja     1245 <atoi+0x35>
    1227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    122e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    1230:	83 c2 01             	add    $0x1,%edx
    1233:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1236:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    123a:	0f be 02             	movsbl (%edx),%eax
    123d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1240:	80 fb 09             	cmp    $0x9,%bl
    1243:	76 eb                	jbe    1230 <atoi+0x20>
  return n;
}
    1245:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1248:	89 c8                	mov    %ecx,%eax
    124a:	c9                   	leave  
    124b:	c3                   	ret    
    124c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001250 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	57                   	push   %edi
    1254:	8b 45 10             	mov    0x10(%ebp),%eax
    1257:	8b 55 08             	mov    0x8(%ebp),%edx
    125a:	56                   	push   %esi
    125b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    125e:	85 c0                	test   %eax,%eax
    1260:	7e 13                	jle    1275 <memmove+0x25>
    1262:	01 d0                	add    %edx,%eax
  dst = vdst;
    1264:	89 d7                	mov    %edx,%edi
    1266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    126d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    1270:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    1271:	39 f8                	cmp    %edi,%eax
    1273:	75 fb                	jne    1270 <memmove+0x20>
  return vdst;
}
    1275:	5e                   	pop    %esi
    1276:	89 d0                	mov    %edx,%eax
    1278:	5f                   	pop    %edi
    1279:	5d                   	pop    %ebp
    127a:	c3                   	ret    
    127b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    127f:	90                   	nop

00001280 <thread_create>:


int thread_create(void (*start_routine)(void*, void*), void *arg1, void *arg2) {
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	53                   	push   %ebx
    1284:	83 ec 20             	sub    $0x20,%esp
  void *stack =  malloc(4096);
    1287:	68 00 10 00 00       	push   $0x1000
    128c:	e8 3f 04 00 00       	call   16d0 <malloc>
  if(stack == 0)
    1291:	83 c4 10             	add    $0x10,%esp
    1294:	85 c0                	test   %eax,%eax
    1296:	74 3f                	je     12d7 <thread_create+0x57>
    return -1;
  int r= clone(start_routine, arg1, arg2, stack);
    1298:	50                   	push   %eax
    1299:	89 c3                	mov    %eax,%ebx
    129b:	ff 75 10             	pushl  0x10(%ebp)
    129e:	ff 75 0c             	pushl  0xc(%ebp)
    12a1:	ff 75 08             	pushl  0x8(%ebp)
    12a4:	e8 00 01 00 00       	call   13a9 <clone>
  if(r==-1) 
    12a9:	83 c4 10             	add    $0x10,%esp
    12ac:	83 f8 ff             	cmp    $0xffffffff,%eax
    12af:	74 0f                	je     12c0 <thread_create+0x40>
    free(stack);
  return r;
}
    12b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12b4:	c9                   	leave  
    12b5:	c3                   	ret    
    12b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12bd:	8d 76 00             	lea    0x0(%esi),%esi
    free(stack);
    12c0:	83 ec 0c             	sub    $0xc,%esp
    12c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12c6:	53                   	push   %ebx
    12c7:	e8 74 03 00 00       	call   1640 <free>
    12cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    12cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    free(stack);
    12d2:	83 c4 10             	add    $0x10,%esp
}
    12d5:	c9                   	leave  
    12d6:	c3                   	ret    
    return -1;
    12d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12dc:	eb d3                	jmp    12b1 <thread_create+0x31>
    12de:	66 90                	xchg   %ax,%ax

000012e0 <thread_join>:


int thread_join(void) {
    12e0:	55                   	push   %ebp
    12e1:	89 e5                	mov    %esp,%ebp
    12e3:	83 ec 24             	sub    $0x24,%esp
  void *stack;
  int r = join(&stack);
    12e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
    12e9:	50                   	push   %eax
    12ea:	e8 c2 00 00 00       	call   13b1 <join>
  return r;
}
    12ef:	c9                   	leave  
    12f0:	c3                   	ret    

000012f1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12f1:	b8 01 00 00 00       	mov    $0x1,%eax
    12f6:	cd 40                	int    $0x40
    12f8:	c3                   	ret    

000012f9 <exit>:
SYSCALL(exit)
    12f9:	b8 02 00 00 00       	mov    $0x2,%eax
    12fe:	cd 40                	int    $0x40
    1300:	c3                   	ret    

00001301 <wait>:
SYSCALL(wait)
    1301:	b8 03 00 00 00       	mov    $0x3,%eax
    1306:	cd 40                	int    $0x40
    1308:	c3                   	ret    

00001309 <pipe>:
SYSCALL(pipe)
    1309:	b8 04 00 00 00       	mov    $0x4,%eax
    130e:	cd 40                	int    $0x40
    1310:	c3                   	ret    

00001311 <read>:
SYSCALL(read)
    1311:	b8 05 00 00 00       	mov    $0x5,%eax
    1316:	cd 40                	int    $0x40
    1318:	c3                   	ret    

00001319 <write>:
SYSCALL(write)
    1319:	b8 10 00 00 00       	mov    $0x10,%eax
    131e:	cd 40                	int    $0x40
    1320:	c3                   	ret    

00001321 <close>:
SYSCALL(close)
    1321:	b8 15 00 00 00       	mov    $0x15,%eax
    1326:	cd 40                	int    $0x40
    1328:	c3                   	ret    

00001329 <kill>:
SYSCALL(kill)
    1329:	b8 06 00 00 00       	mov    $0x6,%eax
    132e:	cd 40                	int    $0x40
    1330:	c3                   	ret    

00001331 <exec>:
SYSCALL(exec)
    1331:	b8 07 00 00 00       	mov    $0x7,%eax
    1336:	cd 40                	int    $0x40
    1338:	c3                   	ret    

00001339 <open>:
SYSCALL(open)
    1339:	b8 0f 00 00 00       	mov    $0xf,%eax
    133e:	cd 40                	int    $0x40
    1340:	c3                   	ret    

00001341 <mknod>:
SYSCALL(mknod)
    1341:	b8 11 00 00 00       	mov    $0x11,%eax
    1346:	cd 40                	int    $0x40
    1348:	c3                   	ret    

00001349 <unlink>:
SYSCALL(unlink)
    1349:	b8 12 00 00 00       	mov    $0x12,%eax
    134e:	cd 40                	int    $0x40
    1350:	c3                   	ret    

00001351 <fstat>:
SYSCALL(fstat)
    1351:	b8 08 00 00 00       	mov    $0x8,%eax
    1356:	cd 40                	int    $0x40
    1358:	c3                   	ret    

00001359 <link>:
SYSCALL(link)
    1359:	b8 13 00 00 00       	mov    $0x13,%eax
    135e:	cd 40                	int    $0x40
    1360:	c3                   	ret    

00001361 <mkdir>:
SYSCALL(mkdir)
    1361:	b8 14 00 00 00       	mov    $0x14,%eax
    1366:	cd 40                	int    $0x40
    1368:	c3                   	ret    

00001369 <chdir>:
SYSCALL(chdir)
    1369:	b8 09 00 00 00       	mov    $0x9,%eax
    136e:	cd 40                	int    $0x40
    1370:	c3                   	ret    

00001371 <dup>:
SYSCALL(dup)
    1371:	b8 0a 00 00 00       	mov    $0xa,%eax
    1376:	cd 40                	int    $0x40
    1378:	c3                   	ret    

00001379 <getpid>:
SYSCALL(getpid)
    1379:	b8 0b 00 00 00       	mov    $0xb,%eax
    137e:	cd 40                	int    $0x40
    1380:	c3                   	ret    

00001381 <sbrk>:
SYSCALL(sbrk)
    1381:	b8 0c 00 00 00       	mov    $0xc,%eax
    1386:	cd 40                	int    $0x40
    1388:	c3                   	ret    

00001389 <sleep>:
SYSCALL(sleep)
    1389:	b8 0d 00 00 00       	mov    $0xd,%eax
    138e:	cd 40                	int    $0x40
    1390:	c3                   	ret    

00001391 <uptime>:
SYSCALL(uptime)
    1391:	b8 0e 00 00 00       	mov    $0xe,%eax
    1396:	cd 40                	int    $0x40
    1398:	c3                   	ret    

00001399 <mprotect>:
SYSCALL(mprotect)
    1399:	b8 16 00 00 00       	mov    $0x16,%eax
    139e:	cd 40                	int    $0x40
    13a0:	c3                   	ret    

000013a1 <munprotect>:
SYSCALL(munprotect)
    13a1:	b8 17 00 00 00       	mov    $0x17,%eax
    13a6:	cd 40                	int    $0x40
    13a8:	c3                   	ret    

000013a9 <clone>:
SYSCALL(clone)
    13a9:	b8 18 00 00 00       	mov    $0x18,%eax
    13ae:	cd 40                	int    $0x40
    13b0:	c3                   	ret    

000013b1 <join>:
SYSCALL(join)
    13b1:	b8 19 00 00 00       	mov    $0x19,%eax
    13b6:	cd 40                	int    $0x40
    13b8:	c3                   	ret    
    13b9:	66 90                	xchg   %ax,%ax
    13bb:	66 90                	xchg   %ax,%ax
    13bd:	66 90                	xchg   %ax,%ax
    13bf:	90                   	nop

000013c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    13c0:	55                   	push   %ebp
    13c1:	89 e5                	mov    %esp,%ebp
    13c3:	57                   	push   %edi
    13c4:	56                   	push   %esi
    13c5:	53                   	push   %ebx
    13c6:	83 ec 3c             	sub    $0x3c,%esp
    13c9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    13cc:	89 d1                	mov    %edx,%ecx
{
    13ce:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    13d1:	85 d2                	test   %edx,%edx
    13d3:	0f 89 7f 00 00 00    	jns    1458 <printint+0x98>
    13d9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    13dd:	74 79                	je     1458 <printint+0x98>
    neg = 1;
    13df:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    13e6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    13e8:	31 db                	xor    %ebx,%ebx
    13ea:	8d 75 d7             	lea    -0x29(%ebp),%esi
    13ed:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    13f0:	89 c8                	mov    %ecx,%eax
    13f2:	31 d2                	xor    %edx,%edx
    13f4:	89 cf                	mov    %ecx,%edi
    13f6:	f7 75 c4             	divl   -0x3c(%ebp)
    13f9:	0f b6 92 e0 17 00 00 	movzbl 0x17e0(%edx),%edx
    1400:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1403:	89 d8                	mov    %ebx,%eax
    1405:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1408:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    140b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    140e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1411:	76 dd                	jbe    13f0 <printint+0x30>
  if(neg)
    1413:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1416:	85 c9                	test   %ecx,%ecx
    1418:	74 0c                	je     1426 <printint+0x66>
    buf[i++] = '-';
    141a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    141f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1421:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1426:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1429:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    142d:	eb 07                	jmp    1436 <printint+0x76>
    142f:	90                   	nop
    putc(fd, buf[i]);
    1430:	0f b6 13             	movzbl (%ebx),%edx
    1433:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1436:	83 ec 04             	sub    $0x4,%esp
    1439:	88 55 d7             	mov    %dl,-0x29(%ebp)
    143c:	6a 01                	push   $0x1
    143e:	56                   	push   %esi
    143f:	57                   	push   %edi
    1440:	e8 d4 fe ff ff       	call   1319 <write>
  while(--i >= 0)
    1445:	83 c4 10             	add    $0x10,%esp
    1448:	39 de                	cmp    %ebx,%esi
    144a:	75 e4                	jne    1430 <printint+0x70>
}
    144c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    144f:	5b                   	pop    %ebx
    1450:	5e                   	pop    %esi
    1451:	5f                   	pop    %edi
    1452:	5d                   	pop    %ebp
    1453:	c3                   	ret    
    1454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1458:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    145f:	eb 87                	jmp    13e8 <printint+0x28>
    1461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1468:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    146f:	90                   	nop

00001470 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1470:	55                   	push   %ebp
    1471:	89 e5                	mov    %esp,%ebp
    1473:	57                   	push   %edi
    1474:	56                   	push   %esi
    1475:	53                   	push   %ebx
    1476:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1479:	8b 75 0c             	mov    0xc(%ebp),%esi
    147c:	0f b6 1e             	movzbl (%esi),%ebx
    147f:	84 db                	test   %bl,%bl
    1481:	0f 84 b8 00 00 00    	je     153f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    1487:	8d 45 10             	lea    0x10(%ebp),%eax
    148a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    148d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    1490:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    1492:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1495:	eb 37                	jmp    14ce <printf+0x5e>
    1497:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    149e:	66 90                	xchg   %ax,%ax
    14a0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    14a3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    14a8:	83 f8 25             	cmp    $0x25,%eax
    14ab:	74 17                	je     14c4 <printf+0x54>
  write(fd, &c, 1);
    14ad:	83 ec 04             	sub    $0x4,%esp
    14b0:	88 5d e7             	mov    %bl,-0x19(%ebp)
    14b3:	6a 01                	push   $0x1
    14b5:	57                   	push   %edi
    14b6:	ff 75 08             	pushl  0x8(%ebp)
    14b9:	e8 5b fe ff ff       	call   1319 <write>
    14be:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    14c1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    14c4:	0f b6 1e             	movzbl (%esi),%ebx
    14c7:	83 c6 01             	add    $0x1,%esi
    14ca:	84 db                	test   %bl,%bl
    14cc:	74 71                	je     153f <printf+0xcf>
    c = fmt[i] & 0xff;
    14ce:	0f be cb             	movsbl %bl,%ecx
    14d1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    14d4:	85 d2                	test   %edx,%edx
    14d6:	74 c8                	je     14a0 <printf+0x30>
      }
    } else if(state == '%'){
    14d8:	83 fa 25             	cmp    $0x25,%edx
    14db:	75 e7                	jne    14c4 <printf+0x54>
      if(c == 'd'){
    14dd:	83 f8 64             	cmp    $0x64,%eax
    14e0:	0f 84 9a 00 00 00    	je     1580 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    14e6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    14ec:	83 f9 70             	cmp    $0x70,%ecx
    14ef:	74 5f                	je     1550 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    14f1:	83 f8 73             	cmp    $0x73,%eax
    14f4:	0f 84 d6 00 00 00    	je     15d0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    14fa:	83 f8 63             	cmp    $0x63,%eax
    14fd:	0f 84 8d 00 00 00    	je     1590 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1503:	83 f8 25             	cmp    $0x25,%eax
    1506:	0f 84 b4 00 00 00    	je     15c0 <printf+0x150>
  write(fd, &c, 1);
    150c:	83 ec 04             	sub    $0x4,%esp
    150f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1513:	6a 01                	push   $0x1
    1515:	57                   	push   %edi
    1516:	ff 75 08             	pushl  0x8(%ebp)
    1519:	e8 fb fd ff ff       	call   1319 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    151e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1521:	83 c4 0c             	add    $0xc,%esp
    1524:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1526:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1529:	57                   	push   %edi
    152a:	ff 75 08             	pushl  0x8(%ebp)
    152d:	e8 e7 fd ff ff       	call   1319 <write>
  for(i = 0; fmt[i]; i++){
    1532:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    1536:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1539:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    153b:	84 db                	test   %bl,%bl
    153d:	75 8f                	jne    14ce <printf+0x5e>
    }
  }
}
    153f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1542:	5b                   	pop    %ebx
    1543:	5e                   	pop    %esi
    1544:	5f                   	pop    %edi
    1545:	5d                   	pop    %ebp
    1546:	c3                   	ret    
    1547:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    154e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    1550:	83 ec 0c             	sub    $0xc,%esp
    1553:	b9 10 00 00 00       	mov    $0x10,%ecx
    1558:	6a 00                	push   $0x0
    155a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    155d:	8b 45 08             	mov    0x8(%ebp),%eax
    1560:	8b 13                	mov    (%ebx),%edx
    1562:	e8 59 fe ff ff       	call   13c0 <printint>
        ap++;
    1567:	89 d8                	mov    %ebx,%eax
    1569:	83 c4 10             	add    $0x10,%esp
      state = 0;
    156c:	31 d2                	xor    %edx,%edx
        ap++;
    156e:	83 c0 04             	add    $0x4,%eax
    1571:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1574:	e9 4b ff ff ff       	jmp    14c4 <printf+0x54>
    1579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    1580:	83 ec 0c             	sub    $0xc,%esp
    1583:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1588:	6a 01                	push   $0x1
    158a:	eb ce                	jmp    155a <printf+0xea>
    158c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1590:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1593:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1596:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    1598:	6a 01                	push   $0x1
        ap++;
    159a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    159d:	57                   	push   %edi
    159e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    15a1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    15a4:	e8 70 fd ff ff       	call   1319 <write>
        ap++;
    15a9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    15ac:	83 c4 10             	add    $0x10,%esp
      state = 0;
    15af:	31 d2                	xor    %edx,%edx
    15b1:	e9 0e ff ff ff       	jmp    14c4 <printf+0x54>
    15b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15bd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    15c0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    15c3:	83 ec 04             	sub    $0x4,%esp
    15c6:	e9 59 ff ff ff       	jmp    1524 <printf+0xb4>
    15cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    15cf:	90                   	nop
        s = (char*)*ap;
    15d0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    15d3:	8b 18                	mov    (%eax),%ebx
        ap++;
    15d5:	83 c0 04             	add    $0x4,%eax
    15d8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    15db:	85 db                	test   %ebx,%ebx
    15dd:	74 17                	je     15f6 <printf+0x186>
        while(*s != 0){
    15df:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    15e2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    15e4:	84 c0                	test   %al,%al
    15e6:	0f 84 d8 fe ff ff    	je     14c4 <printf+0x54>
    15ec:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    15ef:	89 de                	mov    %ebx,%esi
    15f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
    15f4:	eb 1a                	jmp    1610 <printf+0x1a0>
          s = "(null)";
    15f6:	bb d8 17 00 00       	mov    $0x17d8,%ebx
        while(*s != 0){
    15fb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    15fe:	b8 28 00 00 00       	mov    $0x28,%eax
    1603:	89 de                	mov    %ebx,%esi
    1605:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1608:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    160f:	90                   	nop
  write(fd, &c, 1);
    1610:	83 ec 04             	sub    $0x4,%esp
          s++;
    1613:	83 c6 01             	add    $0x1,%esi
    1616:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1619:	6a 01                	push   $0x1
    161b:	57                   	push   %edi
    161c:	53                   	push   %ebx
    161d:	e8 f7 fc ff ff       	call   1319 <write>
        while(*s != 0){
    1622:	0f b6 06             	movzbl (%esi),%eax
    1625:	83 c4 10             	add    $0x10,%esp
    1628:	84 c0                	test   %al,%al
    162a:	75 e4                	jne    1610 <printf+0x1a0>
      state = 0;
    162c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    162f:	31 d2                	xor    %edx,%edx
    1631:	e9 8e fe ff ff       	jmp    14c4 <printf+0x54>
    1636:	66 90                	xchg   %ax,%ax
    1638:	66 90                	xchg   %ax,%ax
    163a:	66 90                	xchg   %ax,%ax
    163c:	66 90                	xchg   %ax,%ax
    163e:	66 90                	xchg   %ax,%ax

00001640 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1640:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1641:	a1 d4 1a 00 00       	mov    0x1ad4,%eax
{
    1646:	89 e5                	mov    %esp,%ebp
    1648:	57                   	push   %edi
    1649:	56                   	push   %esi
    164a:	53                   	push   %ebx
    164b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    164e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1658:	89 c2                	mov    %eax,%edx
    165a:	8b 00                	mov    (%eax),%eax
    165c:	39 ca                	cmp    %ecx,%edx
    165e:	73 30                	jae    1690 <free+0x50>
    1660:	39 c1                	cmp    %eax,%ecx
    1662:	72 04                	jb     1668 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1664:	39 c2                	cmp    %eax,%edx
    1666:	72 f0                	jb     1658 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1668:	8b 73 fc             	mov    -0x4(%ebx),%esi
    166b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    166e:	39 f8                	cmp    %edi,%eax
    1670:	74 30                	je     16a2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1672:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    1675:	8b 42 04             	mov    0x4(%edx),%eax
    1678:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    167b:	39 f1                	cmp    %esi,%ecx
    167d:	74 3a                	je     16b9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    167f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    1681:	5b                   	pop    %ebx
  freep = p;
    1682:	89 15 d4 1a 00 00    	mov    %edx,0x1ad4
}
    1688:	5e                   	pop    %esi
    1689:	5f                   	pop    %edi
    168a:	5d                   	pop    %ebp
    168b:	c3                   	ret    
    168c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1690:	39 c2                	cmp    %eax,%edx
    1692:	72 c4                	jb     1658 <free+0x18>
    1694:	39 c1                	cmp    %eax,%ecx
    1696:	73 c0                	jae    1658 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1698:	8b 73 fc             	mov    -0x4(%ebx),%esi
    169b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    169e:	39 f8                	cmp    %edi,%eax
    16a0:	75 d0                	jne    1672 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    16a2:	03 70 04             	add    0x4(%eax),%esi
    16a5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    16a8:	8b 02                	mov    (%edx),%eax
    16aa:	8b 00                	mov    (%eax),%eax
    16ac:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    16af:	8b 42 04             	mov    0x4(%edx),%eax
    16b2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    16b5:	39 f1                	cmp    %esi,%ecx
    16b7:	75 c6                	jne    167f <free+0x3f>
    p->s.size += bp->s.size;
    16b9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    16bc:	89 15 d4 1a 00 00    	mov    %edx,0x1ad4
    p->s.size += bp->s.size;
    16c2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    16c5:	8b 43 f8             	mov    -0x8(%ebx),%eax
    16c8:	89 02                	mov    %eax,(%edx)
}
    16ca:	5b                   	pop    %ebx
    16cb:	5e                   	pop    %esi
    16cc:	5f                   	pop    %edi
    16cd:	5d                   	pop    %ebp
    16ce:	c3                   	ret    
    16cf:	90                   	nop

000016d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    16d0:	55                   	push   %ebp
    16d1:	89 e5                	mov    %esp,%ebp
    16d3:	57                   	push   %edi
    16d4:	56                   	push   %esi
    16d5:	53                   	push   %ebx
    16d6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    16dc:	8b 3d d4 1a 00 00    	mov    0x1ad4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16e2:	8d 70 07             	lea    0x7(%eax),%esi
    16e5:	c1 ee 03             	shr    $0x3,%esi
    16e8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    16eb:	85 ff                	test   %edi,%edi
    16ed:	0f 84 ad 00 00 00    	je     17a0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16f3:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    16f5:	8b 48 04             	mov    0x4(%eax),%ecx
    16f8:	39 f1                	cmp    %esi,%ecx
    16fa:	73 71                	jae    176d <malloc+0x9d>
    16fc:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1702:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1707:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    170a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1711:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1714:	eb 1b                	jmp    1731 <malloc+0x61>
    1716:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    171d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1720:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1722:	8b 4a 04             	mov    0x4(%edx),%ecx
    1725:	39 f1                	cmp    %esi,%ecx
    1727:	73 4f                	jae    1778 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1729:	8b 3d d4 1a 00 00    	mov    0x1ad4,%edi
    172f:	89 d0                	mov    %edx,%eax
    1731:	39 c7                	cmp    %eax,%edi
    1733:	75 eb                	jne    1720 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1735:	83 ec 0c             	sub    $0xc,%esp
    1738:	ff 75 e4             	pushl  -0x1c(%ebp)
    173b:	e8 41 fc ff ff       	call   1381 <sbrk>
  if(p == (char*)-1)
    1740:	83 c4 10             	add    $0x10,%esp
    1743:	83 f8 ff             	cmp    $0xffffffff,%eax
    1746:	74 1b                	je     1763 <malloc+0x93>
  hp->s.size = nu;
    1748:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    174b:	83 ec 0c             	sub    $0xc,%esp
    174e:	83 c0 08             	add    $0x8,%eax
    1751:	50                   	push   %eax
    1752:	e8 e9 fe ff ff       	call   1640 <free>
  return freep;
    1757:	a1 d4 1a 00 00       	mov    0x1ad4,%eax
      if((p = morecore(nunits)) == 0)
    175c:	83 c4 10             	add    $0x10,%esp
    175f:	85 c0                	test   %eax,%eax
    1761:	75 bd                	jne    1720 <malloc+0x50>
        return 0;
  }
}
    1763:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1766:	31 c0                	xor    %eax,%eax
}
    1768:	5b                   	pop    %ebx
    1769:	5e                   	pop    %esi
    176a:	5f                   	pop    %edi
    176b:	5d                   	pop    %ebp
    176c:	c3                   	ret    
    if(p->s.size >= nunits){
    176d:	89 c2                	mov    %eax,%edx
    176f:	89 f8                	mov    %edi,%eax
    1771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1778:	39 ce                	cmp    %ecx,%esi
    177a:	74 54                	je     17d0 <malloc+0x100>
        p->s.size -= nunits;
    177c:	29 f1                	sub    %esi,%ecx
    177e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    1781:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    1784:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    1787:	a3 d4 1a 00 00       	mov    %eax,0x1ad4
}
    178c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    178f:	8d 42 08             	lea    0x8(%edx),%eax
}
    1792:	5b                   	pop    %ebx
    1793:	5e                   	pop    %esi
    1794:	5f                   	pop    %edi
    1795:	5d                   	pop    %ebp
    1796:	c3                   	ret    
    1797:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    179e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    17a0:	c7 05 d4 1a 00 00 d8 	movl   $0x1ad8,0x1ad4
    17a7:	1a 00 00 
    base.s.size = 0;
    17aa:	bf d8 1a 00 00       	mov    $0x1ad8,%edi
    base.s.ptr = freep = prevp = &base;
    17af:	c7 05 d8 1a 00 00 d8 	movl   $0x1ad8,0x1ad8
    17b6:	1a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17b9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    17bb:	c7 05 dc 1a 00 00 00 	movl   $0x0,0x1adc
    17c2:	00 00 00 
    if(p->s.size >= nunits){
    17c5:	e9 32 ff ff ff       	jmp    16fc <malloc+0x2c>
    17ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    17d0:	8b 0a                	mov    (%edx),%ecx
    17d2:	89 08                	mov    %ecx,(%eax)
    17d4:	eb b1                	jmp    1787 <malloc+0xb7>
