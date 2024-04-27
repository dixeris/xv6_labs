
_cat:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
  }
}

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
    100f:	be 01 00 00 00       	mov    $0x1,%esi
    1014:	53                   	push   %ebx
    1015:	51                   	push   %ecx
    1016:	83 ec 18             	sub    $0x18,%esp
    1019:	8b 01                	mov    (%ecx),%eax
    101b:	8b 59 04             	mov    0x4(%ecx),%ebx
    101e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1021:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
    1024:	83 f8 01             	cmp    $0x1,%eax
    1027:	7e 54                	jle    107d <main+0x7d>
    1029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
    1030:	83 ec 08             	sub    $0x8,%esp
    1033:	6a 00                	push   $0x0
    1035:	ff 33                	pushl  (%ebx)
    1037:	e8 dd 03 00 00       	call   1419 <open>
    103c:	83 c4 10             	add    $0x10,%esp
    103f:	89 c7                	mov    %eax,%edi
    1041:	85 c0                	test   %eax,%eax
    1043:	78 24                	js     1069 <main+0x69>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
    1045:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
    1048:	83 c6 01             	add    $0x1,%esi
    104b:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
    104e:	50                   	push   %eax
    104f:	e8 3c 00 00 00       	call   1090 <cat>
    close(fd);
    1054:	89 3c 24             	mov    %edi,(%esp)
    1057:	e8 a5 03 00 00       	call   1401 <close>
  for(i = 1; i < argc; i++){
    105c:	83 c4 10             	add    $0x10,%esp
    105f:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
    1062:	75 cc                	jne    1030 <main+0x30>
  }
  exit();
    1064:	e8 70 03 00 00       	call   13d9 <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
    1069:	50                   	push   %eax
    106a:	ff 33                	pushl  (%ebx)
    106c:	68 db 18 00 00       	push   $0x18db
    1071:	6a 01                	push   $0x1
    1073:	e8 d8 04 00 00       	call   1550 <printf>
      exit();
    1078:	e8 5c 03 00 00       	call   13d9 <exit>
    cat(0);
    107d:	83 ec 0c             	sub    $0xc,%esp
    1080:	6a 00                	push   $0x0
    1082:	e8 09 00 00 00       	call   1090 <cat>
    exit();
    1087:	e8 4d 03 00 00       	call   13d9 <exit>
    108c:	66 90                	xchg   %ax,%ax
    108e:	66 90                	xchg   %ax,%ax

00001090 <cat>:
{
    1090:	55                   	push   %ebp
    1091:	89 e5                	mov    %esp,%ebp
    1093:	56                   	push   %esi
    1094:	8b 75 08             	mov    0x8(%ebp),%esi
    1097:	53                   	push   %ebx
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    1098:	eb 1d                	jmp    10b7 <cat+0x27>
    109a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
    10a0:	83 ec 04             	sub    $0x4,%esp
    10a3:	53                   	push   %ebx
    10a4:	68 40 1c 00 00       	push   $0x1c40
    10a9:	6a 01                	push   $0x1
    10ab:	e8 49 03 00 00       	call   13f9 <write>
    10b0:	83 c4 10             	add    $0x10,%esp
    10b3:	39 d8                	cmp    %ebx,%eax
    10b5:	75 25                	jne    10dc <cat+0x4c>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    10b7:	83 ec 04             	sub    $0x4,%esp
    10ba:	68 00 02 00 00       	push   $0x200
    10bf:	68 40 1c 00 00       	push   $0x1c40
    10c4:	56                   	push   %esi
    10c5:	e8 27 03 00 00       	call   13f1 <read>
    10ca:	83 c4 10             	add    $0x10,%esp
    10cd:	89 c3                	mov    %eax,%ebx
    10cf:	85 c0                	test   %eax,%eax
    10d1:	7f cd                	jg     10a0 <cat+0x10>
  if(n < 0){
    10d3:	75 1b                	jne    10f0 <cat+0x60>
}
    10d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
    10d8:	5b                   	pop    %ebx
    10d9:	5e                   	pop    %esi
    10da:	5d                   	pop    %ebp
    10db:	c3                   	ret    
      printf(1, "cat: write error\n");
    10dc:	83 ec 08             	sub    $0x8,%esp
    10df:	68 b8 18 00 00       	push   $0x18b8
    10e4:	6a 01                	push   $0x1
    10e6:	e8 65 04 00 00       	call   1550 <printf>
      exit();
    10eb:	e8 e9 02 00 00       	call   13d9 <exit>
    printf(1, "cat: read error\n");
    10f0:	50                   	push   %eax
    10f1:	50                   	push   %eax
    10f2:	68 ca 18 00 00       	push   $0x18ca
    10f7:	6a 01                	push   $0x1
    10f9:	e8 52 04 00 00       	call   1550 <printf>
    exit();
    10fe:	e8 d6 02 00 00       	call   13d9 <exit>
    1103:	66 90                	xchg   %ax,%ax
    1105:	66 90                	xchg   %ax,%ax
    1107:	66 90                	xchg   %ax,%ax
    1109:	66 90                	xchg   %ax,%ax
    110b:	66 90                	xchg   %ax,%ax
    110d:	66 90                	xchg   %ax,%ax
    110f:	90                   	nop

00001110 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"
char*
strcpy(char *s, const char *t)
{
    1110:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1111:	31 c0                	xor    %eax,%eax
{
    1113:	89 e5                	mov    %esp,%ebp
    1115:	53                   	push   %ebx
    1116:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1119:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    111c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    1120:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    1124:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    1127:	83 c0 01             	add    $0x1,%eax
    112a:	84 d2                	test   %dl,%dl
    112c:	75 f2                	jne    1120 <strcpy+0x10>
    ;
  return os;
}
    112e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1131:	89 c8                	mov    %ecx,%eax
    1133:	c9                   	leave  
    1134:	c3                   	ret    
    1135:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    113c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1140:	55                   	push   %ebp
    1141:	89 e5                	mov    %esp,%ebp
    1143:	53                   	push   %ebx
    1144:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1147:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    114a:	0f b6 01             	movzbl (%ecx),%eax
    114d:	0f b6 1a             	movzbl (%edx),%ebx
    1150:	84 c0                	test   %al,%al
    1152:	75 1d                	jne    1171 <strcmp+0x31>
    1154:	eb 2a                	jmp    1180 <strcmp+0x40>
    1156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    115d:	8d 76 00             	lea    0x0(%esi),%esi
    1160:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    1164:	83 c1 01             	add    $0x1,%ecx
    1167:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    116a:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    116d:	84 c0                	test   %al,%al
    116f:	74 0f                	je     1180 <strcmp+0x40>
    1171:	38 d8                	cmp    %bl,%al
    1173:	74 eb                	je     1160 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1175:	29 d8                	sub    %ebx,%eax
}
    1177:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    117a:	c9                   	leave  
    117b:	c3                   	ret    
    117c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1180:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1182:	29 d8                	sub    %ebx,%eax
}
    1184:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1187:	c9                   	leave  
    1188:	c3                   	ret    
    1189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001190 <strlen>:

uint
strlen(const char *s)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    1196:	80 3a 00             	cmpb   $0x0,(%edx)
    1199:	74 15                	je     11b0 <strlen+0x20>
    119b:	31 c0                	xor    %eax,%eax
    119d:	8d 76 00             	lea    0x0(%esi),%esi
    11a0:	83 c0 01             	add    $0x1,%eax
    11a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    11a7:	89 c1                	mov    %eax,%ecx
    11a9:	75 f5                	jne    11a0 <strlen+0x10>
    ;
  return n;
}
    11ab:	89 c8                	mov    %ecx,%eax
    11ad:	5d                   	pop    %ebp
    11ae:	c3                   	ret    
    11af:	90                   	nop
  for(n = 0; s[n]; n++)
    11b0:	31 c9                	xor    %ecx,%ecx
}
    11b2:	5d                   	pop    %ebp
    11b3:	89 c8                	mov    %ecx,%eax
    11b5:	c3                   	ret    
    11b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11bd:	8d 76 00             	lea    0x0(%esi),%esi

000011c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	57                   	push   %edi
    11c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    11cd:	89 d7                	mov    %edx,%edi
    11cf:	fc                   	cld    
    11d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    11d2:	8b 7d fc             	mov    -0x4(%ebp),%edi
    11d5:	89 d0                	mov    %edx,%eax
    11d7:	c9                   	leave  
    11d8:	c3                   	ret    
    11d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000011e0 <strchr>:

char*
strchr(const char *s, char c)
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	8b 45 08             	mov    0x8(%ebp),%eax
    11e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    11ea:	0f b6 10             	movzbl (%eax),%edx
    11ed:	84 d2                	test   %dl,%dl
    11ef:	75 12                	jne    1203 <strchr+0x23>
    11f1:	eb 1d                	jmp    1210 <strchr+0x30>
    11f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11f7:	90                   	nop
    11f8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    11fc:	83 c0 01             	add    $0x1,%eax
    11ff:	84 d2                	test   %dl,%dl
    1201:	74 0d                	je     1210 <strchr+0x30>
    if(*s == c)
    1203:	38 d1                	cmp    %dl,%cl
    1205:	75 f1                	jne    11f8 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1207:	5d                   	pop    %ebp
    1208:	c3                   	ret    
    1209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    1210:	31 c0                	xor    %eax,%eax
}
    1212:	5d                   	pop    %ebp
    1213:	c3                   	ret    
    1214:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    121b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    121f:	90                   	nop

00001220 <gets>:

char*
gets(char *buf, int max)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1225:	31 f6                	xor    %esi,%esi
{
    1227:	53                   	push   %ebx
    1228:	89 f3                	mov    %esi,%ebx
    122a:	83 ec 1c             	sub    $0x1c,%esp
    122d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1230:	eb 2f                	jmp    1261 <gets+0x41>
    1232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1238:	83 ec 04             	sub    $0x4,%esp
    123b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    123e:	6a 01                	push   $0x1
    1240:	50                   	push   %eax
    1241:	6a 00                	push   $0x0
    1243:	e8 a9 01 00 00       	call   13f1 <read>
    if(cc < 1)
    1248:	83 c4 10             	add    $0x10,%esp
    124b:	85 c0                	test   %eax,%eax
    124d:	7e 1c                	jle    126b <gets+0x4b>
      break;
    buf[i++] = c;
    124f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    1253:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    1256:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1259:	3c 0a                	cmp    $0xa,%al
    125b:	74 23                	je     1280 <gets+0x60>
    125d:	3c 0d                	cmp    $0xd,%al
    125f:	74 1f                	je     1280 <gets+0x60>
  for(i=0; i+1 < max; ){
    1261:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    1264:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    1266:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1269:	7c cd                	jl     1238 <gets+0x18>
    126b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    126d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1270:	c6 03 00             	movb   $0x0,(%ebx)
}
    1273:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1276:	5b                   	pop    %ebx
    1277:	5e                   	pop    %esi
    1278:	5f                   	pop    %edi
    1279:	5d                   	pop    %ebp
    127a:	c3                   	ret    
    127b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    127f:	90                   	nop
  buf[i] = '\0';
    1280:	8b 75 08             	mov    0x8(%ebp),%esi
}
    1283:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1286:	01 de                	add    %ebx,%esi
    1288:	89 f3                	mov    %esi,%ebx
    128a:	c6 03 00             	movb   $0x0,(%ebx)
}
    128d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1290:	5b                   	pop    %ebx
    1291:	5e                   	pop    %esi
    1292:	5f                   	pop    %edi
    1293:	5d                   	pop    %ebp
    1294:	c3                   	ret    
    1295:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000012a0 <stat>:

int
stat(const char *n, struct stat *st)
{
    12a0:	55                   	push   %ebp
    12a1:	89 e5                	mov    %esp,%ebp
    12a3:	56                   	push   %esi
    12a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12a5:	83 ec 08             	sub    $0x8,%esp
    12a8:	6a 00                	push   $0x0
    12aa:	ff 75 08             	pushl  0x8(%ebp)
    12ad:	e8 67 01 00 00       	call   1419 <open>
  if(fd < 0)
    12b2:	83 c4 10             	add    $0x10,%esp
    12b5:	85 c0                	test   %eax,%eax
    12b7:	78 27                	js     12e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    12b9:	83 ec 08             	sub    $0x8,%esp
    12bc:	ff 75 0c             	pushl  0xc(%ebp)
    12bf:	89 c3                	mov    %eax,%ebx
    12c1:	50                   	push   %eax
    12c2:	e8 6a 01 00 00       	call   1431 <fstat>
  close(fd);
    12c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    12ca:	89 c6                	mov    %eax,%esi
  close(fd);
    12cc:	e8 30 01 00 00       	call   1401 <close>
  return r;
    12d1:	83 c4 10             	add    $0x10,%esp
}
    12d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    12d7:	89 f0                	mov    %esi,%eax
    12d9:	5b                   	pop    %ebx
    12da:	5e                   	pop    %esi
    12db:	5d                   	pop    %ebp
    12dc:	c3                   	ret    
    12dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    12e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    12e5:	eb ed                	jmp    12d4 <stat+0x34>
    12e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12ee:	66 90                	xchg   %ax,%ax

000012f0 <atoi>:

int
atoi(const char *s)
{
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	53                   	push   %ebx
    12f4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12f7:	0f be 02             	movsbl (%edx),%eax
    12fa:	8d 48 d0             	lea    -0x30(%eax),%ecx
    12fd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1300:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1305:	77 1e                	ja     1325 <atoi+0x35>
    1307:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    130e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    1310:	83 c2 01             	add    $0x1,%edx
    1313:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1316:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    131a:	0f be 02             	movsbl (%edx),%eax
    131d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1320:	80 fb 09             	cmp    $0x9,%bl
    1323:	76 eb                	jbe    1310 <atoi+0x20>
  return n;
}
    1325:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1328:	89 c8                	mov    %ecx,%eax
    132a:	c9                   	leave  
    132b:	c3                   	ret    
    132c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001330 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1330:	55                   	push   %ebp
    1331:	89 e5                	mov    %esp,%ebp
    1333:	57                   	push   %edi
    1334:	8b 45 10             	mov    0x10(%ebp),%eax
    1337:	8b 55 08             	mov    0x8(%ebp),%edx
    133a:	56                   	push   %esi
    133b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    133e:	85 c0                	test   %eax,%eax
    1340:	7e 13                	jle    1355 <memmove+0x25>
    1342:	01 d0                	add    %edx,%eax
  dst = vdst;
    1344:	89 d7                	mov    %edx,%edi
    1346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    134d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    1350:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    1351:	39 f8                	cmp    %edi,%eax
    1353:	75 fb                	jne    1350 <memmove+0x20>
  return vdst;
}
    1355:	5e                   	pop    %esi
    1356:	89 d0                	mov    %edx,%eax
    1358:	5f                   	pop    %edi
    1359:	5d                   	pop    %ebp
    135a:	c3                   	ret    
    135b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    135f:	90                   	nop

00001360 <thread_create>:


int thread_create(void (*start_routine)(void*, void*), void *arg1, void *arg2) {
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	53                   	push   %ebx
    1364:	83 ec 20             	sub    $0x20,%esp
  void *stack =  malloc(4096);
    1367:	68 00 10 00 00       	push   $0x1000
    136c:	e8 3f 04 00 00       	call   17b0 <malloc>
  if(stack == 0)
    1371:	83 c4 10             	add    $0x10,%esp
    1374:	85 c0                	test   %eax,%eax
    1376:	74 3f                	je     13b7 <thread_create+0x57>
    return -1;
  int r= clone(start_routine, arg1, arg2, stack);
    1378:	50                   	push   %eax
    1379:	89 c3                	mov    %eax,%ebx
    137b:	ff 75 10             	pushl  0x10(%ebp)
    137e:	ff 75 0c             	pushl  0xc(%ebp)
    1381:	ff 75 08             	pushl  0x8(%ebp)
    1384:	e8 00 01 00 00       	call   1489 <clone>
  if(r==-1) 
    1389:	83 c4 10             	add    $0x10,%esp
    138c:	83 f8 ff             	cmp    $0xffffffff,%eax
    138f:	74 0f                	je     13a0 <thread_create+0x40>
    free(stack);
  return r;
}
    1391:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1394:	c9                   	leave  
    1395:	c3                   	ret    
    1396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    139d:	8d 76 00             	lea    0x0(%esi),%esi
    free(stack);
    13a0:	83 ec 0c             	sub    $0xc,%esp
    13a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13a6:	53                   	push   %ebx
    13a7:	e8 74 03 00 00       	call   1720 <free>
    13ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    13af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    free(stack);
    13b2:	83 c4 10             	add    $0x10,%esp
}
    13b5:	c9                   	leave  
    13b6:	c3                   	ret    
    return -1;
    13b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13bc:	eb d3                	jmp    1391 <thread_create+0x31>
    13be:	66 90                	xchg   %ax,%ax

000013c0 <thread_join>:


int thread_join(void) {
    13c0:	55                   	push   %ebp
    13c1:	89 e5                	mov    %esp,%ebp
    13c3:	83 ec 24             	sub    $0x24,%esp
  void *stack;
  int r = join(&stack);
    13c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13c9:	50                   	push   %eax
    13ca:	e8 c2 00 00 00       	call   1491 <join>
  return r;
}
    13cf:	c9                   	leave  
    13d0:	c3                   	ret    

000013d1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13d1:	b8 01 00 00 00       	mov    $0x1,%eax
    13d6:	cd 40                	int    $0x40
    13d8:	c3                   	ret    

000013d9 <exit>:
SYSCALL(exit)
    13d9:	b8 02 00 00 00       	mov    $0x2,%eax
    13de:	cd 40                	int    $0x40
    13e0:	c3                   	ret    

000013e1 <wait>:
SYSCALL(wait)
    13e1:	b8 03 00 00 00       	mov    $0x3,%eax
    13e6:	cd 40                	int    $0x40
    13e8:	c3                   	ret    

000013e9 <pipe>:
SYSCALL(pipe)
    13e9:	b8 04 00 00 00       	mov    $0x4,%eax
    13ee:	cd 40                	int    $0x40
    13f0:	c3                   	ret    

000013f1 <read>:
SYSCALL(read)
    13f1:	b8 05 00 00 00       	mov    $0x5,%eax
    13f6:	cd 40                	int    $0x40
    13f8:	c3                   	ret    

000013f9 <write>:
SYSCALL(write)
    13f9:	b8 10 00 00 00       	mov    $0x10,%eax
    13fe:	cd 40                	int    $0x40
    1400:	c3                   	ret    

00001401 <close>:
SYSCALL(close)
    1401:	b8 15 00 00 00       	mov    $0x15,%eax
    1406:	cd 40                	int    $0x40
    1408:	c3                   	ret    

00001409 <kill>:
SYSCALL(kill)
    1409:	b8 06 00 00 00       	mov    $0x6,%eax
    140e:	cd 40                	int    $0x40
    1410:	c3                   	ret    

00001411 <exec>:
SYSCALL(exec)
    1411:	b8 07 00 00 00       	mov    $0x7,%eax
    1416:	cd 40                	int    $0x40
    1418:	c3                   	ret    

00001419 <open>:
SYSCALL(open)
    1419:	b8 0f 00 00 00       	mov    $0xf,%eax
    141e:	cd 40                	int    $0x40
    1420:	c3                   	ret    

00001421 <mknod>:
SYSCALL(mknod)
    1421:	b8 11 00 00 00       	mov    $0x11,%eax
    1426:	cd 40                	int    $0x40
    1428:	c3                   	ret    

00001429 <unlink>:
SYSCALL(unlink)
    1429:	b8 12 00 00 00       	mov    $0x12,%eax
    142e:	cd 40                	int    $0x40
    1430:	c3                   	ret    

00001431 <fstat>:
SYSCALL(fstat)
    1431:	b8 08 00 00 00       	mov    $0x8,%eax
    1436:	cd 40                	int    $0x40
    1438:	c3                   	ret    

00001439 <link>:
SYSCALL(link)
    1439:	b8 13 00 00 00       	mov    $0x13,%eax
    143e:	cd 40                	int    $0x40
    1440:	c3                   	ret    

00001441 <mkdir>:
SYSCALL(mkdir)
    1441:	b8 14 00 00 00       	mov    $0x14,%eax
    1446:	cd 40                	int    $0x40
    1448:	c3                   	ret    

00001449 <chdir>:
SYSCALL(chdir)
    1449:	b8 09 00 00 00       	mov    $0x9,%eax
    144e:	cd 40                	int    $0x40
    1450:	c3                   	ret    

00001451 <dup>:
SYSCALL(dup)
    1451:	b8 0a 00 00 00       	mov    $0xa,%eax
    1456:	cd 40                	int    $0x40
    1458:	c3                   	ret    

00001459 <getpid>:
SYSCALL(getpid)
    1459:	b8 0b 00 00 00       	mov    $0xb,%eax
    145e:	cd 40                	int    $0x40
    1460:	c3                   	ret    

00001461 <sbrk>:
SYSCALL(sbrk)
    1461:	b8 0c 00 00 00       	mov    $0xc,%eax
    1466:	cd 40                	int    $0x40
    1468:	c3                   	ret    

00001469 <sleep>:
SYSCALL(sleep)
    1469:	b8 0d 00 00 00       	mov    $0xd,%eax
    146e:	cd 40                	int    $0x40
    1470:	c3                   	ret    

00001471 <uptime>:
SYSCALL(uptime)
    1471:	b8 0e 00 00 00       	mov    $0xe,%eax
    1476:	cd 40                	int    $0x40
    1478:	c3                   	ret    

00001479 <mprotect>:
SYSCALL(mprotect)
    1479:	b8 16 00 00 00       	mov    $0x16,%eax
    147e:	cd 40                	int    $0x40
    1480:	c3                   	ret    

00001481 <munprotect>:
SYSCALL(munprotect)
    1481:	b8 17 00 00 00       	mov    $0x17,%eax
    1486:	cd 40                	int    $0x40
    1488:	c3                   	ret    

00001489 <clone>:
SYSCALL(clone)
    1489:	b8 18 00 00 00       	mov    $0x18,%eax
    148e:	cd 40                	int    $0x40
    1490:	c3                   	ret    

00001491 <join>:
SYSCALL(join)
    1491:	b8 19 00 00 00       	mov    $0x19,%eax
    1496:	cd 40                	int    $0x40
    1498:	c3                   	ret    
    1499:	66 90                	xchg   %ax,%ax
    149b:	66 90                	xchg   %ax,%ax
    149d:	66 90                	xchg   %ax,%ax
    149f:	90                   	nop

000014a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    14a0:	55                   	push   %ebp
    14a1:	89 e5                	mov    %esp,%ebp
    14a3:	57                   	push   %edi
    14a4:	56                   	push   %esi
    14a5:	53                   	push   %ebx
    14a6:	83 ec 3c             	sub    $0x3c,%esp
    14a9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    14ac:	89 d1                	mov    %edx,%ecx
{
    14ae:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    14b1:	85 d2                	test   %edx,%edx
    14b3:	0f 89 7f 00 00 00    	jns    1538 <printint+0x98>
    14b9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    14bd:	74 79                	je     1538 <printint+0x98>
    neg = 1;
    14bf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    14c6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    14c8:	31 db                	xor    %ebx,%ebx
    14ca:	8d 75 d7             	lea    -0x29(%ebp),%esi
    14cd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    14d0:	89 c8                	mov    %ecx,%eax
    14d2:	31 d2                	xor    %edx,%edx
    14d4:	89 cf                	mov    %ecx,%edi
    14d6:	f7 75 c4             	divl   -0x3c(%ebp)
    14d9:	0f b6 92 f8 18 00 00 	movzbl 0x18f8(%edx),%edx
    14e0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    14e3:	89 d8                	mov    %ebx,%eax
    14e5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    14e8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    14eb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    14ee:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    14f1:	76 dd                	jbe    14d0 <printint+0x30>
  if(neg)
    14f3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    14f6:	85 c9                	test   %ecx,%ecx
    14f8:	74 0c                	je     1506 <printint+0x66>
    buf[i++] = '-';
    14fa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    14ff:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1501:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1506:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1509:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    150d:	eb 07                	jmp    1516 <printint+0x76>
    150f:	90                   	nop
    putc(fd, buf[i]);
    1510:	0f b6 13             	movzbl (%ebx),%edx
    1513:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1516:	83 ec 04             	sub    $0x4,%esp
    1519:	88 55 d7             	mov    %dl,-0x29(%ebp)
    151c:	6a 01                	push   $0x1
    151e:	56                   	push   %esi
    151f:	57                   	push   %edi
    1520:	e8 d4 fe ff ff       	call   13f9 <write>
  while(--i >= 0)
    1525:	83 c4 10             	add    $0x10,%esp
    1528:	39 de                	cmp    %ebx,%esi
    152a:	75 e4                	jne    1510 <printint+0x70>
}
    152c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    152f:	5b                   	pop    %ebx
    1530:	5e                   	pop    %esi
    1531:	5f                   	pop    %edi
    1532:	5d                   	pop    %ebp
    1533:	c3                   	ret    
    1534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1538:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    153f:	eb 87                	jmp    14c8 <printint+0x28>
    1541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    154f:	90                   	nop

00001550 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1550:	55                   	push   %ebp
    1551:	89 e5                	mov    %esp,%ebp
    1553:	57                   	push   %edi
    1554:	56                   	push   %esi
    1555:	53                   	push   %ebx
    1556:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1559:	8b 75 0c             	mov    0xc(%ebp),%esi
    155c:	0f b6 1e             	movzbl (%esi),%ebx
    155f:	84 db                	test   %bl,%bl
    1561:	0f 84 b8 00 00 00    	je     161f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    1567:	8d 45 10             	lea    0x10(%ebp),%eax
    156a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    156d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    1570:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    1572:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1575:	eb 37                	jmp    15ae <printf+0x5e>
    1577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    157e:	66 90                	xchg   %ax,%ax
    1580:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    1583:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1588:	83 f8 25             	cmp    $0x25,%eax
    158b:	74 17                	je     15a4 <printf+0x54>
  write(fd, &c, 1);
    158d:	83 ec 04             	sub    $0x4,%esp
    1590:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1593:	6a 01                	push   $0x1
    1595:	57                   	push   %edi
    1596:	ff 75 08             	pushl  0x8(%ebp)
    1599:	e8 5b fe ff ff       	call   13f9 <write>
    159e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    15a1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    15a4:	0f b6 1e             	movzbl (%esi),%ebx
    15a7:	83 c6 01             	add    $0x1,%esi
    15aa:	84 db                	test   %bl,%bl
    15ac:	74 71                	je     161f <printf+0xcf>
    c = fmt[i] & 0xff;
    15ae:	0f be cb             	movsbl %bl,%ecx
    15b1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    15b4:	85 d2                	test   %edx,%edx
    15b6:	74 c8                	je     1580 <printf+0x30>
      }
    } else if(state == '%'){
    15b8:	83 fa 25             	cmp    $0x25,%edx
    15bb:	75 e7                	jne    15a4 <printf+0x54>
      if(c == 'd'){
    15bd:	83 f8 64             	cmp    $0x64,%eax
    15c0:	0f 84 9a 00 00 00    	je     1660 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    15c6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    15cc:	83 f9 70             	cmp    $0x70,%ecx
    15cf:	74 5f                	je     1630 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    15d1:	83 f8 73             	cmp    $0x73,%eax
    15d4:	0f 84 d6 00 00 00    	je     16b0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15da:	83 f8 63             	cmp    $0x63,%eax
    15dd:	0f 84 8d 00 00 00    	je     1670 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    15e3:	83 f8 25             	cmp    $0x25,%eax
    15e6:	0f 84 b4 00 00 00    	je     16a0 <printf+0x150>
  write(fd, &c, 1);
    15ec:	83 ec 04             	sub    $0x4,%esp
    15ef:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    15f3:	6a 01                	push   $0x1
    15f5:	57                   	push   %edi
    15f6:	ff 75 08             	pushl  0x8(%ebp)
    15f9:	e8 fb fd ff ff       	call   13f9 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    15fe:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1601:	83 c4 0c             	add    $0xc,%esp
    1604:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1606:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1609:	57                   	push   %edi
    160a:	ff 75 08             	pushl  0x8(%ebp)
    160d:	e8 e7 fd ff ff       	call   13f9 <write>
  for(i = 0; fmt[i]; i++){
    1612:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    1616:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1619:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    161b:	84 db                	test   %bl,%bl
    161d:	75 8f                	jne    15ae <printf+0x5e>
    }
  }
}
    161f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1622:	5b                   	pop    %ebx
    1623:	5e                   	pop    %esi
    1624:	5f                   	pop    %edi
    1625:	5d                   	pop    %ebp
    1626:	c3                   	ret    
    1627:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    162e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    1630:	83 ec 0c             	sub    $0xc,%esp
    1633:	b9 10 00 00 00       	mov    $0x10,%ecx
    1638:	6a 00                	push   $0x0
    163a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    163d:	8b 45 08             	mov    0x8(%ebp),%eax
    1640:	8b 13                	mov    (%ebx),%edx
    1642:	e8 59 fe ff ff       	call   14a0 <printint>
        ap++;
    1647:	89 d8                	mov    %ebx,%eax
    1649:	83 c4 10             	add    $0x10,%esp
      state = 0;
    164c:	31 d2                	xor    %edx,%edx
        ap++;
    164e:	83 c0 04             	add    $0x4,%eax
    1651:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1654:	e9 4b ff ff ff       	jmp    15a4 <printf+0x54>
    1659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    1660:	83 ec 0c             	sub    $0xc,%esp
    1663:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1668:	6a 01                	push   $0x1
    166a:	eb ce                	jmp    163a <printf+0xea>
    166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1670:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1673:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1676:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    1678:	6a 01                	push   $0x1
        ap++;
    167a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    167d:	57                   	push   %edi
    167e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    1681:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1684:	e8 70 fd ff ff       	call   13f9 <write>
        ap++;
    1689:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    168c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    168f:	31 d2                	xor    %edx,%edx
    1691:	e9 0e ff ff ff       	jmp    15a4 <printf+0x54>
    1696:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    169d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    16a0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    16a3:	83 ec 04             	sub    $0x4,%esp
    16a6:	e9 59 ff ff ff       	jmp    1604 <printf+0xb4>
    16ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    16af:	90                   	nop
        s = (char*)*ap;
    16b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    16b3:	8b 18                	mov    (%eax),%ebx
        ap++;
    16b5:	83 c0 04             	add    $0x4,%eax
    16b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    16bb:	85 db                	test   %ebx,%ebx
    16bd:	74 17                	je     16d6 <printf+0x186>
        while(*s != 0){
    16bf:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    16c2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    16c4:	84 c0                	test   %al,%al
    16c6:	0f 84 d8 fe ff ff    	je     15a4 <printf+0x54>
    16cc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    16cf:	89 de                	mov    %ebx,%esi
    16d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16d4:	eb 1a                	jmp    16f0 <printf+0x1a0>
          s = "(null)";
    16d6:	bb f0 18 00 00       	mov    $0x18f0,%ebx
        while(*s != 0){
    16db:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    16de:	b8 28 00 00 00       	mov    $0x28,%eax
    16e3:	89 de                	mov    %ebx,%esi
    16e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    16ef:	90                   	nop
  write(fd, &c, 1);
    16f0:	83 ec 04             	sub    $0x4,%esp
          s++;
    16f3:	83 c6 01             	add    $0x1,%esi
    16f6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    16f9:	6a 01                	push   $0x1
    16fb:	57                   	push   %edi
    16fc:	53                   	push   %ebx
    16fd:	e8 f7 fc ff ff       	call   13f9 <write>
        while(*s != 0){
    1702:	0f b6 06             	movzbl (%esi),%eax
    1705:	83 c4 10             	add    $0x10,%esp
    1708:	84 c0                	test   %al,%al
    170a:	75 e4                	jne    16f0 <printf+0x1a0>
      state = 0;
    170c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    170f:	31 d2                	xor    %edx,%edx
    1711:	e9 8e fe ff ff       	jmp    15a4 <printf+0x54>
    1716:	66 90                	xchg   %ax,%ax
    1718:	66 90                	xchg   %ax,%ax
    171a:	66 90                	xchg   %ax,%ax
    171c:	66 90                	xchg   %ax,%ax
    171e:	66 90                	xchg   %ax,%ax

00001720 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1720:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1721:	a1 40 1e 00 00       	mov    0x1e40,%eax
{
    1726:	89 e5                	mov    %esp,%ebp
    1728:	57                   	push   %edi
    1729:	56                   	push   %esi
    172a:	53                   	push   %ebx
    172b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    172e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1738:	89 c2                	mov    %eax,%edx
    173a:	8b 00                	mov    (%eax),%eax
    173c:	39 ca                	cmp    %ecx,%edx
    173e:	73 30                	jae    1770 <free+0x50>
    1740:	39 c1                	cmp    %eax,%ecx
    1742:	72 04                	jb     1748 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1744:	39 c2                	cmp    %eax,%edx
    1746:	72 f0                	jb     1738 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1748:	8b 73 fc             	mov    -0x4(%ebx),%esi
    174b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    174e:	39 f8                	cmp    %edi,%eax
    1750:	74 30                	je     1782 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1752:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    1755:	8b 42 04             	mov    0x4(%edx),%eax
    1758:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    175b:	39 f1                	cmp    %esi,%ecx
    175d:	74 3a                	je     1799 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    175f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    1761:	5b                   	pop    %ebx
  freep = p;
    1762:	89 15 40 1e 00 00    	mov    %edx,0x1e40
}
    1768:	5e                   	pop    %esi
    1769:	5f                   	pop    %edi
    176a:	5d                   	pop    %ebp
    176b:	c3                   	ret    
    176c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1770:	39 c2                	cmp    %eax,%edx
    1772:	72 c4                	jb     1738 <free+0x18>
    1774:	39 c1                	cmp    %eax,%ecx
    1776:	73 c0                	jae    1738 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1778:	8b 73 fc             	mov    -0x4(%ebx),%esi
    177b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    177e:	39 f8                	cmp    %edi,%eax
    1780:	75 d0                	jne    1752 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    1782:	03 70 04             	add    0x4(%eax),%esi
    1785:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1788:	8b 02                	mov    (%edx),%eax
    178a:	8b 00                	mov    (%eax),%eax
    178c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    178f:	8b 42 04             	mov    0x4(%edx),%eax
    1792:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1795:	39 f1                	cmp    %esi,%ecx
    1797:	75 c6                	jne    175f <free+0x3f>
    p->s.size += bp->s.size;
    1799:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    179c:	89 15 40 1e 00 00    	mov    %edx,0x1e40
    p->s.size += bp->s.size;
    17a2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    17a5:	8b 43 f8             	mov    -0x8(%ebx),%eax
    17a8:	89 02                	mov    %eax,(%edx)
}
    17aa:	5b                   	pop    %ebx
    17ab:	5e                   	pop    %esi
    17ac:	5f                   	pop    %edi
    17ad:	5d                   	pop    %ebp
    17ae:	c3                   	ret    
    17af:	90                   	nop

000017b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    17b0:	55                   	push   %ebp
    17b1:	89 e5                	mov    %esp,%ebp
    17b3:	57                   	push   %edi
    17b4:	56                   	push   %esi
    17b5:	53                   	push   %ebx
    17b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    17bc:	8b 3d 40 1e 00 00    	mov    0x1e40,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17c2:	8d 70 07             	lea    0x7(%eax),%esi
    17c5:	c1 ee 03             	shr    $0x3,%esi
    17c8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    17cb:	85 ff                	test   %edi,%edi
    17cd:	0f 84 ad 00 00 00    	je     1880 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17d3:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    17d5:	8b 48 04             	mov    0x4(%eax),%ecx
    17d8:	39 f1                	cmp    %esi,%ecx
    17da:	73 71                	jae    184d <malloc+0x9d>
    17dc:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    17e2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    17e7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    17ea:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    17f1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    17f4:	eb 1b                	jmp    1811 <malloc+0x61>
    17f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1800:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1802:	8b 4a 04             	mov    0x4(%edx),%ecx
    1805:	39 f1                	cmp    %esi,%ecx
    1807:	73 4f                	jae    1858 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1809:	8b 3d 40 1e 00 00    	mov    0x1e40,%edi
    180f:	89 d0                	mov    %edx,%eax
    1811:	39 c7                	cmp    %eax,%edi
    1813:	75 eb                	jne    1800 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1815:	83 ec 0c             	sub    $0xc,%esp
    1818:	ff 75 e4             	pushl  -0x1c(%ebp)
    181b:	e8 41 fc ff ff       	call   1461 <sbrk>
  if(p == (char*)-1)
    1820:	83 c4 10             	add    $0x10,%esp
    1823:	83 f8 ff             	cmp    $0xffffffff,%eax
    1826:	74 1b                	je     1843 <malloc+0x93>
  hp->s.size = nu;
    1828:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    182b:	83 ec 0c             	sub    $0xc,%esp
    182e:	83 c0 08             	add    $0x8,%eax
    1831:	50                   	push   %eax
    1832:	e8 e9 fe ff ff       	call   1720 <free>
  return freep;
    1837:	a1 40 1e 00 00       	mov    0x1e40,%eax
      if((p = morecore(nunits)) == 0)
    183c:	83 c4 10             	add    $0x10,%esp
    183f:	85 c0                	test   %eax,%eax
    1841:	75 bd                	jne    1800 <malloc+0x50>
        return 0;
  }
}
    1843:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1846:	31 c0                	xor    %eax,%eax
}
    1848:	5b                   	pop    %ebx
    1849:	5e                   	pop    %esi
    184a:	5f                   	pop    %edi
    184b:	5d                   	pop    %ebp
    184c:	c3                   	ret    
    if(p->s.size >= nunits){
    184d:	89 c2                	mov    %eax,%edx
    184f:	89 f8                	mov    %edi,%eax
    1851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1858:	39 ce                	cmp    %ecx,%esi
    185a:	74 54                	je     18b0 <malloc+0x100>
        p->s.size -= nunits;
    185c:	29 f1                	sub    %esi,%ecx
    185e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    1861:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    1864:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    1867:	a3 40 1e 00 00       	mov    %eax,0x1e40
}
    186c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    186f:	8d 42 08             	lea    0x8(%edx),%eax
}
    1872:	5b                   	pop    %ebx
    1873:	5e                   	pop    %esi
    1874:	5f                   	pop    %edi
    1875:	5d                   	pop    %ebp
    1876:	c3                   	ret    
    1877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    187e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    1880:	c7 05 40 1e 00 00 44 	movl   $0x1e44,0x1e40
    1887:	1e 00 00 
    base.s.size = 0;
    188a:	bf 44 1e 00 00       	mov    $0x1e44,%edi
    base.s.ptr = freep = prevp = &base;
    188f:	c7 05 44 1e 00 00 44 	movl   $0x1e44,0x1e44
    1896:	1e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1899:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    189b:	c7 05 48 1e 00 00 00 	movl   $0x0,0x1e48
    18a2:	00 00 00 
    if(p->s.size >= nunits){
    18a5:	e9 32 ff ff ff       	jmp    17dc <malloc+0x2c>
    18aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    18b0:	8b 0a                	mov    (%edx),%ecx
    18b2:	89 08                	mov    %ecx,(%eax)
    18b4:	eb b1                	jmp    1867 <malloc+0xb7>
