
_wc:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
    1027:	7e 56                	jle    107f <main+0x7f>
    1029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
    1030:	83 ec 08             	sub    $0x8,%esp
    1033:	6a 00                	push   $0x0
    1035:	ff 33                	pushl  (%ebx)
    1037:	e8 4d 04 00 00       	call   1489 <open>
    103c:	83 c4 10             	add    $0x10,%esp
    103f:	89 c7                	mov    %eax,%edi
    1041:	85 c0                	test   %eax,%eax
    1043:	78 26                	js     106b <main+0x6b>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
    1045:	83 ec 08             	sub    $0x8,%esp
    1048:	ff 33                	pushl  (%ebx)
  for(i = 1; i < argc; i++){
    104a:	83 c6 01             	add    $0x1,%esi
    104d:	83 c3 04             	add    $0x4,%ebx
    wc(fd, argv[i]);
    1050:	50                   	push   %eax
    1051:	e8 4a 00 00 00       	call   10a0 <wc>
    close(fd);
    1056:	89 3c 24             	mov    %edi,(%esp)
    1059:	e8 13 04 00 00       	call   1471 <close>
  for(i = 1; i < argc; i++){
    105e:	83 c4 10             	add    $0x10,%esp
    1061:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
    1064:	75 ca                	jne    1030 <main+0x30>
  }
  exit();
    1066:	e8 de 03 00 00       	call   1449 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
    106b:	50                   	push   %eax
    106c:	ff 33                	pushl  (%ebx)
    106e:	68 6b 19 00 00       	push   $0x196b
    1073:	6a 01                	push   $0x1
    1075:	e8 66 05 00 00       	call   15e0 <printf>
      exit();
    107a:	e8 ca 03 00 00       	call   1449 <exit>
    wc(0, "");
    107f:	52                   	push   %edx
    1080:	52                   	push   %edx
    1081:	68 5d 19 00 00       	push   $0x195d
    1086:	6a 00                	push   $0x0
    1088:	e8 13 00 00 00       	call   10a0 <wc>
    exit();
    108d:	e8 b7 03 00 00       	call   1449 <exit>
    1092:	66 90                	xchg   %ax,%ax
    1094:	66 90                	xchg   %ax,%ax
    1096:	66 90                	xchg   %ax,%ax
    1098:	66 90                	xchg   %ax,%ax
    109a:	66 90                	xchg   %ax,%ax
    109c:	66 90                	xchg   %ax,%ax
    109e:	66 90                	xchg   %ax,%ax

000010a0 <wc>:
{
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	57                   	push   %edi
    10a4:	56                   	push   %esi
    10a5:	53                   	push   %ebx
  l = w = c = 0;
    10a6:	31 db                	xor    %ebx,%ebx
{
    10a8:	83 ec 1c             	sub    $0x1c,%esp
  inword = 0;
    10ab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
    10b2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    10b9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    10c0:	83 ec 04             	sub    $0x4,%esp
    10c3:	68 00 02 00 00       	push   $0x200
    10c8:	68 c0 1c 00 00       	push   $0x1cc0
    10cd:	ff 75 08             	pushl  0x8(%ebp)
    10d0:	e8 8c 03 00 00       	call   1461 <read>
    10d5:	83 c4 10             	add    $0x10,%esp
    10d8:	89 c6                	mov    %eax,%esi
    10da:	85 c0                	test   %eax,%eax
    10dc:	7e 62                	jle    1140 <wc+0xa0>
    for(i=0; i<n; i++){
    10de:	31 ff                	xor    %edi,%edi
    10e0:	eb 14                	jmp    10f6 <wc+0x56>
    10e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        inword = 0;
    10e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for(i=0; i<n; i++){
    10ef:	83 c7 01             	add    $0x1,%edi
    10f2:	39 fe                	cmp    %edi,%esi
    10f4:	74 42                	je     1138 <wc+0x98>
      if(buf[i] == '\n')
    10f6:	0f be 87 c0 1c 00 00 	movsbl 0x1cc0(%edi),%eax
        l++;
    10fd:	31 c9                	xor    %ecx,%ecx
    10ff:	3c 0a                	cmp    $0xa,%al
    1101:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
    1104:	83 ec 08             	sub    $0x8,%esp
    1107:	50                   	push   %eax
        l++;
    1108:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
    110a:	68 48 19 00 00       	push   $0x1948
    110f:	e8 3c 01 00 00       	call   1250 <strchr>
    1114:	83 c4 10             	add    $0x10,%esp
    1117:	85 c0                	test   %eax,%eax
    1119:	75 cd                	jne    10e8 <wc+0x48>
      else if(!inword){
    111b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    111e:	85 d2                	test   %edx,%edx
    1120:	75 cd                	jne    10ef <wc+0x4f>
    for(i=0; i<n; i++){
    1122:	83 c7 01             	add    $0x1,%edi
        w++;
    1125:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
        inword = 1;
    1129:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
    1130:	39 fe                	cmp    %edi,%esi
    1132:	75 c2                	jne    10f6 <wc+0x56>
    1134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      c++;
    1138:	01 75 dc             	add    %esi,-0x24(%ebp)
    113b:	eb 83                	jmp    10c0 <wc+0x20>
    113d:	8d 76 00             	lea    0x0(%esi),%esi
  if(n < 0){
    1140:	75 24                	jne    1166 <wc+0xc6>
  printf(1, "%d %d %d %s\n", l, w, c, name);
    1142:	83 ec 08             	sub    $0x8,%esp
    1145:	ff 75 0c             	pushl  0xc(%ebp)
    1148:	ff 75 dc             	pushl  -0x24(%ebp)
    114b:	ff 75 e0             	pushl  -0x20(%ebp)
    114e:	53                   	push   %ebx
    114f:	68 5e 19 00 00       	push   $0x195e
    1154:	6a 01                	push   $0x1
    1156:	e8 85 04 00 00       	call   15e0 <printf>
}
    115b:	83 c4 20             	add    $0x20,%esp
    115e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1161:	5b                   	pop    %ebx
    1162:	5e                   	pop    %esi
    1163:	5f                   	pop    %edi
    1164:	5d                   	pop    %ebp
    1165:	c3                   	ret    
    printf(1, "wc: read error\n");
    1166:	50                   	push   %eax
    1167:	50                   	push   %eax
    1168:	68 4e 19 00 00       	push   $0x194e
    116d:	6a 01                	push   $0x1
    116f:	e8 6c 04 00 00       	call   15e0 <printf>
    exit();
    1174:	e8 d0 02 00 00       	call   1449 <exit>
    1179:	66 90                	xchg   %ax,%ax
    117b:	66 90                	xchg   %ax,%ax
    117d:	66 90                	xchg   %ax,%ax
    117f:	90                   	nop

00001180 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"
char*
strcpy(char *s, const char *t)
{
    1180:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1181:	31 c0                	xor    %eax,%eax
{
    1183:	89 e5                	mov    %esp,%ebp
    1185:	53                   	push   %ebx
    1186:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1189:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    118c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    1190:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    1194:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    1197:	83 c0 01             	add    $0x1,%eax
    119a:	84 d2                	test   %dl,%dl
    119c:	75 f2                	jne    1190 <strcpy+0x10>
    ;
  return os;
}
    119e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11a1:	89 c8                	mov    %ecx,%eax
    11a3:	c9                   	leave  
    11a4:	c3                   	ret    
    11a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000011b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
    11b3:	53                   	push   %ebx
    11b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    11ba:	0f b6 01             	movzbl (%ecx),%eax
    11bd:	0f b6 1a             	movzbl (%edx),%ebx
    11c0:	84 c0                	test   %al,%al
    11c2:	75 1d                	jne    11e1 <strcmp+0x31>
    11c4:	eb 2a                	jmp    11f0 <strcmp+0x40>
    11c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11cd:	8d 76 00             	lea    0x0(%esi),%esi
    11d0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    11d4:	83 c1 01             	add    $0x1,%ecx
    11d7:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    11da:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    11dd:	84 c0                	test   %al,%al
    11df:	74 0f                	je     11f0 <strcmp+0x40>
    11e1:	38 d8                	cmp    %bl,%al
    11e3:	74 eb                	je     11d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    11e5:	29 d8                	sub    %ebx,%eax
}
    11e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11ea:	c9                   	leave  
    11eb:	c3                   	ret    
    11ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    11f2:	29 d8                	sub    %ebx,%eax
}
    11f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11f7:	c9                   	leave  
    11f8:	c3                   	ret    
    11f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001200 <strlen>:

uint
strlen(const char *s)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    1206:	80 3a 00             	cmpb   $0x0,(%edx)
    1209:	74 15                	je     1220 <strlen+0x20>
    120b:	31 c0                	xor    %eax,%eax
    120d:	8d 76 00             	lea    0x0(%esi),%esi
    1210:	83 c0 01             	add    $0x1,%eax
    1213:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    1217:	89 c1                	mov    %eax,%ecx
    1219:	75 f5                	jne    1210 <strlen+0x10>
    ;
  return n;
}
    121b:	89 c8                	mov    %ecx,%eax
    121d:	5d                   	pop    %ebp
    121e:	c3                   	ret    
    121f:	90                   	nop
  for(n = 0; s[n]; n++)
    1220:	31 c9                	xor    %ecx,%ecx
}
    1222:	5d                   	pop    %ebp
    1223:	89 c8                	mov    %ecx,%eax
    1225:	c3                   	ret    
    1226:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    122d:	8d 76 00             	lea    0x0(%esi),%esi

00001230 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	57                   	push   %edi
    1234:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1237:	8b 4d 10             	mov    0x10(%ebp),%ecx
    123a:	8b 45 0c             	mov    0xc(%ebp),%eax
    123d:	89 d7                	mov    %edx,%edi
    123f:	fc                   	cld    
    1240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1242:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1245:	89 d0                	mov    %edx,%eax
    1247:	c9                   	leave  
    1248:	c3                   	ret    
    1249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001250 <strchr>:

char*
strchr(const char *s, char c)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	8b 45 08             	mov    0x8(%ebp),%eax
    1256:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    125a:	0f b6 10             	movzbl (%eax),%edx
    125d:	84 d2                	test   %dl,%dl
    125f:	75 12                	jne    1273 <strchr+0x23>
    1261:	eb 1d                	jmp    1280 <strchr+0x30>
    1263:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1267:	90                   	nop
    1268:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    126c:	83 c0 01             	add    $0x1,%eax
    126f:	84 d2                	test   %dl,%dl
    1271:	74 0d                	je     1280 <strchr+0x30>
    if(*s == c)
    1273:	38 d1                	cmp    %dl,%cl
    1275:	75 f1                	jne    1268 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1277:	5d                   	pop    %ebp
    1278:	c3                   	ret    
    1279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    1280:	31 c0                	xor    %eax,%eax
}
    1282:	5d                   	pop    %ebp
    1283:	c3                   	ret    
    1284:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    128b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    128f:	90                   	nop

00001290 <gets>:

char*
gets(char *buf, int max)
{
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
    1293:	57                   	push   %edi
    1294:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1295:	31 f6                	xor    %esi,%esi
{
    1297:	53                   	push   %ebx
    1298:	89 f3                	mov    %esi,%ebx
    129a:	83 ec 1c             	sub    $0x1c,%esp
    129d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    12a0:	eb 2f                	jmp    12d1 <gets+0x41>
    12a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    12a8:	83 ec 04             	sub    $0x4,%esp
    12ab:	8d 45 e7             	lea    -0x19(%ebp),%eax
    12ae:	6a 01                	push   $0x1
    12b0:	50                   	push   %eax
    12b1:	6a 00                	push   $0x0
    12b3:	e8 a9 01 00 00       	call   1461 <read>
    if(cc < 1)
    12b8:	83 c4 10             	add    $0x10,%esp
    12bb:	85 c0                	test   %eax,%eax
    12bd:	7e 1c                	jle    12db <gets+0x4b>
      break;
    buf[i++] = c;
    12bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    12c3:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    12c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    12c9:	3c 0a                	cmp    $0xa,%al
    12cb:	74 23                	je     12f0 <gets+0x60>
    12cd:	3c 0d                	cmp    $0xd,%al
    12cf:	74 1f                	je     12f0 <gets+0x60>
  for(i=0; i+1 < max; ){
    12d1:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    12d4:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    12d6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    12d9:	7c cd                	jl     12a8 <gets+0x18>
    12db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    12dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    12e0:	c6 03 00             	movb   $0x0,(%ebx)
}
    12e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12e6:	5b                   	pop    %ebx
    12e7:	5e                   	pop    %esi
    12e8:	5f                   	pop    %edi
    12e9:	5d                   	pop    %ebp
    12ea:	c3                   	ret    
    12eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12ef:	90                   	nop
  buf[i] = '\0';
    12f0:	8b 75 08             	mov    0x8(%ebp),%esi
}
    12f3:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    12f6:	01 de                	add    %ebx,%esi
    12f8:	89 f3                	mov    %esi,%ebx
    12fa:	c6 03 00             	movb   $0x0,(%ebx)
}
    12fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1300:	5b                   	pop    %ebx
    1301:	5e                   	pop    %esi
    1302:	5f                   	pop    %edi
    1303:	5d                   	pop    %ebp
    1304:	c3                   	ret    
    1305:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    130c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001310 <stat>:

int
stat(const char *n, struct stat *st)
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	56                   	push   %esi
    1314:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1315:	83 ec 08             	sub    $0x8,%esp
    1318:	6a 00                	push   $0x0
    131a:	ff 75 08             	pushl  0x8(%ebp)
    131d:	e8 67 01 00 00       	call   1489 <open>
  if(fd < 0)
    1322:	83 c4 10             	add    $0x10,%esp
    1325:	85 c0                	test   %eax,%eax
    1327:	78 27                	js     1350 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1329:	83 ec 08             	sub    $0x8,%esp
    132c:	ff 75 0c             	pushl  0xc(%ebp)
    132f:	89 c3                	mov    %eax,%ebx
    1331:	50                   	push   %eax
    1332:	e8 6a 01 00 00       	call   14a1 <fstat>
  close(fd);
    1337:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    133a:	89 c6                	mov    %eax,%esi
  close(fd);
    133c:	e8 30 01 00 00       	call   1471 <close>
  return r;
    1341:	83 c4 10             	add    $0x10,%esp
}
    1344:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1347:	89 f0                	mov    %esi,%eax
    1349:	5b                   	pop    %ebx
    134a:	5e                   	pop    %esi
    134b:	5d                   	pop    %ebp
    134c:	c3                   	ret    
    134d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1350:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1355:	eb ed                	jmp    1344 <stat+0x34>
    1357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    135e:	66 90                	xchg   %ax,%ax

00001360 <atoi>:

int
atoi(const char *s)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	53                   	push   %ebx
    1364:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1367:	0f be 02             	movsbl (%edx),%eax
    136a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    136d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1370:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1375:	77 1e                	ja     1395 <atoi+0x35>
    1377:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    137e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    1380:	83 c2 01             	add    $0x1,%edx
    1383:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1386:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    138a:	0f be 02             	movsbl (%edx),%eax
    138d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1390:	80 fb 09             	cmp    $0x9,%bl
    1393:	76 eb                	jbe    1380 <atoi+0x20>
  return n;
}
    1395:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1398:	89 c8                	mov    %ecx,%eax
    139a:	c9                   	leave  
    139b:	c3                   	ret    
    139c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000013a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	57                   	push   %edi
    13a4:	8b 45 10             	mov    0x10(%ebp),%eax
    13a7:	8b 55 08             	mov    0x8(%ebp),%edx
    13aa:	56                   	push   %esi
    13ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    13ae:	85 c0                	test   %eax,%eax
    13b0:	7e 13                	jle    13c5 <memmove+0x25>
    13b2:	01 d0                	add    %edx,%eax
  dst = vdst;
    13b4:	89 d7                	mov    %edx,%edi
    13b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13bd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    13c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    13c1:	39 f8                	cmp    %edi,%eax
    13c3:	75 fb                	jne    13c0 <memmove+0x20>
  return vdst;
}
    13c5:	5e                   	pop    %esi
    13c6:	89 d0                	mov    %edx,%eax
    13c8:	5f                   	pop    %edi
    13c9:	5d                   	pop    %ebp
    13ca:	c3                   	ret    
    13cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    13cf:	90                   	nop

000013d0 <thread_create>:


int thread_create(void (*start_routine)(void*, void*), void *arg1, void *arg2) {
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	53                   	push   %ebx
    13d4:	83 ec 20             	sub    $0x20,%esp
  void *stack =  malloc(4096);
    13d7:	68 00 10 00 00       	push   $0x1000
    13dc:	e8 5f 04 00 00       	call   1840 <malloc>
  if(stack == 0)
    13e1:	83 c4 10             	add    $0x10,%esp
    13e4:	85 c0                	test   %eax,%eax
    13e6:	74 3f                	je     1427 <thread_create+0x57>
    return -1;
  int r= clone(start_routine, arg1, arg2, stack);
    13e8:	50                   	push   %eax
    13e9:	89 c3                	mov    %eax,%ebx
    13eb:	ff 75 10             	pushl  0x10(%ebp)
    13ee:	ff 75 0c             	pushl  0xc(%ebp)
    13f1:	ff 75 08             	pushl  0x8(%ebp)
    13f4:	e8 00 01 00 00       	call   14f9 <clone>
  if(r==-1) 
    13f9:	83 c4 10             	add    $0x10,%esp
    13fc:	83 f8 ff             	cmp    $0xffffffff,%eax
    13ff:	74 0f                	je     1410 <thread_create+0x40>
    free(stack);
  return r;
}
    1401:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1404:	c9                   	leave  
    1405:	c3                   	ret    
    1406:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    140d:	8d 76 00             	lea    0x0(%esi),%esi
    free(stack);
    1410:	83 ec 0c             	sub    $0xc,%esp
    1413:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1416:	53                   	push   %ebx
    1417:	e8 94 03 00 00       	call   17b0 <free>
    141c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    141f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    free(stack);
    1422:	83 c4 10             	add    $0x10,%esp
}
    1425:	c9                   	leave  
    1426:	c3                   	ret    
    return -1;
    1427:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    142c:	eb d3                	jmp    1401 <thread_create+0x31>
    142e:	66 90                	xchg   %ax,%ax

00001430 <thread_join>:


int thread_join(void) {
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	83 ec 24             	sub    $0x24,%esp
  void *stack;
  int r = join(&stack);
    1436:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1439:	50                   	push   %eax
    143a:	e8 c2 00 00 00       	call   1501 <join>
  return r;
}
    143f:	c9                   	leave  
    1440:	c3                   	ret    

00001441 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1441:	b8 01 00 00 00       	mov    $0x1,%eax
    1446:	cd 40                	int    $0x40
    1448:	c3                   	ret    

00001449 <exit>:
SYSCALL(exit)
    1449:	b8 02 00 00 00       	mov    $0x2,%eax
    144e:	cd 40                	int    $0x40
    1450:	c3                   	ret    

00001451 <wait>:
SYSCALL(wait)
    1451:	b8 03 00 00 00       	mov    $0x3,%eax
    1456:	cd 40                	int    $0x40
    1458:	c3                   	ret    

00001459 <pipe>:
SYSCALL(pipe)
    1459:	b8 04 00 00 00       	mov    $0x4,%eax
    145e:	cd 40                	int    $0x40
    1460:	c3                   	ret    

00001461 <read>:
SYSCALL(read)
    1461:	b8 05 00 00 00       	mov    $0x5,%eax
    1466:	cd 40                	int    $0x40
    1468:	c3                   	ret    

00001469 <write>:
SYSCALL(write)
    1469:	b8 10 00 00 00       	mov    $0x10,%eax
    146e:	cd 40                	int    $0x40
    1470:	c3                   	ret    

00001471 <close>:
SYSCALL(close)
    1471:	b8 15 00 00 00       	mov    $0x15,%eax
    1476:	cd 40                	int    $0x40
    1478:	c3                   	ret    

00001479 <kill>:
SYSCALL(kill)
    1479:	b8 06 00 00 00       	mov    $0x6,%eax
    147e:	cd 40                	int    $0x40
    1480:	c3                   	ret    

00001481 <exec>:
SYSCALL(exec)
    1481:	b8 07 00 00 00       	mov    $0x7,%eax
    1486:	cd 40                	int    $0x40
    1488:	c3                   	ret    

00001489 <open>:
SYSCALL(open)
    1489:	b8 0f 00 00 00       	mov    $0xf,%eax
    148e:	cd 40                	int    $0x40
    1490:	c3                   	ret    

00001491 <mknod>:
SYSCALL(mknod)
    1491:	b8 11 00 00 00       	mov    $0x11,%eax
    1496:	cd 40                	int    $0x40
    1498:	c3                   	ret    

00001499 <unlink>:
SYSCALL(unlink)
    1499:	b8 12 00 00 00       	mov    $0x12,%eax
    149e:	cd 40                	int    $0x40
    14a0:	c3                   	ret    

000014a1 <fstat>:
SYSCALL(fstat)
    14a1:	b8 08 00 00 00       	mov    $0x8,%eax
    14a6:	cd 40                	int    $0x40
    14a8:	c3                   	ret    

000014a9 <link>:
SYSCALL(link)
    14a9:	b8 13 00 00 00       	mov    $0x13,%eax
    14ae:	cd 40                	int    $0x40
    14b0:	c3                   	ret    

000014b1 <mkdir>:
SYSCALL(mkdir)
    14b1:	b8 14 00 00 00       	mov    $0x14,%eax
    14b6:	cd 40                	int    $0x40
    14b8:	c3                   	ret    

000014b9 <chdir>:
SYSCALL(chdir)
    14b9:	b8 09 00 00 00       	mov    $0x9,%eax
    14be:	cd 40                	int    $0x40
    14c0:	c3                   	ret    

000014c1 <dup>:
SYSCALL(dup)
    14c1:	b8 0a 00 00 00       	mov    $0xa,%eax
    14c6:	cd 40                	int    $0x40
    14c8:	c3                   	ret    

000014c9 <getpid>:
SYSCALL(getpid)
    14c9:	b8 0b 00 00 00       	mov    $0xb,%eax
    14ce:	cd 40                	int    $0x40
    14d0:	c3                   	ret    

000014d1 <sbrk>:
SYSCALL(sbrk)
    14d1:	b8 0c 00 00 00       	mov    $0xc,%eax
    14d6:	cd 40                	int    $0x40
    14d8:	c3                   	ret    

000014d9 <sleep>:
SYSCALL(sleep)
    14d9:	b8 0d 00 00 00       	mov    $0xd,%eax
    14de:	cd 40                	int    $0x40
    14e0:	c3                   	ret    

000014e1 <uptime>:
SYSCALL(uptime)
    14e1:	b8 0e 00 00 00       	mov    $0xe,%eax
    14e6:	cd 40                	int    $0x40
    14e8:	c3                   	ret    

000014e9 <mprotect>:
SYSCALL(mprotect)
    14e9:	b8 16 00 00 00       	mov    $0x16,%eax
    14ee:	cd 40                	int    $0x40
    14f0:	c3                   	ret    

000014f1 <munprotect>:
SYSCALL(munprotect)
    14f1:	b8 17 00 00 00       	mov    $0x17,%eax
    14f6:	cd 40                	int    $0x40
    14f8:	c3                   	ret    

000014f9 <clone>:
SYSCALL(clone)
    14f9:	b8 18 00 00 00       	mov    $0x18,%eax
    14fe:	cd 40                	int    $0x40
    1500:	c3                   	ret    

00001501 <join>:
SYSCALL(join)
    1501:	b8 19 00 00 00       	mov    $0x19,%eax
    1506:	cd 40                	int    $0x40
    1508:	c3                   	ret    

00001509 <getNumProc>:
SYSCALL(getNumProc)
    1509:	b8 1a 00 00 00       	mov    $0x1a,%eax
    150e:	cd 40                	int    $0x40
    1510:	c3                   	ret    

00001511 <getMaxPid>:
SYSCALL(getMaxPid)
    1511:	b8 1b 00 00 00       	mov    $0x1b,%eax
    1516:	cd 40                	int    $0x40
    1518:	c3                   	ret    

00001519 <getProcInfo>:
SYSCALL(getProcInfo)
    1519:	b8 1c 00 00 00       	mov    $0x1c,%eax
    151e:	cd 40                	int    $0x40
    1520:	c3                   	ret    
    1521:	66 90                	xchg   %ax,%ax
    1523:	66 90                	xchg   %ax,%ax
    1525:	66 90                	xchg   %ax,%ax
    1527:	66 90                	xchg   %ax,%ax
    1529:	66 90                	xchg   %ax,%ax
    152b:	66 90                	xchg   %ax,%ax
    152d:	66 90                	xchg   %ax,%ax
    152f:	90                   	nop

00001530 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1530:	55                   	push   %ebp
    1531:	89 e5                	mov    %esp,%ebp
    1533:	57                   	push   %edi
    1534:	56                   	push   %esi
    1535:	53                   	push   %ebx
    1536:	83 ec 3c             	sub    $0x3c,%esp
    1539:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    153c:	89 d1                	mov    %edx,%ecx
{
    153e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    1541:	85 d2                	test   %edx,%edx
    1543:	0f 89 7f 00 00 00    	jns    15c8 <printint+0x98>
    1549:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    154d:	74 79                	je     15c8 <printint+0x98>
    neg = 1;
    154f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    1556:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    1558:	31 db                	xor    %ebx,%ebx
    155a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    155d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1560:	89 c8                	mov    %ecx,%eax
    1562:	31 d2                	xor    %edx,%edx
    1564:	89 cf                	mov    %ecx,%edi
    1566:	f7 75 c4             	divl   -0x3c(%ebp)
    1569:	0f b6 92 88 19 00 00 	movzbl 0x1988(%edx),%edx
    1570:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1573:	89 d8                	mov    %ebx,%eax
    1575:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1578:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    157b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    157e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1581:	76 dd                	jbe    1560 <printint+0x30>
  if(neg)
    1583:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1586:	85 c9                	test   %ecx,%ecx
    1588:	74 0c                	je     1596 <printint+0x66>
    buf[i++] = '-';
    158a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    158f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1591:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1596:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1599:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    159d:	eb 07                	jmp    15a6 <printint+0x76>
    159f:	90                   	nop
    putc(fd, buf[i]);
    15a0:	0f b6 13             	movzbl (%ebx),%edx
    15a3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    15a6:	83 ec 04             	sub    $0x4,%esp
    15a9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    15ac:	6a 01                	push   $0x1
    15ae:	56                   	push   %esi
    15af:	57                   	push   %edi
    15b0:	e8 b4 fe ff ff       	call   1469 <write>
  while(--i >= 0)
    15b5:	83 c4 10             	add    $0x10,%esp
    15b8:	39 de                	cmp    %ebx,%esi
    15ba:	75 e4                	jne    15a0 <printint+0x70>
}
    15bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    15bf:	5b                   	pop    %ebx
    15c0:	5e                   	pop    %esi
    15c1:	5f                   	pop    %edi
    15c2:	5d                   	pop    %ebp
    15c3:	c3                   	ret    
    15c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    15c8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    15cf:	eb 87                	jmp    1558 <printint+0x28>
    15d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15df:	90                   	nop

000015e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    15e0:	55                   	push   %ebp
    15e1:	89 e5                	mov    %esp,%ebp
    15e3:	57                   	push   %edi
    15e4:	56                   	push   %esi
    15e5:	53                   	push   %ebx
    15e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15e9:	8b 75 0c             	mov    0xc(%ebp),%esi
    15ec:	0f b6 1e             	movzbl (%esi),%ebx
    15ef:	84 db                	test   %bl,%bl
    15f1:	0f 84 b8 00 00 00    	je     16af <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    15f7:	8d 45 10             	lea    0x10(%ebp),%eax
    15fa:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    15fd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    1600:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    1602:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1605:	eb 37                	jmp    163e <printf+0x5e>
    1607:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    160e:	66 90                	xchg   %ax,%ax
    1610:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    1613:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1618:	83 f8 25             	cmp    $0x25,%eax
    161b:	74 17                	je     1634 <printf+0x54>
  write(fd, &c, 1);
    161d:	83 ec 04             	sub    $0x4,%esp
    1620:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1623:	6a 01                	push   $0x1
    1625:	57                   	push   %edi
    1626:	ff 75 08             	pushl  0x8(%ebp)
    1629:	e8 3b fe ff ff       	call   1469 <write>
    162e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    1631:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1634:	0f b6 1e             	movzbl (%esi),%ebx
    1637:	83 c6 01             	add    $0x1,%esi
    163a:	84 db                	test   %bl,%bl
    163c:	74 71                	je     16af <printf+0xcf>
    c = fmt[i] & 0xff;
    163e:	0f be cb             	movsbl %bl,%ecx
    1641:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1644:	85 d2                	test   %edx,%edx
    1646:	74 c8                	je     1610 <printf+0x30>
      }
    } else if(state == '%'){
    1648:	83 fa 25             	cmp    $0x25,%edx
    164b:	75 e7                	jne    1634 <printf+0x54>
      if(c == 'd'){
    164d:	83 f8 64             	cmp    $0x64,%eax
    1650:	0f 84 9a 00 00 00    	je     16f0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1656:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    165c:	83 f9 70             	cmp    $0x70,%ecx
    165f:	74 5f                	je     16c0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1661:	83 f8 73             	cmp    $0x73,%eax
    1664:	0f 84 d6 00 00 00    	je     1740 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    166a:	83 f8 63             	cmp    $0x63,%eax
    166d:	0f 84 8d 00 00 00    	je     1700 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1673:	83 f8 25             	cmp    $0x25,%eax
    1676:	0f 84 b4 00 00 00    	je     1730 <printf+0x150>
  write(fd, &c, 1);
    167c:	83 ec 04             	sub    $0x4,%esp
    167f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1683:	6a 01                	push   $0x1
    1685:	57                   	push   %edi
    1686:	ff 75 08             	pushl  0x8(%ebp)
    1689:	e8 db fd ff ff       	call   1469 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    168e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1691:	83 c4 0c             	add    $0xc,%esp
    1694:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1696:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1699:	57                   	push   %edi
    169a:	ff 75 08             	pushl  0x8(%ebp)
    169d:	e8 c7 fd ff ff       	call   1469 <write>
  for(i = 0; fmt[i]; i++){
    16a2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    16a6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    16a9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    16ab:	84 db                	test   %bl,%bl
    16ad:	75 8f                	jne    163e <printf+0x5e>
    }
  }
}
    16af:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16b2:	5b                   	pop    %ebx
    16b3:	5e                   	pop    %esi
    16b4:	5f                   	pop    %edi
    16b5:	5d                   	pop    %ebp
    16b6:	c3                   	ret    
    16b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    16be:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    16c0:	83 ec 0c             	sub    $0xc,%esp
    16c3:	b9 10 00 00 00       	mov    $0x10,%ecx
    16c8:	6a 00                	push   $0x0
    16ca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    16cd:	8b 45 08             	mov    0x8(%ebp),%eax
    16d0:	8b 13                	mov    (%ebx),%edx
    16d2:	e8 59 fe ff ff       	call   1530 <printint>
        ap++;
    16d7:	89 d8                	mov    %ebx,%eax
    16d9:	83 c4 10             	add    $0x10,%esp
      state = 0;
    16dc:	31 d2                	xor    %edx,%edx
        ap++;
    16de:	83 c0 04             	add    $0x4,%eax
    16e1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    16e4:	e9 4b ff ff ff       	jmp    1634 <printf+0x54>
    16e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    16f0:	83 ec 0c             	sub    $0xc,%esp
    16f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    16f8:	6a 01                	push   $0x1
    16fa:	eb ce                	jmp    16ca <printf+0xea>
    16fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1700:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1703:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1706:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    1708:	6a 01                	push   $0x1
        ap++;
    170a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    170d:	57                   	push   %edi
    170e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    1711:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1714:	e8 50 fd ff ff       	call   1469 <write>
        ap++;
    1719:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    171c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    171f:	31 d2                	xor    %edx,%edx
    1721:	e9 0e ff ff ff       	jmp    1634 <printf+0x54>
    1726:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    172d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    1730:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1733:	83 ec 04             	sub    $0x4,%esp
    1736:	e9 59 ff ff ff       	jmp    1694 <printf+0xb4>
    173b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    173f:	90                   	nop
        s = (char*)*ap;
    1740:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1743:	8b 18                	mov    (%eax),%ebx
        ap++;
    1745:	83 c0 04             	add    $0x4,%eax
    1748:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    174b:	85 db                	test   %ebx,%ebx
    174d:	74 17                	je     1766 <printf+0x186>
        while(*s != 0){
    174f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1752:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1754:	84 c0                	test   %al,%al
    1756:	0f 84 d8 fe ff ff    	je     1634 <printf+0x54>
    175c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    175f:	89 de                	mov    %ebx,%esi
    1761:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1764:	eb 1a                	jmp    1780 <printf+0x1a0>
          s = "(null)";
    1766:	bb 7f 19 00 00       	mov    $0x197f,%ebx
        while(*s != 0){
    176b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    176e:	b8 28 00 00 00       	mov    $0x28,%eax
    1773:	89 de                	mov    %ebx,%esi
    1775:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1778:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    177f:	90                   	nop
  write(fd, &c, 1);
    1780:	83 ec 04             	sub    $0x4,%esp
          s++;
    1783:	83 c6 01             	add    $0x1,%esi
    1786:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1789:	6a 01                	push   $0x1
    178b:	57                   	push   %edi
    178c:	53                   	push   %ebx
    178d:	e8 d7 fc ff ff       	call   1469 <write>
        while(*s != 0){
    1792:	0f b6 06             	movzbl (%esi),%eax
    1795:	83 c4 10             	add    $0x10,%esp
    1798:	84 c0                	test   %al,%al
    179a:	75 e4                	jne    1780 <printf+0x1a0>
      state = 0;
    179c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    179f:	31 d2                	xor    %edx,%edx
    17a1:	e9 8e fe ff ff       	jmp    1634 <printf+0x54>
    17a6:	66 90                	xchg   %ax,%ax
    17a8:	66 90                	xchg   %ax,%ax
    17aa:	66 90                	xchg   %ax,%ax
    17ac:	66 90                	xchg   %ax,%ax
    17ae:	66 90                	xchg   %ax,%ax

000017b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    17b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17b1:	a1 c0 1e 00 00       	mov    0x1ec0,%eax
{
    17b6:	89 e5                	mov    %esp,%ebp
    17b8:	57                   	push   %edi
    17b9:	56                   	push   %esi
    17ba:	53                   	push   %ebx
    17bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    17be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17c8:	89 c2                	mov    %eax,%edx
    17ca:	8b 00                	mov    (%eax),%eax
    17cc:	39 ca                	cmp    %ecx,%edx
    17ce:	73 30                	jae    1800 <free+0x50>
    17d0:	39 c1                	cmp    %eax,%ecx
    17d2:	72 04                	jb     17d8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17d4:	39 c2                	cmp    %eax,%edx
    17d6:	72 f0                	jb     17c8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    17d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    17db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    17de:	39 f8                	cmp    %edi,%eax
    17e0:	74 30                	je     1812 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    17e2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    17e5:	8b 42 04             	mov    0x4(%edx),%eax
    17e8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    17eb:	39 f1                	cmp    %esi,%ecx
    17ed:	74 3a                	je     1829 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    17ef:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    17f1:	5b                   	pop    %ebx
  freep = p;
    17f2:	89 15 c0 1e 00 00    	mov    %edx,0x1ec0
}
    17f8:	5e                   	pop    %esi
    17f9:	5f                   	pop    %edi
    17fa:	5d                   	pop    %ebp
    17fb:	c3                   	ret    
    17fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1800:	39 c2                	cmp    %eax,%edx
    1802:	72 c4                	jb     17c8 <free+0x18>
    1804:	39 c1                	cmp    %eax,%ecx
    1806:	73 c0                	jae    17c8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1808:	8b 73 fc             	mov    -0x4(%ebx),%esi
    180b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    180e:	39 f8                	cmp    %edi,%eax
    1810:	75 d0                	jne    17e2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    1812:	03 70 04             	add    0x4(%eax),%esi
    1815:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1818:	8b 02                	mov    (%edx),%eax
    181a:	8b 00                	mov    (%eax),%eax
    181c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    181f:	8b 42 04             	mov    0x4(%edx),%eax
    1822:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1825:	39 f1                	cmp    %esi,%ecx
    1827:	75 c6                	jne    17ef <free+0x3f>
    p->s.size += bp->s.size;
    1829:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    182c:	89 15 c0 1e 00 00    	mov    %edx,0x1ec0
    p->s.size += bp->s.size;
    1832:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1835:	8b 43 f8             	mov    -0x8(%ebx),%eax
    1838:	89 02                	mov    %eax,(%edx)
}
    183a:	5b                   	pop    %ebx
    183b:	5e                   	pop    %esi
    183c:	5f                   	pop    %edi
    183d:	5d                   	pop    %ebp
    183e:	c3                   	ret    
    183f:	90                   	nop

00001840 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1840:	55                   	push   %ebp
    1841:	89 e5                	mov    %esp,%ebp
    1843:	57                   	push   %edi
    1844:	56                   	push   %esi
    1845:	53                   	push   %ebx
    1846:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1849:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    184c:	8b 3d c0 1e 00 00    	mov    0x1ec0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1852:	8d 70 07             	lea    0x7(%eax),%esi
    1855:	c1 ee 03             	shr    $0x3,%esi
    1858:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    185b:	85 ff                	test   %edi,%edi
    185d:	0f 84 ad 00 00 00    	je     1910 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1863:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1865:	8b 48 04             	mov    0x4(%eax),%ecx
    1868:	39 f1                	cmp    %esi,%ecx
    186a:	73 71                	jae    18dd <malloc+0x9d>
    186c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1872:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1877:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    187a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1881:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1884:	eb 1b                	jmp    18a1 <malloc+0x61>
    1886:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    188d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1890:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1892:	8b 4a 04             	mov    0x4(%edx),%ecx
    1895:	39 f1                	cmp    %esi,%ecx
    1897:	73 4f                	jae    18e8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1899:	8b 3d c0 1e 00 00    	mov    0x1ec0,%edi
    189f:	89 d0                	mov    %edx,%eax
    18a1:	39 c7                	cmp    %eax,%edi
    18a3:	75 eb                	jne    1890 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    18a5:	83 ec 0c             	sub    $0xc,%esp
    18a8:	ff 75 e4             	pushl  -0x1c(%ebp)
    18ab:	e8 21 fc ff ff       	call   14d1 <sbrk>
  if(p == (char*)-1)
    18b0:	83 c4 10             	add    $0x10,%esp
    18b3:	83 f8 ff             	cmp    $0xffffffff,%eax
    18b6:	74 1b                	je     18d3 <malloc+0x93>
  hp->s.size = nu;
    18b8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    18bb:	83 ec 0c             	sub    $0xc,%esp
    18be:	83 c0 08             	add    $0x8,%eax
    18c1:	50                   	push   %eax
    18c2:	e8 e9 fe ff ff       	call   17b0 <free>
  return freep;
    18c7:	a1 c0 1e 00 00       	mov    0x1ec0,%eax
      if((p = morecore(nunits)) == 0)
    18cc:	83 c4 10             	add    $0x10,%esp
    18cf:	85 c0                	test   %eax,%eax
    18d1:	75 bd                	jne    1890 <malloc+0x50>
        return 0;
  }
}
    18d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    18d6:	31 c0                	xor    %eax,%eax
}
    18d8:	5b                   	pop    %ebx
    18d9:	5e                   	pop    %esi
    18da:	5f                   	pop    %edi
    18db:	5d                   	pop    %ebp
    18dc:	c3                   	ret    
    if(p->s.size >= nunits){
    18dd:	89 c2                	mov    %eax,%edx
    18df:	89 f8                	mov    %edi,%eax
    18e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    18e8:	39 ce                	cmp    %ecx,%esi
    18ea:	74 54                	je     1940 <malloc+0x100>
        p->s.size -= nunits;
    18ec:	29 f1                	sub    %esi,%ecx
    18ee:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    18f1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    18f4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    18f7:	a3 c0 1e 00 00       	mov    %eax,0x1ec0
}
    18fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    18ff:	8d 42 08             	lea    0x8(%edx),%eax
}
    1902:	5b                   	pop    %ebx
    1903:	5e                   	pop    %esi
    1904:	5f                   	pop    %edi
    1905:	5d                   	pop    %ebp
    1906:	c3                   	ret    
    1907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    190e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    1910:	c7 05 c0 1e 00 00 c4 	movl   $0x1ec4,0x1ec0
    1917:	1e 00 00 
    base.s.size = 0;
    191a:	bf c4 1e 00 00       	mov    $0x1ec4,%edi
    base.s.ptr = freep = prevp = &base;
    191f:	c7 05 c4 1e 00 00 c4 	movl   $0x1ec4,0x1ec4
    1926:	1e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1929:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    192b:	c7 05 c8 1e 00 00 00 	movl   $0x0,0x1ec8
    1932:	00 00 00 
    if(p->s.size >= nunits){
    1935:	e9 32 ff ff ff       	jmp    186c <malloc+0x2c>
    193a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1940:	8b 0a                	mov    (%edx),%ecx
    1942:	89 08                	mov    %ecx,(%eax)
    1944:	eb b1                	jmp    18f7 <malloc+0xb7>
