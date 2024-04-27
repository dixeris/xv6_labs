
_test:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
printf(1,"child thread pid is %d\n", pid);     
printf(1,"arg1 = %d, arg2 = %d\n", (int*)arg1, (int*)arg2);
exit();
}

int main(void) {
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	51                   	push   %ecx
  int arg1 = 11;
  int arg2 = 22;
  thread_create((void(*)(void*,void*))&thread_func, &arg1, &arg2);
    100e:	8d 45 f4             	lea    -0xc(%ebp),%eax
int main(void) {
    1011:	83 ec 18             	sub    $0x18,%esp
  int arg1 = 11;
    1014:	c7 45 f0 0b 00 00 00 	movl   $0xb,-0x10(%ebp)
  thread_create((void(*)(void*,void*))&thread_func, &arg1, &arg2);
    101b:	50                   	push   %eax
    101c:	8d 45 f0             	lea    -0x10(%ebp),%eax
    101f:	50                   	push   %eax
    1020:	68 60 10 00 00       	push   $0x1060
  int arg2 = 22;
    1025:	c7 45 f4 16 00 00 00 	movl   $0x16,-0xc(%ebp)
  thread_create((void(*)(void*,void*))&thread_func, &arg1, &arg2);
    102c:	e8 bf 02 00 00       	call   12f0 <thread_create>
  thread_join();
    1031:	e8 1a 03 00 00       	call   1350 <thread_join>
  int pid = getpid();
    1036:	e8 ae 03 00 00       	call   13e9 <getpid>
  printf(1,"parent pid is %d\n", pid);
    103b:	83 c4 0c             	add    $0xc,%esp
    103e:	50                   	push   %eax
    103f:	68 76 18 00 00       	push   $0x1876
    1044:	6a 01                	push   $0x1
    1046:	e8 95 04 00 00       	call   14e0 <printf>
}
    104b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
    104e:	31 c0                	xor    %eax,%eax
    1050:	c9                   	leave  
    1051:	8d 61 fc             	lea    -0x4(%ecx),%esp
    1054:	c3                   	ret    
    1055:	66 90                	xchg   %ax,%ax
    1057:	66 90                	xchg   %ax,%ax
    1059:	66 90                	xchg   %ax,%ax
    105b:	66 90                	xchg   %ax,%ax
    105d:	66 90                	xchg   %ax,%ax
    105f:	90                   	nop

00001060 <thread_func>:
void thread_func(void* arg1, void* arg2) {
    1060:	55                   	push   %ebp
    1061:	89 e5                	mov    %esp,%ebp
    1063:	83 ec 08             	sub    $0x8,%esp
  int pid = getpid();
    1066:	e8 7e 03 00 00       	call   13e9 <getpid>
printf(1,"child thread pid is %d\n", pid);     
    106b:	83 ec 04             	sub    $0x4,%esp
    106e:	50                   	push   %eax
    106f:	68 48 18 00 00       	push   $0x1848
    1074:	6a 01                	push   $0x1
    1076:	e8 65 04 00 00       	call   14e0 <printf>
printf(1,"arg1 = %d, arg2 = %d\n", (int*)arg1, (int*)arg2);
    107b:	ff 75 0c             	pushl  0xc(%ebp)
    107e:	ff 75 08             	pushl  0x8(%ebp)
    1081:	68 60 18 00 00       	push   $0x1860
    1086:	6a 01                	push   $0x1
    1088:	e8 53 04 00 00       	call   14e0 <printf>
exit();
    108d:	83 c4 20             	add    $0x20,%esp
    1090:	e8 d4 02 00 00       	call   1369 <exit>
    1095:	66 90                	xchg   %ax,%ax
    1097:	66 90                	xchg   %ax,%ax
    1099:	66 90                	xchg   %ax,%ax
    109b:	66 90                	xchg   %ax,%ax
    109d:	66 90                	xchg   %ax,%ax
    109f:	90                   	nop

000010a0 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"
char*
strcpy(char *s, const char *t)
{
    10a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    10a1:	31 c0                	xor    %eax,%eax
{
    10a3:	89 e5                	mov    %esp,%ebp
    10a5:	53                   	push   %ebx
    10a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    10b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    10b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    10b7:	83 c0 01             	add    $0x1,%eax
    10ba:	84 d2                	test   %dl,%dl
    10bc:	75 f2                	jne    10b0 <strcpy+0x10>
    ;
  return os;
}
    10be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10c1:	89 c8                	mov    %ecx,%eax
    10c3:	c9                   	leave  
    10c4:	c3                   	ret    
    10c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000010d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10d0:	55                   	push   %ebp
    10d1:	89 e5                	mov    %esp,%ebp
    10d3:	53                   	push   %ebx
    10d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    10da:	0f b6 01             	movzbl (%ecx),%eax
    10dd:	0f b6 1a             	movzbl (%edx),%ebx
    10e0:	84 c0                	test   %al,%al
    10e2:	75 1d                	jne    1101 <strcmp+0x31>
    10e4:	eb 2a                	jmp    1110 <strcmp+0x40>
    10e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10ed:	8d 76 00             	lea    0x0(%esi),%esi
    10f0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    10f4:	83 c1 01             	add    $0x1,%ecx
    10f7:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    10fa:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    10fd:	84 c0                	test   %al,%al
    10ff:	74 0f                	je     1110 <strcmp+0x40>
    1101:	38 d8                	cmp    %bl,%al
    1103:	74 eb                	je     10f0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1105:	29 d8                	sub    %ebx,%eax
}
    1107:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    110a:	c9                   	leave  
    110b:	c3                   	ret    
    110c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1110:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1112:	29 d8                	sub    %ebx,%eax
}
    1114:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1117:	c9                   	leave  
    1118:	c3                   	ret    
    1119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001120 <strlen>:

uint
strlen(const char *s)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    1126:	80 3a 00             	cmpb   $0x0,(%edx)
    1129:	74 15                	je     1140 <strlen+0x20>
    112b:	31 c0                	xor    %eax,%eax
    112d:	8d 76 00             	lea    0x0(%esi),%esi
    1130:	83 c0 01             	add    $0x1,%eax
    1133:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    1137:	89 c1                	mov    %eax,%ecx
    1139:	75 f5                	jne    1130 <strlen+0x10>
    ;
  return n;
}
    113b:	89 c8                	mov    %ecx,%eax
    113d:	5d                   	pop    %ebp
    113e:	c3                   	ret    
    113f:	90                   	nop
  for(n = 0; s[n]; n++)
    1140:	31 c9                	xor    %ecx,%ecx
}
    1142:	5d                   	pop    %ebp
    1143:	89 c8                	mov    %ecx,%eax
    1145:	c3                   	ret    
    1146:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    114d:	8d 76 00             	lea    0x0(%esi),%esi

00001150 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	57                   	push   %edi
    1154:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1157:	8b 4d 10             	mov    0x10(%ebp),%ecx
    115a:	8b 45 0c             	mov    0xc(%ebp),%eax
    115d:	89 d7                	mov    %edx,%edi
    115f:	fc                   	cld    
    1160:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1162:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1165:	89 d0                	mov    %edx,%eax
    1167:	c9                   	leave  
    1168:	c3                   	ret    
    1169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001170 <strchr>:

char*
strchr(const char *s, char c)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	8b 45 08             	mov    0x8(%ebp),%eax
    1176:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    117a:	0f b6 10             	movzbl (%eax),%edx
    117d:	84 d2                	test   %dl,%dl
    117f:	75 12                	jne    1193 <strchr+0x23>
    1181:	eb 1d                	jmp    11a0 <strchr+0x30>
    1183:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1187:	90                   	nop
    1188:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    118c:	83 c0 01             	add    $0x1,%eax
    118f:	84 d2                	test   %dl,%dl
    1191:	74 0d                	je     11a0 <strchr+0x30>
    if(*s == c)
    1193:	38 d1                	cmp    %dl,%cl
    1195:	75 f1                	jne    1188 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1197:	5d                   	pop    %ebp
    1198:	c3                   	ret    
    1199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    11a0:	31 c0                	xor    %eax,%eax
}
    11a2:	5d                   	pop    %ebp
    11a3:	c3                   	ret    
    11a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11af:	90                   	nop

000011b0 <gets>:

char*
gets(char *buf, int max)
{
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
    11b3:	57                   	push   %edi
    11b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11b5:	31 f6                	xor    %esi,%esi
{
    11b7:	53                   	push   %ebx
    11b8:	89 f3                	mov    %esi,%ebx
    11ba:	83 ec 1c             	sub    $0x1c,%esp
    11bd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    11c0:	eb 2f                	jmp    11f1 <gets+0x41>
    11c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    11c8:	83 ec 04             	sub    $0x4,%esp
    11cb:	8d 45 e7             	lea    -0x19(%ebp),%eax
    11ce:	6a 01                	push   $0x1
    11d0:	50                   	push   %eax
    11d1:	6a 00                	push   $0x0
    11d3:	e8 a9 01 00 00       	call   1381 <read>
    if(cc < 1)
    11d8:	83 c4 10             	add    $0x10,%esp
    11db:	85 c0                	test   %eax,%eax
    11dd:	7e 1c                	jle    11fb <gets+0x4b>
      break;
    buf[i++] = c;
    11df:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    11e3:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    11e6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    11e9:	3c 0a                	cmp    $0xa,%al
    11eb:	74 23                	je     1210 <gets+0x60>
    11ed:	3c 0d                	cmp    $0xd,%al
    11ef:	74 1f                	je     1210 <gets+0x60>
  for(i=0; i+1 < max; ){
    11f1:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    11f4:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    11f6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11f9:	7c cd                	jl     11c8 <gets+0x18>
    11fb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    11fd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1200:	c6 03 00             	movb   $0x0,(%ebx)
}
    1203:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1206:	5b                   	pop    %ebx
    1207:	5e                   	pop    %esi
    1208:	5f                   	pop    %edi
    1209:	5d                   	pop    %ebp
    120a:	c3                   	ret    
    120b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    120f:	90                   	nop
  buf[i] = '\0';
    1210:	8b 75 08             	mov    0x8(%ebp),%esi
}
    1213:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1216:	01 de                	add    %ebx,%esi
    1218:	89 f3                	mov    %esi,%ebx
    121a:	c6 03 00             	movb   $0x0,(%ebx)
}
    121d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1220:	5b                   	pop    %ebx
    1221:	5e                   	pop    %esi
    1222:	5f                   	pop    %edi
    1223:	5d                   	pop    %ebp
    1224:	c3                   	ret    
    1225:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    122c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001230 <stat>:

int
stat(const char *n, struct stat *st)
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	56                   	push   %esi
    1234:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1235:	83 ec 08             	sub    $0x8,%esp
    1238:	6a 00                	push   $0x0
    123a:	ff 75 08             	pushl  0x8(%ebp)
    123d:	e8 67 01 00 00       	call   13a9 <open>
  if(fd < 0)
    1242:	83 c4 10             	add    $0x10,%esp
    1245:	85 c0                	test   %eax,%eax
    1247:	78 27                	js     1270 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1249:	83 ec 08             	sub    $0x8,%esp
    124c:	ff 75 0c             	pushl  0xc(%ebp)
    124f:	89 c3                	mov    %eax,%ebx
    1251:	50                   	push   %eax
    1252:	e8 6a 01 00 00       	call   13c1 <fstat>
  close(fd);
    1257:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    125a:	89 c6                	mov    %eax,%esi
  close(fd);
    125c:	e8 30 01 00 00       	call   1391 <close>
  return r;
    1261:	83 c4 10             	add    $0x10,%esp
}
    1264:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1267:	89 f0                	mov    %esi,%eax
    1269:	5b                   	pop    %ebx
    126a:	5e                   	pop    %esi
    126b:	5d                   	pop    %ebp
    126c:	c3                   	ret    
    126d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1270:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1275:	eb ed                	jmp    1264 <stat+0x34>
    1277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    127e:	66 90                	xchg   %ax,%ax

00001280 <atoi>:

int
atoi(const char *s)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	53                   	push   %ebx
    1284:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1287:	0f be 02             	movsbl (%edx),%eax
    128a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    128d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1290:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1295:	77 1e                	ja     12b5 <atoi+0x35>
    1297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    129e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    12a0:	83 c2 01             	add    $0x1,%edx
    12a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    12a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    12aa:	0f be 02             	movsbl (%edx),%eax
    12ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
    12b0:	80 fb 09             	cmp    $0x9,%bl
    12b3:	76 eb                	jbe    12a0 <atoi+0x20>
  return n;
}
    12b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12b8:	89 c8                	mov    %ecx,%eax
    12ba:	c9                   	leave  
    12bb:	c3                   	ret    
    12bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000012c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	57                   	push   %edi
    12c4:	8b 45 10             	mov    0x10(%ebp),%eax
    12c7:	8b 55 08             	mov    0x8(%ebp),%edx
    12ca:	56                   	push   %esi
    12cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12ce:	85 c0                	test   %eax,%eax
    12d0:	7e 13                	jle    12e5 <memmove+0x25>
    12d2:	01 d0                	add    %edx,%eax
  dst = vdst;
    12d4:	89 d7                	mov    %edx,%edi
    12d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12dd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    12e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    12e1:	39 f8                	cmp    %edi,%eax
    12e3:	75 fb                	jne    12e0 <memmove+0x20>
  return vdst;
}
    12e5:	5e                   	pop    %esi
    12e6:	89 d0                	mov    %edx,%eax
    12e8:	5f                   	pop    %edi
    12e9:	5d                   	pop    %ebp
    12ea:	c3                   	ret    
    12eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12ef:	90                   	nop

000012f0 <thread_create>:


int thread_create(void (*start_routine)(void*, void*), void *arg1, void *arg2) {
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	53                   	push   %ebx
    12f4:	83 ec 20             	sub    $0x20,%esp
  void *stack =  malloc(4096);
    12f7:	68 00 10 00 00       	push   $0x1000
    12fc:	e8 3f 04 00 00       	call   1740 <malloc>
  if(stack == 0)
    1301:	83 c4 10             	add    $0x10,%esp
    1304:	85 c0                	test   %eax,%eax
    1306:	74 3f                	je     1347 <thread_create+0x57>
    return -1;
  int r= clone(start_routine, arg1, arg2, stack);
    1308:	50                   	push   %eax
    1309:	89 c3                	mov    %eax,%ebx
    130b:	ff 75 10             	pushl  0x10(%ebp)
    130e:	ff 75 0c             	pushl  0xc(%ebp)
    1311:	ff 75 08             	pushl  0x8(%ebp)
    1314:	e8 00 01 00 00       	call   1419 <clone>
  if(r==-1) 
    1319:	83 c4 10             	add    $0x10,%esp
    131c:	83 f8 ff             	cmp    $0xffffffff,%eax
    131f:	74 0f                	je     1330 <thread_create+0x40>
    free(stack);
  return r;
}
    1321:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1324:	c9                   	leave  
    1325:	c3                   	ret    
    1326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    132d:	8d 76 00             	lea    0x0(%esi),%esi
    free(stack);
    1330:	83 ec 0c             	sub    $0xc,%esp
    1333:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1336:	53                   	push   %ebx
    1337:	e8 74 03 00 00       	call   16b0 <free>
    133c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    133f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    free(stack);
    1342:	83 c4 10             	add    $0x10,%esp
}
    1345:	c9                   	leave  
    1346:	c3                   	ret    
    return -1;
    1347:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    134c:	eb d3                	jmp    1321 <thread_create+0x31>
    134e:	66 90                	xchg   %ax,%ax

00001350 <thread_join>:


int thread_join(void) {
    1350:	55                   	push   %ebp
    1351:	89 e5                	mov    %esp,%ebp
    1353:	83 ec 24             	sub    $0x24,%esp
  void *stack;
  int r = join(&stack);
    1356:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1359:	50                   	push   %eax
    135a:	e8 c2 00 00 00       	call   1421 <join>
  return r;
}
    135f:	c9                   	leave  
    1360:	c3                   	ret    

00001361 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1361:	b8 01 00 00 00       	mov    $0x1,%eax
    1366:	cd 40                	int    $0x40
    1368:	c3                   	ret    

00001369 <exit>:
SYSCALL(exit)
    1369:	b8 02 00 00 00       	mov    $0x2,%eax
    136e:	cd 40                	int    $0x40
    1370:	c3                   	ret    

00001371 <wait>:
SYSCALL(wait)
    1371:	b8 03 00 00 00       	mov    $0x3,%eax
    1376:	cd 40                	int    $0x40
    1378:	c3                   	ret    

00001379 <pipe>:
SYSCALL(pipe)
    1379:	b8 04 00 00 00       	mov    $0x4,%eax
    137e:	cd 40                	int    $0x40
    1380:	c3                   	ret    

00001381 <read>:
SYSCALL(read)
    1381:	b8 05 00 00 00       	mov    $0x5,%eax
    1386:	cd 40                	int    $0x40
    1388:	c3                   	ret    

00001389 <write>:
SYSCALL(write)
    1389:	b8 10 00 00 00       	mov    $0x10,%eax
    138e:	cd 40                	int    $0x40
    1390:	c3                   	ret    

00001391 <close>:
SYSCALL(close)
    1391:	b8 15 00 00 00       	mov    $0x15,%eax
    1396:	cd 40                	int    $0x40
    1398:	c3                   	ret    

00001399 <kill>:
SYSCALL(kill)
    1399:	b8 06 00 00 00       	mov    $0x6,%eax
    139e:	cd 40                	int    $0x40
    13a0:	c3                   	ret    

000013a1 <exec>:
SYSCALL(exec)
    13a1:	b8 07 00 00 00       	mov    $0x7,%eax
    13a6:	cd 40                	int    $0x40
    13a8:	c3                   	ret    

000013a9 <open>:
SYSCALL(open)
    13a9:	b8 0f 00 00 00       	mov    $0xf,%eax
    13ae:	cd 40                	int    $0x40
    13b0:	c3                   	ret    

000013b1 <mknod>:
SYSCALL(mknod)
    13b1:	b8 11 00 00 00       	mov    $0x11,%eax
    13b6:	cd 40                	int    $0x40
    13b8:	c3                   	ret    

000013b9 <unlink>:
SYSCALL(unlink)
    13b9:	b8 12 00 00 00       	mov    $0x12,%eax
    13be:	cd 40                	int    $0x40
    13c0:	c3                   	ret    

000013c1 <fstat>:
SYSCALL(fstat)
    13c1:	b8 08 00 00 00       	mov    $0x8,%eax
    13c6:	cd 40                	int    $0x40
    13c8:	c3                   	ret    

000013c9 <link>:
SYSCALL(link)
    13c9:	b8 13 00 00 00       	mov    $0x13,%eax
    13ce:	cd 40                	int    $0x40
    13d0:	c3                   	ret    

000013d1 <mkdir>:
SYSCALL(mkdir)
    13d1:	b8 14 00 00 00       	mov    $0x14,%eax
    13d6:	cd 40                	int    $0x40
    13d8:	c3                   	ret    

000013d9 <chdir>:
SYSCALL(chdir)
    13d9:	b8 09 00 00 00       	mov    $0x9,%eax
    13de:	cd 40                	int    $0x40
    13e0:	c3                   	ret    

000013e1 <dup>:
SYSCALL(dup)
    13e1:	b8 0a 00 00 00       	mov    $0xa,%eax
    13e6:	cd 40                	int    $0x40
    13e8:	c3                   	ret    

000013e9 <getpid>:
SYSCALL(getpid)
    13e9:	b8 0b 00 00 00       	mov    $0xb,%eax
    13ee:	cd 40                	int    $0x40
    13f0:	c3                   	ret    

000013f1 <sbrk>:
SYSCALL(sbrk)
    13f1:	b8 0c 00 00 00       	mov    $0xc,%eax
    13f6:	cd 40                	int    $0x40
    13f8:	c3                   	ret    

000013f9 <sleep>:
SYSCALL(sleep)
    13f9:	b8 0d 00 00 00       	mov    $0xd,%eax
    13fe:	cd 40                	int    $0x40
    1400:	c3                   	ret    

00001401 <uptime>:
SYSCALL(uptime)
    1401:	b8 0e 00 00 00       	mov    $0xe,%eax
    1406:	cd 40                	int    $0x40
    1408:	c3                   	ret    

00001409 <mprotect>:
SYSCALL(mprotect)
    1409:	b8 16 00 00 00       	mov    $0x16,%eax
    140e:	cd 40                	int    $0x40
    1410:	c3                   	ret    

00001411 <munprotect>:
SYSCALL(munprotect)
    1411:	b8 17 00 00 00       	mov    $0x17,%eax
    1416:	cd 40                	int    $0x40
    1418:	c3                   	ret    

00001419 <clone>:
SYSCALL(clone)
    1419:	b8 18 00 00 00       	mov    $0x18,%eax
    141e:	cd 40                	int    $0x40
    1420:	c3                   	ret    

00001421 <join>:
SYSCALL(join)
    1421:	b8 19 00 00 00       	mov    $0x19,%eax
    1426:	cd 40                	int    $0x40
    1428:	c3                   	ret    
    1429:	66 90                	xchg   %ax,%ax
    142b:	66 90                	xchg   %ax,%ax
    142d:	66 90                	xchg   %ax,%ax
    142f:	90                   	nop

00001430 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	57                   	push   %edi
    1434:	56                   	push   %esi
    1435:	53                   	push   %ebx
    1436:	83 ec 3c             	sub    $0x3c,%esp
    1439:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    143c:	89 d1                	mov    %edx,%ecx
{
    143e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    1441:	85 d2                	test   %edx,%edx
    1443:	0f 89 7f 00 00 00    	jns    14c8 <printint+0x98>
    1449:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    144d:	74 79                	je     14c8 <printint+0x98>
    neg = 1;
    144f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    1456:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    1458:	31 db                	xor    %ebx,%ebx
    145a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    145d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1460:	89 c8                	mov    %ecx,%eax
    1462:	31 d2                	xor    %edx,%edx
    1464:	89 cf                	mov    %ecx,%edi
    1466:	f7 75 c4             	divl   -0x3c(%ebp)
    1469:	0f b6 92 90 18 00 00 	movzbl 0x1890(%edx),%edx
    1470:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1473:	89 d8                	mov    %ebx,%eax
    1475:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1478:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    147b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    147e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1481:	76 dd                	jbe    1460 <printint+0x30>
  if(neg)
    1483:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1486:	85 c9                	test   %ecx,%ecx
    1488:	74 0c                	je     1496 <printint+0x66>
    buf[i++] = '-';
    148a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    148f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1491:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1496:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1499:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    149d:	eb 07                	jmp    14a6 <printint+0x76>
    149f:	90                   	nop
    putc(fd, buf[i]);
    14a0:	0f b6 13             	movzbl (%ebx),%edx
    14a3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    14a6:	83 ec 04             	sub    $0x4,%esp
    14a9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    14ac:	6a 01                	push   $0x1
    14ae:	56                   	push   %esi
    14af:	57                   	push   %edi
    14b0:	e8 d4 fe ff ff       	call   1389 <write>
  while(--i >= 0)
    14b5:	83 c4 10             	add    $0x10,%esp
    14b8:	39 de                	cmp    %ebx,%esi
    14ba:	75 e4                	jne    14a0 <printint+0x70>
}
    14bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14bf:	5b                   	pop    %ebx
    14c0:	5e                   	pop    %esi
    14c1:	5f                   	pop    %edi
    14c2:	5d                   	pop    %ebp
    14c3:	c3                   	ret    
    14c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    14c8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    14cf:	eb 87                	jmp    1458 <printint+0x28>
    14d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14df:	90                   	nop

000014e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    14e0:	55                   	push   %ebp
    14e1:	89 e5                	mov    %esp,%ebp
    14e3:	57                   	push   %edi
    14e4:	56                   	push   %esi
    14e5:	53                   	push   %ebx
    14e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14e9:	8b 75 0c             	mov    0xc(%ebp),%esi
    14ec:	0f b6 1e             	movzbl (%esi),%ebx
    14ef:	84 db                	test   %bl,%bl
    14f1:	0f 84 b8 00 00 00    	je     15af <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    14f7:	8d 45 10             	lea    0x10(%ebp),%eax
    14fa:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    14fd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    1500:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    1502:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1505:	eb 37                	jmp    153e <printf+0x5e>
    1507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    150e:	66 90                	xchg   %ax,%ax
    1510:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    1513:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1518:	83 f8 25             	cmp    $0x25,%eax
    151b:	74 17                	je     1534 <printf+0x54>
  write(fd, &c, 1);
    151d:	83 ec 04             	sub    $0x4,%esp
    1520:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1523:	6a 01                	push   $0x1
    1525:	57                   	push   %edi
    1526:	ff 75 08             	pushl  0x8(%ebp)
    1529:	e8 5b fe ff ff       	call   1389 <write>
    152e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    1531:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1534:	0f b6 1e             	movzbl (%esi),%ebx
    1537:	83 c6 01             	add    $0x1,%esi
    153a:	84 db                	test   %bl,%bl
    153c:	74 71                	je     15af <printf+0xcf>
    c = fmt[i] & 0xff;
    153e:	0f be cb             	movsbl %bl,%ecx
    1541:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1544:	85 d2                	test   %edx,%edx
    1546:	74 c8                	je     1510 <printf+0x30>
      }
    } else if(state == '%'){
    1548:	83 fa 25             	cmp    $0x25,%edx
    154b:	75 e7                	jne    1534 <printf+0x54>
      if(c == 'd'){
    154d:	83 f8 64             	cmp    $0x64,%eax
    1550:	0f 84 9a 00 00 00    	je     15f0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1556:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    155c:	83 f9 70             	cmp    $0x70,%ecx
    155f:	74 5f                	je     15c0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1561:	83 f8 73             	cmp    $0x73,%eax
    1564:	0f 84 d6 00 00 00    	je     1640 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    156a:	83 f8 63             	cmp    $0x63,%eax
    156d:	0f 84 8d 00 00 00    	je     1600 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1573:	83 f8 25             	cmp    $0x25,%eax
    1576:	0f 84 b4 00 00 00    	je     1630 <printf+0x150>
  write(fd, &c, 1);
    157c:	83 ec 04             	sub    $0x4,%esp
    157f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1583:	6a 01                	push   $0x1
    1585:	57                   	push   %edi
    1586:	ff 75 08             	pushl  0x8(%ebp)
    1589:	e8 fb fd ff ff       	call   1389 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    158e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1591:	83 c4 0c             	add    $0xc,%esp
    1594:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1596:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1599:	57                   	push   %edi
    159a:	ff 75 08             	pushl  0x8(%ebp)
    159d:	e8 e7 fd ff ff       	call   1389 <write>
  for(i = 0; fmt[i]; i++){
    15a2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    15a6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15a9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    15ab:	84 db                	test   %bl,%bl
    15ad:	75 8f                	jne    153e <printf+0x5e>
    }
  }
}
    15af:	8d 65 f4             	lea    -0xc(%ebp),%esp
    15b2:	5b                   	pop    %ebx
    15b3:	5e                   	pop    %esi
    15b4:	5f                   	pop    %edi
    15b5:	5d                   	pop    %ebp
    15b6:	c3                   	ret    
    15b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15be:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    15c0:	83 ec 0c             	sub    $0xc,%esp
    15c3:	b9 10 00 00 00       	mov    $0x10,%ecx
    15c8:	6a 00                	push   $0x0
    15ca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    15cd:	8b 45 08             	mov    0x8(%ebp),%eax
    15d0:	8b 13                	mov    (%ebx),%edx
    15d2:	e8 59 fe ff ff       	call   1430 <printint>
        ap++;
    15d7:	89 d8                	mov    %ebx,%eax
    15d9:	83 c4 10             	add    $0x10,%esp
      state = 0;
    15dc:	31 d2                	xor    %edx,%edx
        ap++;
    15de:	83 c0 04             	add    $0x4,%eax
    15e1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    15e4:	e9 4b ff ff ff       	jmp    1534 <printf+0x54>
    15e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    15f0:	83 ec 0c             	sub    $0xc,%esp
    15f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    15f8:	6a 01                	push   $0x1
    15fa:	eb ce                	jmp    15ca <printf+0xea>
    15fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1600:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1603:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1606:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    1608:	6a 01                	push   $0x1
        ap++;
    160a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    160d:	57                   	push   %edi
    160e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    1611:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1614:	e8 70 fd ff ff       	call   1389 <write>
        ap++;
    1619:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    161c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    161f:	31 d2                	xor    %edx,%edx
    1621:	e9 0e ff ff ff       	jmp    1534 <printf+0x54>
    1626:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    162d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    1630:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1633:	83 ec 04             	sub    $0x4,%esp
    1636:	e9 59 ff ff ff       	jmp    1594 <printf+0xb4>
    163b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    163f:	90                   	nop
        s = (char*)*ap;
    1640:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1643:	8b 18                	mov    (%eax),%ebx
        ap++;
    1645:	83 c0 04             	add    $0x4,%eax
    1648:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    164b:	85 db                	test   %ebx,%ebx
    164d:	74 17                	je     1666 <printf+0x186>
        while(*s != 0){
    164f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1652:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1654:	84 c0                	test   %al,%al
    1656:	0f 84 d8 fe ff ff    	je     1534 <printf+0x54>
    165c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    165f:	89 de                	mov    %ebx,%esi
    1661:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1664:	eb 1a                	jmp    1680 <printf+0x1a0>
          s = "(null)";
    1666:	bb 88 18 00 00       	mov    $0x1888,%ebx
        while(*s != 0){
    166b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    166e:	b8 28 00 00 00       	mov    $0x28,%eax
    1673:	89 de                	mov    %ebx,%esi
    1675:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    167f:	90                   	nop
  write(fd, &c, 1);
    1680:	83 ec 04             	sub    $0x4,%esp
          s++;
    1683:	83 c6 01             	add    $0x1,%esi
    1686:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1689:	6a 01                	push   $0x1
    168b:	57                   	push   %edi
    168c:	53                   	push   %ebx
    168d:	e8 f7 fc ff ff       	call   1389 <write>
        while(*s != 0){
    1692:	0f b6 06             	movzbl (%esi),%eax
    1695:	83 c4 10             	add    $0x10,%esp
    1698:	84 c0                	test   %al,%al
    169a:	75 e4                	jne    1680 <printf+0x1a0>
      state = 0;
    169c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    169f:	31 d2                	xor    %edx,%edx
    16a1:	e9 8e fe ff ff       	jmp    1534 <printf+0x54>
    16a6:	66 90                	xchg   %ax,%ax
    16a8:	66 90                	xchg   %ax,%ax
    16aa:	66 90                	xchg   %ax,%ax
    16ac:	66 90                	xchg   %ax,%ax
    16ae:	66 90                	xchg   %ax,%ax

000016b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16b1:	a1 a8 1b 00 00       	mov    0x1ba8,%eax
{
    16b6:	89 e5                	mov    %esp,%ebp
    16b8:	57                   	push   %edi
    16b9:	56                   	push   %esi
    16ba:	53                   	push   %ebx
    16bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    16be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    16c8:	89 c2                	mov    %eax,%edx
    16ca:	8b 00                	mov    (%eax),%eax
    16cc:	39 ca                	cmp    %ecx,%edx
    16ce:	73 30                	jae    1700 <free+0x50>
    16d0:	39 c1                	cmp    %eax,%ecx
    16d2:	72 04                	jb     16d8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16d4:	39 c2                	cmp    %eax,%edx
    16d6:	72 f0                	jb     16c8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    16d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    16db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16de:	39 f8                	cmp    %edi,%eax
    16e0:	74 30                	je     1712 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    16e2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    16e5:	8b 42 04             	mov    0x4(%edx),%eax
    16e8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    16eb:	39 f1                	cmp    %esi,%ecx
    16ed:	74 3a                	je     1729 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    16ef:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    16f1:	5b                   	pop    %ebx
  freep = p;
    16f2:	89 15 a8 1b 00 00    	mov    %edx,0x1ba8
}
    16f8:	5e                   	pop    %esi
    16f9:	5f                   	pop    %edi
    16fa:	5d                   	pop    %ebp
    16fb:	c3                   	ret    
    16fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1700:	39 c2                	cmp    %eax,%edx
    1702:	72 c4                	jb     16c8 <free+0x18>
    1704:	39 c1                	cmp    %eax,%ecx
    1706:	73 c0                	jae    16c8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1708:	8b 73 fc             	mov    -0x4(%ebx),%esi
    170b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    170e:	39 f8                	cmp    %edi,%eax
    1710:	75 d0                	jne    16e2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    1712:	03 70 04             	add    0x4(%eax),%esi
    1715:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1718:	8b 02                	mov    (%edx),%eax
    171a:	8b 00                	mov    (%eax),%eax
    171c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    171f:	8b 42 04             	mov    0x4(%edx),%eax
    1722:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1725:	39 f1                	cmp    %esi,%ecx
    1727:	75 c6                	jne    16ef <free+0x3f>
    p->s.size += bp->s.size;
    1729:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    172c:	89 15 a8 1b 00 00    	mov    %edx,0x1ba8
    p->s.size += bp->s.size;
    1732:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1735:	8b 43 f8             	mov    -0x8(%ebx),%eax
    1738:	89 02                	mov    %eax,(%edx)
}
    173a:	5b                   	pop    %ebx
    173b:	5e                   	pop    %esi
    173c:	5f                   	pop    %edi
    173d:	5d                   	pop    %ebp
    173e:	c3                   	ret    
    173f:	90                   	nop

00001740 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1740:	55                   	push   %ebp
    1741:	89 e5                	mov    %esp,%ebp
    1743:	57                   	push   %edi
    1744:	56                   	push   %esi
    1745:	53                   	push   %ebx
    1746:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1749:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    174c:	8b 3d a8 1b 00 00    	mov    0x1ba8,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1752:	8d 70 07             	lea    0x7(%eax),%esi
    1755:	c1 ee 03             	shr    $0x3,%esi
    1758:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    175b:	85 ff                	test   %edi,%edi
    175d:	0f 84 ad 00 00 00    	je     1810 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1763:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1765:	8b 48 04             	mov    0x4(%eax),%ecx
    1768:	39 f1                	cmp    %esi,%ecx
    176a:	73 71                	jae    17dd <malloc+0x9d>
    176c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1772:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1777:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    177a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1781:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1784:	eb 1b                	jmp    17a1 <malloc+0x61>
    1786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    178d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1790:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1792:	8b 4a 04             	mov    0x4(%edx),%ecx
    1795:	39 f1                	cmp    %esi,%ecx
    1797:	73 4f                	jae    17e8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1799:	8b 3d a8 1b 00 00    	mov    0x1ba8,%edi
    179f:	89 d0                	mov    %edx,%eax
    17a1:	39 c7                	cmp    %eax,%edi
    17a3:	75 eb                	jne    1790 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    17a5:	83 ec 0c             	sub    $0xc,%esp
    17a8:	ff 75 e4             	pushl  -0x1c(%ebp)
    17ab:	e8 41 fc ff ff       	call   13f1 <sbrk>
  if(p == (char*)-1)
    17b0:	83 c4 10             	add    $0x10,%esp
    17b3:	83 f8 ff             	cmp    $0xffffffff,%eax
    17b6:	74 1b                	je     17d3 <malloc+0x93>
  hp->s.size = nu;
    17b8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    17bb:	83 ec 0c             	sub    $0xc,%esp
    17be:	83 c0 08             	add    $0x8,%eax
    17c1:	50                   	push   %eax
    17c2:	e8 e9 fe ff ff       	call   16b0 <free>
  return freep;
    17c7:	a1 a8 1b 00 00       	mov    0x1ba8,%eax
      if((p = morecore(nunits)) == 0)
    17cc:	83 c4 10             	add    $0x10,%esp
    17cf:	85 c0                	test   %eax,%eax
    17d1:	75 bd                	jne    1790 <malloc+0x50>
        return 0;
  }
}
    17d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    17d6:	31 c0                	xor    %eax,%eax
}
    17d8:	5b                   	pop    %ebx
    17d9:	5e                   	pop    %esi
    17da:	5f                   	pop    %edi
    17db:	5d                   	pop    %ebp
    17dc:	c3                   	ret    
    if(p->s.size >= nunits){
    17dd:	89 c2                	mov    %eax,%edx
    17df:	89 f8                	mov    %edi,%eax
    17e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    17e8:	39 ce                	cmp    %ecx,%esi
    17ea:	74 54                	je     1840 <malloc+0x100>
        p->s.size -= nunits;
    17ec:	29 f1                	sub    %esi,%ecx
    17ee:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    17f1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    17f4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    17f7:	a3 a8 1b 00 00       	mov    %eax,0x1ba8
}
    17fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    17ff:	8d 42 08             	lea    0x8(%edx),%eax
}
    1802:	5b                   	pop    %ebx
    1803:	5e                   	pop    %esi
    1804:	5f                   	pop    %edi
    1805:	5d                   	pop    %ebp
    1806:	c3                   	ret    
    1807:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    180e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    1810:	c7 05 a8 1b 00 00 ac 	movl   $0x1bac,0x1ba8
    1817:	1b 00 00 
    base.s.size = 0;
    181a:	bf ac 1b 00 00       	mov    $0x1bac,%edi
    base.s.ptr = freep = prevp = &base;
    181f:	c7 05 ac 1b 00 00 ac 	movl   $0x1bac,0x1bac
    1826:	1b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1829:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    182b:	c7 05 b0 1b 00 00 00 	movl   $0x0,0x1bb0
    1832:	00 00 00 
    if(p->s.size >= nunits){
    1835:	e9 32 ff ff ff       	jmp    176c <malloc+0x2c>
    183a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1840:	8b 0a                	mov    (%edx),%ecx
    1842:	89 08                	mov    %ecx,(%eax)
    1844:	eb b1                	jmp    17f7 <malloc+0xb7>
