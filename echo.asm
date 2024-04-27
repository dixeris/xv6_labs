
_echo:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	57                   	push   %edi
    100e:	56                   	push   %esi
    100f:	53                   	push   %ebx
    1010:	51                   	push   %ecx
    1011:	83 ec 08             	sub    $0x8,%esp
    1014:	8b 31                	mov    (%ecx),%esi
    1016:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  for(i = 1; i < argc; i++)
    1019:	83 fe 01             	cmp    $0x1,%esi
    101c:	7e 47                	jle    1065 <main+0x65>
    101e:	bb 01 00 00 00       	mov    $0x1,%ebx
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
    1023:	83 c3 01             	add    $0x1,%ebx
    1026:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
    102a:	39 f3                	cmp    %esi,%ebx
    102c:	74 22                	je     1050 <main+0x50>
    102e:	66 90                	xchg   %ax,%ax
    1030:	68 18 18 00 00       	push   $0x1818
    1035:	83 c3 01             	add    $0x1,%ebx
    1038:	50                   	push   %eax
    1039:	68 1a 18 00 00       	push   $0x181a
    103e:	6a 01                	push   $0x1
    1040:	e8 6b 04 00 00       	call   14b0 <printf>
    1045:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
    1049:	83 c4 10             	add    $0x10,%esp
    104c:	39 f3                	cmp    %esi,%ebx
    104e:	75 e0                	jne    1030 <main+0x30>
    1050:	68 1f 18 00 00       	push   $0x181f
    1055:	50                   	push   %eax
    1056:	68 1a 18 00 00       	push   $0x181a
    105b:	6a 01                	push   $0x1
    105d:	e8 4e 04 00 00       	call   14b0 <printf>
    1062:	83 c4 10             	add    $0x10,%esp
  exit();
    1065:	e8 cf 02 00 00       	call   1339 <exit>
    106a:	66 90                	xchg   %ax,%ax
    106c:	66 90                	xchg   %ax,%ax
    106e:	66 90                	xchg   %ax,%ax

00001070 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"
char*
strcpy(char *s, const char *t)
{
    1070:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1071:	31 c0                	xor    %eax,%eax
{
    1073:	89 e5                	mov    %esp,%ebp
    1075:	53                   	push   %ebx
    1076:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1079:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    107c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    1080:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    1084:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    1087:	83 c0 01             	add    $0x1,%eax
    108a:	84 d2                	test   %dl,%dl
    108c:	75 f2                	jne    1080 <strcpy+0x10>
    ;
  return os;
}
    108e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1091:	89 c8                	mov    %ecx,%eax
    1093:	c9                   	leave  
    1094:	c3                   	ret    
    1095:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    109c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000010a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	53                   	push   %ebx
    10a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    10aa:	0f b6 01             	movzbl (%ecx),%eax
    10ad:	0f b6 1a             	movzbl (%edx),%ebx
    10b0:	84 c0                	test   %al,%al
    10b2:	75 1d                	jne    10d1 <strcmp+0x31>
    10b4:	eb 2a                	jmp    10e0 <strcmp+0x40>
    10b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10bd:	8d 76 00             	lea    0x0(%esi),%esi
    10c0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    10c4:	83 c1 01             	add    $0x1,%ecx
    10c7:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    10ca:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    10cd:	84 c0                	test   %al,%al
    10cf:	74 0f                	je     10e0 <strcmp+0x40>
    10d1:	38 d8                	cmp    %bl,%al
    10d3:	74 eb                	je     10c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    10d5:	29 d8                	sub    %ebx,%eax
}
    10d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10da:	c9                   	leave  
    10db:	c3                   	ret    
    10dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    10e2:	29 d8                	sub    %ebx,%eax
}
    10e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10e7:	c9                   	leave  
    10e8:	c3                   	ret    
    10e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000010f0 <strlen>:

uint
strlen(const char *s)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    10f6:	80 3a 00             	cmpb   $0x0,(%edx)
    10f9:	74 15                	je     1110 <strlen+0x20>
    10fb:	31 c0                	xor    %eax,%eax
    10fd:	8d 76 00             	lea    0x0(%esi),%esi
    1100:	83 c0 01             	add    $0x1,%eax
    1103:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    1107:	89 c1                	mov    %eax,%ecx
    1109:	75 f5                	jne    1100 <strlen+0x10>
    ;
  return n;
}
    110b:	89 c8                	mov    %ecx,%eax
    110d:	5d                   	pop    %ebp
    110e:	c3                   	ret    
    110f:	90                   	nop
  for(n = 0; s[n]; n++)
    1110:	31 c9                	xor    %ecx,%ecx
}
    1112:	5d                   	pop    %ebp
    1113:	89 c8                	mov    %ecx,%eax
    1115:	c3                   	ret    
    1116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    111d:	8d 76 00             	lea    0x0(%esi),%esi

00001120 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	57                   	push   %edi
    1124:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1127:	8b 4d 10             	mov    0x10(%ebp),%ecx
    112a:	8b 45 0c             	mov    0xc(%ebp),%eax
    112d:	89 d7                	mov    %edx,%edi
    112f:	fc                   	cld    
    1130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1132:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1135:	89 d0                	mov    %edx,%eax
    1137:	c9                   	leave  
    1138:	c3                   	ret    
    1139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001140 <strchr>:

char*
strchr(const char *s, char c)
{
    1140:	55                   	push   %ebp
    1141:	89 e5                	mov    %esp,%ebp
    1143:	8b 45 08             	mov    0x8(%ebp),%eax
    1146:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    114a:	0f b6 10             	movzbl (%eax),%edx
    114d:	84 d2                	test   %dl,%dl
    114f:	75 12                	jne    1163 <strchr+0x23>
    1151:	eb 1d                	jmp    1170 <strchr+0x30>
    1153:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1157:	90                   	nop
    1158:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    115c:	83 c0 01             	add    $0x1,%eax
    115f:	84 d2                	test   %dl,%dl
    1161:	74 0d                	je     1170 <strchr+0x30>
    if(*s == c)
    1163:	38 d1                	cmp    %dl,%cl
    1165:	75 f1                	jne    1158 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1167:	5d                   	pop    %ebp
    1168:	c3                   	ret    
    1169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    1170:	31 c0                	xor    %eax,%eax
}
    1172:	5d                   	pop    %ebp
    1173:	c3                   	ret    
    1174:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    117b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    117f:	90                   	nop

00001180 <gets>:

char*
gets(char *buf, int max)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	57                   	push   %edi
    1184:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1185:	31 f6                	xor    %esi,%esi
{
    1187:	53                   	push   %ebx
    1188:	89 f3                	mov    %esi,%ebx
    118a:	83 ec 1c             	sub    $0x1c,%esp
    118d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1190:	eb 2f                	jmp    11c1 <gets+0x41>
    1192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1198:	83 ec 04             	sub    $0x4,%esp
    119b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    119e:	6a 01                	push   $0x1
    11a0:	50                   	push   %eax
    11a1:	6a 00                	push   $0x0
    11a3:	e8 a9 01 00 00       	call   1351 <read>
    if(cc < 1)
    11a8:	83 c4 10             	add    $0x10,%esp
    11ab:	85 c0                	test   %eax,%eax
    11ad:	7e 1c                	jle    11cb <gets+0x4b>
      break;
    buf[i++] = c;
    11af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    11b3:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    11b6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    11b9:	3c 0a                	cmp    $0xa,%al
    11bb:	74 23                	je     11e0 <gets+0x60>
    11bd:	3c 0d                	cmp    $0xd,%al
    11bf:	74 1f                	je     11e0 <gets+0x60>
  for(i=0; i+1 < max; ){
    11c1:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    11c4:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    11c6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11c9:	7c cd                	jl     1198 <gets+0x18>
    11cb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    11cd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    11d0:	c6 03 00             	movb   $0x0,(%ebx)
}
    11d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11d6:	5b                   	pop    %ebx
    11d7:	5e                   	pop    %esi
    11d8:	5f                   	pop    %edi
    11d9:	5d                   	pop    %ebp
    11da:	c3                   	ret    
    11db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11df:	90                   	nop
  buf[i] = '\0';
    11e0:	8b 75 08             	mov    0x8(%ebp),%esi
}
    11e3:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    11e6:	01 de                	add    %ebx,%esi
    11e8:	89 f3                	mov    %esi,%ebx
    11ea:	c6 03 00             	movb   $0x0,(%ebx)
}
    11ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11f0:	5b                   	pop    %ebx
    11f1:	5e                   	pop    %esi
    11f2:	5f                   	pop    %edi
    11f3:	5d                   	pop    %ebp
    11f4:	c3                   	ret    
    11f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001200 <stat>:

int
stat(const char *n, struct stat *st)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	56                   	push   %esi
    1204:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1205:	83 ec 08             	sub    $0x8,%esp
    1208:	6a 00                	push   $0x0
    120a:	ff 75 08             	pushl  0x8(%ebp)
    120d:	e8 67 01 00 00       	call   1379 <open>
  if(fd < 0)
    1212:	83 c4 10             	add    $0x10,%esp
    1215:	85 c0                	test   %eax,%eax
    1217:	78 27                	js     1240 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1219:	83 ec 08             	sub    $0x8,%esp
    121c:	ff 75 0c             	pushl  0xc(%ebp)
    121f:	89 c3                	mov    %eax,%ebx
    1221:	50                   	push   %eax
    1222:	e8 6a 01 00 00       	call   1391 <fstat>
  close(fd);
    1227:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    122a:	89 c6                	mov    %eax,%esi
  close(fd);
    122c:	e8 30 01 00 00       	call   1361 <close>
  return r;
    1231:	83 c4 10             	add    $0x10,%esp
}
    1234:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1237:	89 f0                	mov    %esi,%eax
    1239:	5b                   	pop    %ebx
    123a:	5e                   	pop    %esi
    123b:	5d                   	pop    %ebp
    123c:	c3                   	ret    
    123d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1240:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1245:	eb ed                	jmp    1234 <stat+0x34>
    1247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    124e:	66 90                	xchg   %ax,%ax

00001250 <atoi>:

int
atoi(const char *s)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	53                   	push   %ebx
    1254:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1257:	0f be 02             	movsbl (%edx),%eax
    125a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    125d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1260:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1265:	77 1e                	ja     1285 <atoi+0x35>
    1267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    126e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    1270:	83 c2 01             	add    $0x1,%edx
    1273:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1276:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    127a:	0f be 02             	movsbl (%edx),%eax
    127d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1280:	80 fb 09             	cmp    $0x9,%bl
    1283:	76 eb                	jbe    1270 <atoi+0x20>
  return n;
}
    1285:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1288:	89 c8                	mov    %ecx,%eax
    128a:	c9                   	leave  
    128b:	c3                   	ret    
    128c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001290 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
    1293:	57                   	push   %edi
    1294:	8b 45 10             	mov    0x10(%ebp),%eax
    1297:	8b 55 08             	mov    0x8(%ebp),%edx
    129a:	56                   	push   %esi
    129b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    129e:	85 c0                	test   %eax,%eax
    12a0:	7e 13                	jle    12b5 <memmove+0x25>
    12a2:	01 d0                	add    %edx,%eax
  dst = vdst;
    12a4:	89 d7                	mov    %edx,%edi
    12a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12ad:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    12b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    12b1:	39 f8                	cmp    %edi,%eax
    12b3:	75 fb                	jne    12b0 <memmove+0x20>
  return vdst;
}
    12b5:	5e                   	pop    %esi
    12b6:	89 d0                	mov    %edx,%eax
    12b8:	5f                   	pop    %edi
    12b9:	5d                   	pop    %ebp
    12ba:	c3                   	ret    
    12bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12bf:	90                   	nop

000012c0 <thread_create>:


int thread_create(void (*start_routine)(void*, void*), void *arg1, void *arg2) {
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	53                   	push   %ebx
    12c4:	83 ec 20             	sub    $0x20,%esp
  void *stack =  malloc(4096);
    12c7:	68 00 10 00 00       	push   $0x1000
    12cc:	e8 3f 04 00 00       	call   1710 <malloc>
  if(stack == 0)
    12d1:	83 c4 10             	add    $0x10,%esp
    12d4:	85 c0                	test   %eax,%eax
    12d6:	74 3f                	je     1317 <thread_create+0x57>
    return -1;
  int r= clone(start_routine, arg1, arg2, stack);
    12d8:	50                   	push   %eax
    12d9:	89 c3                	mov    %eax,%ebx
    12db:	ff 75 10             	pushl  0x10(%ebp)
    12de:	ff 75 0c             	pushl  0xc(%ebp)
    12e1:	ff 75 08             	pushl  0x8(%ebp)
    12e4:	e8 00 01 00 00       	call   13e9 <clone>
  if(r==-1) 
    12e9:	83 c4 10             	add    $0x10,%esp
    12ec:	83 f8 ff             	cmp    $0xffffffff,%eax
    12ef:	74 0f                	je     1300 <thread_create+0x40>
    free(stack);
  return r;
}
    12f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12f4:	c9                   	leave  
    12f5:	c3                   	ret    
    12f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12fd:	8d 76 00             	lea    0x0(%esi),%esi
    free(stack);
    1300:	83 ec 0c             	sub    $0xc,%esp
    1303:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1306:	53                   	push   %ebx
    1307:	e8 74 03 00 00       	call   1680 <free>
    130c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    130f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    free(stack);
    1312:	83 c4 10             	add    $0x10,%esp
}
    1315:	c9                   	leave  
    1316:	c3                   	ret    
    return -1;
    1317:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    131c:	eb d3                	jmp    12f1 <thread_create+0x31>
    131e:	66 90                	xchg   %ax,%ax

00001320 <thread_join>:


int thread_join(void) {
    1320:	55                   	push   %ebp
    1321:	89 e5                	mov    %esp,%ebp
    1323:	83 ec 24             	sub    $0x24,%esp
  void *stack;
  int r = join(&stack);
    1326:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1329:	50                   	push   %eax
    132a:	e8 c2 00 00 00       	call   13f1 <join>
  return r;
}
    132f:	c9                   	leave  
    1330:	c3                   	ret    

00001331 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1331:	b8 01 00 00 00       	mov    $0x1,%eax
    1336:	cd 40                	int    $0x40
    1338:	c3                   	ret    

00001339 <exit>:
SYSCALL(exit)
    1339:	b8 02 00 00 00       	mov    $0x2,%eax
    133e:	cd 40                	int    $0x40
    1340:	c3                   	ret    

00001341 <wait>:
SYSCALL(wait)
    1341:	b8 03 00 00 00       	mov    $0x3,%eax
    1346:	cd 40                	int    $0x40
    1348:	c3                   	ret    

00001349 <pipe>:
SYSCALL(pipe)
    1349:	b8 04 00 00 00       	mov    $0x4,%eax
    134e:	cd 40                	int    $0x40
    1350:	c3                   	ret    

00001351 <read>:
SYSCALL(read)
    1351:	b8 05 00 00 00       	mov    $0x5,%eax
    1356:	cd 40                	int    $0x40
    1358:	c3                   	ret    

00001359 <write>:
SYSCALL(write)
    1359:	b8 10 00 00 00       	mov    $0x10,%eax
    135e:	cd 40                	int    $0x40
    1360:	c3                   	ret    

00001361 <close>:
SYSCALL(close)
    1361:	b8 15 00 00 00       	mov    $0x15,%eax
    1366:	cd 40                	int    $0x40
    1368:	c3                   	ret    

00001369 <kill>:
SYSCALL(kill)
    1369:	b8 06 00 00 00       	mov    $0x6,%eax
    136e:	cd 40                	int    $0x40
    1370:	c3                   	ret    

00001371 <exec>:
SYSCALL(exec)
    1371:	b8 07 00 00 00       	mov    $0x7,%eax
    1376:	cd 40                	int    $0x40
    1378:	c3                   	ret    

00001379 <open>:
SYSCALL(open)
    1379:	b8 0f 00 00 00       	mov    $0xf,%eax
    137e:	cd 40                	int    $0x40
    1380:	c3                   	ret    

00001381 <mknod>:
SYSCALL(mknod)
    1381:	b8 11 00 00 00       	mov    $0x11,%eax
    1386:	cd 40                	int    $0x40
    1388:	c3                   	ret    

00001389 <unlink>:
SYSCALL(unlink)
    1389:	b8 12 00 00 00       	mov    $0x12,%eax
    138e:	cd 40                	int    $0x40
    1390:	c3                   	ret    

00001391 <fstat>:
SYSCALL(fstat)
    1391:	b8 08 00 00 00       	mov    $0x8,%eax
    1396:	cd 40                	int    $0x40
    1398:	c3                   	ret    

00001399 <link>:
SYSCALL(link)
    1399:	b8 13 00 00 00       	mov    $0x13,%eax
    139e:	cd 40                	int    $0x40
    13a0:	c3                   	ret    

000013a1 <mkdir>:
SYSCALL(mkdir)
    13a1:	b8 14 00 00 00       	mov    $0x14,%eax
    13a6:	cd 40                	int    $0x40
    13a8:	c3                   	ret    

000013a9 <chdir>:
SYSCALL(chdir)
    13a9:	b8 09 00 00 00       	mov    $0x9,%eax
    13ae:	cd 40                	int    $0x40
    13b0:	c3                   	ret    

000013b1 <dup>:
SYSCALL(dup)
    13b1:	b8 0a 00 00 00       	mov    $0xa,%eax
    13b6:	cd 40                	int    $0x40
    13b8:	c3                   	ret    

000013b9 <getpid>:
SYSCALL(getpid)
    13b9:	b8 0b 00 00 00       	mov    $0xb,%eax
    13be:	cd 40                	int    $0x40
    13c0:	c3                   	ret    

000013c1 <sbrk>:
SYSCALL(sbrk)
    13c1:	b8 0c 00 00 00       	mov    $0xc,%eax
    13c6:	cd 40                	int    $0x40
    13c8:	c3                   	ret    

000013c9 <sleep>:
SYSCALL(sleep)
    13c9:	b8 0d 00 00 00       	mov    $0xd,%eax
    13ce:	cd 40                	int    $0x40
    13d0:	c3                   	ret    

000013d1 <uptime>:
SYSCALL(uptime)
    13d1:	b8 0e 00 00 00       	mov    $0xe,%eax
    13d6:	cd 40                	int    $0x40
    13d8:	c3                   	ret    

000013d9 <mprotect>:
SYSCALL(mprotect)
    13d9:	b8 16 00 00 00       	mov    $0x16,%eax
    13de:	cd 40                	int    $0x40
    13e0:	c3                   	ret    

000013e1 <munprotect>:
SYSCALL(munprotect)
    13e1:	b8 17 00 00 00       	mov    $0x17,%eax
    13e6:	cd 40                	int    $0x40
    13e8:	c3                   	ret    

000013e9 <clone>:
SYSCALL(clone)
    13e9:	b8 18 00 00 00       	mov    $0x18,%eax
    13ee:	cd 40                	int    $0x40
    13f0:	c3                   	ret    

000013f1 <join>:
SYSCALL(join)
    13f1:	b8 19 00 00 00       	mov    $0x19,%eax
    13f6:	cd 40                	int    $0x40
    13f8:	c3                   	ret    
    13f9:	66 90                	xchg   %ax,%ax
    13fb:	66 90                	xchg   %ax,%ax
    13fd:	66 90                	xchg   %ax,%ax
    13ff:	90                   	nop

00001400 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    1403:	57                   	push   %edi
    1404:	56                   	push   %esi
    1405:	53                   	push   %ebx
    1406:	83 ec 3c             	sub    $0x3c,%esp
    1409:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    140c:	89 d1                	mov    %edx,%ecx
{
    140e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    1411:	85 d2                	test   %edx,%edx
    1413:	0f 89 7f 00 00 00    	jns    1498 <printint+0x98>
    1419:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    141d:	74 79                	je     1498 <printint+0x98>
    neg = 1;
    141f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    1426:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    1428:	31 db                	xor    %ebx,%ebx
    142a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    142d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1430:	89 c8                	mov    %ecx,%eax
    1432:	31 d2                	xor    %edx,%edx
    1434:	89 cf                	mov    %ecx,%edi
    1436:	f7 75 c4             	divl   -0x3c(%ebp)
    1439:	0f b6 92 28 18 00 00 	movzbl 0x1828(%edx),%edx
    1440:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1443:	89 d8                	mov    %ebx,%eax
    1445:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1448:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    144b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    144e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1451:	76 dd                	jbe    1430 <printint+0x30>
  if(neg)
    1453:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1456:	85 c9                	test   %ecx,%ecx
    1458:	74 0c                	je     1466 <printint+0x66>
    buf[i++] = '-';
    145a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    145f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1461:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1466:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1469:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    146d:	eb 07                	jmp    1476 <printint+0x76>
    146f:	90                   	nop
    putc(fd, buf[i]);
    1470:	0f b6 13             	movzbl (%ebx),%edx
    1473:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1476:	83 ec 04             	sub    $0x4,%esp
    1479:	88 55 d7             	mov    %dl,-0x29(%ebp)
    147c:	6a 01                	push   $0x1
    147e:	56                   	push   %esi
    147f:	57                   	push   %edi
    1480:	e8 d4 fe ff ff       	call   1359 <write>
  while(--i >= 0)
    1485:	83 c4 10             	add    $0x10,%esp
    1488:	39 de                	cmp    %ebx,%esi
    148a:	75 e4                	jne    1470 <printint+0x70>
}
    148c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    148f:	5b                   	pop    %ebx
    1490:	5e                   	pop    %esi
    1491:	5f                   	pop    %edi
    1492:	5d                   	pop    %ebp
    1493:	c3                   	ret    
    1494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1498:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    149f:	eb 87                	jmp    1428 <printint+0x28>
    14a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14af:	90                   	nop

000014b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    14b0:	55                   	push   %ebp
    14b1:	89 e5                	mov    %esp,%ebp
    14b3:	57                   	push   %edi
    14b4:	56                   	push   %esi
    14b5:	53                   	push   %ebx
    14b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14b9:	8b 75 0c             	mov    0xc(%ebp),%esi
    14bc:	0f b6 1e             	movzbl (%esi),%ebx
    14bf:	84 db                	test   %bl,%bl
    14c1:	0f 84 b8 00 00 00    	je     157f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    14c7:	8d 45 10             	lea    0x10(%ebp),%eax
    14ca:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    14cd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    14d0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    14d2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    14d5:	eb 37                	jmp    150e <printf+0x5e>
    14d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14de:	66 90                	xchg   %ax,%ax
    14e0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    14e3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    14e8:	83 f8 25             	cmp    $0x25,%eax
    14eb:	74 17                	je     1504 <printf+0x54>
  write(fd, &c, 1);
    14ed:	83 ec 04             	sub    $0x4,%esp
    14f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
    14f3:	6a 01                	push   $0x1
    14f5:	57                   	push   %edi
    14f6:	ff 75 08             	pushl  0x8(%ebp)
    14f9:	e8 5b fe ff ff       	call   1359 <write>
    14fe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    1501:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1504:	0f b6 1e             	movzbl (%esi),%ebx
    1507:	83 c6 01             	add    $0x1,%esi
    150a:	84 db                	test   %bl,%bl
    150c:	74 71                	je     157f <printf+0xcf>
    c = fmt[i] & 0xff;
    150e:	0f be cb             	movsbl %bl,%ecx
    1511:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1514:	85 d2                	test   %edx,%edx
    1516:	74 c8                	je     14e0 <printf+0x30>
      }
    } else if(state == '%'){
    1518:	83 fa 25             	cmp    $0x25,%edx
    151b:	75 e7                	jne    1504 <printf+0x54>
      if(c == 'd'){
    151d:	83 f8 64             	cmp    $0x64,%eax
    1520:	0f 84 9a 00 00 00    	je     15c0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1526:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    152c:	83 f9 70             	cmp    $0x70,%ecx
    152f:	74 5f                	je     1590 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1531:	83 f8 73             	cmp    $0x73,%eax
    1534:	0f 84 d6 00 00 00    	je     1610 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    153a:	83 f8 63             	cmp    $0x63,%eax
    153d:	0f 84 8d 00 00 00    	je     15d0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1543:	83 f8 25             	cmp    $0x25,%eax
    1546:	0f 84 b4 00 00 00    	je     1600 <printf+0x150>
  write(fd, &c, 1);
    154c:	83 ec 04             	sub    $0x4,%esp
    154f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1553:	6a 01                	push   $0x1
    1555:	57                   	push   %edi
    1556:	ff 75 08             	pushl  0x8(%ebp)
    1559:	e8 fb fd ff ff       	call   1359 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    155e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1561:	83 c4 0c             	add    $0xc,%esp
    1564:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1566:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1569:	57                   	push   %edi
    156a:	ff 75 08             	pushl  0x8(%ebp)
    156d:	e8 e7 fd ff ff       	call   1359 <write>
  for(i = 0; fmt[i]; i++){
    1572:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    1576:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1579:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    157b:	84 db                	test   %bl,%bl
    157d:	75 8f                	jne    150e <printf+0x5e>
    }
  }
}
    157f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1582:	5b                   	pop    %ebx
    1583:	5e                   	pop    %esi
    1584:	5f                   	pop    %edi
    1585:	5d                   	pop    %ebp
    1586:	c3                   	ret    
    1587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    158e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    1590:	83 ec 0c             	sub    $0xc,%esp
    1593:	b9 10 00 00 00       	mov    $0x10,%ecx
    1598:	6a 00                	push   $0x0
    159a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    159d:	8b 45 08             	mov    0x8(%ebp),%eax
    15a0:	8b 13                	mov    (%ebx),%edx
    15a2:	e8 59 fe ff ff       	call   1400 <printint>
        ap++;
    15a7:	89 d8                	mov    %ebx,%eax
    15a9:	83 c4 10             	add    $0x10,%esp
      state = 0;
    15ac:	31 d2                	xor    %edx,%edx
        ap++;
    15ae:	83 c0 04             	add    $0x4,%eax
    15b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    15b4:	e9 4b ff ff ff       	jmp    1504 <printf+0x54>
    15b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    15c0:	83 ec 0c             	sub    $0xc,%esp
    15c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    15c8:	6a 01                	push   $0x1
    15ca:	eb ce                	jmp    159a <printf+0xea>
    15cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    15d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    15d3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    15d6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    15d8:	6a 01                	push   $0x1
        ap++;
    15da:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    15dd:	57                   	push   %edi
    15de:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    15e1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    15e4:	e8 70 fd ff ff       	call   1359 <write>
        ap++;
    15e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    15ec:	83 c4 10             	add    $0x10,%esp
      state = 0;
    15ef:	31 d2                	xor    %edx,%edx
    15f1:	e9 0e ff ff ff       	jmp    1504 <printf+0x54>
    15f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15fd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    1600:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1603:	83 ec 04             	sub    $0x4,%esp
    1606:	e9 59 ff ff ff       	jmp    1564 <printf+0xb4>
    160b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    160f:	90                   	nop
        s = (char*)*ap;
    1610:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1613:	8b 18                	mov    (%eax),%ebx
        ap++;
    1615:	83 c0 04             	add    $0x4,%eax
    1618:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    161b:	85 db                	test   %ebx,%ebx
    161d:	74 17                	je     1636 <printf+0x186>
        while(*s != 0){
    161f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1622:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1624:	84 c0                	test   %al,%al
    1626:	0f 84 d8 fe ff ff    	je     1504 <printf+0x54>
    162c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    162f:	89 de                	mov    %ebx,%esi
    1631:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1634:	eb 1a                	jmp    1650 <printf+0x1a0>
          s = "(null)";
    1636:	bb 21 18 00 00       	mov    $0x1821,%ebx
        while(*s != 0){
    163b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    163e:	b8 28 00 00 00       	mov    $0x28,%eax
    1643:	89 de                	mov    %ebx,%esi
    1645:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1648:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    164f:	90                   	nop
  write(fd, &c, 1);
    1650:	83 ec 04             	sub    $0x4,%esp
          s++;
    1653:	83 c6 01             	add    $0x1,%esi
    1656:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1659:	6a 01                	push   $0x1
    165b:	57                   	push   %edi
    165c:	53                   	push   %ebx
    165d:	e8 f7 fc ff ff       	call   1359 <write>
        while(*s != 0){
    1662:	0f b6 06             	movzbl (%esi),%eax
    1665:	83 c4 10             	add    $0x10,%esp
    1668:	84 c0                	test   %al,%al
    166a:	75 e4                	jne    1650 <printf+0x1a0>
      state = 0;
    166c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    166f:	31 d2                	xor    %edx,%edx
    1671:	e9 8e fe ff ff       	jmp    1504 <printf+0x54>
    1676:	66 90                	xchg   %ax,%ax
    1678:	66 90                	xchg   %ax,%ax
    167a:	66 90                	xchg   %ax,%ax
    167c:	66 90                	xchg   %ax,%ax
    167e:	66 90                	xchg   %ax,%ax

00001680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1680:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1681:	a1 28 1b 00 00       	mov    0x1b28,%eax
{
    1686:	89 e5                	mov    %esp,%ebp
    1688:	57                   	push   %edi
    1689:	56                   	push   %esi
    168a:	53                   	push   %ebx
    168b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    168e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1698:	89 c2                	mov    %eax,%edx
    169a:	8b 00                	mov    (%eax),%eax
    169c:	39 ca                	cmp    %ecx,%edx
    169e:	73 30                	jae    16d0 <free+0x50>
    16a0:	39 c1                	cmp    %eax,%ecx
    16a2:	72 04                	jb     16a8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16a4:	39 c2                	cmp    %eax,%edx
    16a6:	72 f0                	jb     1698 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    16a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    16ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16ae:	39 f8                	cmp    %edi,%eax
    16b0:	74 30                	je     16e2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    16b2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    16b5:	8b 42 04             	mov    0x4(%edx),%eax
    16b8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    16bb:	39 f1                	cmp    %esi,%ecx
    16bd:	74 3a                	je     16f9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    16bf:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    16c1:	5b                   	pop    %ebx
  freep = p;
    16c2:	89 15 28 1b 00 00    	mov    %edx,0x1b28
}
    16c8:	5e                   	pop    %esi
    16c9:	5f                   	pop    %edi
    16ca:	5d                   	pop    %ebp
    16cb:	c3                   	ret    
    16cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16d0:	39 c2                	cmp    %eax,%edx
    16d2:	72 c4                	jb     1698 <free+0x18>
    16d4:	39 c1                	cmp    %eax,%ecx
    16d6:	73 c0                	jae    1698 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    16d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    16db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16de:	39 f8                	cmp    %edi,%eax
    16e0:	75 d0                	jne    16b2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    16e2:	03 70 04             	add    0x4(%eax),%esi
    16e5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    16e8:	8b 02                	mov    (%edx),%eax
    16ea:	8b 00                	mov    (%eax),%eax
    16ec:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    16ef:	8b 42 04             	mov    0x4(%edx),%eax
    16f2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    16f5:	39 f1                	cmp    %esi,%ecx
    16f7:	75 c6                	jne    16bf <free+0x3f>
    p->s.size += bp->s.size;
    16f9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    16fc:	89 15 28 1b 00 00    	mov    %edx,0x1b28
    p->s.size += bp->s.size;
    1702:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1705:	8b 43 f8             	mov    -0x8(%ebx),%eax
    1708:	89 02                	mov    %eax,(%edx)
}
    170a:	5b                   	pop    %ebx
    170b:	5e                   	pop    %esi
    170c:	5f                   	pop    %edi
    170d:	5d                   	pop    %ebp
    170e:	c3                   	ret    
    170f:	90                   	nop

00001710 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1710:	55                   	push   %ebp
    1711:	89 e5                	mov    %esp,%ebp
    1713:	57                   	push   %edi
    1714:	56                   	push   %esi
    1715:	53                   	push   %ebx
    1716:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1719:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    171c:	8b 3d 28 1b 00 00    	mov    0x1b28,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1722:	8d 70 07             	lea    0x7(%eax),%esi
    1725:	c1 ee 03             	shr    $0x3,%esi
    1728:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    172b:	85 ff                	test   %edi,%edi
    172d:	0f 84 ad 00 00 00    	je     17e0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1733:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1735:	8b 48 04             	mov    0x4(%eax),%ecx
    1738:	39 f1                	cmp    %esi,%ecx
    173a:	73 71                	jae    17ad <malloc+0x9d>
    173c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1742:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1747:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    174a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1751:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1754:	eb 1b                	jmp    1771 <malloc+0x61>
    1756:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    175d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1760:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1762:	8b 4a 04             	mov    0x4(%edx),%ecx
    1765:	39 f1                	cmp    %esi,%ecx
    1767:	73 4f                	jae    17b8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1769:	8b 3d 28 1b 00 00    	mov    0x1b28,%edi
    176f:	89 d0                	mov    %edx,%eax
    1771:	39 c7                	cmp    %eax,%edi
    1773:	75 eb                	jne    1760 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1775:	83 ec 0c             	sub    $0xc,%esp
    1778:	ff 75 e4             	pushl  -0x1c(%ebp)
    177b:	e8 41 fc ff ff       	call   13c1 <sbrk>
  if(p == (char*)-1)
    1780:	83 c4 10             	add    $0x10,%esp
    1783:	83 f8 ff             	cmp    $0xffffffff,%eax
    1786:	74 1b                	je     17a3 <malloc+0x93>
  hp->s.size = nu;
    1788:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    178b:	83 ec 0c             	sub    $0xc,%esp
    178e:	83 c0 08             	add    $0x8,%eax
    1791:	50                   	push   %eax
    1792:	e8 e9 fe ff ff       	call   1680 <free>
  return freep;
    1797:	a1 28 1b 00 00       	mov    0x1b28,%eax
      if((p = morecore(nunits)) == 0)
    179c:	83 c4 10             	add    $0x10,%esp
    179f:	85 c0                	test   %eax,%eax
    17a1:	75 bd                	jne    1760 <malloc+0x50>
        return 0;
  }
}
    17a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    17a6:	31 c0                	xor    %eax,%eax
}
    17a8:	5b                   	pop    %ebx
    17a9:	5e                   	pop    %esi
    17aa:	5f                   	pop    %edi
    17ab:	5d                   	pop    %ebp
    17ac:	c3                   	ret    
    if(p->s.size >= nunits){
    17ad:	89 c2                	mov    %eax,%edx
    17af:	89 f8                	mov    %edi,%eax
    17b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    17b8:	39 ce                	cmp    %ecx,%esi
    17ba:	74 54                	je     1810 <malloc+0x100>
        p->s.size -= nunits;
    17bc:	29 f1                	sub    %esi,%ecx
    17be:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    17c1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    17c4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    17c7:	a3 28 1b 00 00       	mov    %eax,0x1b28
}
    17cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    17cf:	8d 42 08             	lea    0x8(%edx),%eax
}
    17d2:	5b                   	pop    %ebx
    17d3:	5e                   	pop    %esi
    17d4:	5f                   	pop    %edi
    17d5:	5d                   	pop    %ebp
    17d6:	c3                   	ret    
    17d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17de:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    17e0:	c7 05 28 1b 00 00 2c 	movl   $0x1b2c,0x1b28
    17e7:	1b 00 00 
    base.s.size = 0;
    17ea:	bf 2c 1b 00 00       	mov    $0x1b2c,%edi
    base.s.ptr = freep = prevp = &base;
    17ef:	c7 05 2c 1b 00 00 2c 	movl   $0x1b2c,0x1b2c
    17f6:	1b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17f9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    17fb:	c7 05 30 1b 00 00 00 	movl   $0x0,0x1b30
    1802:	00 00 00 
    if(p->s.size >= nunits){
    1805:	e9 32 ff ff ff       	jmp    173c <malloc+0x2c>
    180a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1810:	8b 0a                	mov    (%edx),%ecx
    1812:	89 08                	mov    %ecx,(%eax)
    1814:	eb b1                	jmp    17c7 <malloc+0xb7>
