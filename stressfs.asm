
_stressfs:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
  int fd, i;
  char path[] = "stressfs0";
    1007:	b8 30 00 00 00       	mov    $0x30,%eax
{
    100c:	ff 71 fc             	pushl  -0x4(%ecx)
    100f:	55                   	push   %ebp
    1010:	89 e5                	mov    %esp,%ebp
    1012:	57                   	push   %edi
    1013:	56                   	push   %esi
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));
    1014:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
{
    101a:	53                   	push   %ebx

  for(i = 0; i < 4; i++)
    101b:	31 db                	xor    %ebx,%ebx
{
    101d:	51                   	push   %ecx
    101e:	81 ec 20 02 00 00    	sub    $0x220,%esp
  char path[] = "stressfs0";
    1024:	66 89 85 e6 fd ff ff 	mov    %ax,-0x21a(%ebp)
  printf(1, "stressfs starting\n");
    102b:	68 08 19 00 00       	push   $0x1908
    1030:	6a 01                	push   $0x1
  char path[] = "stressfs0";
    1032:	c7 85 de fd ff ff 73 	movl   $0x65727473,-0x222(%ebp)
    1039:	74 72 65 
    103c:	c7 85 e2 fd ff ff 73 	movl   $0x73667373,-0x21e(%ebp)
    1043:	73 66 73 
  printf(1, "stressfs starting\n");
    1046:	e8 55 05 00 00       	call   15a0 <printf>
  memset(data, 'a', sizeof(data));
    104b:	83 c4 0c             	add    $0xc,%esp
    104e:	68 00 02 00 00       	push   $0x200
    1053:	6a 61                	push   $0x61
    1055:	56                   	push   %esi
    1056:	e8 95 01 00 00       	call   11f0 <memset>
    105b:	83 c4 10             	add    $0x10,%esp
    if(fork() > 0)
    105e:	e8 9e 03 00 00       	call   1401 <fork>
    1063:	85 c0                	test   %eax,%eax
    1065:	0f 8f bf 00 00 00    	jg     112a <main+0x12a>
  for(i = 0; i < 4; i++)
    106b:	83 c3 01             	add    $0x1,%ebx
    106e:	83 fb 04             	cmp    $0x4,%ebx
    1071:	75 eb                	jne    105e <main+0x5e>
    1073:	bf 04 00 00 00       	mov    $0x4,%edi
      break;

  printf(1, "write %d\n", i);
    1078:	83 ec 04             	sub    $0x4,%esp
    107b:	53                   	push   %ebx

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
    107c:	bb 14 00 00 00       	mov    $0x14,%ebx
  printf(1, "write %d\n", i);
    1081:	68 1b 19 00 00       	push   $0x191b
    1086:	6a 01                	push   $0x1
    1088:	e8 13 05 00 00       	call   15a0 <printf>
  path[8] += i;
    108d:	89 f8                	mov    %edi,%eax
  fd = open(path, O_CREATE | O_RDWR);
    108f:	5f                   	pop    %edi
  path[8] += i;
    1090:	00 85 e6 fd ff ff    	add    %al,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
    1096:	58                   	pop    %eax
    1097:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
    109d:	68 02 02 00 00       	push   $0x202
    10a2:	50                   	push   %eax
    10a3:	e8 a1 03 00 00       	call   1449 <open>
    10a8:	83 c4 10             	add    $0x10,%esp
    10ab:	89 c7                	mov    %eax,%edi
  for(i = 0; i < 20; i++)
    10ad:	8d 76 00             	lea    0x0(%esi),%esi
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
    10b0:	83 ec 04             	sub    $0x4,%esp
    10b3:	68 00 02 00 00       	push   $0x200
    10b8:	56                   	push   %esi
    10b9:	57                   	push   %edi
    10ba:	e8 6a 03 00 00       	call   1429 <write>
  for(i = 0; i < 20; i++)
    10bf:	83 c4 10             	add    $0x10,%esp
    10c2:	83 eb 01             	sub    $0x1,%ebx
    10c5:	75 e9                	jne    10b0 <main+0xb0>
  close(fd);
    10c7:	83 ec 0c             	sub    $0xc,%esp
    10ca:	57                   	push   %edi
    10cb:	e8 61 03 00 00       	call   1431 <close>

  printf(1, "read\n");
    10d0:	58                   	pop    %eax
    10d1:	5a                   	pop    %edx
    10d2:	68 25 19 00 00       	push   $0x1925
    10d7:	6a 01                	push   $0x1
    10d9:	e8 c2 04 00 00       	call   15a0 <printf>

  fd = open(path, O_RDONLY);
    10de:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
    10e4:	59                   	pop    %ecx
    10e5:	5b                   	pop    %ebx
    10e6:	6a 00                	push   $0x0
    10e8:	bb 14 00 00 00       	mov    $0x14,%ebx
    10ed:	50                   	push   %eax
    10ee:	e8 56 03 00 00       	call   1449 <open>
    10f3:	83 c4 10             	add    $0x10,%esp
    10f6:	89 c7                	mov    %eax,%edi
  for (i = 0; i < 20; i++)
    10f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10ff:	90                   	nop
    read(fd, data, sizeof(data));
    1100:	83 ec 04             	sub    $0x4,%esp
    1103:	68 00 02 00 00       	push   $0x200
    1108:	56                   	push   %esi
    1109:	57                   	push   %edi
    110a:	e8 12 03 00 00       	call   1421 <read>
  for (i = 0; i < 20; i++)
    110f:	83 c4 10             	add    $0x10,%esp
    1112:	83 eb 01             	sub    $0x1,%ebx
    1115:	75 e9                	jne    1100 <main+0x100>
  close(fd);
    1117:	83 ec 0c             	sub    $0xc,%esp
    111a:	57                   	push   %edi
    111b:	e8 11 03 00 00       	call   1431 <close>

  wait();
    1120:	e8 ec 02 00 00       	call   1411 <wait>

  exit();
    1125:	e8 df 02 00 00       	call   1409 <exit>
  path[8] += i;
    112a:	89 df                	mov    %ebx,%edi
    112c:	e9 47 ff ff ff       	jmp    1078 <main+0x78>
    1131:	66 90                	xchg   %ax,%ax
    1133:	66 90                	xchg   %ax,%ax
    1135:	66 90                	xchg   %ax,%ax
    1137:	66 90                	xchg   %ax,%ax
    1139:	66 90                	xchg   %ax,%ax
    113b:	66 90                	xchg   %ax,%ax
    113d:	66 90                	xchg   %ax,%ax
    113f:	90                   	nop

00001140 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"
char*
strcpy(char *s, const char *t)
{
    1140:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1141:	31 c0                	xor    %eax,%eax
{
    1143:	89 e5                	mov    %esp,%ebp
    1145:	53                   	push   %ebx
    1146:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1149:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    1150:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    1154:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    1157:	83 c0 01             	add    $0x1,%eax
    115a:	84 d2                	test   %dl,%dl
    115c:	75 f2                	jne    1150 <strcpy+0x10>
    ;
  return os;
}
    115e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1161:	89 c8                	mov    %ecx,%eax
    1163:	c9                   	leave  
    1164:	c3                   	ret    
    1165:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    116c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	53                   	push   %ebx
    1174:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1177:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    117a:	0f b6 01             	movzbl (%ecx),%eax
    117d:	0f b6 1a             	movzbl (%edx),%ebx
    1180:	84 c0                	test   %al,%al
    1182:	75 1d                	jne    11a1 <strcmp+0x31>
    1184:	eb 2a                	jmp    11b0 <strcmp+0x40>
    1186:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    118d:	8d 76 00             	lea    0x0(%esi),%esi
    1190:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    1194:	83 c1 01             	add    $0x1,%ecx
    1197:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    119a:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    119d:	84 c0                	test   %al,%al
    119f:	74 0f                	je     11b0 <strcmp+0x40>
    11a1:	38 d8                	cmp    %bl,%al
    11a3:	74 eb                	je     1190 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    11a5:	29 d8                	sub    %ebx,%eax
}
    11a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11aa:	c9                   	leave  
    11ab:	c3                   	ret    
    11ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11b0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    11b2:	29 d8                	sub    %ebx,%eax
}
    11b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11b7:	c9                   	leave  
    11b8:	c3                   	ret    
    11b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000011c0 <strlen>:

uint
strlen(const char *s)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    11c6:	80 3a 00             	cmpb   $0x0,(%edx)
    11c9:	74 15                	je     11e0 <strlen+0x20>
    11cb:	31 c0                	xor    %eax,%eax
    11cd:	8d 76 00             	lea    0x0(%esi),%esi
    11d0:	83 c0 01             	add    $0x1,%eax
    11d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    11d7:	89 c1                	mov    %eax,%ecx
    11d9:	75 f5                	jne    11d0 <strlen+0x10>
    ;
  return n;
}
    11db:	89 c8                	mov    %ecx,%eax
    11dd:	5d                   	pop    %ebp
    11de:	c3                   	ret    
    11df:	90                   	nop
  for(n = 0; s[n]; n++)
    11e0:	31 c9                	xor    %ecx,%ecx
}
    11e2:	5d                   	pop    %ebp
    11e3:	89 c8                	mov    %ecx,%eax
    11e5:	c3                   	ret    
    11e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11ed:	8d 76 00             	lea    0x0(%esi),%esi

000011f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	57                   	push   %edi
    11f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    11fd:	89 d7                	mov    %edx,%edi
    11ff:	fc                   	cld    
    1200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1202:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1205:	89 d0                	mov    %edx,%eax
    1207:	c9                   	leave  
    1208:	c3                   	ret    
    1209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001210 <strchr>:

char*
strchr(const char *s, char c)
{
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	8b 45 08             	mov    0x8(%ebp),%eax
    1216:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    121a:	0f b6 10             	movzbl (%eax),%edx
    121d:	84 d2                	test   %dl,%dl
    121f:	75 12                	jne    1233 <strchr+0x23>
    1221:	eb 1d                	jmp    1240 <strchr+0x30>
    1223:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1227:	90                   	nop
    1228:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    122c:	83 c0 01             	add    $0x1,%eax
    122f:	84 d2                	test   %dl,%dl
    1231:	74 0d                	je     1240 <strchr+0x30>
    if(*s == c)
    1233:	38 d1                	cmp    %dl,%cl
    1235:	75 f1                	jne    1228 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1237:	5d                   	pop    %ebp
    1238:	c3                   	ret    
    1239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    1240:	31 c0                	xor    %eax,%eax
}
    1242:	5d                   	pop    %ebp
    1243:	c3                   	ret    
    1244:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    124b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    124f:	90                   	nop

00001250 <gets>:

char*
gets(char *buf, int max)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	57                   	push   %edi
    1254:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1255:	31 f6                	xor    %esi,%esi
{
    1257:	53                   	push   %ebx
    1258:	89 f3                	mov    %esi,%ebx
    125a:	83 ec 1c             	sub    $0x1c,%esp
    125d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1260:	eb 2f                	jmp    1291 <gets+0x41>
    1262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1268:	83 ec 04             	sub    $0x4,%esp
    126b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    126e:	6a 01                	push   $0x1
    1270:	50                   	push   %eax
    1271:	6a 00                	push   $0x0
    1273:	e8 a9 01 00 00       	call   1421 <read>
    if(cc < 1)
    1278:	83 c4 10             	add    $0x10,%esp
    127b:	85 c0                	test   %eax,%eax
    127d:	7e 1c                	jle    129b <gets+0x4b>
      break;
    buf[i++] = c;
    127f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    1283:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    1286:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1289:	3c 0a                	cmp    $0xa,%al
    128b:	74 23                	je     12b0 <gets+0x60>
    128d:	3c 0d                	cmp    $0xd,%al
    128f:	74 1f                	je     12b0 <gets+0x60>
  for(i=0; i+1 < max; ){
    1291:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    1294:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    1296:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1299:	7c cd                	jl     1268 <gets+0x18>
    129b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    129d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    12a0:	c6 03 00             	movb   $0x0,(%ebx)
}
    12a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12a6:	5b                   	pop    %ebx
    12a7:	5e                   	pop    %esi
    12a8:	5f                   	pop    %edi
    12a9:	5d                   	pop    %ebp
    12aa:	c3                   	ret    
    12ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12af:	90                   	nop
  buf[i] = '\0';
    12b0:	8b 75 08             	mov    0x8(%ebp),%esi
}
    12b3:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    12b6:	01 de                	add    %ebx,%esi
    12b8:	89 f3                	mov    %esi,%ebx
    12ba:	c6 03 00             	movb   $0x0,(%ebx)
}
    12bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12c0:	5b                   	pop    %ebx
    12c1:	5e                   	pop    %esi
    12c2:	5f                   	pop    %edi
    12c3:	5d                   	pop    %ebp
    12c4:	c3                   	ret    
    12c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000012d0 <stat>:

int
stat(const char *n, struct stat *st)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	56                   	push   %esi
    12d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12d5:	83 ec 08             	sub    $0x8,%esp
    12d8:	6a 00                	push   $0x0
    12da:	ff 75 08             	pushl  0x8(%ebp)
    12dd:	e8 67 01 00 00       	call   1449 <open>
  if(fd < 0)
    12e2:	83 c4 10             	add    $0x10,%esp
    12e5:	85 c0                	test   %eax,%eax
    12e7:	78 27                	js     1310 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    12e9:	83 ec 08             	sub    $0x8,%esp
    12ec:	ff 75 0c             	pushl  0xc(%ebp)
    12ef:	89 c3                	mov    %eax,%ebx
    12f1:	50                   	push   %eax
    12f2:	e8 6a 01 00 00       	call   1461 <fstat>
  close(fd);
    12f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    12fa:	89 c6                	mov    %eax,%esi
  close(fd);
    12fc:	e8 30 01 00 00       	call   1431 <close>
  return r;
    1301:	83 c4 10             	add    $0x10,%esp
}
    1304:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1307:	89 f0                	mov    %esi,%eax
    1309:	5b                   	pop    %ebx
    130a:	5e                   	pop    %esi
    130b:	5d                   	pop    %ebp
    130c:	c3                   	ret    
    130d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1310:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1315:	eb ed                	jmp    1304 <stat+0x34>
    1317:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    131e:	66 90                	xchg   %ax,%ax

00001320 <atoi>:

int
atoi(const char *s)
{
    1320:	55                   	push   %ebp
    1321:	89 e5                	mov    %esp,%ebp
    1323:	53                   	push   %ebx
    1324:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1327:	0f be 02             	movsbl (%edx),%eax
    132a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    132d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1330:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1335:	77 1e                	ja     1355 <atoi+0x35>
    1337:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    133e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    1340:	83 c2 01             	add    $0x1,%edx
    1343:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1346:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    134a:	0f be 02             	movsbl (%edx),%eax
    134d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1350:	80 fb 09             	cmp    $0x9,%bl
    1353:	76 eb                	jbe    1340 <atoi+0x20>
  return n;
}
    1355:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1358:	89 c8                	mov    %ecx,%eax
    135a:	c9                   	leave  
    135b:	c3                   	ret    
    135c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001360 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	57                   	push   %edi
    1364:	8b 45 10             	mov    0x10(%ebp),%eax
    1367:	8b 55 08             	mov    0x8(%ebp),%edx
    136a:	56                   	push   %esi
    136b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    136e:	85 c0                	test   %eax,%eax
    1370:	7e 13                	jle    1385 <memmove+0x25>
    1372:	01 d0                	add    %edx,%eax
  dst = vdst;
    1374:	89 d7                	mov    %edx,%edi
    1376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    137d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    1380:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    1381:	39 f8                	cmp    %edi,%eax
    1383:	75 fb                	jne    1380 <memmove+0x20>
  return vdst;
}
    1385:	5e                   	pop    %esi
    1386:	89 d0                	mov    %edx,%eax
    1388:	5f                   	pop    %edi
    1389:	5d                   	pop    %ebp
    138a:	c3                   	ret    
    138b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    138f:	90                   	nop

00001390 <thread_create>:


int thread_create(void (*start_routine)(void*, void*), void *arg1, void *arg2) {
    1390:	55                   	push   %ebp
    1391:	89 e5                	mov    %esp,%ebp
    1393:	53                   	push   %ebx
    1394:	83 ec 20             	sub    $0x20,%esp
  void *stack =  malloc(4096);
    1397:	68 00 10 00 00       	push   $0x1000
    139c:	e8 5f 04 00 00       	call   1800 <malloc>
  if(stack == 0)
    13a1:	83 c4 10             	add    $0x10,%esp
    13a4:	85 c0                	test   %eax,%eax
    13a6:	74 3f                	je     13e7 <thread_create+0x57>
    return -1;
  int r= clone(start_routine, arg1, arg2, stack);
    13a8:	50                   	push   %eax
    13a9:	89 c3                	mov    %eax,%ebx
    13ab:	ff 75 10             	pushl  0x10(%ebp)
    13ae:	ff 75 0c             	pushl  0xc(%ebp)
    13b1:	ff 75 08             	pushl  0x8(%ebp)
    13b4:	e8 00 01 00 00       	call   14b9 <clone>
  if(r==-1) 
    13b9:	83 c4 10             	add    $0x10,%esp
    13bc:	83 f8 ff             	cmp    $0xffffffff,%eax
    13bf:	74 0f                	je     13d0 <thread_create+0x40>
    free(stack);
  return r;
}
    13c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13c4:	c9                   	leave  
    13c5:	c3                   	ret    
    13c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13cd:	8d 76 00             	lea    0x0(%esi),%esi
    free(stack);
    13d0:	83 ec 0c             	sub    $0xc,%esp
    13d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13d6:	53                   	push   %ebx
    13d7:	e8 94 03 00 00       	call   1770 <free>
    13dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    13df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    free(stack);
    13e2:	83 c4 10             	add    $0x10,%esp
}
    13e5:	c9                   	leave  
    13e6:	c3                   	ret    
    return -1;
    13e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13ec:	eb d3                	jmp    13c1 <thread_create+0x31>
    13ee:	66 90                	xchg   %ax,%ax

000013f0 <thread_join>:


int thread_join(void) {
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	83 ec 24             	sub    $0x24,%esp
  void *stack;
  int r = join(&stack);
    13f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13f9:	50                   	push   %eax
    13fa:	e8 c2 00 00 00       	call   14c1 <join>
  return r;
}
    13ff:	c9                   	leave  
    1400:	c3                   	ret    

00001401 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1401:	b8 01 00 00 00       	mov    $0x1,%eax
    1406:	cd 40                	int    $0x40
    1408:	c3                   	ret    

00001409 <exit>:
SYSCALL(exit)
    1409:	b8 02 00 00 00       	mov    $0x2,%eax
    140e:	cd 40                	int    $0x40
    1410:	c3                   	ret    

00001411 <wait>:
SYSCALL(wait)
    1411:	b8 03 00 00 00       	mov    $0x3,%eax
    1416:	cd 40                	int    $0x40
    1418:	c3                   	ret    

00001419 <pipe>:
SYSCALL(pipe)
    1419:	b8 04 00 00 00       	mov    $0x4,%eax
    141e:	cd 40                	int    $0x40
    1420:	c3                   	ret    

00001421 <read>:
SYSCALL(read)
    1421:	b8 05 00 00 00       	mov    $0x5,%eax
    1426:	cd 40                	int    $0x40
    1428:	c3                   	ret    

00001429 <write>:
SYSCALL(write)
    1429:	b8 10 00 00 00       	mov    $0x10,%eax
    142e:	cd 40                	int    $0x40
    1430:	c3                   	ret    

00001431 <close>:
SYSCALL(close)
    1431:	b8 15 00 00 00       	mov    $0x15,%eax
    1436:	cd 40                	int    $0x40
    1438:	c3                   	ret    

00001439 <kill>:
SYSCALL(kill)
    1439:	b8 06 00 00 00       	mov    $0x6,%eax
    143e:	cd 40                	int    $0x40
    1440:	c3                   	ret    

00001441 <exec>:
SYSCALL(exec)
    1441:	b8 07 00 00 00       	mov    $0x7,%eax
    1446:	cd 40                	int    $0x40
    1448:	c3                   	ret    

00001449 <open>:
SYSCALL(open)
    1449:	b8 0f 00 00 00       	mov    $0xf,%eax
    144e:	cd 40                	int    $0x40
    1450:	c3                   	ret    

00001451 <mknod>:
SYSCALL(mknod)
    1451:	b8 11 00 00 00       	mov    $0x11,%eax
    1456:	cd 40                	int    $0x40
    1458:	c3                   	ret    

00001459 <unlink>:
SYSCALL(unlink)
    1459:	b8 12 00 00 00       	mov    $0x12,%eax
    145e:	cd 40                	int    $0x40
    1460:	c3                   	ret    

00001461 <fstat>:
SYSCALL(fstat)
    1461:	b8 08 00 00 00       	mov    $0x8,%eax
    1466:	cd 40                	int    $0x40
    1468:	c3                   	ret    

00001469 <link>:
SYSCALL(link)
    1469:	b8 13 00 00 00       	mov    $0x13,%eax
    146e:	cd 40                	int    $0x40
    1470:	c3                   	ret    

00001471 <mkdir>:
SYSCALL(mkdir)
    1471:	b8 14 00 00 00       	mov    $0x14,%eax
    1476:	cd 40                	int    $0x40
    1478:	c3                   	ret    

00001479 <chdir>:
SYSCALL(chdir)
    1479:	b8 09 00 00 00       	mov    $0x9,%eax
    147e:	cd 40                	int    $0x40
    1480:	c3                   	ret    

00001481 <dup>:
SYSCALL(dup)
    1481:	b8 0a 00 00 00       	mov    $0xa,%eax
    1486:	cd 40                	int    $0x40
    1488:	c3                   	ret    

00001489 <getpid>:
SYSCALL(getpid)
    1489:	b8 0b 00 00 00       	mov    $0xb,%eax
    148e:	cd 40                	int    $0x40
    1490:	c3                   	ret    

00001491 <sbrk>:
SYSCALL(sbrk)
    1491:	b8 0c 00 00 00       	mov    $0xc,%eax
    1496:	cd 40                	int    $0x40
    1498:	c3                   	ret    

00001499 <sleep>:
SYSCALL(sleep)
    1499:	b8 0d 00 00 00       	mov    $0xd,%eax
    149e:	cd 40                	int    $0x40
    14a0:	c3                   	ret    

000014a1 <uptime>:
SYSCALL(uptime)
    14a1:	b8 0e 00 00 00       	mov    $0xe,%eax
    14a6:	cd 40                	int    $0x40
    14a8:	c3                   	ret    

000014a9 <mprotect>:
SYSCALL(mprotect)
    14a9:	b8 16 00 00 00       	mov    $0x16,%eax
    14ae:	cd 40                	int    $0x40
    14b0:	c3                   	ret    

000014b1 <munprotect>:
SYSCALL(munprotect)
    14b1:	b8 17 00 00 00       	mov    $0x17,%eax
    14b6:	cd 40                	int    $0x40
    14b8:	c3                   	ret    

000014b9 <clone>:
SYSCALL(clone)
    14b9:	b8 18 00 00 00       	mov    $0x18,%eax
    14be:	cd 40                	int    $0x40
    14c0:	c3                   	ret    

000014c1 <join>:
SYSCALL(join)
    14c1:	b8 19 00 00 00       	mov    $0x19,%eax
    14c6:	cd 40                	int    $0x40
    14c8:	c3                   	ret    

000014c9 <getNumProc>:
SYSCALL(getNumProc)
    14c9:	b8 1a 00 00 00       	mov    $0x1a,%eax
    14ce:	cd 40                	int    $0x40
    14d0:	c3                   	ret    

000014d1 <getMaxPid>:
SYSCALL(getMaxPid)
    14d1:	b8 1b 00 00 00       	mov    $0x1b,%eax
    14d6:	cd 40                	int    $0x40
    14d8:	c3                   	ret    

000014d9 <getProcInfo>:
SYSCALL(getProcInfo)
    14d9:	b8 1c 00 00 00       	mov    $0x1c,%eax
    14de:	cd 40                	int    $0x40
    14e0:	c3                   	ret    
    14e1:	66 90                	xchg   %ax,%ax
    14e3:	66 90                	xchg   %ax,%ax
    14e5:	66 90                	xchg   %ax,%ax
    14e7:	66 90                	xchg   %ax,%ax
    14e9:	66 90                	xchg   %ax,%ax
    14eb:	66 90                	xchg   %ax,%ax
    14ed:	66 90                	xchg   %ax,%ax
    14ef:	90                   	nop

000014f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    14f0:	55                   	push   %ebp
    14f1:	89 e5                	mov    %esp,%ebp
    14f3:	57                   	push   %edi
    14f4:	56                   	push   %esi
    14f5:	53                   	push   %ebx
    14f6:	83 ec 3c             	sub    $0x3c,%esp
    14f9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    14fc:	89 d1                	mov    %edx,%ecx
{
    14fe:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    1501:	85 d2                	test   %edx,%edx
    1503:	0f 89 7f 00 00 00    	jns    1588 <printint+0x98>
    1509:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    150d:	74 79                	je     1588 <printint+0x98>
    neg = 1;
    150f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    1516:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    1518:	31 db                	xor    %ebx,%ebx
    151a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    151d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1520:	89 c8                	mov    %ecx,%eax
    1522:	31 d2                	xor    %edx,%edx
    1524:	89 cf                	mov    %ecx,%edi
    1526:	f7 75 c4             	divl   -0x3c(%ebp)
    1529:	0f b6 92 34 19 00 00 	movzbl 0x1934(%edx),%edx
    1530:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1533:	89 d8                	mov    %ebx,%eax
    1535:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1538:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    153b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    153e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1541:	76 dd                	jbe    1520 <printint+0x30>
  if(neg)
    1543:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1546:	85 c9                	test   %ecx,%ecx
    1548:	74 0c                	je     1556 <printint+0x66>
    buf[i++] = '-';
    154a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    154f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1551:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1556:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1559:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    155d:	eb 07                	jmp    1566 <printint+0x76>
    155f:	90                   	nop
    putc(fd, buf[i]);
    1560:	0f b6 13             	movzbl (%ebx),%edx
    1563:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1566:	83 ec 04             	sub    $0x4,%esp
    1569:	88 55 d7             	mov    %dl,-0x29(%ebp)
    156c:	6a 01                	push   $0x1
    156e:	56                   	push   %esi
    156f:	57                   	push   %edi
    1570:	e8 b4 fe ff ff       	call   1429 <write>
  while(--i >= 0)
    1575:	83 c4 10             	add    $0x10,%esp
    1578:	39 de                	cmp    %ebx,%esi
    157a:	75 e4                	jne    1560 <printint+0x70>
}
    157c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    157f:	5b                   	pop    %ebx
    1580:	5e                   	pop    %esi
    1581:	5f                   	pop    %edi
    1582:	5d                   	pop    %ebp
    1583:	c3                   	ret    
    1584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1588:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    158f:	eb 87                	jmp    1518 <printint+0x28>
    1591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1598:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    159f:	90                   	nop

000015a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    15a0:	55                   	push   %ebp
    15a1:	89 e5                	mov    %esp,%ebp
    15a3:	57                   	push   %edi
    15a4:	56                   	push   %esi
    15a5:	53                   	push   %ebx
    15a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15a9:	8b 75 0c             	mov    0xc(%ebp),%esi
    15ac:	0f b6 1e             	movzbl (%esi),%ebx
    15af:	84 db                	test   %bl,%bl
    15b1:	0f 84 b8 00 00 00    	je     166f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    15b7:	8d 45 10             	lea    0x10(%ebp),%eax
    15ba:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    15bd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    15c0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    15c2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    15c5:	eb 37                	jmp    15fe <printf+0x5e>
    15c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15ce:	66 90                	xchg   %ax,%ax
    15d0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    15d3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    15d8:	83 f8 25             	cmp    $0x25,%eax
    15db:	74 17                	je     15f4 <printf+0x54>
  write(fd, &c, 1);
    15dd:	83 ec 04             	sub    $0x4,%esp
    15e0:	88 5d e7             	mov    %bl,-0x19(%ebp)
    15e3:	6a 01                	push   $0x1
    15e5:	57                   	push   %edi
    15e6:	ff 75 08             	pushl  0x8(%ebp)
    15e9:	e8 3b fe ff ff       	call   1429 <write>
    15ee:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    15f1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    15f4:	0f b6 1e             	movzbl (%esi),%ebx
    15f7:	83 c6 01             	add    $0x1,%esi
    15fa:	84 db                	test   %bl,%bl
    15fc:	74 71                	je     166f <printf+0xcf>
    c = fmt[i] & 0xff;
    15fe:	0f be cb             	movsbl %bl,%ecx
    1601:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1604:	85 d2                	test   %edx,%edx
    1606:	74 c8                	je     15d0 <printf+0x30>
      }
    } else if(state == '%'){
    1608:	83 fa 25             	cmp    $0x25,%edx
    160b:	75 e7                	jne    15f4 <printf+0x54>
      if(c == 'd'){
    160d:	83 f8 64             	cmp    $0x64,%eax
    1610:	0f 84 9a 00 00 00    	je     16b0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1616:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    161c:	83 f9 70             	cmp    $0x70,%ecx
    161f:	74 5f                	je     1680 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1621:	83 f8 73             	cmp    $0x73,%eax
    1624:	0f 84 d6 00 00 00    	je     1700 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    162a:	83 f8 63             	cmp    $0x63,%eax
    162d:	0f 84 8d 00 00 00    	je     16c0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1633:	83 f8 25             	cmp    $0x25,%eax
    1636:	0f 84 b4 00 00 00    	je     16f0 <printf+0x150>
  write(fd, &c, 1);
    163c:	83 ec 04             	sub    $0x4,%esp
    163f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1643:	6a 01                	push   $0x1
    1645:	57                   	push   %edi
    1646:	ff 75 08             	pushl  0x8(%ebp)
    1649:	e8 db fd ff ff       	call   1429 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    164e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1651:	83 c4 0c             	add    $0xc,%esp
    1654:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1656:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1659:	57                   	push   %edi
    165a:	ff 75 08             	pushl  0x8(%ebp)
    165d:	e8 c7 fd ff ff       	call   1429 <write>
  for(i = 0; fmt[i]; i++){
    1662:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    1666:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1669:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    166b:	84 db                	test   %bl,%bl
    166d:	75 8f                	jne    15fe <printf+0x5e>
    }
  }
}
    166f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1672:	5b                   	pop    %ebx
    1673:	5e                   	pop    %esi
    1674:	5f                   	pop    %edi
    1675:	5d                   	pop    %ebp
    1676:	c3                   	ret    
    1677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    167e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    1680:	83 ec 0c             	sub    $0xc,%esp
    1683:	b9 10 00 00 00       	mov    $0x10,%ecx
    1688:	6a 00                	push   $0x0
    168a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    168d:	8b 45 08             	mov    0x8(%ebp),%eax
    1690:	8b 13                	mov    (%ebx),%edx
    1692:	e8 59 fe ff ff       	call   14f0 <printint>
        ap++;
    1697:	89 d8                	mov    %ebx,%eax
    1699:	83 c4 10             	add    $0x10,%esp
      state = 0;
    169c:	31 d2                	xor    %edx,%edx
        ap++;
    169e:	83 c0 04             	add    $0x4,%eax
    16a1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    16a4:	e9 4b ff ff ff       	jmp    15f4 <printf+0x54>
    16a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    16b0:	83 ec 0c             	sub    $0xc,%esp
    16b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    16b8:	6a 01                	push   $0x1
    16ba:	eb ce                	jmp    168a <printf+0xea>
    16bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    16c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    16c3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    16c6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    16c8:	6a 01                	push   $0x1
        ap++;
    16ca:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    16cd:	57                   	push   %edi
    16ce:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    16d1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    16d4:	e8 50 fd ff ff       	call   1429 <write>
        ap++;
    16d9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    16dc:	83 c4 10             	add    $0x10,%esp
      state = 0;
    16df:	31 d2                	xor    %edx,%edx
    16e1:	e9 0e ff ff ff       	jmp    15f4 <printf+0x54>
    16e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    16ed:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    16f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    16f3:	83 ec 04             	sub    $0x4,%esp
    16f6:	e9 59 ff ff ff       	jmp    1654 <printf+0xb4>
    16fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    16ff:	90                   	nop
        s = (char*)*ap;
    1700:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1703:	8b 18                	mov    (%eax),%ebx
        ap++;
    1705:	83 c0 04             	add    $0x4,%eax
    1708:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    170b:	85 db                	test   %ebx,%ebx
    170d:	74 17                	je     1726 <printf+0x186>
        while(*s != 0){
    170f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1712:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1714:	84 c0                	test   %al,%al
    1716:	0f 84 d8 fe ff ff    	je     15f4 <printf+0x54>
    171c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    171f:	89 de                	mov    %ebx,%esi
    1721:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1724:	eb 1a                	jmp    1740 <printf+0x1a0>
          s = "(null)";
    1726:	bb 2b 19 00 00       	mov    $0x192b,%ebx
        while(*s != 0){
    172b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    172e:	b8 28 00 00 00       	mov    $0x28,%eax
    1733:	89 de                	mov    %ebx,%esi
    1735:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1738:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    173f:	90                   	nop
  write(fd, &c, 1);
    1740:	83 ec 04             	sub    $0x4,%esp
          s++;
    1743:	83 c6 01             	add    $0x1,%esi
    1746:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1749:	6a 01                	push   $0x1
    174b:	57                   	push   %edi
    174c:	53                   	push   %ebx
    174d:	e8 d7 fc ff ff       	call   1429 <write>
        while(*s != 0){
    1752:	0f b6 06             	movzbl (%esi),%eax
    1755:	83 c4 10             	add    $0x10,%esp
    1758:	84 c0                	test   %al,%al
    175a:	75 e4                	jne    1740 <printf+0x1a0>
      state = 0;
    175c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    175f:	31 d2                	xor    %edx,%edx
    1761:	e9 8e fe ff ff       	jmp    15f4 <printf+0x54>
    1766:	66 90                	xchg   %ax,%ax
    1768:	66 90                	xchg   %ax,%ax
    176a:	66 90                	xchg   %ax,%ax
    176c:	66 90                	xchg   %ax,%ax
    176e:	66 90                	xchg   %ax,%ax

00001770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1770:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1771:	a1 38 1c 00 00       	mov    0x1c38,%eax
{
    1776:	89 e5                	mov    %esp,%ebp
    1778:	57                   	push   %edi
    1779:	56                   	push   %esi
    177a:	53                   	push   %ebx
    177b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    177e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1788:	89 c2                	mov    %eax,%edx
    178a:	8b 00                	mov    (%eax),%eax
    178c:	39 ca                	cmp    %ecx,%edx
    178e:	73 30                	jae    17c0 <free+0x50>
    1790:	39 c1                	cmp    %eax,%ecx
    1792:	72 04                	jb     1798 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1794:	39 c2                	cmp    %eax,%edx
    1796:	72 f0                	jb     1788 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1798:	8b 73 fc             	mov    -0x4(%ebx),%esi
    179b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    179e:	39 f8                	cmp    %edi,%eax
    17a0:	74 30                	je     17d2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    17a2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    17a5:	8b 42 04             	mov    0x4(%edx),%eax
    17a8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    17ab:	39 f1                	cmp    %esi,%ecx
    17ad:	74 3a                	je     17e9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    17af:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    17b1:	5b                   	pop    %ebx
  freep = p;
    17b2:	89 15 38 1c 00 00    	mov    %edx,0x1c38
}
    17b8:	5e                   	pop    %esi
    17b9:	5f                   	pop    %edi
    17ba:	5d                   	pop    %ebp
    17bb:	c3                   	ret    
    17bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17c0:	39 c2                	cmp    %eax,%edx
    17c2:	72 c4                	jb     1788 <free+0x18>
    17c4:	39 c1                	cmp    %eax,%ecx
    17c6:	73 c0                	jae    1788 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    17c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    17cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    17ce:	39 f8                	cmp    %edi,%eax
    17d0:	75 d0                	jne    17a2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    17d2:	03 70 04             	add    0x4(%eax),%esi
    17d5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    17d8:	8b 02                	mov    (%edx),%eax
    17da:	8b 00                	mov    (%eax),%eax
    17dc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    17df:	8b 42 04             	mov    0x4(%edx),%eax
    17e2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    17e5:	39 f1                	cmp    %esi,%ecx
    17e7:	75 c6                	jne    17af <free+0x3f>
    p->s.size += bp->s.size;
    17e9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    17ec:	89 15 38 1c 00 00    	mov    %edx,0x1c38
    p->s.size += bp->s.size;
    17f2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    17f5:	8b 43 f8             	mov    -0x8(%ebx),%eax
    17f8:	89 02                	mov    %eax,(%edx)
}
    17fa:	5b                   	pop    %ebx
    17fb:	5e                   	pop    %esi
    17fc:	5f                   	pop    %edi
    17fd:	5d                   	pop    %ebp
    17fe:	c3                   	ret    
    17ff:	90                   	nop

00001800 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1800:	55                   	push   %ebp
    1801:	89 e5                	mov    %esp,%ebp
    1803:	57                   	push   %edi
    1804:	56                   	push   %esi
    1805:	53                   	push   %ebx
    1806:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1809:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    180c:	8b 3d 38 1c 00 00    	mov    0x1c38,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1812:	8d 70 07             	lea    0x7(%eax),%esi
    1815:	c1 ee 03             	shr    $0x3,%esi
    1818:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    181b:	85 ff                	test   %edi,%edi
    181d:	0f 84 ad 00 00 00    	je     18d0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1823:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1825:	8b 48 04             	mov    0x4(%eax),%ecx
    1828:	39 f1                	cmp    %esi,%ecx
    182a:	73 71                	jae    189d <malloc+0x9d>
    182c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1832:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1837:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    183a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1841:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1844:	eb 1b                	jmp    1861 <malloc+0x61>
    1846:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    184d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1850:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1852:	8b 4a 04             	mov    0x4(%edx),%ecx
    1855:	39 f1                	cmp    %esi,%ecx
    1857:	73 4f                	jae    18a8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1859:	8b 3d 38 1c 00 00    	mov    0x1c38,%edi
    185f:	89 d0                	mov    %edx,%eax
    1861:	39 c7                	cmp    %eax,%edi
    1863:	75 eb                	jne    1850 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1865:	83 ec 0c             	sub    $0xc,%esp
    1868:	ff 75 e4             	pushl  -0x1c(%ebp)
    186b:	e8 21 fc ff ff       	call   1491 <sbrk>
  if(p == (char*)-1)
    1870:	83 c4 10             	add    $0x10,%esp
    1873:	83 f8 ff             	cmp    $0xffffffff,%eax
    1876:	74 1b                	je     1893 <malloc+0x93>
  hp->s.size = nu;
    1878:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    187b:	83 ec 0c             	sub    $0xc,%esp
    187e:	83 c0 08             	add    $0x8,%eax
    1881:	50                   	push   %eax
    1882:	e8 e9 fe ff ff       	call   1770 <free>
  return freep;
    1887:	a1 38 1c 00 00       	mov    0x1c38,%eax
      if((p = morecore(nunits)) == 0)
    188c:	83 c4 10             	add    $0x10,%esp
    188f:	85 c0                	test   %eax,%eax
    1891:	75 bd                	jne    1850 <malloc+0x50>
        return 0;
  }
}
    1893:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1896:	31 c0                	xor    %eax,%eax
}
    1898:	5b                   	pop    %ebx
    1899:	5e                   	pop    %esi
    189a:	5f                   	pop    %edi
    189b:	5d                   	pop    %ebp
    189c:	c3                   	ret    
    if(p->s.size >= nunits){
    189d:	89 c2                	mov    %eax,%edx
    189f:	89 f8                	mov    %edi,%eax
    18a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    18a8:	39 ce                	cmp    %ecx,%esi
    18aa:	74 54                	je     1900 <malloc+0x100>
        p->s.size -= nunits;
    18ac:	29 f1                	sub    %esi,%ecx
    18ae:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    18b1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    18b4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    18b7:	a3 38 1c 00 00       	mov    %eax,0x1c38
}
    18bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    18bf:	8d 42 08             	lea    0x8(%edx),%eax
}
    18c2:	5b                   	pop    %ebx
    18c3:	5e                   	pop    %esi
    18c4:	5f                   	pop    %edi
    18c5:	5d                   	pop    %ebp
    18c6:	c3                   	ret    
    18c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    18ce:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    18d0:	c7 05 38 1c 00 00 3c 	movl   $0x1c3c,0x1c38
    18d7:	1c 00 00 
    base.s.size = 0;
    18da:	bf 3c 1c 00 00       	mov    $0x1c3c,%edi
    base.s.ptr = freep = prevp = &base;
    18df:	c7 05 3c 1c 00 00 3c 	movl   $0x1c3c,0x1c3c
    18e6:	1c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18e9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    18eb:	c7 05 40 1c 00 00 00 	movl   $0x0,0x1c40
    18f2:	00 00 00 
    if(p->s.size >= nunits){
    18f5:	e9 32 ff ff ff       	jmp    182c <malloc+0x2c>
    18fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1900:	8b 0a                	mov    (%edx),%ecx
    1902:	89 08                	mov    %ecx,(%eax)
    1904:	eb b1                	jmp    18b7 <malloc+0xb7>
