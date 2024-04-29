
_test:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "types.h"
#include "user.h"
#include "processInfo.h"


int main(void) {
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	53                   	push   %ebx
    100e:	51                   	push   %ecx
    100f:	83 ec 10             	sub    $0x10,%esp
  struct processInfo pinfo;  
  
  printf(1,"number of processes = %d\n", getNumProc());
    1012:	e8 22 04 00 00       	call   1439 <getNumProc>
    1017:	83 ec 04             	sub    $0x4,%esp
    101a:	50                   	push   %eax
    101b:	68 78 18 00 00       	push   $0x1878
    1020:	6a 01                	push   $0x1
    1022:	e8 e9 04 00 00       	call   1510 <printf>
  int maxpid  = getMaxPid(); 
    1027:	e8 15 04 00 00       	call   1441 <getMaxPid>
  printf(1,"MaxPid among the processes = %d\n", maxpid);
    102c:	83 c4 0c             	add    $0xc,%esp
    102f:	50                   	push   %eax
  int maxpid  = getMaxPid(); 
    1030:	89 c3                	mov    %eax,%ebx
  printf(1,"MaxPid among the processes = %d\n", maxpid);
    1032:	68 d0 18 00 00       	push   $0x18d0
    1037:	6a 01                	push   $0x1
    1039:	e8 d2 04 00 00       	call   1510 <printf>

  if(getProcInfo(maxpid,&pinfo) == -1) {
    103e:	8d 45 ec             	lea    -0x14(%ebp),%eax
    1041:	5a                   	pop    %edx
    1042:	59                   	pop    %ecx
    1043:	50                   	push   %eax
    1044:	53                   	push   %ebx
    1045:	e8 ff 03 00 00       	call   1449 <getProcInfo>
    104a:	83 c4 10             	add    $0x10,%esp
    104d:	83 f8 ff             	cmp    $0xffffffff,%eax
    1050:	74 42                	je     1094 <main+0x94>
    printf(1,"Error: maxpid %d not found\n", maxpid);    
  }
  printf(1,"cscnt = %d\n", pinfo.numberContextSwitches);
    1052:	83 ec 04             	sub    $0x4,%esp
    1055:	ff 75 f4             	pushl  -0xc(%ebp)
    1058:	68 ae 18 00 00       	push   $0x18ae
    105d:	6a 01                	push   $0x1
    105f:	e8 ac 04 00 00       	call   1510 <printf>

  printf(1,"size = %d\n", pinfo.psize);
    1064:	83 c4 0c             	add    $0xc,%esp
    1067:	ff 75 f0             	pushl  -0x10(%ebp)
    106a:	68 ba 18 00 00       	push   $0x18ba
    106f:	6a 01                	push   $0x1
    1071:	e8 9a 04 00 00       	call   1510 <printf>
  printf(1,"ppid = %d\n", pinfo.ppid);
    1076:	83 c4 0c             	add    $0xc,%esp
    1079:	ff 75 ec             	pushl  -0x14(%ebp)
    107c:	68 c5 18 00 00       	push   $0x18c5
    1081:	6a 01                	push   $0x1
    1083:	e8 88 04 00 00       	call   1510 <printf>
  

  
}
    1088:	8d 65 f8             	lea    -0x8(%ebp),%esp
    108b:	31 c0                	xor    %eax,%eax
    108d:	59                   	pop    %ecx
    108e:	5b                   	pop    %ebx
    108f:	5d                   	pop    %ebp
    1090:	8d 61 fc             	lea    -0x4(%ecx),%esp
    1093:	c3                   	ret    
    printf(1,"Error: maxpid %d not found\n", maxpid);    
    1094:	50                   	push   %eax
    1095:	53                   	push   %ebx
    1096:	68 92 18 00 00       	push   $0x1892
    109b:	6a 01                	push   $0x1
    109d:	e8 6e 04 00 00       	call   1510 <printf>
    10a2:	83 c4 10             	add    $0x10,%esp
    10a5:	eb ab                	jmp    1052 <main+0x52>
    10a7:	66 90                	xchg   %ax,%ax
    10a9:	66 90                	xchg   %ax,%ax
    10ab:	66 90                	xchg   %ax,%ax
    10ad:	66 90                	xchg   %ax,%ax
    10af:	90                   	nop

000010b0 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"
char*
strcpy(char *s, const char *t)
{
    10b0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    10b1:	31 c0                	xor    %eax,%eax
{
    10b3:	89 e5                	mov    %esp,%ebp
    10b5:	53                   	push   %ebx
    10b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    10c0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    10c4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    10c7:	83 c0 01             	add    $0x1,%eax
    10ca:	84 d2                	test   %dl,%dl
    10cc:	75 f2                	jne    10c0 <strcpy+0x10>
    ;
  return os;
}
    10ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10d1:	89 c8                	mov    %ecx,%eax
    10d3:	c9                   	leave  
    10d4:	c3                   	ret    
    10d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000010e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	53                   	push   %ebx
    10e4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    10ea:	0f b6 01             	movzbl (%ecx),%eax
    10ed:	0f b6 1a             	movzbl (%edx),%ebx
    10f0:	84 c0                	test   %al,%al
    10f2:	75 1d                	jne    1111 <strcmp+0x31>
    10f4:	eb 2a                	jmp    1120 <strcmp+0x40>
    10f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10fd:	8d 76 00             	lea    0x0(%esi),%esi
    1100:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    1104:	83 c1 01             	add    $0x1,%ecx
    1107:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    110a:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    110d:	84 c0                	test   %al,%al
    110f:	74 0f                	je     1120 <strcmp+0x40>
    1111:	38 d8                	cmp    %bl,%al
    1113:	74 eb                	je     1100 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1115:	29 d8                	sub    %ebx,%eax
}
    1117:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    111a:	c9                   	leave  
    111b:	c3                   	ret    
    111c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1120:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1122:	29 d8                	sub    %ebx,%eax
}
    1124:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1127:	c9                   	leave  
    1128:	c3                   	ret    
    1129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001130 <strlen>:

uint
strlen(const char *s)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    1136:	80 3a 00             	cmpb   $0x0,(%edx)
    1139:	74 15                	je     1150 <strlen+0x20>
    113b:	31 c0                	xor    %eax,%eax
    113d:	8d 76 00             	lea    0x0(%esi),%esi
    1140:	83 c0 01             	add    $0x1,%eax
    1143:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    1147:	89 c1                	mov    %eax,%ecx
    1149:	75 f5                	jne    1140 <strlen+0x10>
    ;
  return n;
}
    114b:	89 c8                	mov    %ecx,%eax
    114d:	5d                   	pop    %ebp
    114e:	c3                   	ret    
    114f:	90                   	nop
  for(n = 0; s[n]; n++)
    1150:	31 c9                	xor    %ecx,%ecx
}
    1152:	5d                   	pop    %ebp
    1153:	89 c8                	mov    %ecx,%eax
    1155:	c3                   	ret    
    1156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    115d:	8d 76 00             	lea    0x0(%esi),%esi

00001160 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1160:	55                   	push   %ebp
    1161:	89 e5                	mov    %esp,%ebp
    1163:	57                   	push   %edi
    1164:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1167:	8b 4d 10             	mov    0x10(%ebp),%ecx
    116a:	8b 45 0c             	mov    0xc(%ebp),%eax
    116d:	89 d7                	mov    %edx,%edi
    116f:	fc                   	cld    
    1170:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1172:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1175:	89 d0                	mov    %edx,%eax
    1177:	c9                   	leave  
    1178:	c3                   	ret    
    1179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001180 <strchr>:

char*
strchr(const char *s, char c)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	8b 45 08             	mov    0x8(%ebp),%eax
    1186:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    118a:	0f b6 10             	movzbl (%eax),%edx
    118d:	84 d2                	test   %dl,%dl
    118f:	75 12                	jne    11a3 <strchr+0x23>
    1191:	eb 1d                	jmp    11b0 <strchr+0x30>
    1193:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1197:	90                   	nop
    1198:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    119c:	83 c0 01             	add    $0x1,%eax
    119f:	84 d2                	test   %dl,%dl
    11a1:	74 0d                	je     11b0 <strchr+0x30>
    if(*s == c)
    11a3:	38 d1                	cmp    %dl,%cl
    11a5:	75 f1                	jne    1198 <strchr+0x18>
      return (char*)s;
  return 0;
}
    11a7:	5d                   	pop    %ebp
    11a8:	c3                   	ret    
    11a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    11b0:	31 c0                	xor    %eax,%eax
}
    11b2:	5d                   	pop    %ebp
    11b3:	c3                   	ret    
    11b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11bf:	90                   	nop

000011c0 <gets>:

char*
gets(char *buf, int max)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	57                   	push   %edi
    11c4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11c5:	31 f6                	xor    %esi,%esi
{
    11c7:	53                   	push   %ebx
    11c8:	89 f3                	mov    %esi,%ebx
    11ca:	83 ec 1c             	sub    $0x1c,%esp
    11cd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    11d0:	eb 2f                	jmp    1201 <gets+0x41>
    11d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    11d8:	83 ec 04             	sub    $0x4,%esp
    11db:	8d 45 e7             	lea    -0x19(%ebp),%eax
    11de:	6a 01                	push   $0x1
    11e0:	50                   	push   %eax
    11e1:	6a 00                	push   $0x0
    11e3:	e8 a9 01 00 00       	call   1391 <read>
    if(cc < 1)
    11e8:	83 c4 10             	add    $0x10,%esp
    11eb:	85 c0                	test   %eax,%eax
    11ed:	7e 1c                	jle    120b <gets+0x4b>
      break;
    buf[i++] = c;
    11ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    11f3:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    11f6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    11f9:	3c 0a                	cmp    $0xa,%al
    11fb:	74 23                	je     1220 <gets+0x60>
    11fd:	3c 0d                	cmp    $0xd,%al
    11ff:	74 1f                	je     1220 <gets+0x60>
  for(i=0; i+1 < max; ){
    1201:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    1204:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    1206:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1209:	7c cd                	jl     11d8 <gets+0x18>
    120b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    120d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1210:	c6 03 00             	movb   $0x0,(%ebx)
}
    1213:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1216:	5b                   	pop    %ebx
    1217:	5e                   	pop    %esi
    1218:	5f                   	pop    %edi
    1219:	5d                   	pop    %ebp
    121a:	c3                   	ret    
    121b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    121f:	90                   	nop
  buf[i] = '\0';
    1220:	8b 75 08             	mov    0x8(%ebp),%esi
}
    1223:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1226:	01 de                	add    %ebx,%esi
    1228:	89 f3                	mov    %esi,%ebx
    122a:	c6 03 00             	movb   $0x0,(%ebx)
}
    122d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1230:	5b                   	pop    %ebx
    1231:	5e                   	pop    %esi
    1232:	5f                   	pop    %edi
    1233:	5d                   	pop    %ebp
    1234:	c3                   	ret    
    1235:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    123c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001240 <stat>:

int
stat(const char *n, struct stat *st)
{
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	56                   	push   %esi
    1244:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1245:	83 ec 08             	sub    $0x8,%esp
    1248:	6a 00                	push   $0x0
    124a:	ff 75 08             	pushl  0x8(%ebp)
    124d:	e8 67 01 00 00       	call   13b9 <open>
  if(fd < 0)
    1252:	83 c4 10             	add    $0x10,%esp
    1255:	85 c0                	test   %eax,%eax
    1257:	78 27                	js     1280 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1259:	83 ec 08             	sub    $0x8,%esp
    125c:	ff 75 0c             	pushl  0xc(%ebp)
    125f:	89 c3                	mov    %eax,%ebx
    1261:	50                   	push   %eax
    1262:	e8 6a 01 00 00       	call   13d1 <fstat>
  close(fd);
    1267:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    126a:	89 c6                	mov    %eax,%esi
  close(fd);
    126c:	e8 30 01 00 00       	call   13a1 <close>
  return r;
    1271:	83 c4 10             	add    $0x10,%esp
}
    1274:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1277:	89 f0                	mov    %esi,%eax
    1279:	5b                   	pop    %ebx
    127a:	5e                   	pop    %esi
    127b:	5d                   	pop    %ebp
    127c:	c3                   	ret    
    127d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1280:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1285:	eb ed                	jmp    1274 <stat+0x34>
    1287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    128e:	66 90                	xchg   %ax,%ax

00001290 <atoi>:

int
atoi(const char *s)
{
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
    1293:	53                   	push   %ebx
    1294:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1297:	0f be 02             	movsbl (%edx),%eax
    129a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    129d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    12a0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    12a5:	77 1e                	ja     12c5 <atoi+0x35>
    12a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12ae:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    12b0:	83 c2 01             	add    $0x1,%edx
    12b3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    12b6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    12ba:	0f be 02             	movsbl (%edx),%eax
    12bd:	8d 58 d0             	lea    -0x30(%eax),%ebx
    12c0:	80 fb 09             	cmp    $0x9,%bl
    12c3:	76 eb                	jbe    12b0 <atoi+0x20>
  return n;
}
    12c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12c8:	89 c8                	mov    %ecx,%eax
    12ca:	c9                   	leave  
    12cb:	c3                   	ret    
    12cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000012d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	57                   	push   %edi
    12d4:	8b 45 10             	mov    0x10(%ebp),%eax
    12d7:	8b 55 08             	mov    0x8(%ebp),%edx
    12da:	56                   	push   %esi
    12db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12de:	85 c0                	test   %eax,%eax
    12e0:	7e 13                	jle    12f5 <memmove+0x25>
    12e2:	01 d0                	add    %edx,%eax
  dst = vdst;
    12e4:	89 d7                	mov    %edx,%edi
    12e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12ed:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    12f0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    12f1:	39 f8                	cmp    %edi,%eax
    12f3:	75 fb                	jne    12f0 <memmove+0x20>
  return vdst;
}
    12f5:	5e                   	pop    %esi
    12f6:	89 d0                	mov    %edx,%eax
    12f8:	5f                   	pop    %edi
    12f9:	5d                   	pop    %ebp
    12fa:	c3                   	ret    
    12fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12ff:	90                   	nop

00001300 <thread_create>:


int thread_create(void (*start_routine)(void*, void*), void *arg1, void *arg2) {
    1300:	55                   	push   %ebp
    1301:	89 e5                	mov    %esp,%ebp
    1303:	53                   	push   %ebx
    1304:	83 ec 20             	sub    $0x20,%esp
  void *stack =  malloc(4096);
    1307:	68 00 10 00 00       	push   $0x1000
    130c:	e8 5f 04 00 00       	call   1770 <malloc>
  if(stack == 0)
    1311:	83 c4 10             	add    $0x10,%esp
    1314:	85 c0                	test   %eax,%eax
    1316:	74 3f                	je     1357 <thread_create+0x57>
    return -1;
  int r= clone(start_routine, arg1, arg2, stack);
    1318:	50                   	push   %eax
    1319:	89 c3                	mov    %eax,%ebx
    131b:	ff 75 10             	pushl  0x10(%ebp)
    131e:	ff 75 0c             	pushl  0xc(%ebp)
    1321:	ff 75 08             	pushl  0x8(%ebp)
    1324:	e8 00 01 00 00       	call   1429 <clone>
  if(r==-1) 
    1329:	83 c4 10             	add    $0x10,%esp
    132c:	83 f8 ff             	cmp    $0xffffffff,%eax
    132f:	74 0f                	je     1340 <thread_create+0x40>
    free(stack);
  return r;
}
    1331:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1334:	c9                   	leave  
    1335:	c3                   	ret    
    1336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    133d:	8d 76 00             	lea    0x0(%esi),%esi
    free(stack);
    1340:	83 ec 0c             	sub    $0xc,%esp
    1343:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1346:	53                   	push   %ebx
    1347:	e8 94 03 00 00       	call   16e0 <free>
    134c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    134f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    free(stack);
    1352:	83 c4 10             	add    $0x10,%esp
}
    1355:	c9                   	leave  
    1356:	c3                   	ret    
    return -1;
    1357:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    135c:	eb d3                	jmp    1331 <thread_create+0x31>
    135e:	66 90                	xchg   %ax,%ax

00001360 <thread_join>:


int thread_join(void) {
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	83 ec 24             	sub    $0x24,%esp
  void *stack;
  int r = join(&stack);
    1366:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1369:	50                   	push   %eax
    136a:	e8 c2 00 00 00       	call   1431 <join>
  return r;
}
    136f:	c9                   	leave  
    1370:	c3                   	ret    

00001371 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1371:	b8 01 00 00 00       	mov    $0x1,%eax
    1376:	cd 40                	int    $0x40
    1378:	c3                   	ret    

00001379 <exit>:
SYSCALL(exit)
    1379:	b8 02 00 00 00       	mov    $0x2,%eax
    137e:	cd 40                	int    $0x40
    1380:	c3                   	ret    

00001381 <wait>:
SYSCALL(wait)
    1381:	b8 03 00 00 00       	mov    $0x3,%eax
    1386:	cd 40                	int    $0x40
    1388:	c3                   	ret    

00001389 <pipe>:
SYSCALL(pipe)
    1389:	b8 04 00 00 00       	mov    $0x4,%eax
    138e:	cd 40                	int    $0x40
    1390:	c3                   	ret    

00001391 <read>:
SYSCALL(read)
    1391:	b8 05 00 00 00       	mov    $0x5,%eax
    1396:	cd 40                	int    $0x40
    1398:	c3                   	ret    

00001399 <write>:
SYSCALL(write)
    1399:	b8 10 00 00 00       	mov    $0x10,%eax
    139e:	cd 40                	int    $0x40
    13a0:	c3                   	ret    

000013a1 <close>:
SYSCALL(close)
    13a1:	b8 15 00 00 00       	mov    $0x15,%eax
    13a6:	cd 40                	int    $0x40
    13a8:	c3                   	ret    

000013a9 <kill>:
SYSCALL(kill)
    13a9:	b8 06 00 00 00       	mov    $0x6,%eax
    13ae:	cd 40                	int    $0x40
    13b0:	c3                   	ret    

000013b1 <exec>:
SYSCALL(exec)
    13b1:	b8 07 00 00 00       	mov    $0x7,%eax
    13b6:	cd 40                	int    $0x40
    13b8:	c3                   	ret    

000013b9 <open>:
SYSCALL(open)
    13b9:	b8 0f 00 00 00       	mov    $0xf,%eax
    13be:	cd 40                	int    $0x40
    13c0:	c3                   	ret    

000013c1 <mknod>:
SYSCALL(mknod)
    13c1:	b8 11 00 00 00       	mov    $0x11,%eax
    13c6:	cd 40                	int    $0x40
    13c8:	c3                   	ret    

000013c9 <unlink>:
SYSCALL(unlink)
    13c9:	b8 12 00 00 00       	mov    $0x12,%eax
    13ce:	cd 40                	int    $0x40
    13d0:	c3                   	ret    

000013d1 <fstat>:
SYSCALL(fstat)
    13d1:	b8 08 00 00 00       	mov    $0x8,%eax
    13d6:	cd 40                	int    $0x40
    13d8:	c3                   	ret    

000013d9 <link>:
SYSCALL(link)
    13d9:	b8 13 00 00 00       	mov    $0x13,%eax
    13de:	cd 40                	int    $0x40
    13e0:	c3                   	ret    

000013e1 <mkdir>:
SYSCALL(mkdir)
    13e1:	b8 14 00 00 00       	mov    $0x14,%eax
    13e6:	cd 40                	int    $0x40
    13e8:	c3                   	ret    

000013e9 <chdir>:
SYSCALL(chdir)
    13e9:	b8 09 00 00 00       	mov    $0x9,%eax
    13ee:	cd 40                	int    $0x40
    13f0:	c3                   	ret    

000013f1 <dup>:
SYSCALL(dup)
    13f1:	b8 0a 00 00 00       	mov    $0xa,%eax
    13f6:	cd 40                	int    $0x40
    13f8:	c3                   	ret    

000013f9 <getpid>:
SYSCALL(getpid)
    13f9:	b8 0b 00 00 00       	mov    $0xb,%eax
    13fe:	cd 40                	int    $0x40
    1400:	c3                   	ret    

00001401 <sbrk>:
SYSCALL(sbrk)
    1401:	b8 0c 00 00 00       	mov    $0xc,%eax
    1406:	cd 40                	int    $0x40
    1408:	c3                   	ret    

00001409 <sleep>:
SYSCALL(sleep)
    1409:	b8 0d 00 00 00       	mov    $0xd,%eax
    140e:	cd 40                	int    $0x40
    1410:	c3                   	ret    

00001411 <uptime>:
SYSCALL(uptime)
    1411:	b8 0e 00 00 00       	mov    $0xe,%eax
    1416:	cd 40                	int    $0x40
    1418:	c3                   	ret    

00001419 <mprotect>:
SYSCALL(mprotect)
    1419:	b8 16 00 00 00       	mov    $0x16,%eax
    141e:	cd 40                	int    $0x40
    1420:	c3                   	ret    

00001421 <munprotect>:
SYSCALL(munprotect)
    1421:	b8 17 00 00 00       	mov    $0x17,%eax
    1426:	cd 40                	int    $0x40
    1428:	c3                   	ret    

00001429 <clone>:
SYSCALL(clone)
    1429:	b8 18 00 00 00       	mov    $0x18,%eax
    142e:	cd 40                	int    $0x40
    1430:	c3                   	ret    

00001431 <join>:
SYSCALL(join)
    1431:	b8 19 00 00 00       	mov    $0x19,%eax
    1436:	cd 40                	int    $0x40
    1438:	c3                   	ret    

00001439 <getNumProc>:
SYSCALL(getNumProc)
    1439:	b8 1a 00 00 00       	mov    $0x1a,%eax
    143e:	cd 40                	int    $0x40
    1440:	c3                   	ret    

00001441 <getMaxPid>:
SYSCALL(getMaxPid)
    1441:	b8 1b 00 00 00       	mov    $0x1b,%eax
    1446:	cd 40                	int    $0x40
    1448:	c3                   	ret    

00001449 <getProcInfo>:
SYSCALL(getProcInfo)
    1449:	b8 1c 00 00 00       	mov    $0x1c,%eax
    144e:	cd 40                	int    $0x40
    1450:	c3                   	ret    
    1451:	66 90                	xchg   %ax,%ax
    1453:	66 90                	xchg   %ax,%ax
    1455:	66 90                	xchg   %ax,%ax
    1457:	66 90                	xchg   %ax,%ax
    1459:	66 90                	xchg   %ax,%ax
    145b:	66 90                	xchg   %ax,%ax
    145d:	66 90                	xchg   %ax,%ax
    145f:	90                   	nop

00001460 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1460:	55                   	push   %ebp
    1461:	89 e5                	mov    %esp,%ebp
    1463:	57                   	push   %edi
    1464:	56                   	push   %esi
    1465:	53                   	push   %ebx
    1466:	83 ec 3c             	sub    $0x3c,%esp
    1469:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    146c:	89 d1                	mov    %edx,%ecx
{
    146e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    1471:	85 d2                	test   %edx,%edx
    1473:	0f 89 7f 00 00 00    	jns    14f8 <printint+0x98>
    1479:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    147d:	74 79                	je     14f8 <printint+0x98>
    neg = 1;
    147f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    1486:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    1488:	31 db                	xor    %ebx,%ebx
    148a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    148d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1490:	89 c8                	mov    %ecx,%eax
    1492:	31 d2                	xor    %edx,%edx
    1494:	89 cf                	mov    %ecx,%edi
    1496:	f7 75 c4             	divl   -0x3c(%ebp)
    1499:	0f b6 92 f8 18 00 00 	movzbl 0x18f8(%edx),%edx
    14a0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    14a3:	89 d8                	mov    %ebx,%eax
    14a5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    14a8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    14ab:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    14ae:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    14b1:	76 dd                	jbe    1490 <printint+0x30>
  if(neg)
    14b3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    14b6:	85 c9                	test   %ecx,%ecx
    14b8:	74 0c                	je     14c6 <printint+0x66>
    buf[i++] = '-';
    14ba:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    14bf:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    14c1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    14c6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    14c9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    14cd:	eb 07                	jmp    14d6 <printint+0x76>
    14cf:	90                   	nop
    putc(fd, buf[i]);
    14d0:	0f b6 13             	movzbl (%ebx),%edx
    14d3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    14d6:	83 ec 04             	sub    $0x4,%esp
    14d9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    14dc:	6a 01                	push   $0x1
    14de:	56                   	push   %esi
    14df:	57                   	push   %edi
    14e0:	e8 b4 fe ff ff       	call   1399 <write>
  while(--i >= 0)
    14e5:	83 c4 10             	add    $0x10,%esp
    14e8:	39 de                	cmp    %ebx,%esi
    14ea:	75 e4                	jne    14d0 <printint+0x70>
}
    14ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14ef:	5b                   	pop    %ebx
    14f0:	5e                   	pop    %esi
    14f1:	5f                   	pop    %edi
    14f2:	5d                   	pop    %ebp
    14f3:	c3                   	ret    
    14f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    14f8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    14ff:	eb 87                	jmp    1488 <printint+0x28>
    1501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1508:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    150f:	90                   	nop

00001510 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1510:	55                   	push   %ebp
    1511:	89 e5                	mov    %esp,%ebp
    1513:	57                   	push   %edi
    1514:	56                   	push   %esi
    1515:	53                   	push   %ebx
    1516:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1519:	8b 75 0c             	mov    0xc(%ebp),%esi
    151c:	0f b6 1e             	movzbl (%esi),%ebx
    151f:	84 db                	test   %bl,%bl
    1521:	0f 84 b8 00 00 00    	je     15df <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    1527:	8d 45 10             	lea    0x10(%ebp),%eax
    152a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    152d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    1530:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    1532:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1535:	eb 37                	jmp    156e <printf+0x5e>
    1537:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    153e:	66 90                	xchg   %ax,%ax
    1540:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    1543:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1548:	83 f8 25             	cmp    $0x25,%eax
    154b:	74 17                	je     1564 <printf+0x54>
  write(fd, &c, 1);
    154d:	83 ec 04             	sub    $0x4,%esp
    1550:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1553:	6a 01                	push   $0x1
    1555:	57                   	push   %edi
    1556:	ff 75 08             	pushl  0x8(%ebp)
    1559:	e8 3b fe ff ff       	call   1399 <write>
    155e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    1561:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1564:	0f b6 1e             	movzbl (%esi),%ebx
    1567:	83 c6 01             	add    $0x1,%esi
    156a:	84 db                	test   %bl,%bl
    156c:	74 71                	je     15df <printf+0xcf>
    c = fmt[i] & 0xff;
    156e:	0f be cb             	movsbl %bl,%ecx
    1571:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1574:	85 d2                	test   %edx,%edx
    1576:	74 c8                	je     1540 <printf+0x30>
      }
    } else if(state == '%'){
    1578:	83 fa 25             	cmp    $0x25,%edx
    157b:	75 e7                	jne    1564 <printf+0x54>
      if(c == 'd'){
    157d:	83 f8 64             	cmp    $0x64,%eax
    1580:	0f 84 9a 00 00 00    	je     1620 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1586:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    158c:	83 f9 70             	cmp    $0x70,%ecx
    158f:	74 5f                	je     15f0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1591:	83 f8 73             	cmp    $0x73,%eax
    1594:	0f 84 d6 00 00 00    	je     1670 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    159a:	83 f8 63             	cmp    $0x63,%eax
    159d:	0f 84 8d 00 00 00    	je     1630 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    15a3:	83 f8 25             	cmp    $0x25,%eax
    15a6:	0f 84 b4 00 00 00    	je     1660 <printf+0x150>
  write(fd, &c, 1);
    15ac:	83 ec 04             	sub    $0x4,%esp
    15af:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    15b3:	6a 01                	push   $0x1
    15b5:	57                   	push   %edi
    15b6:	ff 75 08             	pushl  0x8(%ebp)
    15b9:	e8 db fd ff ff       	call   1399 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    15be:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    15c1:	83 c4 0c             	add    $0xc,%esp
    15c4:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    15c6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    15c9:	57                   	push   %edi
    15ca:	ff 75 08             	pushl  0x8(%ebp)
    15cd:	e8 c7 fd ff ff       	call   1399 <write>
  for(i = 0; fmt[i]; i++){
    15d2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    15d6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15d9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    15db:	84 db                	test   %bl,%bl
    15dd:	75 8f                	jne    156e <printf+0x5e>
    }
  }
}
    15df:	8d 65 f4             	lea    -0xc(%ebp),%esp
    15e2:	5b                   	pop    %ebx
    15e3:	5e                   	pop    %esi
    15e4:	5f                   	pop    %edi
    15e5:	5d                   	pop    %ebp
    15e6:	c3                   	ret    
    15e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15ee:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    15f0:	83 ec 0c             	sub    $0xc,%esp
    15f3:	b9 10 00 00 00       	mov    $0x10,%ecx
    15f8:	6a 00                	push   $0x0
    15fa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    15fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1600:	8b 13                	mov    (%ebx),%edx
    1602:	e8 59 fe ff ff       	call   1460 <printint>
        ap++;
    1607:	89 d8                	mov    %ebx,%eax
    1609:	83 c4 10             	add    $0x10,%esp
      state = 0;
    160c:	31 d2                	xor    %edx,%edx
        ap++;
    160e:	83 c0 04             	add    $0x4,%eax
    1611:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1614:	e9 4b ff ff ff       	jmp    1564 <printf+0x54>
    1619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    1620:	83 ec 0c             	sub    $0xc,%esp
    1623:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1628:	6a 01                	push   $0x1
    162a:	eb ce                	jmp    15fa <printf+0xea>
    162c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1630:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1633:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1636:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    1638:	6a 01                	push   $0x1
        ap++;
    163a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    163d:	57                   	push   %edi
    163e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    1641:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1644:	e8 50 fd ff ff       	call   1399 <write>
        ap++;
    1649:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    164c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    164f:	31 d2                	xor    %edx,%edx
    1651:	e9 0e ff ff ff       	jmp    1564 <printf+0x54>
    1656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    165d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    1660:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1663:	83 ec 04             	sub    $0x4,%esp
    1666:	e9 59 ff ff ff       	jmp    15c4 <printf+0xb4>
    166b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    166f:	90                   	nop
        s = (char*)*ap;
    1670:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1673:	8b 18                	mov    (%eax),%ebx
        ap++;
    1675:	83 c0 04             	add    $0x4,%eax
    1678:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    167b:	85 db                	test   %ebx,%ebx
    167d:	74 17                	je     1696 <printf+0x186>
        while(*s != 0){
    167f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1682:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1684:	84 c0                	test   %al,%al
    1686:	0f 84 d8 fe ff ff    	je     1564 <printf+0x54>
    168c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    168f:	89 de                	mov    %ebx,%esi
    1691:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1694:	eb 1a                	jmp    16b0 <printf+0x1a0>
          s = "(null)";
    1696:	bb f1 18 00 00       	mov    $0x18f1,%ebx
        while(*s != 0){
    169b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    169e:	b8 28 00 00 00       	mov    $0x28,%eax
    16a3:	89 de                	mov    %ebx,%esi
    16a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    16af:	90                   	nop
  write(fd, &c, 1);
    16b0:	83 ec 04             	sub    $0x4,%esp
          s++;
    16b3:	83 c6 01             	add    $0x1,%esi
    16b6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    16b9:	6a 01                	push   $0x1
    16bb:	57                   	push   %edi
    16bc:	53                   	push   %ebx
    16bd:	e8 d7 fc ff ff       	call   1399 <write>
        while(*s != 0){
    16c2:	0f b6 06             	movzbl (%esi),%eax
    16c5:	83 c4 10             	add    $0x10,%esp
    16c8:	84 c0                	test   %al,%al
    16ca:	75 e4                	jne    16b0 <printf+0x1a0>
      state = 0;
    16cc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    16cf:	31 d2                	xor    %edx,%edx
    16d1:	e9 8e fe ff ff       	jmp    1564 <printf+0x54>
    16d6:	66 90                	xchg   %ax,%ax
    16d8:	66 90                	xchg   %ax,%ax
    16da:	66 90                	xchg   %ax,%ax
    16dc:	66 90                	xchg   %ax,%ax
    16de:	66 90                	xchg   %ax,%ax

000016e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16e1:	a1 00 1c 00 00       	mov    0x1c00,%eax
{
    16e6:	89 e5                	mov    %esp,%ebp
    16e8:	57                   	push   %edi
    16e9:	56                   	push   %esi
    16ea:	53                   	push   %ebx
    16eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    16ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    16f8:	89 c2                	mov    %eax,%edx
    16fa:	8b 00                	mov    (%eax),%eax
    16fc:	39 ca                	cmp    %ecx,%edx
    16fe:	73 30                	jae    1730 <free+0x50>
    1700:	39 c1                	cmp    %eax,%ecx
    1702:	72 04                	jb     1708 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1704:	39 c2                	cmp    %eax,%edx
    1706:	72 f0                	jb     16f8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1708:	8b 73 fc             	mov    -0x4(%ebx),%esi
    170b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    170e:	39 f8                	cmp    %edi,%eax
    1710:	74 30                	je     1742 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1712:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    1715:	8b 42 04             	mov    0x4(%edx),%eax
    1718:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    171b:	39 f1                	cmp    %esi,%ecx
    171d:	74 3a                	je     1759 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    171f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    1721:	5b                   	pop    %ebx
  freep = p;
    1722:	89 15 00 1c 00 00    	mov    %edx,0x1c00
}
    1728:	5e                   	pop    %esi
    1729:	5f                   	pop    %edi
    172a:	5d                   	pop    %ebp
    172b:	c3                   	ret    
    172c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1730:	39 c2                	cmp    %eax,%edx
    1732:	72 c4                	jb     16f8 <free+0x18>
    1734:	39 c1                	cmp    %eax,%ecx
    1736:	73 c0                	jae    16f8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1738:	8b 73 fc             	mov    -0x4(%ebx),%esi
    173b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    173e:	39 f8                	cmp    %edi,%eax
    1740:	75 d0                	jne    1712 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    1742:	03 70 04             	add    0x4(%eax),%esi
    1745:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1748:	8b 02                	mov    (%edx),%eax
    174a:	8b 00                	mov    (%eax),%eax
    174c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    174f:	8b 42 04             	mov    0x4(%edx),%eax
    1752:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1755:	39 f1                	cmp    %esi,%ecx
    1757:	75 c6                	jne    171f <free+0x3f>
    p->s.size += bp->s.size;
    1759:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    175c:	89 15 00 1c 00 00    	mov    %edx,0x1c00
    p->s.size += bp->s.size;
    1762:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1765:	8b 43 f8             	mov    -0x8(%ebx),%eax
    1768:	89 02                	mov    %eax,(%edx)
}
    176a:	5b                   	pop    %ebx
    176b:	5e                   	pop    %esi
    176c:	5f                   	pop    %edi
    176d:	5d                   	pop    %ebp
    176e:	c3                   	ret    
    176f:	90                   	nop

00001770 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1770:	55                   	push   %ebp
    1771:	89 e5                	mov    %esp,%ebp
    1773:	57                   	push   %edi
    1774:	56                   	push   %esi
    1775:	53                   	push   %ebx
    1776:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1779:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    177c:	8b 3d 00 1c 00 00    	mov    0x1c00,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1782:	8d 70 07             	lea    0x7(%eax),%esi
    1785:	c1 ee 03             	shr    $0x3,%esi
    1788:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    178b:	85 ff                	test   %edi,%edi
    178d:	0f 84 ad 00 00 00    	je     1840 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1793:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1795:	8b 48 04             	mov    0x4(%eax),%ecx
    1798:	39 f1                	cmp    %esi,%ecx
    179a:	73 71                	jae    180d <malloc+0x9d>
    179c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    17a2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    17a7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    17aa:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    17b1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    17b4:	eb 1b                	jmp    17d1 <malloc+0x61>
    17b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17c0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    17c2:	8b 4a 04             	mov    0x4(%edx),%ecx
    17c5:	39 f1                	cmp    %esi,%ecx
    17c7:	73 4f                	jae    1818 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    17c9:	8b 3d 00 1c 00 00    	mov    0x1c00,%edi
    17cf:	89 d0                	mov    %edx,%eax
    17d1:	39 c7                	cmp    %eax,%edi
    17d3:	75 eb                	jne    17c0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    17d5:	83 ec 0c             	sub    $0xc,%esp
    17d8:	ff 75 e4             	pushl  -0x1c(%ebp)
    17db:	e8 21 fc ff ff       	call   1401 <sbrk>
  if(p == (char*)-1)
    17e0:	83 c4 10             	add    $0x10,%esp
    17e3:	83 f8 ff             	cmp    $0xffffffff,%eax
    17e6:	74 1b                	je     1803 <malloc+0x93>
  hp->s.size = nu;
    17e8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    17eb:	83 ec 0c             	sub    $0xc,%esp
    17ee:	83 c0 08             	add    $0x8,%eax
    17f1:	50                   	push   %eax
    17f2:	e8 e9 fe ff ff       	call   16e0 <free>
  return freep;
    17f7:	a1 00 1c 00 00       	mov    0x1c00,%eax
      if((p = morecore(nunits)) == 0)
    17fc:	83 c4 10             	add    $0x10,%esp
    17ff:	85 c0                	test   %eax,%eax
    1801:	75 bd                	jne    17c0 <malloc+0x50>
        return 0;
  }
}
    1803:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1806:	31 c0                	xor    %eax,%eax
}
    1808:	5b                   	pop    %ebx
    1809:	5e                   	pop    %esi
    180a:	5f                   	pop    %edi
    180b:	5d                   	pop    %ebp
    180c:	c3                   	ret    
    if(p->s.size >= nunits){
    180d:	89 c2                	mov    %eax,%edx
    180f:	89 f8                	mov    %edi,%eax
    1811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1818:	39 ce                	cmp    %ecx,%esi
    181a:	74 54                	je     1870 <malloc+0x100>
        p->s.size -= nunits;
    181c:	29 f1                	sub    %esi,%ecx
    181e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    1821:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    1824:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    1827:	a3 00 1c 00 00       	mov    %eax,0x1c00
}
    182c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    182f:	8d 42 08             	lea    0x8(%edx),%eax
}
    1832:	5b                   	pop    %ebx
    1833:	5e                   	pop    %esi
    1834:	5f                   	pop    %edi
    1835:	5d                   	pop    %ebp
    1836:	c3                   	ret    
    1837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    183e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    1840:	c7 05 00 1c 00 00 04 	movl   $0x1c04,0x1c00
    1847:	1c 00 00 
    base.s.size = 0;
    184a:	bf 04 1c 00 00       	mov    $0x1c04,%edi
    base.s.ptr = freep = prevp = &base;
    184f:	c7 05 04 1c 00 00 04 	movl   $0x1c04,0x1c04
    1856:	1c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1859:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    185b:	c7 05 08 1c 00 00 00 	movl   $0x0,0x1c08
    1862:	00 00 00 
    if(p->s.size >= nunits){
    1865:	e9 32 ff ff ff       	jmp    179c <malloc+0x2c>
    186a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1870:	8b 0a                	mov    (%edx),%ecx
    1872:	89 08                	mov    %ecx,(%eax)
    1874:	eb b1                	jmp    1827 <malloc+0xb7>
