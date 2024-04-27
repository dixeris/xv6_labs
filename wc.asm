
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
    106e:	68 4b 19 00 00       	push   $0x194b
    1073:	6a 01                	push   $0x1
    1075:	e8 46 05 00 00       	call   15c0 <printf>
      exit();
    107a:	e8 ca 03 00 00       	call   1449 <exit>
    wc(0, "");
    107f:	52                   	push   %edx
    1080:	52                   	push   %edx
    1081:	68 3d 19 00 00       	push   $0x193d
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
    10c8:	68 a0 1c 00 00       	push   $0x1ca0
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
    10f6:	0f be 87 a0 1c 00 00 	movsbl 0x1ca0(%edi),%eax
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
    110a:	68 28 19 00 00       	push   $0x1928
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
    114f:	68 3e 19 00 00       	push   $0x193e
    1154:	6a 01                	push   $0x1
    1156:	e8 65 04 00 00       	call   15c0 <printf>
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
    1168:	68 2e 19 00 00       	push   $0x192e
    116d:	6a 01                	push   $0x1
    116f:	e8 4c 04 00 00       	call   15c0 <printf>
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
    13dc:	e8 3f 04 00 00       	call   1820 <malloc>
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
    1417:	e8 74 03 00 00       	call   1790 <free>
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
    1509:	66 90                	xchg   %ax,%ax
    150b:	66 90                	xchg   %ax,%ax
    150d:	66 90                	xchg   %ax,%ax
    150f:	90                   	nop

00001510 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1510:	55                   	push   %ebp
    1511:	89 e5                	mov    %esp,%ebp
    1513:	57                   	push   %edi
    1514:	56                   	push   %esi
    1515:	53                   	push   %ebx
    1516:	83 ec 3c             	sub    $0x3c,%esp
    1519:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    151c:	89 d1                	mov    %edx,%ecx
{
    151e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    1521:	85 d2                	test   %edx,%edx
    1523:	0f 89 7f 00 00 00    	jns    15a8 <printint+0x98>
    1529:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    152d:	74 79                	je     15a8 <printint+0x98>
    neg = 1;
    152f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    1536:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    1538:	31 db                	xor    %ebx,%ebx
    153a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    153d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1540:	89 c8                	mov    %ecx,%eax
    1542:	31 d2                	xor    %edx,%edx
    1544:	89 cf                	mov    %ecx,%edi
    1546:	f7 75 c4             	divl   -0x3c(%ebp)
    1549:	0f b6 92 68 19 00 00 	movzbl 0x1968(%edx),%edx
    1550:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1553:	89 d8                	mov    %ebx,%eax
    1555:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1558:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    155b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    155e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1561:	76 dd                	jbe    1540 <printint+0x30>
  if(neg)
    1563:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1566:	85 c9                	test   %ecx,%ecx
    1568:	74 0c                	je     1576 <printint+0x66>
    buf[i++] = '-';
    156a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    156f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1571:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1576:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1579:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    157d:	eb 07                	jmp    1586 <printint+0x76>
    157f:	90                   	nop
    putc(fd, buf[i]);
    1580:	0f b6 13             	movzbl (%ebx),%edx
    1583:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1586:	83 ec 04             	sub    $0x4,%esp
    1589:	88 55 d7             	mov    %dl,-0x29(%ebp)
    158c:	6a 01                	push   $0x1
    158e:	56                   	push   %esi
    158f:	57                   	push   %edi
    1590:	e8 d4 fe ff ff       	call   1469 <write>
  while(--i >= 0)
    1595:	83 c4 10             	add    $0x10,%esp
    1598:	39 de                	cmp    %ebx,%esi
    159a:	75 e4                	jne    1580 <printint+0x70>
}
    159c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    159f:	5b                   	pop    %ebx
    15a0:	5e                   	pop    %esi
    15a1:	5f                   	pop    %edi
    15a2:	5d                   	pop    %ebp
    15a3:	c3                   	ret    
    15a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    15a8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    15af:	eb 87                	jmp    1538 <printint+0x28>
    15b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15bf:	90                   	nop

000015c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    15c0:	55                   	push   %ebp
    15c1:	89 e5                	mov    %esp,%ebp
    15c3:	57                   	push   %edi
    15c4:	56                   	push   %esi
    15c5:	53                   	push   %ebx
    15c6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15c9:	8b 75 0c             	mov    0xc(%ebp),%esi
    15cc:	0f b6 1e             	movzbl (%esi),%ebx
    15cf:	84 db                	test   %bl,%bl
    15d1:	0f 84 b8 00 00 00    	je     168f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    15d7:	8d 45 10             	lea    0x10(%ebp),%eax
    15da:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    15dd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    15e0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    15e2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    15e5:	eb 37                	jmp    161e <printf+0x5e>
    15e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15ee:	66 90                	xchg   %ax,%ax
    15f0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    15f3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    15f8:	83 f8 25             	cmp    $0x25,%eax
    15fb:	74 17                	je     1614 <printf+0x54>
  write(fd, &c, 1);
    15fd:	83 ec 04             	sub    $0x4,%esp
    1600:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1603:	6a 01                	push   $0x1
    1605:	57                   	push   %edi
    1606:	ff 75 08             	pushl  0x8(%ebp)
    1609:	e8 5b fe ff ff       	call   1469 <write>
    160e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    1611:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1614:	0f b6 1e             	movzbl (%esi),%ebx
    1617:	83 c6 01             	add    $0x1,%esi
    161a:	84 db                	test   %bl,%bl
    161c:	74 71                	je     168f <printf+0xcf>
    c = fmt[i] & 0xff;
    161e:	0f be cb             	movsbl %bl,%ecx
    1621:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1624:	85 d2                	test   %edx,%edx
    1626:	74 c8                	je     15f0 <printf+0x30>
      }
    } else if(state == '%'){
    1628:	83 fa 25             	cmp    $0x25,%edx
    162b:	75 e7                	jne    1614 <printf+0x54>
      if(c == 'd'){
    162d:	83 f8 64             	cmp    $0x64,%eax
    1630:	0f 84 9a 00 00 00    	je     16d0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1636:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    163c:	83 f9 70             	cmp    $0x70,%ecx
    163f:	74 5f                	je     16a0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1641:	83 f8 73             	cmp    $0x73,%eax
    1644:	0f 84 d6 00 00 00    	je     1720 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    164a:	83 f8 63             	cmp    $0x63,%eax
    164d:	0f 84 8d 00 00 00    	je     16e0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1653:	83 f8 25             	cmp    $0x25,%eax
    1656:	0f 84 b4 00 00 00    	je     1710 <printf+0x150>
  write(fd, &c, 1);
    165c:	83 ec 04             	sub    $0x4,%esp
    165f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1663:	6a 01                	push   $0x1
    1665:	57                   	push   %edi
    1666:	ff 75 08             	pushl  0x8(%ebp)
    1669:	e8 fb fd ff ff       	call   1469 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    166e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1671:	83 c4 0c             	add    $0xc,%esp
    1674:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1676:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1679:	57                   	push   %edi
    167a:	ff 75 08             	pushl  0x8(%ebp)
    167d:	e8 e7 fd ff ff       	call   1469 <write>
  for(i = 0; fmt[i]; i++){
    1682:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    1686:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1689:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    168b:	84 db                	test   %bl,%bl
    168d:	75 8f                	jne    161e <printf+0x5e>
    }
  }
}
    168f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1692:	5b                   	pop    %ebx
    1693:	5e                   	pop    %esi
    1694:	5f                   	pop    %edi
    1695:	5d                   	pop    %ebp
    1696:	c3                   	ret    
    1697:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    169e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    16a0:	83 ec 0c             	sub    $0xc,%esp
    16a3:	b9 10 00 00 00       	mov    $0x10,%ecx
    16a8:	6a 00                	push   $0x0
    16aa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    16ad:	8b 45 08             	mov    0x8(%ebp),%eax
    16b0:	8b 13                	mov    (%ebx),%edx
    16b2:	e8 59 fe ff ff       	call   1510 <printint>
        ap++;
    16b7:	89 d8                	mov    %ebx,%eax
    16b9:	83 c4 10             	add    $0x10,%esp
      state = 0;
    16bc:	31 d2                	xor    %edx,%edx
        ap++;
    16be:	83 c0 04             	add    $0x4,%eax
    16c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    16c4:	e9 4b ff ff ff       	jmp    1614 <printf+0x54>
    16c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    16d0:	83 ec 0c             	sub    $0xc,%esp
    16d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    16d8:	6a 01                	push   $0x1
    16da:	eb ce                	jmp    16aa <printf+0xea>
    16dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    16e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    16e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    16e6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    16e8:	6a 01                	push   $0x1
        ap++;
    16ea:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    16ed:	57                   	push   %edi
    16ee:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    16f1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    16f4:	e8 70 fd ff ff       	call   1469 <write>
        ap++;
    16f9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    16fc:	83 c4 10             	add    $0x10,%esp
      state = 0;
    16ff:	31 d2                	xor    %edx,%edx
    1701:	e9 0e ff ff ff       	jmp    1614 <printf+0x54>
    1706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    170d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    1710:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1713:	83 ec 04             	sub    $0x4,%esp
    1716:	e9 59 ff ff ff       	jmp    1674 <printf+0xb4>
    171b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    171f:	90                   	nop
        s = (char*)*ap;
    1720:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1723:	8b 18                	mov    (%eax),%ebx
        ap++;
    1725:	83 c0 04             	add    $0x4,%eax
    1728:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    172b:	85 db                	test   %ebx,%ebx
    172d:	74 17                	je     1746 <printf+0x186>
        while(*s != 0){
    172f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1732:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1734:	84 c0                	test   %al,%al
    1736:	0f 84 d8 fe ff ff    	je     1614 <printf+0x54>
    173c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    173f:	89 de                	mov    %ebx,%esi
    1741:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1744:	eb 1a                	jmp    1760 <printf+0x1a0>
          s = "(null)";
    1746:	bb 5f 19 00 00       	mov    $0x195f,%ebx
        while(*s != 0){
    174b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    174e:	b8 28 00 00 00       	mov    $0x28,%eax
    1753:	89 de                	mov    %ebx,%esi
    1755:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    175f:	90                   	nop
  write(fd, &c, 1);
    1760:	83 ec 04             	sub    $0x4,%esp
          s++;
    1763:	83 c6 01             	add    $0x1,%esi
    1766:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1769:	6a 01                	push   $0x1
    176b:	57                   	push   %edi
    176c:	53                   	push   %ebx
    176d:	e8 f7 fc ff ff       	call   1469 <write>
        while(*s != 0){
    1772:	0f b6 06             	movzbl (%esi),%eax
    1775:	83 c4 10             	add    $0x10,%esp
    1778:	84 c0                	test   %al,%al
    177a:	75 e4                	jne    1760 <printf+0x1a0>
      state = 0;
    177c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    177f:	31 d2                	xor    %edx,%edx
    1781:	e9 8e fe ff ff       	jmp    1614 <printf+0x54>
    1786:	66 90                	xchg   %ax,%ax
    1788:	66 90                	xchg   %ax,%ax
    178a:	66 90                	xchg   %ax,%ax
    178c:	66 90                	xchg   %ax,%ax
    178e:	66 90                	xchg   %ax,%ax

00001790 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1790:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1791:	a1 a0 1e 00 00       	mov    0x1ea0,%eax
{
    1796:	89 e5                	mov    %esp,%ebp
    1798:	57                   	push   %edi
    1799:	56                   	push   %esi
    179a:	53                   	push   %ebx
    179b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    179e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17a8:	89 c2                	mov    %eax,%edx
    17aa:	8b 00                	mov    (%eax),%eax
    17ac:	39 ca                	cmp    %ecx,%edx
    17ae:	73 30                	jae    17e0 <free+0x50>
    17b0:	39 c1                	cmp    %eax,%ecx
    17b2:	72 04                	jb     17b8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17b4:	39 c2                	cmp    %eax,%edx
    17b6:	72 f0                	jb     17a8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    17b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    17bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    17be:	39 f8                	cmp    %edi,%eax
    17c0:	74 30                	je     17f2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    17c2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    17c5:	8b 42 04             	mov    0x4(%edx),%eax
    17c8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    17cb:	39 f1                	cmp    %esi,%ecx
    17cd:	74 3a                	je     1809 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    17cf:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    17d1:	5b                   	pop    %ebx
  freep = p;
    17d2:	89 15 a0 1e 00 00    	mov    %edx,0x1ea0
}
    17d8:	5e                   	pop    %esi
    17d9:	5f                   	pop    %edi
    17da:	5d                   	pop    %ebp
    17db:	c3                   	ret    
    17dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17e0:	39 c2                	cmp    %eax,%edx
    17e2:	72 c4                	jb     17a8 <free+0x18>
    17e4:	39 c1                	cmp    %eax,%ecx
    17e6:	73 c0                	jae    17a8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    17e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    17eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    17ee:	39 f8                	cmp    %edi,%eax
    17f0:	75 d0                	jne    17c2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    17f2:	03 70 04             	add    0x4(%eax),%esi
    17f5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    17f8:	8b 02                	mov    (%edx),%eax
    17fa:	8b 00                	mov    (%eax),%eax
    17fc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    17ff:	8b 42 04             	mov    0x4(%edx),%eax
    1802:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1805:	39 f1                	cmp    %esi,%ecx
    1807:	75 c6                	jne    17cf <free+0x3f>
    p->s.size += bp->s.size;
    1809:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    180c:	89 15 a0 1e 00 00    	mov    %edx,0x1ea0
    p->s.size += bp->s.size;
    1812:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1815:	8b 43 f8             	mov    -0x8(%ebx),%eax
    1818:	89 02                	mov    %eax,(%edx)
}
    181a:	5b                   	pop    %ebx
    181b:	5e                   	pop    %esi
    181c:	5f                   	pop    %edi
    181d:	5d                   	pop    %ebp
    181e:	c3                   	ret    
    181f:	90                   	nop

00001820 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1820:	55                   	push   %ebp
    1821:	89 e5                	mov    %esp,%ebp
    1823:	57                   	push   %edi
    1824:	56                   	push   %esi
    1825:	53                   	push   %ebx
    1826:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1829:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    182c:	8b 3d a0 1e 00 00    	mov    0x1ea0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1832:	8d 70 07             	lea    0x7(%eax),%esi
    1835:	c1 ee 03             	shr    $0x3,%esi
    1838:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    183b:	85 ff                	test   %edi,%edi
    183d:	0f 84 ad 00 00 00    	je     18f0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1843:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1845:	8b 48 04             	mov    0x4(%eax),%ecx
    1848:	39 f1                	cmp    %esi,%ecx
    184a:	73 71                	jae    18bd <malloc+0x9d>
    184c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1852:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1857:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    185a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1861:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1864:	eb 1b                	jmp    1881 <malloc+0x61>
    1866:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    186d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1870:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1872:	8b 4a 04             	mov    0x4(%edx),%ecx
    1875:	39 f1                	cmp    %esi,%ecx
    1877:	73 4f                	jae    18c8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1879:	8b 3d a0 1e 00 00    	mov    0x1ea0,%edi
    187f:	89 d0                	mov    %edx,%eax
    1881:	39 c7                	cmp    %eax,%edi
    1883:	75 eb                	jne    1870 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1885:	83 ec 0c             	sub    $0xc,%esp
    1888:	ff 75 e4             	pushl  -0x1c(%ebp)
    188b:	e8 41 fc ff ff       	call   14d1 <sbrk>
  if(p == (char*)-1)
    1890:	83 c4 10             	add    $0x10,%esp
    1893:	83 f8 ff             	cmp    $0xffffffff,%eax
    1896:	74 1b                	je     18b3 <malloc+0x93>
  hp->s.size = nu;
    1898:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    189b:	83 ec 0c             	sub    $0xc,%esp
    189e:	83 c0 08             	add    $0x8,%eax
    18a1:	50                   	push   %eax
    18a2:	e8 e9 fe ff ff       	call   1790 <free>
  return freep;
    18a7:	a1 a0 1e 00 00       	mov    0x1ea0,%eax
      if((p = morecore(nunits)) == 0)
    18ac:	83 c4 10             	add    $0x10,%esp
    18af:	85 c0                	test   %eax,%eax
    18b1:	75 bd                	jne    1870 <malloc+0x50>
        return 0;
  }
}
    18b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    18b6:	31 c0                	xor    %eax,%eax
}
    18b8:	5b                   	pop    %ebx
    18b9:	5e                   	pop    %esi
    18ba:	5f                   	pop    %edi
    18bb:	5d                   	pop    %ebp
    18bc:	c3                   	ret    
    if(p->s.size >= nunits){
    18bd:	89 c2                	mov    %eax,%edx
    18bf:	89 f8                	mov    %edi,%eax
    18c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    18c8:	39 ce                	cmp    %ecx,%esi
    18ca:	74 54                	je     1920 <malloc+0x100>
        p->s.size -= nunits;
    18cc:	29 f1                	sub    %esi,%ecx
    18ce:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    18d1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    18d4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    18d7:	a3 a0 1e 00 00       	mov    %eax,0x1ea0
}
    18dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    18df:	8d 42 08             	lea    0x8(%edx),%eax
}
    18e2:	5b                   	pop    %ebx
    18e3:	5e                   	pop    %esi
    18e4:	5f                   	pop    %edi
    18e5:	5d                   	pop    %ebp
    18e6:	c3                   	ret    
    18e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    18ee:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    18f0:	c7 05 a0 1e 00 00 a4 	movl   $0x1ea4,0x1ea0
    18f7:	1e 00 00 
    base.s.size = 0;
    18fa:	bf a4 1e 00 00       	mov    $0x1ea4,%edi
    base.s.ptr = freep = prevp = &base;
    18ff:	c7 05 a4 1e 00 00 a4 	movl   $0x1ea4,0x1ea4
    1906:	1e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1909:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    190b:	c7 05 a8 1e 00 00 00 	movl   $0x0,0x1ea8
    1912:	00 00 00 
    if(p->s.size >= nunits){
    1915:	e9 32 ff ff ff       	jmp    184c <malloc+0x2c>
    191a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1920:	8b 0a                	mov    (%edx),%ecx
    1922:	89 08                	mov    %ecx,(%eax)
    1924:	eb b1                	jmp    18d7 <malloc+0xb7>
