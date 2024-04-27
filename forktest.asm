
_forktest:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
  forktest();
    1006:	e8 35 00 00 00       	call   1040 <forktest>
  exit();
    100b:	e8 d9 03 00 00       	call   13e9 <exit>

00001010 <printf>:
{
    1010:	55                   	push   %ebp
    1011:	89 e5                	mov    %esp,%ebp
    1013:	53                   	push   %ebx
    1014:	83 ec 10             	sub    $0x10,%esp
    1017:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
    101a:	53                   	push   %ebx
    101b:	e8 80 01 00 00       	call   11a0 <strlen>
    1020:	83 c4 0c             	add    $0xc,%esp
    1023:	50                   	push   %eax
    1024:	53                   	push   %ebx
    1025:	ff 75 08             	pushl  0x8(%ebp)
    1028:	e8 dc 03 00 00       	call   1409 <write>
}
    102d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1030:	83 c4 10             	add    $0x10,%esp
    1033:	c9                   	leave  
    1034:	c3                   	ret    
    1035:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001040 <forktest>:
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	53                   	push   %ebx
  for(n=0; n<N; n++){
    1044:	31 db                	xor    %ebx,%ebx
{
    1046:	83 ec 10             	sub    $0x10,%esp
  write(fd, s, strlen(s));
    1049:	68 48 16 00 00       	push   $0x1648
    104e:	e8 4d 01 00 00       	call   11a0 <strlen>
    1053:	83 c4 0c             	add    $0xc,%esp
    1056:	50                   	push   %eax
    1057:	68 48 16 00 00       	push   $0x1648
    105c:	6a 01                	push   $0x1
    105e:	e8 a6 03 00 00       	call   1409 <write>
    1063:	83 c4 10             	add    $0x10,%esp
    1066:	eb 19                	jmp    1081 <forktest+0x41>
    1068:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    106f:	90                   	nop
    if(pid == 0)
    1070:	74 58                	je     10ca <forktest+0x8a>
  for(n=0; n<N; n++){
    1072:	83 c3 01             	add    $0x1,%ebx
    1075:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    107b:	0f 84 83 00 00 00    	je     1104 <forktest+0xc4>
    pid = fork();
    1081:	e8 5b 03 00 00       	call   13e1 <fork>
    if(pid < 0)
    1086:	85 c0                	test   %eax,%eax
    1088:	79 e6                	jns    1070 <forktest+0x30>
  for(; n > 0; n--){
    108a:	85 db                	test   %ebx,%ebx
    108c:	74 10                	je     109e <forktest+0x5e>
    108e:	66 90                	xchg   %ax,%ax
    if(wait() < 0){
    1090:	e8 5c 03 00 00       	call   13f1 <wait>
    1095:	85 c0                	test   %eax,%eax
    1097:	78 36                	js     10cf <forktest+0x8f>
  for(; n > 0; n--){
    1099:	83 eb 01             	sub    $0x1,%ebx
    109c:	75 f2                	jne    1090 <forktest+0x50>
  if(wait() != -1){
    109e:	e8 4e 03 00 00       	call   13f1 <wait>
    10a3:	83 f8 ff             	cmp    $0xffffffff,%eax
    10a6:	75 49                	jne    10f1 <forktest+0xb1>
  write(fd, s, strlen(s));
    10a8:	83 ec 0c             	sub    $0xc,%esp
    10ab:	68 7a 16 00 00       	push   $0x167a
    10b0:	e8 eb 00 00 00       	call   11a0 <strlen>
    10b5:	83 c4 0c             	add    $0xc,%esp
    10b8:	50                   	push   %eax
    10b9:	68 7a 16 00 00       	push   $0x167a
    10be:	6a 01                	push   $0x1
    10c0:	e8 44 03 00 00       	call   1409 <write>
}
    10c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10c8:	c9                   	leave  
    10c9:	c3                   	ret    
      exit();
    10ca:	e8 1a 03 00 00       	call   13e9 <exit>
  write(fd, s, strlen(s));
    10cf:	83 ec 0c             	sub    $0xc,%esp
    10d2:	68 53 16 00 00       	push   $0x1653
    10d7:	e8 c4 00 00 00       	call   11a0 <strlen>
    10dc:	83 c4 0c             	add    $0xc,%esp
    10df:	50                   	push   %eax
    10e0:	68 53 16 00 00       	push   $0x1653
    10e5:	6a 01                	push   $0x1
    10e7:	e8 1d 03 00 00       	call   1409 <write>
      exit();
    10ec:	e8 f8 02 00 00       	call   13e9 <exit>
    printf(1, "wait got too many\n");
    10f1:	52                   	push   %edx
    10f2:	52                   	push   %edx
    10f3:	68 67 16 00 00       	push   $0x1667
    10f8:	6a 01                	push   $0x1
    10fa:	e8 11 ff ff ff       	call   1010 <printf>
    exit();
    10ff:	e8 e5 02 00 00       	call   13e9 <exit>
    printf(1, "fork claimed to work N times!\n", N);
    1104:	50                   	push   %eax
    1105:	68 e8 03 00 00       	push   $0x3e8
    110a:	68 88 16 00 00       	push   $0x1688
    110f:	6a 01                	push   $0x1
    1111:	e8 fa fe ff ff       	call   1010 <printf>
    exit();
    1116:	e8 ce 02 00 00       	call   13e9 <exit>
    111b:	66 90                	xchg   %ax,%ax
    111d:	66 90                	xchg   %ax,%ax
    111f:	90                   	nop

00001120 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"
char*
strcpy(char *s, const char *t)
{
    1120:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1121:	31 c0                	xor    %eax,%eax
{
    1123:	89 e5                	mov    %esp,%ebp
    1125:	53                   	push   %ebx
    1126:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    112c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    1130:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    1134:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    1137:	83 c0 01             	add    $0x1,%eax
    113a:	84 d2                	test   %dl,%dl
    113c:	75 f2                	jne    1130 <strcpy+0x10>
    ;
  return os;
}
    113e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1141:	89 c8                	mov    %ecx,%eax
    1143:	c9                   	leave  
    1144:	c3                   	ret    
    1145:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	53                   	push   %ebx
    1154:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1157:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    115a:	0f b6 01             	movzbl (%ecx),%eax
    115d:	0f b6 1a             	movzbl (%edx),%ebx
    1160:	84 c0                	test   %al,%al
    1162:	75 1d                	jne    1181 <strcmp+0x31>
    1164:	eb 2a                	jmp    1190 <strcmp+0x40>
    1166:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    116d:	8d 76 00             	lea    0x0(%esi),%esi
    1170:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    1174:	83 c1 01             	add    $0x1,%ecx
    1177:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    117a:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    117d:	84 c0                	test   %al,%al
    117f:	74 0f                	je     1190 <strcmp+0x40>
    1181:	38 d8                	cmp    %bl,%al
    1183:	74 eb                	je     1170 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1185:	29 d8                	sub    %ebx,%eax
}
    1187:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    118a:	c9                   	leave  
    118b:	c3                   	ret    
    118c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1190:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1192:	29 d8                	sub    %ebx,%eax
}
    1194:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1197:	c9                   	leave  
    1198:	c3                   	ret    
    1199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000011a0 <strlen>:

uint
strlen(const char *s)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    11a6:	80 3a 00             	cmpb   $0x0,(%edx)
    11a9:	74 15                	je     11c0 <strlen+0x20>
    11ab:	31 c0                	xor    %eax,%eax
    11ad:	8d 76 00             	lea    0x0(%esi),%esi
    11b0:	83 c0 01             	add    $0x1,%eax
    11b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    11b7:	89 c1                	mov    %eax,%ecx
    11b9:	75 f5                	jne    11b0 <strlen+0x10>
    ;
  return n;
}
    11bb:	89 c8                	mov    %ecx,%eax
    11bd:	5d                   	pop    %ebp
    11be:	c3                   	ret    
    11bf:	90                   	nop
  for(n = 0; s[n]; n++)
    11c0:	31 c9                	xor    %ecx,%ecx
}
    11c2:	5d                   	pop    %ebp
    11c3:	89 c8                	mov    %ecx,%eax
    11c5:	c3                   	ret    
    11c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11cd:	8d 76 00             	lea    0x0(%esi),%esi

000011d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11d0:	55                   	push   %ebp
    11d1:	89 e5                	mov    %esp,%ebp
    11d3:	57                   	push   %edi
    11d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11da:	8b 45 0c             	mov    0xc(%ebp),%eax
    11dd:	89 d7                	mov    %edx,%edi
    11df:	fc                   	cld    
    11e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    11e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
    11e5:	89 d0                	mov    %edx,%eax
    11e7:	c9                   	leave  
    11e8:	c3                   	ret    
    11e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000011f0 <strchr>:

char*
strchr(const char *s, char c)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	8b 45 08             	mov    0x8(%ebp),%eax
    11f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    11fa:	0f b6 10             	movzbl (%eax),%edx
    11fd:	84 d2                	test   %dl,%dl
    11ff:	75 12                	jne    1213 <strchr+0x23>
    1201:	eb 1d                	jmp    1220 <strchr+0x30>
    1203:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1207:	90                   	nop
    1208:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    120c:	83 c0 01             	add    $0x1,%eax
    120f:	84 d2                	test   %dl,%dl
    1211:	74 0d                	je     1220 <strchr+0x30>
    if(*s == c)
    1213:	38 d1                	cmp    %dl,%cl
    1215:	75 f1                	jne    1208 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1217:	5d                   	pop    %ebp
    1218:	c3                   	ret    
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    1220:	31 c0                	xor    %eax,%eax
}
    1222:	5d                   	pop    %ebp
    1223:	c3                   	ret    
    1224:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    122b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    122f:	90                   	nop

00001230 <gets>:

char*
gets(char *buf, int max)
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	57                   	push   %edi
    1234:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1235:	31 f6                	xor    %esi,%esi
{
    1237:	53                   	push   %ebx
    1238:	89 f3                	mov    %esi,%ebx
    123a:	83 ec 1c             	sub    $0x1c,%esp
    123d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1240:	eb 2f                	jmp    1271 <gets+0x41>
    1242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1248:	83 ec 04             	sub    $0x4,%esp
    124b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    124e:	6a 01                	push   $0x1
    1250:	50                   	push   %eax
    1251:	6a 00                	push   $0x0
    1253:	e8 a9 01 00 00       	call   1401 <read>
    if(cc < 1)
    1258:	83 c4 10             	add    $0x10,%esp
    125b:	85 c0                	test   %eax,%eax
    125d:	7e 1c                	jle    127b <gets+0x4b>
      break;
    buf[i++] = c;
    125f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    1263:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    1266:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1269:	3c 0a                	cmp    $0xa,%al
    126b:	74 23                	je     1290 <gets+0x60>
    126d:	3c 0d                	cmp    $0xd,%al
    126f:	74 1f                	je     1290 <gets+0x60>
  for(i=0; i+1 < max; ){
    1271:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    1274:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    1276:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1279:	7c cd                	jl     1248 <gets+0x18>
    127b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    127d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1280:	c6 03 00             	movb   $0x0,(%ebx)
}
    1283:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1286:	5b                   	pop    %ebx
    1287:	5e                   	pop    %esi
    1288:	5f                   	pop    %edi
    1289:	5d                   	pop    %ebp
    128a:	c3                   	ret    
    128b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    128f:	90                   	nop
  buf[i] = '\0';
    1290:	8b 75 08             	mov    0x8(%ebp),%esi
}
    1293:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1296:	01 de                	add    %ebx,%esi
    1298:	89 f3                	mov    %esi,%ebx
    129a:	c6 03 00             	movb   $0x0,(%ebx)
}
    129d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12a0:	5b                   	pop    %ebx
    12a1:	5e                   	pop    %esi
    12a2:	5f                   	pop    %edi
    12a3:	5d                   	pop    %ebp
    12a4:	c3                   	ret    
    12a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000012b0 <stat>:

int
stat(const char *n, struct stat *st)
{
    12b0:	55                   	push   %ebp
    12b1:	89 e5                	mov    %esp,%ebp
    12b3:	56                   	push   %esi
    12b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12b5:	83 ec 08             	sub    $0x8,%esp
    12b8:	6a 00                	push   $0x0
    12ba:	ff 75 08             	pushl  0x8(%ebp)
    12bd:	e8 67 01 00 00       	call   1429 <open>
  if(fd < 0)
    12c2:	83 c4 10             	add    $0x10,%esp
    12c5:	85 c0                	test   %eax,%eax
    12c7:	78 27                	js     12f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    12c9:	83 ec 08             	sub    $0x8,%esp
    12cc:	ff 75 0c             	pushl  0xc(%ebp)
    12cf:	89 c3                	mov    %eax,%ebx
    12d1:	50                   	push   %eax
    12d2:	e8 6a 01 00 00       	call   1441 <fstat>
  close(fd);
    12d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    12da:	89 c6                	mov    %eax,%esi
  close(fd);
    12dc:	e8 30 01 00 00       	call   1411 <close>
  return r;
    12e1:	83 c4 10             	add    $0x10,%esp
}
    12e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    12e7:	89 f0                	mov    %esi,%eax
    12e9:	5b                   	pop    %ebx
    12ea:	5e                   	pop    %esi
    12eb:	5d                   	pop    %ebp
    12ec:	c3                   	ret    
    12ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    12f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    12f5:	eb ed                	jmp    12e4 <stat+0x34>
    12f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12fe:	66 90                	xchg   %ax,%ax

00001300 <atoi>:

int
atoi(const char *s)
{
    1300:	55                   	push   %ebp
    1301:	89 e5                	mov    %esp,%ebp
    1303:	53                   	push   %ebx
    1304:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1307:	0f be 02             	movsbl (%edx),%eax
    130a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    130d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1310:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1315:	77 1e                	ja     1335 <atoi+0x35>
    1317:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    131e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    1320:	83 c2 01             	add    $0x1,%edx
    1323:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1326:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    132a:	0f be 02             	movsbl (%edx),%eax
    132d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1330:	80 fb 09             	cmp    $0x9,%bl
    1333:	76 eb                	jbe    1320 <atoi+0x20>
  return n;
}
    1335:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1338:	89 c8                	mov    %ecx,%eax
    133a:	c9                   	leave  
    133b:	c3                   	ret    
    133c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001340 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	57                   	push   %edi
    1344:	8b 45 10             	mov    0x10(%ebp),%eax
    1347:	8b 55 08             	mov    0x8(%ebp),%edx
    134a:	56                   	push   %esi
    134b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    134e:	85 c0                	test   %eax,%eax
    1350:	7e 13                	jle    1365 <memmove+0x25>
    1352:	01 d0                	add    %edx,%eax
  dst = vdst;
    1354:	89 d7                	mov    %edx,%edi
    1356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    135d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    1360:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    1361:	39 f8                	cmp    %edi,%eax
    1363:	75 fb                	jne    1360 <memmove+0x20>
  return vdst;
}
    1365:	5e                   	pop    %esi
    1366:	89 d0                	mov    %edx,%eax
    1368:	5f                   	pop    %edi
    1369:	5d                   	pop    %ebp
    136a:	c3                   	ret    
    136b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    136f:	90                   	nop

00001370 <thread_create>:


int thread_create(void (*start_routine)(void*, void*), void *arg1, void *arg2) {
    1370:	55                   	push   %ebp
    1371:	89 e5                	mov    %esp,%ebp
    1373:	53                   	push   %ebx
    1374:	83 ec 20             	sub    $0x20,%esp
  void *stack =  malloc(4096);
    1377:	68 00 10 00 00       	push   $0x1000
    137c:	e8 bf 01 00 00       	call   1540 <malloc>
  if(stack == 0)
    1381:	83 c4 10             	add    $0x10,%esp
    1384:	85 c0                	test   %eax,%eax
    1386:	74 3f                	je     13c7 <thread_create+0x57>
    return -1;
  int r= clone(start_routine, arg1, arg2, stack);
    1388:	50                   	push   %eax
    1389:	89 c3                	mov    %eax,%ebx
    138b:	ff 75 10             	pushl  0x10(%ebp)
    138e:	ff 75 0c             	pushl  0xc(%ebp)
    1391:	ff 75 08             	pushl  0x8(%ebp)
    1394:	e8 00 01 00 00       	call   1499 <clone>
  if(r==-1) 
    1399:	83 c4 10             	add    $0x10,%esp
    139c:	83 f8 ff             	cmp    $0xffffffff,%eax
    139f:	74 0f                	je     13b0 <thread_create+0x40>
    free(stack);
  return r;
}
    13a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13a4:	c9                   	leave  
    13a5:	c3                   	ret    
    13a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13ad:	8d 76 00             	lea    0x0(%esi),%esi
    free(stack);
    13b0:	83 ec 0c             	sub    $0xc,%esp
    13b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13b6:	53                   	push   %ebx
    13b7:	e8 f4 00 00 00       	call   14b0 <free>
    13bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    13bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    free(stack);
    13c2:	83 c4 10             	add    $0x10,%esp
}
    13c5:	c9                   	leave  
    13c6:	c3                   	ret    
    return -1;
    13c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13cc:	eb d3                	jmp    13a1 <thread_create+0x31>
    13ce:	66 90                	xchg   %ax,%ax

000013d0 <thread_join>:


int thread_join(void) {
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	83 ec 24             	sub    $0x24,%esp
  void *stack;
  int r = join(&stack);
    13d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13d9:	50                   	push   %eax
    13da:	e8 c2 00 00 00       	call   14a1 <join>
  return r;
}
    13df:	c9                   	leave  
    13e0:	c3                   	ret    

000013e1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13e1:	b8 01 00 00 00       	mov    $0x1,%eax
    13e6:	cd 40                	int    $0x40
    13e8:	c3                   	ret    

000013e9 <exit>:
SYSCALL(exit)
    13e9:	b8 02 00 00 00       	mov    $0x2,%eax
    13ee:	cd 40                	int    $0x40
    13f0:	c3                   	ret    

000013f1 <wait>:
SYSCALL(wait)
    13f1:	b8 03 00 00 00       	mov    $0x3,%eax
    13f6:	cd 40                	int    $0x40
    13f8:	c3                   	ret    

000013f9 <pipe>:
SYSCALL(pipe)
    13f9:	b8 04 00 00 00       	mov    $0x4,%eax
    13fe:	cd 40                	int    $0x40
    1400:	c3                   	ret    

00001401 <read>:
SYSCALL(read)
    1401:	b8 05 00 00 00       	mov    $0x5,%eax
    1406:	cd 40                	int    $0x40
    1408:	c3                   	ret    

00001409 <write>:
SYSCALL(write)
    1409:	b8 10 00 00 00       	mov    $0x10,%eax
    140e:	cd 40                	int    $0x40
    1410:	c3                   	ret    

00001411 <close>:
SYSCALL(close)
    1411:	b8 15 00 00 00       	mov    $0x15,%eax
    1416:	cd 40                	int    $0x40
    1418:	c3                   	ret    

00001419 <kill>:
SYSCALL(kill)
    1419:	b8 06 00 00 00       	mov    $0x6,%eax
    141e:	cd 40                	int    $0x40
    1420:	c3                   	ret    

00001421 <exec>:
SYSCALL(exec)
    1421:	b8 07 00 00 00       	mov    $0x7,%eax
    1426:	cd 40                	int    $0x40
    1428:	c3                   	ret    

00001429 <open>:
SYSCALL(open)
    1429:	b8 0f 00 00 00       	mov    $0xf,%eax
    142e:	cd 40                	int    $0x40
    1430:	c3                   	ret    

00001431 <mknod>:
SYSCALL(mknod)
    1431:	b8 11 00 00 00       	mov    $0x11,%eax
    1436:	cd 40                	int    $0x40
    1438:	c3                   	ret    

00001439 <unlink>:
SYSCALL(unlink)
    1439:	b8 12 00 00 00       	mov    $0x12,%eax
    143e:	cd 40                	int    $0x40
    1440:	c3                   	ret    

00001441 <fstat>:
SYSCALL(fstat)
    1441:	b8 08 00 00 00       	mov    $0x8,%eax
    1446:	cd 40                	int    $0x40
    1448:	c3                   	ret    

00001449 <link>:
SYSCALL(link)
    1449:	b8 13 00 00 00       	mov    $0x13,%eax
    144e:	cd 40                	int    $0x40
    1450:	c3                   	ret    

00001451 <mkdir>:
SYSCALL(mkdir)
    1451:	b8 14 00 00 00       	mov    $0x14,%eax
    1456:	cd 40                	int    $0x40
    1458:	c3                   	ret    

00001459 <chdir>:
SYSCALL(chdir)
    1459:	b8 09 00 00 00       	mov    $0x9,%eax
    145e:	cd 40                	int    $0x40
    1460:	c3                   	ret    

00001461 <dup>:
SYSCALL(dup)
    1461:	b8 0a 00 00 00       	mov    $0xa,%eax
    1466:	cd 40                	int    $0x40
    1468:	c3                   	ret    

00001469 <getpid>:
SYSCALL(getpid)
    1469:	b8 0b 00 00 00       	mov    $0xb,%eax
    146e:	cd 40                	int    $0x40
    1470:	c3                   	ret    

00001471 <sbrk>:
SYSCALL(sbrk)
    1471:	b8 0c 00 00 00       	mov    $0xc,%eax
    1476:	cd 40                	int    $0x40
    1478:	c3                   	ret    

00001479 <sleep>:
SYSCALL(sleep)
    1479:	b8 0d 00 00 00       	mov    $0xd,%eax
    147e:	cd 40                	int    $0x40
    1480:	c3                   	ret    

00001481 <uptime>:
SYSCALL(uptime)
    1481:	b8 0e 00 00 00       	mov    $0xe,%eax
    1486:	cd 40                	int    $0x40
    1488:	c3                   	ret    

00001489 <mprotect>:
SYSCALL(mprotect)
    1489:	b8 16 00 00 00       	mov    $0x16,%eax
    148e:	cd 40                	int    $0x40
    1490:	c3                   	ret    

00001491 <munprotect>:
SYSCALL(munprotect)
    1491:	b8 17 00 00 00       	mov    $0x17,%eax
    1496:	cd 40                	int    $0x40
    1498:	c3                   	ret    

00001499 <clone>:
SYSCALL(clone)
    1499:	b8 18 00 00 00       	mov    $0x18,%eax
    149e:	cd 40                	int    $0x40
    14a0:	c3                   	ret    

000014a1 <join>:
SYSCALL(join)
    14a1:	b8 19 00 00 00       	mov    $0x19,%eax
    14a6:	cd 40                	int    $0x40
    14a8:	c3                   	ret    
    14a9:	66 90                	xchg   %ax,%ax
    14ab:	66 90                	xchg   %ax,%ax
    14ad:	66 90                	xchg   %ax,%ax
    14af:	90                   	nop

000014b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14b1:	a1 6c 19 00 00       	mov    0x196c,%eax
{
    14b6:	89 e5                	mov    %esp,%ebp
    14b8:	57                   	push   %edi
    14b9:	56                   	push   %esi
    14ba:	53                   	push   %ebx
    14bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    14be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14c8:	89 c2                	mov    %eax,%edx
    14ca:	8b 00                	mov    (%eax),%eax
    14cc:	39 ca                	cmp    %ecx,%edx
    14ce:	73 30                	jae    1500 <free+0x50>
    14d0:	39 c1                	cmp    %eax,%ecx
    14d2:	72 04                	jb     14d8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14d4:	39 c2                	cmp    %eax,%edx
    14d6:	72 f0                	jb     14c8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14de:	39 f8                	cmp    %edi,%eax
    14e0:	74 30                	je     1512 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14e2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    14e5:	8b 42 04             	mov    0x4(%edx),%eax
    14e8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    14eb:	39 f1                	cmp    %esi,%ecx
    14ed:	74 3a                	je     1529 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    14ef:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    14f1:	5b                   	pop    %ebx
  freep = p;
    14f2:	89 15 6c 19 00 00    	mov    %edx,0x196c
}
    14f8:	5e                   	pop    %esi
    14f9:	5f                   	pop    %edi
    14fa:	5d                   	pop    %ebp
    14fb:	c3                   	ret    
    14fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1500:	39 c2                	cmp    %eax,%edx
    1502:	72 c4                	jb     14c8 <free+0x18>
    1504:	39 c1                	cmp    %eax,%ecx
    1506:	73 c0                	jae    14c8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1508:	8b 73 fc             	mov    -0x4(%ebx),%esi
    150b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    150e:	39 f8                	cmp    %edi,%eax
    1510:	75 d0                	jne    14e2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    1512:	03 70 04             	add    0x4(%eax),%esi
    1515:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1518:	8b 02                	mov    (%edx),%eax
    151a:	8b 00                	mov    (%eax),%eax
    151c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    151f:	8b 42 04             	mov    0x4(%edx),%eax
    1522:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1525:	39 f1                	cmp    %esi,%ecx
    1527:	75 c6                	jne    14ef <free+0x3f>
    p->s.size += bp->s.size;
    1529:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    152c:	89 15 6c 19 00 00    	mov    %edx,0x196c
    p->s.size += bp->s.size;
    1532:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1535:	8b 43 f8             	mov    -0x8(%ebx),%eax
    1538:	89 02                	mov    %eax,(%edx)
}
    153a:	5b                   	pop    %ebx
    153b:	5e                   	pop    %esi
    153c:	5f                   	pop    %edi
    153d:	5d                   	pop    %ebp
    153e:	c3                   	ret    
    153f:	90                   	nop

00001540 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1540:	55                   	push   %ebp
    1541:	89 e5                	mov    %esp,%ebp
    1543:	57                   	push   %edi
    1544:	56                   	push   %esi
    1545:	53                   	push   %ebx
    1546:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1549:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    154c:	8b 3d 6c 19 00 00    	mov    0x196c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1552:	8d 70 07             	lea    0x7(%eax),%esi
    1555:	c1 ee 03             	shr    $0x3,%esi
    1558:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    155b:	85 ff                	test   %edi,%edi
    155d:	0f 84 ad 00 00 00    	je     1610 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1563:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1565:	8b 48 04             	mov    0x4(%eax),%ecx
    1568:	39 f1                	cmp    %esi,%ecx
    156a:	73 71                	jae    15dd <malloc+0x9d>
    156c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1572:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1577:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    157a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1581:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1584:	eb 1b                	jmp    15a1 <malloc+0x61>
    1586:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    158d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1590:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1592:	8b 4a 04             	mov    0x4(%edx),%ecx
    1595:	39 f1                	cmp    %esi,%ecx
    1597:	73 4f                	jae    15e8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1599:	8b 3d 6c 19 00 00    	mov    0x196c,%edi
    159f:	89 d0                	mov    %edx,%eax
    15a1:	39 c7                	cmp    %eax,%edi
    15a3:	75 eb                	jne    1590 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    15a5:	83 ec 0c             	sub    $0xc,%esp
    15a8:	ff 75 e4             	pushl  -0x1c(%ebp)
    15ab:	e8 c1 fe ff ff       	call   1471 <sbrk>
  if(p == (char*)-1)
    15b0:	83 c4 10             	add    $0x10,%esp
    15b3:	83 f8 ff             	cmp    $0xffffffff,%eax
    15b6:	74 1b                	je     15d3 <malloc+0x93>
  hp->s.size = nu;
    15b8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    15bb:	83 ec 0c             	sub    $0xc,%esp
    15be:	83 c0 08             	add    $0x8,%eax
    15c1:	50                   	push   %eax
    15c2:	e8 e9 fe ff ff       	call   14b0 <free>
  return freep;
    15c7:	a1 6c 19 00 00       	mov    0x196c,%eax
      if((p = morecore(nunits)) == 0)
    15cc:	83 c4 10             	add    $0x10,%esp
    15cf:	85 c0                	test   %eax,%eax
    15d1:	75 bd                	jne    1590 <malloc+0x50>
        return 0;
  }
}
    15d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    15d6:	31 c0                	xor    %eax,%eax
}
    15d8:	5b                   	pop    %ebx
    15d9:	5e                   	pop    %esi
    15da:	5f                   	pop    %edi
    15db:	5d                   	pop    %ebp
    15dc:	c3                   	ret    
    if(p->s.size >= nunits){
    15dd:	89 c2                	mov    %eax,%edx
    15df:	89 f8                	mov    %edi,%eax
    15e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    15e8:	39 ce                	cmp    %ecx,%esi
    15ea:	74 54                	je     1640 <malloc+0x100>
        p->s.size -= nunits;
    15ec:	29 f1                	sub    %esi,%ecx
    15ee:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    15f1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    15f4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    15f7:	a3 6c 19 00 00       	mov    %eax,0x196c
}
    15fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    15ff:	8d 42 08             	lea    0x8(%edx),%eax
}
    1602:	5b                   	pop    %ebx
    1603:	5e                   	pop    %esi
    1604:	5f                   	pop    %edi
    1605:	5d                   	pop    %ebp
    1606:	c3                   	ret    
    1607:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    160e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    1610:	c7 05 6c 19 00 00 70 	movl   $0x1970,0x196c
    1617:	19 00 00 
    base.s.size = 0;
    161a:	bf 70 19 00 00       	mov    $0x1970,%edi
    base.s.ptr = freep = prevp = &base;
    161f:	c7 05 70 19 00 00 70 	movl   $0x1970,0x1970
    1626:	19 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1629:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    162b:	c7 05 74 19 00 00 00 	movl   $0x0,0x1974
    1632:	00 00 00 
    if(p->s.size >= nunits){
    1635:	e9 32 ff ff ff       	jmp    156c <malloc+0x2c>
    163a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1640:	8b 0a                	mov    (%edx),%ecx
    1642:	89 08                	mov    %ecx,(%eax)
    1644:	eb b1                	jmp    15f7 <malloc+0xb7>
