
_init:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	53                   	push   %ebx
    100e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    100f:	83 ec 08             	sub    $0x8,%esp
    1012:	6a 02                	push   $0x2
    1014:	68 98 18 00 00       	push   $0x1898
    1019:	e8 db 03 00 00       	call   13f9 <open>
    101e:	83 c4 10             	add    $0x10,%esp
    1021:	85 c0                	test   %eax,%eax
    1023:	0f 88 9f 00 00 00    	js     10c8 <main+0xc8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
    1029:	83 ec 0c             	sub    $0xc,%esp
    102c:	6a 00                	push   $0x0
    102e:	e8 fe 03 00 00       	call   1431 <dup>
  dup(0);  // stderr
    1033:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    103a:	e8 f2 03 00 00       	call   1431 <dup>
    103f:	83 c4 10             	add    $0x10,%esp
    1042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
    1048:	83 ec 08             	sub    $0x8,%esp
    104b:	68 a0 18 00 00       	push   $0x18a0
    1050:	6a 01                	push   $0x1
    1052:	e8 d9 04 00 00       	call   1530 <printf>
    pid = fork();
    1057:	e8 55 03 00 00       	call   13b1 <fork>
    if(pid < 0){
    105c:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    105f:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    1061:	85 c0                	test   %eax,%eax
    1063:	78 2c                	js     1091 <main+0x91>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
    1065:	74 3d                	je     10a4 <main+0xa4>
    1067:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    106e:	66 90                	xchg   %ax,%ax
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
    1070:	e8 4c 03 00 00       	call   13c1 <wait>
    1075:	85 c0                	test   %eax,%eax
    1077:	78 cf                	js     1048 <main+0x48>
    1079:	39 c3                	cmp    %eax,%ebx
    107b:	74 cb                	je     1048 <main+0x48>
      printf(1, "zombie!\n");
    107d:	83 ec 08             	sub    $0x8,%esp
    1080:	68 df 18 00 00       	push   $0x18df
    1085:	6a 01                	push   $0x1
    1087:	e8 a4 04 00 00       	call   1530 <printf>
    108c:	83 c4 10             	add    $0x10,%esp
    108f:	eb df                	jmp    1070 <main+0x70>
      printf(1, "init: fork failed\n");
    1091:	53                   	push   %ebx
    1092:	53                   	push   %ebx
    1093:	68 b3 18 00 00       	push   $0x18b3
    1098:	6a 01                	push   $0x1
    109a:	e8 91 04 00 00       	call   1530 <printf>
      exit();
    109f:	e8 15 03 00 00       	call   13b9 <exit>
      exec("sh", argv);
    10a4:	50                   	push   %eax
    10a5:	50                   	push   %eax
    10a6:	68 e8 1b 00 00       	push   $0x1be8
    10ab:	68 c6 18 00 00       	push   $0x18c6
    10b0:	e8 3c 03 00 00       	call   13f1 <exec>
      printf(1, "init: exec sh failed\n");
    10b5:	5a                   	pop    %edx
    10b6:	59                   	pop    %ecx
    10b7:	68 c9 18 00 00       	push   $0x18c9
    10bc:	6a 01                	push   $0x1
    10be:	e8 6d 04 00 00       	call   1530 <printf>
      exit();
    10c3:	e8 f1 02 00 00       	call   13b9 <exit>
    mknod("console", 1, 1);
    10c8:	50                   	push   %eax
    10c9:	6a 01                	push   $0x1
    10cb:	6a 01                	push   $0x1
    10cd:	68 98 18 00 00       	push   $0x1898
    10d2:	e8 2a 03 00 00       	call   1401 <mknod>
    open("console", O_RDWR);
    10d7:	58                   	pop    %eax
    10d8:	5a                   	pop    %edx
    10d9:	6a 02                	push   $0x2
    10db:	68 98 18 00 00       	push   $0x1898
    10e0:	e8 14 03 00 00       	call   13f9 <open>
    10e5:	83 c4 10             	add    $0x10,%esp
    10e8:	e9 3c ff ff ff       	jmp    1029 <main+0x29>
    10ed:	66 90                	xchg   %ax,%ax
    10ef:	90                   	nop

000010f0 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"
char*
strcpy(char *s, const char *t)
{
    10f0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    10f1:	31 c0                	xor    %eax,%eax
{
    10f3:	89 e5                	mov    %esp,%ebp
    10f5:	53                   	push   %ebx
    10f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    1100:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    1104:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    1107:	83 c0 01             	add    $0x1,%eax
    110a:	84 d2                	test   %dl,%dl
    110c:	75 f2                	jne    1100 <strcpy+0x10>
    ;
  return os;
}
    110e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1111:	89 c8                	mov    %ecx,%eax
    1113:	c9                   	leave  
    1114:	c3                   	ret    
    1115:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    111c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	53                   	push   %ebx
    1124:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1127:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    112a:	0f b6 01             	movzbl (%ecx),%eax
    112d:	0f b6 1a             	movzbl (%edx),%ebx
    1130:	84 c0                	test   %al,%al
    1132:	75 1d                	jne    1151 <strcmp+0x31>
    1134:	eb 2a                	jmp    1160 <strcmp+0x40>
    1136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    113d:	8d 76 00             	lea    0x0(%esi),%esi
    1140:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    1144:	83 c1 01             	add    $0x1,%ecx
    1147:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    114a:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    114d:	84 c0                	test   %al,%al
    114f:	74 0f                	je     1160 <strcmp+0x40>
    1151:	38 d8                	cmp    %bl,%al
    1153:	74 eb                	je     1140 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1155:	29 d8                	sub    %ebx,%eax
}
    1157:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    115a:	c9                   	leave  
    115b:	c3                   	ret    
    115c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1160:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1162:	29 d8                	sub    %ebx,%eax
}
    1164:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1167:	c9                   	leave  
    1168:	c3                   	ret    
    1169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001170 <strlen>:

uint
strlen(const char *s)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    1176:	80 3a 00             	cmpb   $0x0,(%edx)
    1179:	74 15                	je     1190 <strlen+0x20>
    117b:	31 c0                	xor    %eax,%eax
    117d:	8d 76 00             	lea    0x0(%esi),%esi
    1180:	83 c0 01             	add    $0x1,%eax
    1183:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    1187:	89 c1                	mov    %eax,%ecx
    1189:	75 f5                	jne    1180 <strlen+0x10>
    ;
  return n;
}
    118b:	89 c8                	mov    %ecx,%eax
    118d:	5d                   	pop    %ebp
    118e:	c3                   	ret    
    118f:	90                   	nop
  for(n = 0; s[n]; n++)
    1190:	31 c9                	xor    %ecx,%ecx
}
    1192:	5d                   	pop    %ebp
    1193:	89 c8                	mov    %ecx,%eax
    1195:	c3                   	ret    
    1196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    119d:	8d 76 00             	lea    0x0(%esi),%esi

000011a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	57                   	push   %edi
    11a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ad:	89 d7                	mov    %edx,%edi
    11af:	fc                   	cld    
    11b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    11b2:	8b 7d fc             	mov    -0x4(%ebp),%edi
    11b5:	89 d0                	mov    %edx,%eax
    11b7:	c9                   	leave  
    11b8:	c3                   	ret    
    11b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000011c0 <strchr>:

char*
strchr(const char *s, char c)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	8b 45 08             	mov    0x8(%ebp),%eax
    11c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    11ca:	0f b6 10             	movzbl (%eax),%edx
    11cd:	84 d2                	test   %dl,%dl
    11cf:	75 12                	jne    11e3 <strchr+0x23>
    11d1:	eb 1d                	jmp    11f0 <strchr+0x30>
    11d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11d7:	90                   	nop
    11d8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    11dc:	83 c0 01             	add    $0x1,%eax
    11df:	84 d2                	test   %dl,%dl
    11e1:	74 0d                	je     11f0 <strchr+0x30>
    if(*s == c)
    11e3:	38 d1                	cmp    %dl,%cl
    11e5:	75 f1                	jne    11d8 <strchr+0x18>
      return (char*)s;
  return 0;
}
    11e7:	5d                   	pop    %ebp
    11e8:	c3                   	ret    
    11e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    11f0:	31 c0                	xor    %eax,%eax
}
    11f2:	5d                   	pop    %ebp
    11f3:	c3                   	ret    
    11f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11ff:	90                   	nop

00001200 <gets>:

char*
gets(char *buf, int max)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	57                   	push   %edi
    1204:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1205:	31 f6                	xor    %esi,%esi
{
    1207:	53                   	push   %ebx
    1208:	89 f3                	mov    %esi,%ebx
    120a:	83 ec 1c             	sub    $0x1c,%esp
    120d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1210:	eb 2f                	jmp    1241 <gets+0x41>
    1212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1218:	83 ec 04             	sub    $0x4,%esp
    121b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    121e:	6a 01                	push   $0x1
    1220:	50                   	push   %eax
    1221:	6a 00                	push   $0x0
    1223:	e8 a9 01 00 00       	call   13d1 <read>
    if(cc < 1)
    1228:	83 c4 10             	add    $0x10,%esp
    122b:	85 c0                	test   %eax,%eax
    122d:	7e 1c                	jle    124b <gets+0x4b>
      break;
    buf[i++] = c;
    122f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    1233:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    1236:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1239:	3c 0a                	cmp    $0xa,%al
    123b:	74 23                	je     1260 <gets+0x60>
    123d:	3c 0d                	cmp    $0xd,%al
    123f:	74 1f                	je     1260 <gets+0x60>
  for(i=0; i+1 < max; ){
    1241:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    1244:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    1246:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1249:	7c cd                	jl     1218 <gets+0x18>
    124b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1250:	c6 03 00             	movb   $0x0,(%ebx)
}
    1253:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1256:	5b                   	pop    %ebx
    1257:	5e                   	pop    %esi
    1258:	5f                   	pop    %edi
    1259:	5d                   	pop    %ebp
    125a:	c3                   	ret    
    125b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    125f:	90                   	nop
  buf[i] = '\0';
    1260:	8b 75 08             	mov    0x8(%ebp),%esi
}
    1263:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1266:	01 de                	add    %ebx,%esi
    1268:	89 f3                	mov    %esi,%ebx
    126a:	c6 03 00             	movb   $0x0,(%ebx)
}
    126d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1270:	5b                   	pop    %ebx
    1271:	5e                   	pop    %esi
    1272:	5f                   	pop    %edi
    1273:	5d                   	pop    %ebp
    1274:	c3                   	ret    
    1275:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    127c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001280 <stat>:

int
stat(const char *n, struct stat *st)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	56                   	push   %esi
    1284:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1285:	83 ec 08             	sub    $0x8,%esp
    1288:	6a 00                	push   $0x0
    128a:	ff 75 08             	pushl  0x8(%ebp)
    128d:	e8 67 01 00 00       	call   13f9 <open>
  if(fd < 0)
    1292:	83 c4 10             	add    $0x10,%esp
    1295:	85 c0                	test   %eax,%eax
    1297:	78 27                	js     12c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1299:	83 ec 08             	sub    $0x8,%esp
    129c:	ff 75 0c             	pushl  0xc(%ebp)
    129f:	89 c3                	mov    %eax,%ebx
    12a1:	50                   	push   %eax
    12a2:	e8 6a 01 00 00       	call   1411 <fstat>
  close(fd);
    12a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    12aa:	89 c6                	mov    %eax,%esi
  close(fd);
    12ac:	e8 30 01 00 00       	call   13e1 <close>
  return r;
    12b1:	83 c4 10             	add    $0x10,%esp
}
    12b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    12b7:	89 f0                	mov    %esi,%eax
    12b9:	5b                   	pop    %ebx
    12ba:	5e                   	pop    %esi
    12bb:	5d                   	pop    %ebp
    12bc:	c3                   	ret    
    12bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    12c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    12c5:	eb ed                	jmp    12b4 <stat+0x34>
    12c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12ce:	66 90                	xchg   %ax,%ax

000012d0 <atoi>:

int
atoi(const char *s)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	53                   	push   %ebx
    12d4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12d7:	0f be 02             	movsbl (%edx),%eax
    12da:	8d 48 d0             	lea    -0x30(%eax),%ecx
    12dd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    12e0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    12e5:	77 1e                	ja     1305 <atoi+0x35>
    12e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12ee:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    12f0:	83 c2 01             	add    $0x1,%edx
    12f3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    12f6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    12fa:	0f be 02             	movsbl (%edx),%eax
    12fd:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1300:	80 fb 09             	cmp    $0x9,%bl
    1303:	76 eb                	jbe    12f0 <atoi+0x20>
  return n;
}
    1305:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1308:	89 c8                	mov    %ecx,%eax
    130a:	c9                   	leave  
    130b:	c3                   	ret    
    130c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	57                   	push   %edi
    1314:	8b 45 10             	mov    0x10(%ebp),%eax
    1317:	8b 55 08             	mov    0x8(%ebp),%edx
    131a:	56                   	push   %esi
    131b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    131e:	85 c0                	test   %eax,%eax
    1320:	7e 13                	jle    1335 <memmove+0x25>
    1322:	01 d0                	add    %edx,%eax
  dst = vdst;
    1324:	89 d7                	mov    %edx,%edi
    1326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    132d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    1330:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    1331:	39 f8                	cmp    %edi,%eax
    1333:	75 fb                	jne    1330 <memmove+0x20>
  return vdst;
}
    1335:	5e                   	pop    %esi
    1336:	89 d0                	mov    %edx,%eax
    1338:	5f                   	pop    %edi
    1339:	5d                   	pop    %ebp
    133a:	c3                   	ret    
    133b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    133f:	90                   	nop

00001340 <thread_create>:


int thread_create(void (*start_routine)(void*, void*), void *arg1, void *arg2) {
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	53                   	push   %ebx
    1344:	83 ec 20             	sub    $0x20,%esp
  void *stack =  malloc(4096);
    1347:	68 00 10 00 00       	push   $0x1000
    134c:	e8 3f 04 00 00       	call   1790 <malloc>
  if(stack == 0)
    1351:	83 c4 10             	add    $0x10,%esp
    1354:	85 c0                	test   %eax,%eax
    1356:	74 3f                	je     1397 <thread_create+0x57>
    return -1;
  int r= clone(start_routine, arg1, arg2, stack);
    1358:	50                   	push   %eax
    1359:	89 c3                	mov    %eax,%ebx
    135b:	ff 75 10             	pushl  0x10(%ebp)
    135e:	ff 75 0c             	pushl  0xc(%ebp)
    1361:	ff 75 08             	pushl  0x8(%ebp)
    1364:	e8 00 01 00 00       	call   1469 <clone>
  if(r==-1) 
    1369:	83 c4 10             	add    $0x10,%esp
    136c:	83 f8 ff             	cmp    $0xffffffff,%eax
    136f:	74 0f                	je     1380 <thread_create+0x40>
    free(stack);
  return r;
}
    1371:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1374:	c9                   	leave  
    1375:	c3                   	ret    
    1376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    137d:	8d 76 00             	lea    0x0(%esi),%esi
    free(stack);
    1380:	83 ec 0c             	sub    $0xc,%esp
    1383:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1386:	53                   	push   %ebx
    1387:	e8 74 03 00 00       	call   1700 <free>
    138c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    138f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    free(stack);
    1392:	83 c4 10             	add    $0x10,%esp
}
    1395:	c9                   	leave  
    1396:	c3                   	ret    
    return -1;
    1397:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    139c:	eb d3                	jmp    1371 <thread_create+0x31>
    139e:	66 90                	xchg   %ax,%ax

000013a0 <thread_join>:


int thread_join(void) {
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	83 ec 24             	sub    $0x24,%esp
  void *stack;
  int r = join(&stack);
    13a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13a9:	50                   	push   %eax
    13aa:	e8 c2 00 00 00       	call   1471 <join>
  return r;
}
    13af:	c9                   	leave  
    13b0:	c3                   	ret    

000013b1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13b1:	b8 01 00 00 00       	mov    $0x1,%eax
    13b6:	cd 40                	int    $0x40
    13b8:	c3                   	ret    

000013b9 <exit>:
SYSCALL(exit)
    13b9:	b8 02 00 00 00       	mov    $0x2,%eax
    13be:	cd 40                	int    $0x40
    13c0:	c3                   	ret    

000013c1 <wait>:
SYSCALL(wait)
    13c1:	b8 03 00 00 00       	mov    $0x3,%eax
    13c6:	cd 40                	int    $0x40
    13c8:	c3                   	ret    

000013c9 <pipe>:
SYSCALL(pipe)
    13c9:	b8 04 00 00 00       	mov    $0x4,%eax
    13ce:	cd 40                	int    $0x40
    13d0:	c3                   	ret    

000013d1 <read>:
SYSCALL(read)
    13d1:	b8 05 00 00 00       	mov    $0x5,%eax
    13d6:	cd 40                	int    $0x40
    13d8:	c3                   	ret    

000013d9 <write>:
SYSCALL(write)
    13d9:	b8 10 00 00 00       	mov    $0x10,%eax
    13de:	cd 40                	int    $0x40
    13e0:	c3                   	ret    

000013e1 <close>:
SYSCALL(close)
    13e1:	b8 15 00 00 00       	mov    $0x15,%eax
    13e6:	cd 40                	int    $0x40
    13e8:	c3                   	ret    

000013e9 <kill>:
SYSCALL(kill)
    13e9:	b8 06 00 00 00       	mov    $0x6,%eax
    13ee:	cd 40                	int    $0x40
    13f0:	c3                   	ret    

000013f1 <exec>:
SYSCALL(exec)
    13f1:	b8 07 00 00 00       	mov    $0x7,%eax
    13f6:	cd 40                	int    $0x40
    13f8:	c3                   	ret    

000013f9 <open>:
SYSCALL(open)
    13f9:	b8 0f 00 00 00       	mov    $0xf,%eax
    13fe:	cd 40                	int    $0x40
    1400:	c3                   	ret    

00001401 <mknod>:
SYSCALL(mknod)
    1401:	b8 11 00 00 00       	mov    $0x11,%eax
    1406:	cd 40                	int    $0x40
    1408:	c3                   	ret    

00001409 <unlink>:
SYSCALL(unlink)
    1409:	b8 12 00 00 00       	mov    $0x12,%eax
    140e:	cd 40                	int    $0x40
    1410:	c3                   	ret    

00001411 <fstat>:
SYSCALL(fstat)
    1411:	b8 08 00 00 00       	mov    $0x8,%eax
    1416:	cd 40                	int    $0x40
    1418:	c3                   	ret    

00001419 <link>:
SYSCALL(link)
    1419:	b8 13 00 00 00       	mov    $0x13,%eax
    141e:	cd 40                	int    $0x40
    1420:	c3                   	ret    

00001421 <mkdir>:
SYSCALL(mkdir)
    1421:	b8 14 00 00 00       	mov    $0x14,%eax
    1426:	cd 40                	int    $0x40
    1428:	c3                   	ret    

00001429 <chdir>:
SYSCALL(chdir)
    1429:	b8 09 00 00 00       	mov    $0x9,%eax
    142e:	cd 40                	int    $0x40
    1430:	c3                   	ret    

00001431 <dup>:
SYSCALL(dup)
    1431:	b8 0a 00 00 00       	mov    $0xa,%eax
    1436:	cd 40                	int    $0x40
    1438:	c3                   	ret    

00001439 <getpid>:
SYSCALL(getpid)
    1439:	b8 0b 00 00 00       	mov    $0xb,%eax
    143e:	cd 40                	int    $0x40
    1440:	c3                   	ret    

00001441 <sbrk>:
SYSCALL(sbrk)
    1441:	b8 0c 00 00 00       	mov    $0xc,%eax
    1446:	cd 40                	int    $0x40
    1448:	c3                   	ret    

00001449 <sleep>:
SYSCALL(sleep)
    1449:	b8 0d 00 00 00       	mov    $0xd,%eax
    144e:	cd 40                	int    $0x40
    1450:	c3                   	ret    

00001451 <uptime>:
SYSCALL(uptime)
    1451:	b8 0e 00 00 00       	mov    $0xe,%eax
    1456:	cd 40                	int    $0x40
    1458:	c3                   	ret    

00001459 <mprotect>:
SYSCALL(mprotect)
    1459:	b8 16 00 00 00       	mov    $0x16,%eax
    145e:	cd 40                	int    $0x40
    1460:	c3                   	ret    

00001461 <munprotect>:
SYSCALL(munprotect)
    1461:	b8 17 00 00 00       	mov    $0x17,%eax
    1466:	cd 40                	int    $0x40
    1468:	c3                   	ret    

00001469 <clone>:
SYSCALL(clone)
    1469:	b8 18 00 00 00       	mov    $0x18,%eax
    146e:	cd 40                	int    $0x40
    1470:	c3                   	ret    

00001471 <join>:
SYSCALL(join)
    1471:	b8 19 00 00 00       	mov    $0x19,%eax
    1476:	cd 40                	int    $0x40
    1478:	c3                   	ret    
    1479:	66 90                	xchg   %ax,%ax
    147b:	66 90                	xchg   %ax,%ax
    147d:	66 90                	xchg   %ax,%ax
    147f:	90                   	nop

00001480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1480:	55                   	push   %ebp
    1481:	89 e5                	mov    %esp,%ebp
    1483:	57                   	push   %edi
    1484:	56                   	push   %esi
    1485:	53                   	push   %ebx
    1486:	83 ec 3c             	sub    $0x3c,%esp
    1489:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    148c:	89 d1                	mov    %edx,%ecx
{
    148e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    1491:	85 d2                	test   %edx,%edx
    1493:	0f 89 7f 00 00 00    	jns    1518 <printint+0x98>
    1499:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    149d:	74 79                	je     1518 <printint+0x98>
    neg = 1;
    149f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    14a6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    14a8:	31 db                	xor    %ebx,%ebx
    14aa:	8d 75 d7             	lea    -0x29(%ebp),%esi
    14ad:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    14b0:	89 c8                	mov    %ecx,%eax
    14b2:	31 d2                	xor    %edx,%edx
    14b4:	89 cf                	mov    %ecx,%edi
    14b6:	f7 75 c4             	divl   -0x3c(%ebp)
    14b9:	0f b6 92 f0 18 00 00 	movzbl 0x18f0(%edx),%edx
    14c0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    14c3:	89 d8                	mov    %ebx,%eax
    14c5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    14c8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    14cb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    14ce:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    14d1:	76 dd                	jbe    14b0 <printint+0x30>
  if(neg)
    14d3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    14d6:	85 c9                	test   %ecx,%ecx
    14d8:	74 0c                	je     14e6 <printint+0x66>
    buf[i++] = '-';
    14da:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    14df:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    14e1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    14e6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    14e9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    14ed:	eb 07                	jmp    14f6 <printint+0x76>
    14ef:	90                   	nop
    putc(fd, buf[i]);
    14f0:	0f b6 13             	movzbl (%ebx),%edx
    14f3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    14f6:	83 ec 04             	sub    $0x4,%esp
    14f9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    14fc:	6a 01                	push   $0x1
    14fe:	56                   	push   %esi
    14ff:	57                   	push   %edi
    1500:	e8 d4 fe ff ff       	call   13d9 <write>
  while(--i >= 0)
    1505:	83 c4 10             	add    $0x10,%esp
    1508:	39 de                	cmp    %ebx,%esi
    150a:	75 e4                	jne    14f0 <printint+0x70>
}
    150c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    150f:	5b                   	pop    %ebx
    1510:	5e                   	pop    %esi
    1511:	5f                   	pop    %edi
    1512:	5d                   	pop    %ebp
    1513:	c3                   	ret    
    1514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1518:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    151f:	eb 87                	jmp    14a8 <printint+0x28>
    1521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1528:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    152f:	90                   	nop

00001530 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1530:	55                   	push   %ebp
    1531:	89 e5                	mov    %esp,%ebp
    1533:	57                   	push   %edi
    1534:	56                   	push   %esi
    1535:	53                   	push   %ebx
    1536:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1539:	8b 75 0c             	mov    0xc(%ebp),%esi
    153c:	0f b6 1e             	movzbl (%esi),%ebx
    153f:	84 db                	test   %bl,%bl
    1541:	0f 84 b8 00 00 00    	je     15ff <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    1547:	8d 45 10             	lea    0x10(%ebp),%eax
    154a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    154d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    1550:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    1552:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1555:	eb 37                	jmp    158e <printf+0x5e>
    1557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    155e:	66 90                	xchg   %ax,%ax
    1560:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    1563:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1568:	83 f8 25             	cmp    $0x25,%eax
    156b:	74 17                	je     1584 <printf+0x54>
  write(fd, &c, 1);
    156d:	83 ec 04             	sub    $0x4,%esp
    1570:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1573:	6a 01                	push   $0x1
    1575:	57                   	push   %edi
    1576:	ff 75 08             	pushl  0x8(%ebp)
    1579:	e8 5b fe ff ff       	call   13d9 <write>
    157e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    1581:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1584:	0f b6 1e             	movzbl (%esi),%ebx
    1587:	83 c6 01             	add    $0x1,%esi
    158a:	84 db                	test   %bl,%bl
    158c:	74 71                	je     15ff <printf+0xcf>
    c = fmt[i] & 0xff;
    158e:	0f be cb             	movsbl %bl,%ecx
    1591:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1594:	85 d2                	test   %edx,%edx
    1596:	74 c8                	je     1560 <printf+0x30>
      }
    } else if(state == '%'){
    1598:	83 fa 25             	cmp    $0x25,%edx
    159b:	75 e7                	jne    1584 <printf+0x54>
      if(c == 'd'){
    159d:	83 f8 64             	cmp    $0x64,%eax
    15a0:	0f 84 9a 00 00 00    	je     1640 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    15a6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    15ac:	83 f9 70             	cmp    $0x70,%ecx
    15af:	74 5f                	je     1610 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    15b1:	83 f8 73             	cmp    $0x73,%eax
    15b4:	0f 84 d6 00 00 00    	je     1690 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15ba:	83 f8 63             	cmp    $0x63,%eax
    15bd:	0f 84 8d 00 00 00    	je     1650 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    15c3:	83 f8 25             	cmp    $0x25,%eax
    15c6:	0f 84 b4 00 00 00    	je     1680 <printf+0x150>
  write(fd, &c, 1);
    15cc:	83 ec 04             	sub    $0x4,%esp
    15cf:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    15d3:	6a 01                	push   $0x1
    15d5:	57                   	push   %edi
    15d6:	ff 75 08             	pushl  0x8(%ebp)
    15d9:	e8 fb fd ff ff       	call   13d9 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    15de:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    15e1:	83 c4 0c             	add    $0xc,%esp
    15e4:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    15e6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    15e9:	57                   	push   %edi
    15ea:	ff 75 08             	pushl  0x8(%ebp)
    15ed:	e8 e7 fd ff ff       	call   13d9 <write>
  for(i = 0; fmt[i]; i++){
    15f2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    15f6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15f9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    15fb:	84 db                	test   %bl,%bl
    15fd:	75 8f                	jne    158e <printf+0x5e>
    }
  }
}
    15ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1602:	5b                   	pop    %ebx
    1603:	5e                   	pop    %esi
    1604:	5f                   	pop    %edi
    1605:	5d                   	pop    %ebp
    1606:	c3                   	ret    
    1607:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    160e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    1610:	83 ec 0c             	sub    $0xc,%esp
    1613:	b9 10 00 00 00       	mov    $0x10,%ecx
    1618:	6a 00                	push   $0x0
    161a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    161d:	8b 45 08             	mov    0x8(%ebp),%eax
    1620:	8b 13                	mov    (%ebx),%edx
    1622:	e8 59 fe ff ff       	call   1480 <printint>
        ap++;
    1627:	89 d8                	mov    %ebx,%eax
    1629:	83 c4 10             	add    $0x10,%esp
      state = 0;
    162c:	31 d2                	xor    %edx,%edx
        ap++;
    162e:	83 c0 04             	add    $0x4,%eax
    1631:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1634:	e9 4b ff ff ff       	jmp    1584 <printf+0x54>
    1639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    1640:	83 ec 0c             	sub    $0xc,%esp
    1643:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1648:	6a 01                	push   $0x1
    164a:	eb ce                	jmp    161a <printf+0xea>
    164c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1650:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1653:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1656:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    1658:	6a 01                	push   $0x1
        ap++;
    165a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    165d:	57                   	push   %edi
    165e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    1661:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1664:	e8 70 fd ff ff       	call   13d9 <write>
        ap++;
    1669:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    166c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    166f:	31 d2                	xor    %edx,%edx
    1671:	e9 0e ff ff ff       	jmp    1584 <printf+0x54>
    1676:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    167d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    1680:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1683:	83 ec 04             	sub    $0x4,%esp
    1686:	e9 59 ff ff ff       	jmp    15e4 <printf+0xb4>
    168b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    168f:	90                   	nop
        s = (char*)*ap;
    1690:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1693:	8b 18                	mov    (%eax),%ebx
        ap++;
    1695:	83 c0 04             	add    $0x4,%eax
    1698:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    169b:	85 db                	test   %ebx,%ebx
    169d:	74 17                	je     16b6 <printf+0x186>
        while(*s != 0){
    169f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    16a2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    16a4:	84 c0                	test   %al,%al
    16a6:	0f 84 d8 fe ff ff    	je     1584 <printf+0x54>
    16ac:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    16af:	89 de                	mov    %ebx,%esi
    16b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16b4:	eb 1a                	jmp    16d0 <printf+0x1a0>
          s = "(null)";
    16b6:	bb e8 18 00 00       	mov    $0x18e8,%ebx
        while(*s != 0){
    16bb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    16be:	b8 28 00 00 00       	mov    $0x28,%eax
    16c3:	89 de                	mov    %ebx,%esi
    16c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    16cf:	90                   	nop
  write(fd, &c, 1);
    16d0:	83 ec 04             	sub    $0x4,%esp
          s++;
    16d3:	83 c6 01             	add    $0x1,%esi
    16d6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    16d9:	6a 01                	push   $0x1
    16db:	57                   	push   %edi
    16dc:	53                   	push   %ebx
    16dd:	e8 f7 fc ff ff       	call   13d9 <write>
        while(*s != 0){
    16e2:	0f b6 06             	movzbl (%esi),%eax
    16e5:	83 c4 10             	add    $0x10,%esp
    16e8:	84 c0                	test   %al,%al
    16ea:	75 e4                	jne    16d0 <printf+0x1a0>
      state = 0;
    16ec:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    16ef:	31 d2                	xor    %edx,%edx
    16f1:	e9 8e fe ff ff       	jmp    1584 <printf+0x54>
    16f6:	66 90                	xchg   %ax,%ax
    16f8:	66 90                	xchg   %ax,%ax
    16fa:	66 90                	xchg   %ax,%ax
    16fc:	66 90                	xchg   %ax,%ax
    16fe:	66 90                	xchg   %ax,%ax

00001700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1701:	a1 f0 1b 00 00       	mov    0x1bf0,%eax
{
    1706:	89 e5                	mov    %esp,%ebp
    1708:	57                   	push   %edi
    1709:	56                   	push   %esi
    170a:	53                   	push   %ebx
    170b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    170e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1718:	89 c2                	mov    %eax,%edx
    171a:	8b 00                	mov    (%eax),%eax
    171c:	39 ca                	cmp    %ecx,%edx
    171e:	73 30                	jae    1750 <free+0x50>
    1720:	39 c1                	cmp    %eax,%ecx
    1722:	72 04                	jb     1728 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1724:	39 c2                	cmp    %eax,%edx
    1726:	72 f0                	jb     1718 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1728:	8b 73 fc             	mov    -0x4(%ebx),%esi
    172b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    172e:	39 f8                	cmp    %edi,%eax
    1730:	74 30                	je     1762 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1732:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    1735:	8b 42 04             	mov    0x4(%edx),%eax
    1738:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    173b:	39 f1                	cmp    %esi,%ecx
    173d:	74 3a                	je     1779 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    173f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    1741:	5b                   	pop    %ebx
  freep = p;
    1742:	89 15 f0 1b 00 00    	mov    %edx,0x1bf0
}
    1748:	5e                   	pop    %esi
    1749:	5f                   	pop    %edi
    174a:	5d                   	pop    %ebp
    174b:	c3                   	ret    
    174c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1750:	39 c2                	cmp    %eax,%edx
    1752:	72 c4                	jb     1718 <free+0x18>
    1754:	39 c1                	cmp    %eax,%ecx
    1756:	73 c0                	jae    1718 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1758:	8b 73 fc             	mov    -0x4(%ebx),%esi
    175b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    175e:	39 f8                	cmp    %edi,%eax
    1760:	75 d0                	jne    1732 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    1762:	03 70 04             	add    0x4(%eax),%esi
    1765:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1768:	8b 02                	mov    (%edx),%eax
    176a:	8b 00                	mov    (%eax),%eax
    176c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    176f:	8b 42 04             	mov    0x4(%edx),%eax
    1772:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1775:	39 f1                	cmp    %esi,%ecx
    1777:	75 c6                	jne    173f <free+0x3f>
    p->s.size += bp->s.size;
    1779:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    177c:	89 15 f0 1b 00 00    	mov    %edx,0x1bf0
    p->s.size += bp->s.size;
    1782:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1785:	8b 43 f8             	mov    -0x8(%ebx),%eax
    1788:	89 02                	mov    %eax,(%edx)
}
    178a:	5b                   	pop    %ebx
    178b:	5e                   	pop    %esi
    178c:	5f                   	pop    %edi
    178d:	5d                   	pop    %ebp
    178e:	c3                   	ret    
    178f:	90                   	nop

00001790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1790:	55                   	push   %ebp
    1791:	89 e5                	mov    %esp,%ebp
    1793:	57                   	push   %edi
    1794:	56                   	push   %esi
    1795:	53                   	push   %ebx
    1796:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1799:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    179c:	8b 3d f0 1b 00 00    	mov    0x1bf0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17a2:	8d 70 07             	lea    0x7(%eax),%esi
    17a5:	c1 ee 03             	shr    $0x3,%esi
    17a8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    17ab:	85 ff                	test   %edi,%edi
    17ad:	0f 84 ad 00 00 00    	je     1860 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17b3:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    17b5:	8b 48 04             	mov    0x4(%eax),%ecx
    17b8:	39 f1                	cmp    %esi,%ecx
    17ba:	73 71                	jae    182d <malloc+0x9d>
    17bc:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    17c2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    17c7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    17ca:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    17d1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    17d4:	eb 1b                	jmp    17f1 <malloc+0x61>
    17d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17dd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17e0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    17e2:	8b 4a 04             	mov    0x4(%edx),%ecx
    17e5:	39 f1                	cmp    %esi,%ecx
    17e7:	73 4f                	jae    1838 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    17e9:	8b 3d f0 1b 00 00    	mov    0x1bf0,%edi
    17ef:	89 d0                	mov    %edx,%eax
    17f1:	39 c7                	cmp    %eax,%edi
    17f3:	75 eb                	jne    17e0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    17f5:	83 ec 0c             	sub    $0xc,%esp
    17f8:	ff 75 e4             	pushl  -0x1c(%ebp)
    17fb:	e8 41 fc ff ff       	call   1441 <sbrk>
  if(p == (char*)-1)
    1800:	83 c4 10             	add    $0x10,%esp
    1803:	83 f8 ff             	cmp    $0xffffffff,%eax
    1806:	74 1b                	je     1823 <malloc+0x93>
  hp->s.size = nu;
    1808:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    180b:	83 ec 0c             	sub    $0xc,%esp
    180e:	83 c0 08             	add    $0x8,%eax
    1811:	50                   	push   %eax
    1812:	e8 e9 fe ff ff       	call   1700 <free>
  return freep;
    1817:	a1 f0 1b 00 00       	mov    0x1bf0,%eax
      if((p = morecore(nunits)) == 0)
    181c:	83 c4 10             	add    $0x10,%esp
    181f:	85 c0                	test   %eax,%eax
    1821:	75 bd                	jne    17e0 <malloc+0x50>
        return 0;
  }
}
    1823:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1826:	31 c0                	xor    %eax,%eax
}
    1828:	5b                   	pop    %ebx
    1829:	5e                   	pop    %esi
    182a:	5f                   	pop    %edi
    182b:	5d                   	pop    %ebp
    182c:	c3                   	ret    
    if(p->s.size >= nunits){
    182d:	89 c2                	mov    %eax,%edx
    182f:	89 f8                	mov    %edi,%eax
    1831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1838:	39 ce                	cmp    %ecx,%esi
    183a:	74 54                	je     1890 <malloc+0x100>
        p->s.size -= nunits;
    183c:	29 f1                	sub    %esi,%ecx
    183e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    1841:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    1844:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    1847:	a3 f0 1b 00 00       	mov    %eax,0x1bf0
}
    184c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    184f:	8d 42 08             	lea    0x8(%edx),%eax
}
    1852:	5b                   	pop    %ebx
    1853:	5e                   	pop    %esi
    1854:	5f                   	pop    %edi
    1855:	5d                   	pop    %ebp
    1856:	c3                   	ret    
    1857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    185e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    1860:	c7 05 f0 1b 00 00 f4 	movl   $0x1bf4,0x1bf0
    1867:	1b 00 00 
    base.s.size = 0;
    186a:	bf f4 1b 00 00       	mov    $0x1bf4,%edi
    base.s.ptr = freep = prevp = &base;
    186f:	c7 05 f4 1b 00 00 f4 	movl   $0x1bf4,0x1bf4
    1876:	1b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1879:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    187b:	c7 05 f8 1b 00 00 00 	movl   $0x0,0x1bf8
    1882:	00 00 00 
    if(p->s.size >= nunits){
    1885:	e9 32 ff ff ff       	jmp    17bc <malloc+0x2c>
    188a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1890:	8b 0a                	mov    (%edx),%ecx
    1892:	89 08                	mov    %ecx,(%eax)
    1894:	eb b1                	jmp    1847 <malloc+0xb7>
