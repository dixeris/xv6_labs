
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
    1030:	68 38 18 00 00       	push   $0x1838
    1035:	83 c3 01             	add    $0x1,%ebx
    1038:	50                   	push   %eax
    1039:	68 3a 18 00 00       	push   $0x183a
    103e:	6a 01                	push   $0x1
    1040:	e8 8b 04 00 00       	call   14d0 <printf>
    1045:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
    1049:	83 c4 10             	add    $0x10,%esp
    104c:	39 f3                	cmp    %esi,%ebx
    104e:	75 e0                	jne    1030 <main+0x30>
    1050:	68 3f 18 00 00       	push   $0x183f
    1055:	50                   	push   %eax
    1056:	68 3a 18 00 00       	push   $0x183a
    105b:	6a 01                	push   $0x1
    105d:	e8 6e 04 00 00       	call   14d0 <printf>
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
    12cc:	e8 5f 04 00 00       	call   1730 <malloc>
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
    1307:	e8 94 03 00 00       	call   16a0 <free>
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

000013f9 <getNumProc>:
SYSCALL(getNumProc)
    13f9:	b8 1a 00 00 00       	mov    $0x1a,%eax
    13fe:	cd 40                	int    $0x40
    1400:	c3                   	ret    

00001401 <getMaxPid>:
SYSCALL(getMaxPid)
    1401:	b8 1b 00 00 00       	mov    $0x1b,%eax
    1406:	cd 40                	int    $0x40
    1408:	c3                   	ret    

00001409 <getProcInfo>:
SYSCALL(getProcInfo)
    1409:	b8 1c 00 00 00       	mov    $0x1c,%eax
    140e:	cd 40                	int    $0x40
    1410:	c3                   	ret    
    1411:	66 90                	xchg   %ax,%ax
    1413:	66 90                	xchg   %ax,%ax
    1415:	66 90                	xchg   %ax,%ax
    1417:	66 90                	xchg   %ax,%ax
    1419:	66 90                	xchg   %ax,%ax
    141b:	66 90                	xchg   %ax,%ax
    141d:	66 90                	xchg   %ax,%ax
    141f:	90                   	nop

00001420 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	57                   	push   %edi
    1424:	56                   	push   %esi
    1425:	53                   	push   %ebx
    1426:	83 ec 3c             	sub    $0x3c,%esp
    1429:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    142c:	89 d1                	mov    %edx,%ecx
{
    142e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    1431:	85 d2                	test   %edx,%edx
    1433:	0f 89 7f 00 00 00    	jns    14b8 <printint+0x98>
    1439:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    143d:	74 79                	je     14b8 <printint+0x98>
    neg = 1;
    143f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    1446:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    1448:	31 db                	xor    %ebx,%ebx
    144a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    144d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1450:	89 c8                	mov    %ecx,%eax
    1452:	31 d2                	xor    %edx,%edx
    1454:	89 cf                	mov    %ecx,%edi
    1456:	f7 75 c4             	divl   -0x3c(%ebp)
    1459:	0f b6 92 48 18 00 00 	movzbl 0x1848(%edx),%edx
    1460:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1463:	89 d8                	mov    %ebx,%eax
    1465:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1468:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    146b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    146e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1471:	76 dd                	jbe    1450 <printint+0x30>
  if(neg)
    1473:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1476:	85 c9                	test   %ecx,%ecx
    1478:	74 0c                	je     1486 <printint+0x66>
    buf[i++] = '-';
    147a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    147f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1481:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1486:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1489:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    148d:	eb 07                	jmp    1496 <printint+0x76>
    148f:	90                   	nop
    putc(fd, buf[i]);
    1490:	0f b6 13             	movzbl (%ebx),%edx
    1493:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1496:	83 ec 04             	sub    $0x4,%esp
    1499:	88 55 d7             	mov    %dl,-0x29(%ebp)
    149c:	6a 01                	push   $0x1
    149e:	56                   	push   %esi
    149f:	57                   	push   %edi
    14a0:	e8 b4 fe ff ff       	call   1359 <write>
  while(--i >= 0)
    14a5:	83 c4 10             	add    $0x10,%esp
    14a8:	39 de                	cmp    %ebx,%esi
    14aa:	75 e4                	jne    1490 <printint+0x70>
}
    14ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14af:	5b                   	pop    %ebx
    14b0:	5e                   	pop    %esi
    14b1:	5f                   	pop    %edi
    14b2:	5d                   	pop    %ebp
    14b3:	c3                   	ret    
    14b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    14b8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    14bf:	eb 87                	jmp    1448 <printint+0x28>
    14c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14cf:	90                   	nop

000014d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    14d0:	55                   	push   %ebp
    14d1:	89 e5                	mov    %esp,%ebp
    14d3:	57                   	push   %edi
    14d4:	56                   	push   %esi
    14d5:	53                   	push   %ebx
    14d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14d9:	8b 75 0c             	mov    0xc(%ebp),%esi
    14dc:	0f b6 1e             	movzbl (%esi),%ebx
    14df:	84 db                	test   %bl,%bl
    14e1:	0f 84 b8 00 00 00    	je     159f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    14e7:	8d 45 10             	lea    0x10(%ebp),%eax
    14ea:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    14ed:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    14f0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    14f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    14f5:	eb 37                	jmp    152e <printf+0x5e>
    14f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14fe:	66 90                	xchg   %ax,%ax
    1500:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    1503:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1508:	83 f8 25             	cmp    $0x25,%eax
    150b:	74 17                	je     1524 <printf+0x54>
  write(fd, &c, 1);
    150d:	83 ec 04             	sub    $0x4,%esp
    1510:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1513:	6a 01                	push   $0x1
    1515:	57                   	push   %edi
    1516:	ff 75 08             	pushl  0x8(%ebp)
    1519:	e8 3b fe ff ff       	call   1359 <write>
    151e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    1521:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1524:	0f b6 1e             	movzbl (%esi),%ebx
    1527:	83 c6 01             	add    $0x1,%esi
    152a:	84 db                	test   %bl,%bl
    152c:	74 71                	je     159f <printf+0xcf>
    c = fmt[i] & 0xff;
    152e:	0f be cb             	movsbl %bl,%ecx
    1531:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1534:	85 d2                	test   %edx,%edx
    1536:	74 c8                	je     1500 <printf+0x30>
      }
    } else if(state == '%'){
    1538:	83 fa 25             	cmp    $0x25,%edx
    153b:	75 e7                	jne    1524 <printf+0x54>
      if(c == 'd'){
    153d:	83 f8 64             	cmp    $0x64,%eax
    1540:	0f 84 9a 00 00 00    	je     15e0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1546:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    154c:	83 f9 70             	cmp    $0x70,%ecx
    154f:	74 5f                	je     15b0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1551:	83 f8 73             	cmp    $0x73,%eax
    1554:	0f 84 d6 00 00 00    	je     1630 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    155a:	83 f8 63             	cmp    $0x63,%eax
    155d:	0f 84 8d 00 00 00    	je     15f0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1563:	83 f8 25             	cmp    $0x25,%eax
    1566:	0f 84 b4 00 00 00    	je     1620 <printf+0x150>
  write(fd, &c, 1);
    156c:	83 ec 04             	sub    $0x4,%esp
    156f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1573:	6a 01                	push   $0x1
    1575:	57                   	push   %edi
    1576:	ff 75 08             	pushl  0x8(%ebp)
    1579:	e8 db fd ff ff       	call   1359 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    157e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1581:	83 c4 0c             	add    $0xc,%esp
    1584:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1586:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1589:	57                   	push   %edi
    158a:	ff 75 08             	pushl  0x8(%ebp)
    158d:	e8 c7 fd ff ff       	call   1359 <write>
  for(i = 0; fmt[i]; i++){
    1592:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    1596:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1599:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    159b:	84 db                	test   %bl,%bl
    159d:	75 8f                	jne    152e <printf+0x5e>
    }
  }
}
    159f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    15a2:	5b                   	pop    %ebx
    15a3:	5e                   	pop    %esi
    15a4:	5f                   	pop    %edi
    15a5:	5d                   	pop    %ebp
    15a6:	c3                   	ret    
    15a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15ae:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    15b0:	83 ec 0c             	sub    $0xc,%esp
    15b3:	b9 10 00 00 00       	mov    $0x10,%ecx
    15b8:	6a 00                	push   $0x0
    15ba:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    15bd:	8b 45 08             	mov    0x8(%ebp),%eax
    15c0:	8b 13                	mov    (%ebx),%edx
    15c2:	e8 59 fe ff ff       	call   1420 <printint>
        ap++;
    15c7:	89 d8                	mov    %ebx,%eax
    15c9:	83 c4 10             	add    $0x10,%esp
      state = 0;
    15cc:	31 d2                	xor    %edx,%edx
        ap++;
    15ce:	83 c0 04             	add    $0x4,%eax
    15d1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    15d4:	e9 4b ff ff ff       	jmp    1524 <printf+0x54>
    15d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    15e0:	83 ec 0c             	sub    $0xc,%esp
    15e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    15e8:	6a 01                	push   $0x1
    15ea:	eb ce                	jmp    15ba <printf+0xea>
    15ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    15f0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    15f3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    15f6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    15f8:	6a 01                	push   $0x1
        ap++;
    15fa:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    15fd:	57                   	push   %edi
    15fe:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    1601:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1604:	e8 50 fd ff ff       	call   1359 <write>
        ap++;
    1609:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    160c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    160f:	31 d2                	xor    %edx,%edx
    1611:	e9 0e ff ff ff       	jmp    1524 <printf+0x54>
    1616:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    161d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    1620:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1623:	83 ec 04             	sub    $0x4,%esp
    1626:	e9 59 ff ff ff       	jmp    1584 <printf+0xb4>
    162b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    162f:	90                   	nop
        s = (char*)*ap;
    1630:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1633:	8b 18                	mov    (%eax),%ebx
        ap++;
    1635:	83 c0 04             	add    $0x4,%eax
    1638:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    163b:	85 db                	test   %ebx,%ebx
    163d:	74 17                	je     1656 <printf+0x186>
        while(*s != 0){
    163f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1642:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1644:	84 c0                	test   %al,%al
    1646:	0f 84 d8 fe ff ff    	je     1524 <printf+0x54>
    164c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    164f:	89 de                	mov    %ebx,%esi
    1651:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1654:	eb 1a                	jmp    1670 <printf+0x1a0>
          s = "(null)";
    1656:	bb 41 18 00 00       	mov    $0x1841,%ebx
        while(*s != 0){
    165b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    165e:	b8 28 00 00 00       	mov    $0x28,%eax
    1663:	89 de                	mov    %ebx,%esi
    1665:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1668:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    166f:	90                   	nop
  write(fd, &c, 1);
    1670:	83 ec 04             	sub    $0x4,%esp
          s++;
    1673:	83 c6 01             	add    $0x1,%esi
    1676:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1679:	6a 01                	push   $0x1
    167b:	57                   	push   %edi
    167c:	53                   	push   %ebx
    167d:	e8 d7 fc ff ff       	call   1359 <write>
        while(*s != 0){
    1682:	0f b6 06             	movzbl (%esi),%eax
    1685:	83 c4 10             	add    $0x10,%esp
    1688:	84 c0                	test   %al,%al
    168a:	75 e4                	jne    1670 <printf+0x1a0>
      state = 0;
    168c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    168f:	31 d2                	xor    %edx,%edx
    1691:	e9 8e fe ff ff       	jmp    1524 <printf+0x54>
    1696:	66 90                	xchg   %ax,%ax
    1698:	66 90                	xchg   %ax,%ax
    169a:	66 90                	xchg   %ax,%ax
    169c:	66 90                	xchg   %ax,%ax
    169e:	66 90                	xchg   %ax,%ax

000016a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16a1:	a1 48 1b 00 00       	mov    0x1b48,%eax
{
    16a6:	89 e5                	mov    %esp,%ebp
    16a8:	57                   	push   %edi
    16a9:	56                   	push   %esi
    16aa:	53                   	push   %ebx
    16ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    16ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    16b8:	89 c2                	mov    %eax,%edx
    16ba:	8b 00                	mov    (%eax),%eax
    16bc:	39 ca                	cmp    %ecx,%edx
    16be:	73 30                	jae    16f0 <free+0x50>
    16c0:	39 c1                	cmp    %eax,%ecx
    16c2:	72 04                	jb     16c8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16c4:	39 c2                	cmp    %eax,%edx
    16c6:	72 f0                	jb     16b8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    16c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    16cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16ce:	39 f8                	cmp    %edi,%eax
    16d0:	74 30                	je     1702 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    16d2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    16d5:	8b 42 04             	mov    0x4(%edx),%eax
    16d8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    16db:	39 f1                	cmp    %esi,%ecx
    16dd:	74 3a                	je     1719 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    16df:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    16e1:	5b                   	pop    %ebx
  freep = p;
    16e2:	89 15 48 1b 00 00    	mov    %edx,0x1b48
}
    16e8:	5e                   	pop    %esi
    16e9:	5f                   	pop    %edi
    16ea:	5d                   	pop    %ebp
    16eb:	c3                   	ret    
    16ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16f0:	39 c2                	cmp    %eax,%edx
    16f2:	72 c4                	jb     16b8 <free+0x18>
    16f4:	39 c1                	cmp    %eax,%ecx
    16f6:	73 c0                	jae    16b8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    16f8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    16fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16fe:	39 f8                	cmp    %edi,%eax
    1700:	75 d0                	jne    16d2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    1702:	03 70 04             	add    0x4(%eax),%esi
    1705:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1708:	8b 02                	mov    (%edx),%eax
    170a:	8b 00                	mov    (%eax),%eax
    170c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    170f:	8b 42 04             	mov    0x4(%edx),%eax
    1712:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1715:	39 f1                	cmp    %esi,%ecx
    1717:	75 c6                	jne    16df <free+0x3f>
    p->s.size += bp->s.size;
    1719:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    171c:	89 15 48 1b 00 00    	mov    %edx,0x1b48
    p->s.size += bp->s.size;
    1722:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1725:	8b 43 f8             	mov    -0x8(%ebx),%eax
    1728:	89 02                	mov    %eax,(%edx)
}
    172a:	5b                   	pop    %ebx
    172b:	5e                   	pop    %esi
    172c:	5f                   	pop    %edi
    172d:	5d                   	pop    %ebp
    172e:	c3                   	ret    
    172f:	90                   	nop

00001730 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1730:	55                   	push   %ebp
    1731:	89 e5                	mov    %esp,%ebp
    1733:	57                   	push   %edi
    1734:	56                   	push   %esi
    1735:	53                   	push   %ebx
    1736:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1739:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    173c:	8b 3d 48 1b 00 00    	mov    0x1b48,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1742:	8d 70 07             	lea    0x7(%eax),%esi
    1745:	c1 ee 03             	shr    $0x3,%esi
    1748:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    174b:	85 ff                	test   %edi,%edi
    174d:	0f 84 ad 00 00 00    	je     1800 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1753:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1755:	8b 48 04             	mov    0x4(%eax),%ecx
    1758:	39 f1                	cmp    %esi,%ecx
    175a:	73 71                	jae    17cd <malloc+0x9d>
    175c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1762:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1767:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    176a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1771:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1774:	eb 1b                	jmp    1791 <malloc+0x61>
    1776:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    177d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1780:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1782:	8b 4a 04             	mov    0x4(%edx),%ecx
    1785:	39 f1                	cmp    %esi,%ecx
    1787:	73 4f                	jae    17d8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1789:	8b 3d 48 1b 00 00    	mov    0x1b48,%edi
    178f:	89 d0                	mov    %edx,%eax
    1791:	39 c7                	cmp    %eax,%edi
    1793:	75 eb                	jne    1780 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1795:	83 ec 0c             	sub    $0xc,%esp
    1798:	ff 75 e4             	pushl  -0x1c(%ebp)
    179b:	e8 21 fc ff ff       	call   13c1 <sbrk>
  if(p == (char*)-1)
    17a0:	83 c4 10             	add    $0x10,%esp
    17a3:	83 f8 ff             	cmp    $0xffffffff,%eax
    17a6:	74 1b                	je     17c3 <malloc+0x93>
  hp->s.size = nu;
    17a8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    17ab:	83 ec 0c             	sub    $0xc,%esp
    17ae:	83 c0 08             	add    $0x8,%eax
    17b1:	50                   	push   %eax
    17b2:	e8 e9 fe ff ff       	call   16a0 <free>
  return freep;
    17b7:	a1 48 1b 00 00       	mov    0x1b48,%eax
      if((p = morecore(nunits)) == 0)
    17bc:	83 c4 10             	add    $0x10,%esp
    17bf:	85 c0                	test   %eax,%eax
    17c1:	75 bd                	jne    1780 <malloc+0x50>
        return 0;
  }
}
    17c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    17c6:	31 c0                	xor    %eax,%eax
}
    17c8:	5b                   	pop    %ebx
    17c9:	5e                   	pop    %esi
    17ca:	5f                   	pop    %edi
    17cb:	5d                   	pop    %ebp
    17cc:	c3                   	ret    
    if(p->s.size >= nunits){
    17cd:	89 c2                	mov    %eax,%edx
    17cf:	89 f8                	mov    %edi,%eax
    17d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    17d8:	39 ce                	cmp    %ecx,%esi
    17da:	74 54                	je     1830 <malloc+0x100>
        p->s.size -= nunits;
    17dc:	29 f1                	sub    %esi,%ecx
    17de:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    17e1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    17e4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    17e7:	a3 48 1b 00 00       	mov    %eax,0x1b48
}
    17ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    17ef:	8d 42 08             	lea    0x8(%edx),%eax
}
    17f2:	5b                   	pop    %ebx
    17f3:	5e                   	pop    %esi
    17f4:	5f                   	pop    %edi
    17f5:	5d                   	pop    %ebp
    17f6:	c3                   	ret    
    17f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17fe:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    1800:	c7 05 48 1b 00 00 4c 	movl   $0x1b4c,0x1b48
    1807:	1b 00 00 
    base.s.size = 0;
    180a:	bf 4c 1b 00 00       	mov    $0x1b4c,%edi
    base.s.ptr = freep = prevp = &base;
    180f:	c7 05 4c 1b 00 00 4c 	movl   $0x1b4c,0x1b4c
    1816:	1b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1819:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    181b:	c7 05 50 1b 00 00 00 	movl   $0x0,0x1b50
    1822:	00 00 00 
    if(p->s.size >= nunits){
    1825:	e9 32 ff ff ff       	jmp    175c <malloc+0x2c>
    182a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1830:	8b 0a                	mov    (%edx),%ecx
    1832:	89 08                	mov    %ecx,(%eax)
    1834:	eb b1                	jmp    17e7 <malloc+0xb7>
