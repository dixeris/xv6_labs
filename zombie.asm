
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
    128c:	e8 5f 04 00 00       	call   16f0 <malloc>
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
    12c7:	e8 94 03 00 00       	call   1660 <free>
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

000013b9 <getNumProc>:
SYSCALL(getNumProc)
    13b9:	b8 1a 00 00 00       	mov    $0x1a,%eax
    13be:	cd 40                	int    $0x40
    13c0:	c3                   	ret    

000013c1 <getMaxPid>:
SYSCALL(getMaxPid)
    13c1:	b8 1b 00 00 00       	mov    $0x1b,%eax
    13c6:	cd 40                	int    $0x40
    13c8:	c3                   	ret    

000013c9 <getProcInfo>:
SYSCALL(getProcInfo)
    13c9:	b8 1c 00 00 00       	mov    $0x1c,%eax
    13ce:	cd 40                	int    $0x40
    13d0:	c3                   	ret    
    13d1:	66 90                	xchg   %ax,%ax
    13d3:	66 90                	xchg   %ax,%ax
    13d5:	66 90                	xchg   %ax,%ax
    13d7:	66 90                	xchg   %ax,%ax
    13d9:	66 90                	xchg   %ax,%ax
    13db:	66 90                	xchg   %ax,%ax
    13dd:	66 90                	xchg   %ax,%ax
    13df:	90                   	nop

000013e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    13e0:	55                   	push   %ebp
    13e1:	89 e5                	mov    %esp,%ebp
    13e3:	57                   	push   %edi
    13e4:	56                   	push   %esi
    13e5:	53                   	push   %ebx
    13e6:	83 ec 3c             	sub    $0x3c,%esp
    13e9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    13ec:	89 d1                	mov    %edx,%ecx
{
    13ee:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    13f1:	85 d2                	test   %edx,%edx
    13f3:	0f 89 7f 00 00 00    	jns    1478 <printint+0x98>
    13f9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    13fd:	74 79                	je     1478 <printint+0x98>
    neg = 1;
    13ff:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    1406:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    1408:	31 db                	xor    %ebx,%ebx
    140a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    140d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1410:	89 c8                	mov    %ecx,%eax
    1412:	31 d2                	xor    %edx,%edx
    1414:	89 cf                	mov    %ecx,%edi
    1416:	f7 75 c4             	divl   -0x3c(%ebp)
    1419:	0f b6 92 00 18 00 00 	movzbl 0x1800(%edx),%edx
    1420:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1423:	89 d8                	mov    %ebx,%eax
    1425:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1428:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    142b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    142e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1431:	76 dd                	jbe    1410 <printint+0x30>
  if(neg)
    1433:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1436:	85 c9                	test   %ecx,%ecx
    1438:	74 0c                	je     1446 <printint+0x66>
    buf[i++] = '-';
    143a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    143f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1441:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1446:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1449:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    144d:	eb 07                	jmp    1456 <printint+0x76>
    144f:	90                   	nop
    putc(fd, buf[i]);
    1450:	0f b6 13             	movzbl (%ebx),%edx
    1453:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1456:	83 ec 04             	sub    $0x4,%esp
    1459:	88 55 d7             	mov    %dl,-0x29(%ebp)
    145c:	6a 01                	push   $0x1
    145e:	56                   	push   %esi
    145f:	57                   	push   %edi
    1460:	e8 b4 fe ff ff       	call   1319 <write>
  while(--i >= 0)
    1465:	83 c4 10             	add    $0x10,%esp
    1468:	39 de                	cmp    %ebx,%esi
    146a:	75 e4                	jne    1450 <printint+0x70>
}
    146c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    146f:	5b                   	pop    %ebx
    1470:	5e                   	pop    %esi
    1471:	5f                   	pop    %edi
    1472:	5d                   	pop    %ebp
    1473:	c3                   	ret    
    1474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1478:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    147f:	eb 87                	jmp    1408 <printint+0x28>
    1481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    148f:	90                   	nop

00001490 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1490:	55                   	push   %ebp
    1491:	89 e5                	mov    %esp,%ebp
    1493:	57                   	push   %edi
    1494:	56                   	push   %esi
    1495:	53                   	push   %ebx
    1496:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1499:	8b 75 0c             	mov    0xc(%ebp),%esi
    149c:	0f b6 1e             	movzbl (%esi),%ebx
    149f:	84 db                	test   %bl,%bl
    14a1:	0f 84 b8 00 00 00    	je     155f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    14a7:	8d 45 10             	lea    0x10(%ebp),%eax
    14aa:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    14ad:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    14b0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    14b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    14b5:	eb 37                	jmp    14ee <printf+0x5e>
    14b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14be:	66 90                	xchg   %ax,%ax
    14c0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    14c3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    14c8:	83 f8 25             	cmp    $0x25,%eax
    14cb:	74 17                	je     14e4 <printf+0x54>
  write(fd, &c, 1);
    14cd:	83 ec 04             	sub    $0x4,%esp
    14d0:	88 5d e7             	mov    %bl,-0x19(%ebp)
    14d3:	6a 01                	push   $0x1
    14d5:	57                   	push   %edi
    14d6:	ff 75 08             	pushl  0x8(%ebp)
    14d9:	e8 3b fe ff ff       	call   1319 <write>
    14de:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    14e1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    14e4:	0f b6 1e             	movzbl (%esi),%ebx
    14e7:	83 c6 01             	add    $0x1,%esi
    14ea:	84 db                	test   %bl,%bl
    14ec:	74 71                	je     155f <printf+0xcf>
    c = fmt[i] & 0xff;
    14ee:	0f be cb             	movsbl %bl,%ecx
    14f1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    14f4:	85 d2                	test   %edx,%edx
    14f6:	74 c8                	je     14c0 <printf+0x30>
      }
    } else if(state == '%'){
    14f8:	83 fa 25             	cmp    $0x25,%edx
    14fb:	75 e7                	jne    14e4 <printf+0x54>
      if(c == 'd'){
    14fd:	83 f8 64             	cmp    $0x64,%eax
    1500:	0f 84 9a 00 00 00    	je     15a0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1506:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    150c:	83 f9 70             	cmp    $0x70,%ecx
    150f:	74 5f                	je     1570 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1511:	83 f8 73             	cmp    $0x73,%eax
    1514:	0f 84 d6 00 00 00    	je     15f0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    151a:	83 f8 63             	cmp    $0x63,%eax
    151d:	0f 84 8d 00 00 00    	je     15b0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1523:	83 f8 25             	cmp    $0x25,%eax
    1526:	0f 84 b4 00 00 00    	je     15e0 <printf+0x150>
  write(fd, &c, 1);
    152c:	83 ec 04             	sub    $0x4,%esp
    152f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1533:	6a 01                	push   $0x1
    1535:	57                   	push   %edi
    1536:	ff 75 08             	pushl  0x8(%ebp)
    1539:	e8 db fd ff ff       	call   1319 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    153e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1541:	83 c4 0c             	add    $0xc,%esp
    1544:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1546:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1549:	57                   	push   %edi
    154a:	ff 75 08             	pushl  0x8(%ebp)
    154d:	e8 c7 fd ff ff       	call   1319 <write>
  for(i = 0; fmt[i]; i++){
    1552:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    1556:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1559:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    155b:	84 db                	test   %bl,%bl
    155d:	75 8f                	jne    14ee <printf+0x5e>
    }
  }
}
    155f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1562:	5b                   	pop    %ebx
    1563:	5e                   	pop    %esi
    1564:	5f                   	pop    %edi
    1565:	5d                   	pop    %ebp
    1566:	c3                   	ret    
    1567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    156e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    1570:	83 ec 0c             	sub    $0xc,%esp
    1573:	b9 10 00 00 00       	mov    $0x10,%ecx
    1578:	6a 00                	push   $0x0
    157a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    157d:	8b 45 08             	mov    0x8(%ebp),%eax
    1580:	8b 13                	mov    (%ebx),%edx
    1582:	e8 59 fe ff ff       	call   13e0 <printint>
        ap++;
    1587:	89 d8                	mov    %ebx,%eax
    1589:	83 c4 10             	add    $0x10,%esp
      state = 0;
    158c:	31 d2                	xor    %edx,%edx
        ap++;
    158e:	83 c0 04             	add    $0x4,%eax
    1591:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1594:	e9 4b ff ff ff       	jmp    14e4 <printf+0x54>
    1599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    15a0:	83 ec 0c             	sub    $0xc,%esp
    15a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    15a8:	6a 01                	push   $0x1
    15aa:	eb ce                	jmp    157a <printf+0xea>
    15ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    15b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    15b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    15b6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    15b8:	6a 01                	push   $0x1
        ap++;
    15ba:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    15bd:	57                   	push   %edi
    15be:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    15c1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    15c4:	e8 50 fd ff ff       	call   1319 <write>
        ap++;
    15c9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    15cc:	83 c4 10             	add    $0x10,%esp
      state = 0;
    15cf:	31 d2                	xor    %edx,%edx
    15d1:	e9 0e ff ff ff       	jmp    14e4 <printf+0x54>
    15d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15dd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    15e0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    15e3:	83 ec 04             	sub    $0x4,%esp
    15e6:	e9 59 ff ff ff       	jmp    1544 <printf+0xb4>
    15eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    15ef:	90                   	nop
        s = (char*)*ap;
    15f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    15f3:	8b 18                	mov    (%eax),%ebx
        ap++;
    15f5:	83 c0 04             	add    $0x4,%eax
    15f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    15fb:	85 db                	test   %ebx,%ebx
    15fd:	74 17                	je     1616 <printf+0x186>
        while(*s != 0){
    15ff:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1602:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1604:	84 c0                	test   %al,%al
    1606:	0f 84 d8 fe ff ff    	je     14e4 <printf+0x54>
    160c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    160f:	89 de                	mov    %ebx,%esi
    1611:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1614:	eb 1a                	jmp    1630 <printf+0x1a0>
          s = "(null)";
    1616:	bb f8 17 00 00       	mov    $0x17f8,%ebx
        while(*s != 0){
    161b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    161e:	b8 28 00 00 00       	mov    $0x28,%eax
    1623:	89 de                	mov    %ebx,%esi
    1625:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    162f:	90                   	nop
  write(fd, &c, 1);
    1630:	83 ec 04             	sub    $0x4,%esp
          s++;
    1633:	83 c6 01             	add    $0x1,%esi
    1636:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1639:	6a 01                	push   $0x1
    163b:	57                   	push   %edi
    163c:	53                   	push   %ebx
    163d:	e8 d7 fc ff ff       	call   1319 <write>
        while(*s != 0){
    1642:	0f b6 06             	movzbl (%esi),%eax
    1645:	83 c4 10             	add    $0x10,%esp
    1648:	84 c0                	test   %al,%al
    164a:	75 e4                	jne    1630 <printf+0x1a0>
      state = 0;
    164c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    164f:	31 d2                	xor    %edx,%edx
    1651:	e9 8e fe ff ff       	jmp    14e4 <printf+0x54>
    1656:	66 90                	xchg   %ax,%ax
    1658:	66 90                	xchg   %ax,%ax
    165a:	66 90                	xchg   %ax,%ax
    165c:	66 90                	xchg   %ax,%ax
    165e:	66 90                	xchg   %ax,%ax

00001660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1661:	a1 f4 1a 00 00       	mov    0x1af4,%eax
{
    1666:	89 e5                	mov    %esp,%ebp
    1668:	57                   	push   %edi
    1669:	56                   	push   %esi
    166a:	53                   	push   %ebx
    166b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    166e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1678:	89 c2                	mov    %eax,%edx
    167a:	8b 00                	mov    (%eax),%eax
    167c:	39 ca                	cmp    %ecx,%edx
    167e:	73 30                	jae    16b0 <free+0x50>
    1680:	39 c1                	cmp    %eax,%ecx
    1682:	72 04                	jb     1688 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1684:	39 c2                	cmp    %eax,%edx
    1686:	72 f0                	jb     1678 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1688:	8b 73 fc             	mov    -0x4(%ebx),%esi
    168b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    168e:	39 f8                	cmp    %edi,%eax
    1690:	74 30                	je     16c2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1692:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    1695:	8b 42 04             	mov    0x4(%edx),%eax
    1698:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    169b:	39 f1                	cmp    %esi,%ecx
    169d:	74 3a                	je     16d9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    169f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    16a1:	5b                   	pop    %ebx
  freep = p;
    16a2:	89 15 f4 1a 00 00    	mov    %edx,0x1af4
}
    16a8:	5e                   	pop    %esi
    16a9:	5f                   	pop    %edi
    16aa:	5d                   	pop    %ebp
    16ab:	c3                   	ret    
    16ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16b0:	39 c2                	cmp    %eax,%edx
    16b2:	72 c4                	jb     1678 <free+0x18>
    16b4:	39 c1                	cmp    %eax,%ecx
    16b6:	73 c0                	jae    1678 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    16b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    16bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16be:	39 f8                	cmp    %edi,%eax
    16c0:	75 d0                	jne    1692 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    16c2:	03 70 04             	add    0x4(%eax),%esi
    16c5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    16c8:	8b 02                	mov    (%edx),%eax
    16ca:	8b 00                	mov    (%eax),%eax
    16cc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    16cf:	8b 42 04             	mov    0x4(%edx),%eax
    16d2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    16d5:	39 f1                	cmp    %esi,%ecx
    16d7:	75 c6                	jne    169f <free+0x3f>
    p->s.size += bp->s.size;
    16d9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    16dc:	89 15 f4 1a 00 00    	mov    %edx,0x1af4
    p->s.size += bp->s.size;
    16e2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    16e5:	8b 43 f8             	mov    -0x8(%ebx),%eax
    16e8:	89 02                	mov    %eax,(%edx)
}
    16ea:	5b                   	pop    %ebx
    16eb:	5e                   	pop    %esi
    16ec:	5f                   	pop    %edi
    16ed:	5d                   	pop    %ebp
    16ee:	c3                   	ret    
    16ef:	90                   	nop

000016f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    16f0:	55                   	push   %ebp
    16f1:	89 e5                	mov    %esp,%ebp
    16f3:	57                   	push   %edi
    16f4:	56                   	push   %esi
    16f5:	53                   	push   %ebx
    16f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    16fc:	8b 3d f4 1a 00 00    	mov    0x1af4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1702:	8d 70 07             	lea    0x7(%eax),%esi
    1705:	c1 ee 03             	shr    $0x3,%esi
    1708:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    170b:	85 ff                	test   %edi,%edi
    170d:	0f 84 ad 00 00 00    	je     17c0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1713:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1715:	8b 48 04             	mov    0x4(%eax),%ecx
    1718:	39 f1                	cmp    %esi,%ecx
    171a:	73 71                	jae    178d <malloc+0x9d>
    171c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1722:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1727:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    172a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1731:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1734:	eb 1b                	jmp    1751 <malloc+0x61>
    1736:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    173d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1740:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1742:	8b 4a 04             	mov    0x4(%edx),%ecx
    1745:	39 f1                	cmp    %esi,%ecx
    1747:	73 4f                	jae    1798 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1749:	8b 3d f4 1a 00 00    	mov    0x1af4,%edi
    174f:	89 d0                	mov    %edx,%eax
    1751:	39 c7                	cmp    %eax,%edi
    1753:	75 eb                	jne    1740 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1755:	83 ec 0c             	sub    $0xc,%esp
    1758:	ff 75 e4             	pushl  -0x1c(%ebp)
    175b:	e8 21 fc ff ff       	call   1381 <sbrk>
  if(p == (char*)-1)
    1760:	83 c4 10             	add    $0x10,%esp
    1763:	83 f8 ff             	cmp    $0xffffffff,%eax
    1766:	74 1b                	je     1783 <malloc+0x93>
  hp->s.size = nu;
    1768:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    176b:	83 ec 0c             	sub    $0xc,%esp
    176e:	83 c0 08             	add    $0x8,%eax
    1771:	50                   	push   %eax
    1772:	e8 e9 fe ff ff       	call   1660 <free>
  return freep;
    1777:	a1 f4 1a 00 00       	mov    0x1af4,%eax
      if((p = morecore(nunits)) == 0)
    177c:	83 c4 10             	add    $0x10,%esp
    177f:	85 c0                	test   %eax,%eax
    1781:	75 bd                	jne    1740 <malloc+0x50>
        return 0;
  }
}
    1783:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1786:	31 c0                	xor    %eax,%eax
}
    1788:	5b                   	pop    %ebx
    1789:	5e                   	pop    %esi
    178a:	5f                   	pop    %edi
    178b:	5d                   	pop    %ebp
    178c:	c3                   	ret    
    if(p->s.size >= nunits){
    178d:	89 c2                	mov    %eax,%edx
    178f:	89 f8                	mov    %edi,%eax
    1791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1798:	39 ce                	cmp    %ecx,%esi
    179a:	74 54                	je     17f0 <malloc+0x100>
        p->s.size -= nunits;
    179c:	29 f1                	sub    %esi,%ecx
    179e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    17a1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    17a4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    17a7:	a3 f4 1a 00 00       	mov    %eax,0x1af4
}
    17ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    17af:	8d 42 08             	lea    0x8(%edx),%eax
}
    17b2:	5b                   	pop    %ebx
    17b3:	5e                   	pop    %esi
    17b4:	5f                   	pop    %edi
    17b5:	5d                   	pop    %ebp
    17b6:	c3                   	ret    
    17b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17be:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    17c0:	c7 05 f4 1a 00 00 f8 	movl   $0x1af8,0x1af4
    17c7:	1a 00 00 
    base.s.size = 0;
    17ca:	bf f8 1a 00 00       	mov    $0x1af8,%edi
    base.s.ptr = freep = prevp = &base;
    17cf:	c7 05 f8 1a 00 00 f8 	movl   $0x1af8,0x1af8
    17d6:	1a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17d9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    17db:	c7 05 fc 1a 00 00 00 	movl   $0x0,0x1afc
    17e2:	00 00 00 
    if(p->s.size >= nunits){
    17e5:	e9 32 ff ff ff       	jmp    171c <malloc+0x2c>
    17ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    17f0:	8b 0a                	mov    (%edx),%ecx
    17f2:	89 08                	mov    %ecx,(%eax)
    17f4:	eb b1                	jmp    17a7 <malloc+0xb7>
