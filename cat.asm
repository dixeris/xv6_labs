
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
    106c:	68 fb 18 00 00       	push   $0x18fb
    1071:	6a 01                	push   $0x1
    1073:	e8 f8 04 00 00       	call   1570 <printf>
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
    10a4:	68 60 1c 00 00       	push   $0x1c60
    10a9:	6a 01                	push   $0x1
    10ab:	e8 49 03 00 00       	call   13f9 <write>
    10b0:	83 c4 10             	add    $0x10,%esp
    10b3:	39 d8                	cmp    %ebx,%eax
    10b5:	75 25                	jne    10dc <cat+0x4c>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    10b7:	83 ec 04             	sub    $0x4,%esp
    10ba:	68 00 02 00 00       	push   $0x200
    10bf:	68 60 1c 00 00       	push   $0x1c60
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
    10df:	68 d8 18 00 00       	push   $0x18d8
    10e4:	6a 01                	push   $0x1
    10e6:	e8 85 04 00 00       	call   1570 <printf>
      exit();
    10eb:	e8 e9 02 00 00       	call   13d9 <exit>
    printf(1, "cat: read error\n");
    10f0:	50                   	push   %eax
    10f1:	50                   	push   %eax
    10f2:	68 ea 18 00 00       	push   $0x18ea
    10f7:	6a 01                	push   $0x1
    10f9:	e8 72 04 00 00       	call   1570 <printf>
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
    136c:	e8 5f 04 00 00       	call   17d0 <malloc>
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
    13a7:	e8 94 03 00 00       	call   1740 <free>
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

00001499 <getNumProc>:
SYSCALL(getNumProc)
    1499:	b8 1a 00 00 00       	mov    $0x1a,%eax
    149e:	cd 40                	int    $0x40
    14a0:	c3                   	ret    

000014a1 <getMaxPid>:
SYSCALL(getMaxPid)
    14a1:	b8 1b 00 00 00       	mov    $0x1b,%eax
    14a6:	cd 40                	int    $0x40
    14a8:	c3                   	ret    

000014a9 <getProcInfo>:
SYSCALL(getProcInfo)
    14a9:	b8 1c 00 00 00       	mov    $0x1c,%eax
    14ae:	cd 40                	int    $0x40
    14b0:	c3                   	ret    
    14b1:	66 90                	xchg   %ax,%ax
    14b3:	66 90                	xchg   %ax,%ax
    14b5:	66 90                	xchg   %ax,%ax
    14b7:	66 90                	xchg   %ax,%ax
    14b9:	66 90                	xchg   %ax,%ax
    14bb:	66 90                	xchg   %ax,%ax
    14bd:	66 90                	xchg   %ax,%ax
    14bf:	90                   	nop

000014c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    14c0:	55                   	push   %ebp
    14c1:	89 e5                	mov    %esp,%ebp
    14c3:	57                   	push   %edi
    14c4:	56                   	push   %esi
    14c5:	53                   	push   %ebx
    14c6:	83 ec 3c             	sub    $0x3c,%esp
    14c9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    14cc:	89 d1                	mov    %edx,%ecx
{
    14ce:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    14d1:	85 d2                	test   %edx,%edx
    14d3:	0f 89 7f 00 00 00    	jns    1558 <printint+0x98>
    14d9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    14dd:	74 79                	je     1558 <printint+0x98>
    neg = 1;
    14df:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    14e6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    14e8:	31 db                	xor    %ebx,%ebx
    14ea:	8d 75 d7             	lea    -0x29(%ebp),%esi
    14ed:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    14f0:	89 c8                	mov    %ecx,%eax
    14f2:	31 d2                	xor    %edx,%edx
    14f4:	89 cf                	mov    %ecx,%edi
    14f6:	f7 75 c4             	divl   -0x3c(%ebp)
    14f9:	0f b6 92 18 19 00 00 	movzbl 0x1918(%edx),%edx
    1500:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1503:	89 d8                	mov    %ebx,%eax
    1505:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1508:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    150b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    150e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1511:	76 dd                	jbe    14f0 <printint+0x30>
  if(neg)
    1513:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1516:	85 c9                	test   %ecx,%ecx
    1518:	74 0c                	je     1526 <printint+0x66>
    buf[i++] = '-';
    151a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    151f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1521:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1526:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1529:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    152d:	eb 07                	jmp    1536 <printint+0x76>
    152f:	90                   	nop
    putc(fd, buf[i]);
    1530:	0f b6 13             	movzbl (%ebx),%edx
    1533:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1536:	83 ec 04             	sub    $0x4,%esp
    1539:	88 55 d7             	mov    %dl,-0x29(%ebp)
    153c:	6a 01                	push   $0x1
    153e:	56                   	push   %esi
    153f:	57                   	push   %edi
    1540:	e8 b4 fe ff ff       	call   13f9 <write>
  while(--i >= 0)
    1545:	83 c4 10             	add    $0x10,%esp
    1548:	39 de                	cmp    %ebx,%esi
    154a:	75 e4                	jne    1530 <printint+0x70>
}
    154c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    154f:	5b                   	pop    %ebx
    1550:	5e                   	pop    %esi
    1551:	5f                   	pop    %edi
    1552:	5d                   	pop    %ebp
    1553:	c3                   	ret    
    1554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1558:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    155f:	eb 87                	jmp    14e8 <printint+0x28>
    1561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1568:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    156f:	90                   	nop

00001570 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1570:	55                   	push   %ebp
    1571:	89 e5                	mov    %esp,%ebp
    1573:	57                   	push   %edi
    1574:	56                   	push   %esi
    1575:	53                   	push   %ebx
    1576:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1579:	8b 75 0c             	mov    0xc(%ebp),%esi
    157c:	0f b6 1e             	movzbl (%esi),%ebx
    157f:	84 db                	test   %bl,%bl
    1581:	0f 84 b8 00 00 00    	je     163f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    1587:	8d 45 10             	lea    0x10(%ebp),%eax
    158a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    158d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    1590:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    1592:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1595:	eb 37                	jmp    15ce <printf+0x5e>
    1597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    159e:	66 90                	xchg   %ax,%ax
    15a0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    15a3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    15a8:	83 f8 25             	cmp    $0x25,%eax
    15ab:	74 17                	je     15c4 <printf+0x54>
  write(fd, &c, 1);
    15ad:	83 ec 04             	sub    $0x4,%esp
    15b0:	88 5d e7             	mov    %bl,-0x19(%ebp)
    15b3:	6a 01                	push   $0x1
    15b5:	57                   	push   %edi
    15b6:	ff 75 08             	pushl  0x8(%ebp)
    15b9:	e8 3b fe ff ff       	call   13f9 <write>
    15be:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    15c1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    15c4:	0f b6 1e             	movzbl (%esi),%ebx
    15c7:	83 c6 01             	add    $0x1,%esi
    15ca:	84 db                	test   %bl,%bl
    15cc:	74 71                	je     163f <printf+0xcf>
    c = fmt[i] & 0xff;
    15ce:	0f be cb             	movsbl %bl,%ecx
    15d1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    15d4:	85 d2                	test   %edx,%edx
    15d6:	74 c8                	je     15a0 <printf+0x30>
      }
    } else if(state == '%'){
    15d8:	83 fa 25             	cmp    $0x25,%edx
    15db:	75 e7                	jne    15c4 <printf+0x54>
      if(c == 'd'){
    15dd:	83 f8 64             	cmp    $0x64,%eax
    15e0:	0f 84 9a 00 00 00    	je     1680 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    15e6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    15ec:	83 f9 70             	cmp    $0x70,%ecx
    15ef:	74 5f                	je     1650 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    15f1:	83 f8 73             	cmp    $0x73,%eax
    15f4:	0f 84 d6 00 00 00    	je     16d0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15fa:	83 f8 63             	cmp    $0x63,%eax
    15fd:	0f 84 8d 00 00 00    	je     1690 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1603:	83 f8 25             	cmp    $0x25,%eax
    1606:	0f 84 b4 00 00 00    	je     16c0 <printf+0x150>
  write(fd, &c, 1);
    160c:	83 ec 04             	sub    $0x4,%esp
    160f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1613:	6a 01                	push   $0x1
    1615:	57                   	push   %edi
    1616:	ff 75 08             	pushl  0x8(%ebp)
    1619:	e8 db fd ff ff       	call   13f9 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    161e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1621:	83 c4 0c             	add    $0xc,%esp
    1624:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1626:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1629:	57                   	push   %edi
    162a:	ff 75 08             	pushl  0x8(%ebp)
    162d:	e8 c7 fd ff ff       	call   13f9 <write>
  for(i = 0; fmt[i]; i++){
    1632:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    1636:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1639:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    163b:	84 db                	test   %bl,%bl
    163d:	75 8f                	jne    15ce <printf+0x5e>
    }
  }
}
    163f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1642:	5b                   	pop    %ebx
    1643:	5e                   	pop    %esi
    1644:	5f                   	pop    %edi
    1645:	5d                   	pop    %ebp
    1646:	c3                   	ret    
    1647:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    164e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    1650:	83 ec 0c             	sub    $0xc,%esp
    1653:	b9 10 00 00 00       	mov    $0x10,%ecx
    1658:	6a 00                	push   $0x0
    165a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    165d:	8b 45 08             	mov    0x8(%ebp),%eax
    1660:	8b 13                	mov    (%ebx),%edx
    1662:	e8 59 fe ff ff       	call   14c0 <printint>
        ap++;
    1667:	89 d8                	mov    %ebx,%eax
    1669:	83 c4 10             	add    $0x10,%esp
      state = 0;
    166c:	31 d2                	xor    %edx,%edx
        ap++;
    166e:	83 c0 04             	add    $0x4,%eax
    1671:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1674:	e9 4b ff ff ff       	jmp    15c4 <printf+0x54>
    1679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    1680:	83 ec 0c             	sub    $0xc,%esp
    1683:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1688:	6a 01                	push   $0x1
    168a:	eb ce                	jmp    165a <printf+0xea>
    168c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1690:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1693:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1696:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    1698:	6a 01                	push   $0x1
        ap++;
    169a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    169d:	57                   	push   %edi
    169e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    16a1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    16a4:	e8 50 fd ff ff       	call   13f9 <write>
        ap++;
    16a9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    16ac:	83 c4 10             	add    $0x10,%esp
      state = 0;
    16af:	31 d2                	xor    %edx,%edx
    16b1:	e9 0e ff ff ff       	jmp    15c4 <printf+0x54>
    16b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    16bd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    16c0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    16c3:	83 ec 04             	sub    $0x4,%esp
    16c6:	e9 59 ff ff ff       	jmp    1624 <printf+0xb4>
    16cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    16cf:	90                   	nop
        s = (char*)*ap;
    16d0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    16d3:	8b 18                	mov    (%eax),%ebx
        ap++;
    16d5:	83 c0 04             	add    $0x4,%eax
    16d8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    16db:	85 db                	test   %ebx,%ebx
    16dd:	74 17                	je     16f6 <printf+0x186>
        while(*s != 0){
    16df:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    16e2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    16e4:	84 c0                	test   %al,%al
    16e6:	0f 84 d8 fe ff ff    	je     15c4 <printf+0x54>
    16ec:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    16ef:	89 de                	mov    %ebx,%esi
    16f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16f4:	eb 1a                	jmp    1710 <printf+0x1a0>
          s = "(null)";
    16f6:	bb 10 19 00 00       	mov    $0x1910,%ebx
        while(*s != 0){
    16fb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    16fe:	b8 28 00 00 00       	mov    $0x28,%eax
    1703:	89 de                	mov    %ebx,%esi
    1705:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1708:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    170f:	90                   	nop
  write(fd, &c, 1);
    1710:	83 ec 04             	sub    $0x4,%esp
          s++;
    1713:	83 c6 01             	add    $0x1,%esi
    1716:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1719:	6a 01                	push   $0x1
    171b:	57                   	push   %edi
    171c:	53                   	push   %ebx
    171d:	e8 d7 fc ff ff       	call   13f9 <write>
        while(*s != 0){
    1722:	0f b6 06             	movzbl (%esi),%eax
    1725:	83 c4 10             	add    $0x10,%esp
    1728:	84 c0                	test   %al,%al
    172a:	75 e4                	jne    1710 <printf+0x1a0>
      state = 0;
    172c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    172f:	31 d2                	xor    %edx,%edx
    1731:	e9 8e fe ff ff       	jmp    15c4 <printf+0x54>
    1736:	66 90                	xchg   %ax,%ax
    1738:	66 90                	xchg   %ax,%ax
    173a:	66 90                	xchg   %ax,%ax
    173c:	66 90                	xchg   %ax,%ax
    173e:	66 90                	xchg   %ax,%ax

00001740 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1740:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1741:	a1 60 1e 00 00       	mov    0x1e60,%eax
{
    1746:	89 e5                	mov    %esp,%ebp
    1748:	57                   	push   %edi
    1749:	56                   	push   %esi
    174a:	53                   	push   %ebx
    174b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    174e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1758:	89 c2                	mov    %eax,%edx
    175a:	8b 00                	mov    (%eax),%eax
    175c:	39 ca                	cmp    %ecx,%edx
    175e:	73 30                	jae    1790 <free+0x50>
    1760:	39 c1                	cmp    %eax,%ecx
    1762:	72 04                	jb     1768 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1764:	39 c2                	cmp    %eax,%edx
    1766:	72 f0                	jb     1758 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1768:	8b 73 fc             	mov    -0x4(%ebx),%esi
    176b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    176e:	39 f8                	cmp    %edi,%eax
    1770:	74 30                	je     17a2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1772:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    1775:	8b 42 04             	mov    0x4(%edx),%eax
    1778:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    177b:	39 f1                	cmp    %esi,%ecx
    177d:	74 3a                	je     17b9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    177f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    1781:	5b                   	pop    %ebx
  freep = p;
    1782:	89 15 60 1e 00 00    	mov    %edx,0x1e60
}
    1788:	5e                   	pop    %esi
    1789:	5f                   	pop    %edi
    178a:	5d                   	pop    %ebp
    178b:	c3                   	ret    
    178c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1790:	39 c2                	cmp    %eax,%edx
    1792:	72 c4                	jb     1758 <free+0x18>
    1794:	39 c1                	cmp    %eax,%ecx
    1796:	73 c0                	jae    1758 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1798:	8b 73 fc             	mov    -0x4(%ebx),%esi
    179b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    179e:	39 f8                	cmp    %edi,%eax
    17a0:	75 d0                	jne    1772 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    17a2:	03 70 04             	add    0x4(%eax),%esi
    17a5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    17a8:	8b 02                	mov    (%edx),%eax
    17aa:	8b 00                	mov    (%eax),%eax
    17ac:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    17af:	8b 42 04             	mov    0x4(%edx),%eax
    17b2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    17b5:	39 f1                	cmp    %esi,%ecx
    17b7:	75 c6                	jne    177f <free+0x3f>
    p->s.size += bp->s.size;
    17b9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    17bc:	89 15 60 1e 00 00    	mov    %edx,0x1e60
    p->s.size += bp->s.size;
    17c2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    17c5:	8b 43 f8             	mov    -0x8(%ebx),%eax
    17c8:	89 02                	mov    %eax,(%edx)
}
    17ca:	5b                   	pop    %ebx
    17cb:	5e                   	pop    %esi
    17cc:	5f                   	pop    %edi
    17cd:	5d                   	pop    %ebp
    17ce:	c3                   	ret    
    17cf:	90                   	nop

000017d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    17d0:	55                   	push   %ebp
    17d1:	89 e5                	mov    %esp,%ebp
    17d3:	57                   	push   %edi
    17d4:	56                   	push   %esi
    17d5:	53                   	push   %ebx
    17d6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    17dc:	8b 3d 60 1e 00 00    	mov    0x1e60,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17e2:	8d 70 07             	lea    0x7(%eax),%esi
    17e5:	c1 ee 03             	shr    $0x3,%esi
    17e8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    17eb:	85 ff                	test   %edi,%edi
    17ed:	0f 84 ad 00 00 00    	je     18a0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17f3:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    17f5:	8b 48 04             	mov    0x4(%eax),%ecx
    17f8:	39 f1                	cmp    %esi,%ecx
    17fa:	73 71                	jae    186d <malloc+0x9d>
    17fc:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1802:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1807:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    180a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1811:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1814:	eb 1b                	jmp    1831 <malloc+0x61>
    1816:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    181d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1820:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1822:	8b 4a 04             	mov    0x4(%edx),%ecx
    1825:	39 f1                	cmp    %esi,%ecx
    1827:	73 4f                	jae    1878 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1829:	8b 3d 60 1e 00 00    	mov    0x1e60,%edi
    182f:	89 d0                	mov    %edx,%eax
    1831:	39 c7                	cmp    %eax,%edi
    1833:	75 eb                	jne    1820 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1835:	83 ec 0c             	sub    $0xc,%esp
    1838:	ff 75 e4             	pushl  -0x1c(%ebp)
    183b:	e8 21 fc ff ff       	call   1461 <sbrk>
  if(p == (char*)-1)
    1840:	83 c4 10             	add    $0x10,%esp
    1843:	83 f8 ff             	cmp    $0xffffffff,%eax
    1846:	74 1b                	je     1863 <malloc+0x93>
  hp->s.size = nu;
    1848:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    184b:	83 ec 0c             	sub    $0xc,%esp
    184e:	83 c0 08             	add    $0x8,%eax
    1851:	50                   	push   %eax
    1852:	e8 e9 fe ff ff       	call   1740 <free>
  return freep;
    1857:	a1 60 1e 00 00       	mov    0x1e60,%eax
      if((p = morecore(nunits)) == 0)
    185c:	83 c4 10             	add    $0x10,%esp
    185f:	85 c0                	test   %eax,%eax
    1861:	75 bd                	jne    1820 <malloc+0x50>
        return 0;
  }
}
    1863:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1866:	31 c0                	xor    %eax,%eax
}
    1868:	5b                   	pop    %ebx
    1869:	5e                   	pop    %esi
    186a:	5f                   	pop    %edi
    186b:	5d                   	pop    %ebp
    186c:	c3                   	ret    
    if(p->s.size >= nunits){
    186d:	89 c2                	mov    %eax,%edx
    186f:	89 f8                	mov    %edi,%eax
    1871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1878:	39 ce                	cmp    %ecx,%esi
    187a:	74 54                	je     18d0 <malloc+0x100>
        p->s.size -= nunits;
    187c:	29 f1                	sub    %esi,%ecx
    187e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    1881:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    1884:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    1887:	a3 60 1e 00 00       	mov    %eax,0x1e60
}
    188c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    188f:	8d 42 08             	lea    0x8(%edx),%eax
}
    1892:	5b                   	pop    %ebx
    1893:	5e                   	pop    %esi
    1894:	5f                   	pop    %edi
    1895:	5d                   	pop    %ebp
    1896:	c3                   	ret    
    1897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    189e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    18a0:	c7 05 60 1e 00 00 64 	movl   $0x1e64,0x1e60
    18a7:	1e 00 00 
    base.s.size = 0;
    18aa:	bf 64 1e 00 00       	mov    $0x1e64,%edi
    base.s.ptr = freep = prevp = &base;
    18af:	c7 05 64 1e 00 00 64 	movl   $0x1e64,0x1e64
    18b6:	1e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18b9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    18bb:	c7 05 68 1e 00 00 00 	movl   $0x0,0x1e68
    18c2:	00 00 00 
    if(p->s.size >= nunits){
    18c5:	e9 32 ff ff ff       	jmp    17fc <malloc+0x2c>
    18ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    18d0:	8b 0a                	mov    (%edx),%ecx
    18d2:	89 08                	mov    %ecx,(%eax)
    18d4:	eb b1                	jmp    1887 <malloc+0xb7>
