
_ls:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
  close(fd);
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
    100f:	53                   	push   %ebx
    1010:	bb 01 00 00 00       	mov    $0x1,%ebx
    1015:	51                   	push   %ecx
    1016:	83 ec 08             	sub    $0x8,%esp
    1019:	8b 31                	mov    (%ecx),%esi
    101b:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
    101e:	83 fe 01             	cmp    $0x1,%esi
    1021:	7e 1f                	jle    1042 <main+0x42>
    1023:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1027:	90                   	nop
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
    1028:	83 ec 0c             	sub    $0xc,%esp
    102b:	ff 34 9f             	pushl  (%edi,%ebx,4)
  for(i=1; i<argc; i++)
    102e:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
    1031:	e8 ca 00 00 00       	call   1100 <ls>
  for(i=1; i<argc; i++)
    1036:	83 c4 10             	add    $0x10,%esp
    1039:	39 de                	cmp    %ebx,%esi
    103b:	75 eb                	jne    1028 <main+0x28>
  exit();
    103d:	e8 c7 05 00 00       	call   1609 <exit>
    ls(".");
    1042:	83 ec 0c             	sub    $0xc,%esp
    1045:	68 30 1b 00 00       	push   $0x1b30
    104a:	e8 b1 00 00 00       	call   1100 <ls>
    exit();
    104f:	e8 b5 05 00 00       	call   1609 <exit>
    1054:	66 90                	xchg   %ax,%ax
    1056:	66 90                	xchg   %ax,%ax
    1058:	66 90                	xchg   %ax,%ax
    105a:	66 90                	xchg   %ax,%ax
    105c:	66 90                	xchg   %ax,%ax
    105e:	66 90                	xchg   %ax,%ax

00001060 <fmtname>:
{
    1060:	55                   	push   %ebp
    1061:	89 e5                	mov    %esp,%ebp
    1063:	56                   	push   %esi
    1064:	53                   	push   %ebx
    1065:	8b 75 08             	mov    0x8(%ebp),%esi
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    1068:	83 ec 0c             	sub    $0xc,%esp
    106b:	56                   	push   %esi
    106c:	e8 4f 03 00 00       	call   13c0 <strlen>
    1071:	83 c4 10             	add    $0x10,%esp
    1074:	01 f0                	add    %esi,%eax
    1076:	89 c3                	mov    %eax,%ebx
    1078:	73 0f                	jae    1089 <fmtname+0x29>
    107a:	eb 12                	jmp    108e <fmtname+0x2e>
    107c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1080:	8d 43 ff             	lea    -0x1(%ebx),%eax
    1083:	39 c6                	cmp    %eax,%esi
    1085:	77 0a                	ja     1091 <fmtname+0x31>
    1087:	89 c3                	mov    %eax,%ebx
    1089:	80 3b 2f             	cmpb   $0x2f,(%ebx)
    108c:	75 f2                	jne    1080 <fmtname+0x20>
  p++;
    108e:	83 c3 01             	add    $0x1,%ebx
  if(strlen(p) >= DIRSIZ)
    1091:	83 ec 0c             	sub    $0xc,%esp
    1094:	53                   	push   %ebx
    1095:	e8 26 03 00 00       	call   13c0 <strlen>
    109a:	83 c4 10             	add    $0x10,%esp
    109d:	83 f8 0d             	cmp    $0xd,%eax
    10a0:	77 4a                	ja     10ec <fmtname+0x8c>
  memmove(buf, p, strlen(p));
    10a2:	83 ec 0c             	sub    $0xc,%esp
    10a5:	53                   	push   %ebx
    10a6:	e8 15 03 00 00       	call   13c0 <strlen>
    10ab:	83 c4 0c             	add    $0xc,%esp
    10ae:	50                   	push   %eax
    10af:	53                   	push   %ebx
    10b0:	68 b8 1e 00 00       	push   $0x1eb8
    10b5:	e8 a6 04 00 00       	call   1560 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    10ba:	89 1c 24             	mov    %ebx,(%esp)
    10bd:	e8 fe 02 00 00       	call   13c0 <strlen>
    10c2:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
    10c5:	bb b8 1e 00 00       	mov    $0x1eb8,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    10ca:	89 c6                	mov    %eax,%esi
    10cc:	e8 ef 02 00 00       	call   13c0 <strlen>
    10d1:	ba 0e 00 00 00       	mov    $0xe,%edx
    10d6:	83 c4 0c             	add    $0xc,%esp
    10d9:	29 f2                	sub    %esi,%edx
    10db:	05 b8 1e 00 00       	add    $0x1eb8,%eax
    10e0:	52                   	push   %edx
    10e1:	6a 20                	push   $0x20
    10e3:	50                   	push   %eax
    10e4:	e8 07 03 00 00       	call   13f0 <memset>
  return buf;
    10e9:	83 c4 10             	add    $0x10,%esp
}
    10ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
    10ef:	89 d8                	mov    %ebx,%eax
    10f1:	5b                   	pop    %ebx
    10f2:	5e                   	pop    %esi
    10f3:	5d                   	pop    %ebp
    10f4:	c3                   	ret    
    10f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001100 <ls>:
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	57                   	push   %edi
    1104:	56                   	push   %esi
    1105:	53                   	push   %ebx
    1106:	81 ec 64 02 00 00    	sub    $0x264,%esp
    110c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
    110f:	6a 00                	push   $0x0
    1111:	57                   	push   %edi
    1112:	e8 32 05 00 00       	call   1649 <open>
    1117:	83 c4 10             	add    $0x10,%esp
    111a:	85 c0                	test   %eax,%eax
    111c:	0f 88 9e 01 00 00    	js     12c0 <ls+0x1c0>
  if(fstat(fd, &st) < 0){
    1122:	83 ec 08             	sub    $0x8,%esp
    1125:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
    112b:	89 c3                	mov    %eax,%ebx
    112d:	56                   	push   %esi
    112e:	50                   	push   %eax
    112f:	e8 2d 05 00 00       	call   1661 <fstat>
    1134:	83 c4 10             	add    $0x10,%esp
    1137:	85 c0                	test   %eax,%eax
    1139:	0f 88 c1 01 00 00    	js     1300 <ls+0x200>
  switch(st.type){
    113f:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
    1146:	66 83 f8 01          	cmp    $0x1,%ax
    114a:	74 64                	je     11b0 <ls+0xb0>
    114c:	66 83 f8 02          	cmp    $0x2,%ax
    1150:	74 1e                	je     1170 <ls+0x70>
  close(fd);
    1152:	83 ec 0c             	sub    $0xc,%esp
    1155:	53                   	push   %ebx
    1156:	e8 d6 04 00 00       	call   1631 <close>
    115b:	83 c4 10             	add    $0x10,%esp
}
    115e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1161:	5b                   	pop    %ebx
    1162:	5e                   	pop    %esi
    1163:	5f                   	pop    %edi
    1164:	5d                   	pop    %ebp
    1165:	c3                   	ret    
    1166:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    116d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    1170:	83 ec 0c             	sub    $0xc,%esp
    1173:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
    1179:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
    117f:	57                   	push   %edi
    1180:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
    1186:	e8 d5 fe ff ff       	call   1060 <fmtname>
    118b:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
    1191:	59                   	pop    %ecx
    1192:	5f                   	pop    %edi
    1193:	52                   	push   %edx
    1194:	56                   	push   %esi
    1195:	6a 02                	push   $0x2
    1197:	50                   	push   %eax
    1198:	68 10 1b 00 00       	push   $0x1b10
    119d:	6a 01                	push   $0x1
    119f:	e8 dc 05 00 00       	call   1780 <printf>
    break;
    11a4:	83 c4 20             	add    $0x20,%esp
    11a7:	eb a9                	jmp    1152 <ls+0x52>
    11a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
    11b0:	83 ec 0c             	sub    $0xc,%esp
    11b3:	57                   	push   %edi
    11b4:	e8 07 02 00 00       	call   13c0 <strlen>
    11b9:	83 c4 10             	add    $0x10,%esp
    11bc:	83 c0 10             	add    $0x10,%eax
    11bf:	3d 00 02 00 00       	cmp    $0x200,%eax
    11c4:	0f 87 16 01 00 00    	ja     12e0 <ls+0x1e0>
    strcpy(buf, path);
    11ca:	83 ec 08             	sub    $0x8,%esp
    11cd:	57                   	push   %edi
    11ce:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
    11d4:	57                   	push   %edi
    11d5:	e8 66 01 00 00       	call   1340 <strcpy>
    p = buf+strlen(buf);
    11da:	89 3c 24             	mov    %edi,(%esp)
    11dd:	e8 de 01 00 00       	call   13c0 <strlen>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    11e2:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
    11e5:	01 f8                	add    %edi,%eax
    *p++ = '/';
    11e7:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
    11ea:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
    11f0:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
    11f6:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    11f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1200:	83 ec 04             	sub    $0x4,%esp
    1203:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
    1209:	6a 10                	push   $0x10
    120b:	50                   	push   %eax
    120c:	53                   	push   %ebx
    120d:	e8 0f 04 00 00       	call   1621 <read>
    1212:	83 c4 10             	add    $0x10,%esp
    1215:	83 f8 10             	cmp    $0x10,%eax
    1218:	0f 85 34 ff ff ff    	jne    1152 <ls+0x52>
      if(de.inum == 0)
    121e:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
    1225:	00 
    1226:	74 d8                	je     1200 <ls+0x100>
      memmove(p, de.name, DIRSIZ);
    1228:	83 ec 04             	sub    $0x4,%esp
    122b:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
    1231:	6a 0e                	push   $0xe
    1233:	50                   	push   %eax
    1234:	ff b5 a4 fd ff ff    	pushl  -0x25c(%ebp)
    123a:	e8 21 03 00 00       	call   1560 <memmove>
      p[DIRSIZ] = 0;
    123f:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
    1245:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
    1249:	58                   	pop    %eax
    124a:	5a                   	pop    %edx
    124b:	56                   	push   %esi
    124c:	57                   	push   %edi
    124d:	e8 7e 02 00 00       	call   14d0 <stat>
    1252:	83 c4 10             	add    $0x10,%esp
    1255:	85 c0                	test   %eax,%eax
    1257:	0f 88 cb 00 00 00    	js     1328 <ls+0x228>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    125d:	83 ec 0c             	sub    $0xc,%esp
    1260:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
    1266:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
    126c:	57                   	push   %edi
    126d:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
    1274:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
    127a:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
    1280:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    1286:	e8 d5 fd ff ff       	call   1060 <fmtname>
    128b:	5a                   	pop    %edx
    128c:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
    1292:	59                   	pop    %ecx
    1293:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
    1299:	51                   	push   %ecx
    129a:	52                   	push   %edx
    129b:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
    12a1:	50                   	push   %eax
    12a2:	68 10 1b 00 00       	push   $0x1b10
    12a7:	6a 01                	push   $0x1
    12a9:	e8 d2 04 00 00       	call   1780 <printf>
    12ae:	83 c4 20             	add    $0x20,%esp
    12b1:	e9 4a ff ff ff       	jmp    1200 <ls+0x100>
    12b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12bd:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
    12c0:	83 ec 04             	sub    $0x4,%esp
    12c3:	57                   	push   %edi
    12c4:	68 e8 1a 00 00       	push   $0x1ae8
    12c9:	6a 02                	push   $0x2
    12cb:	e8 b0 04 00 00       	call   1780 <printf>
    return;
    12d0:	83 c4 10             	add    $0x10,%esp
}
    12d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12d6:	5b                   	pop    %ebx
    12d7:	5e                   	pop    %esi
    12d8:	5f                   	pop    %edi
    12d9:	5d                   	pop    %ebp
    12da:	c3                   	ret    
    12db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12df:	90                   	nop
      printf(1, "ls: path too long\n");
    12e0:	83 ec 08             	sub    $0x8,%esp
    12e3:	68 1d 1b 00 00       	push   $0x1b1d
    12e8:	6a 01                	push   $0x1
    12ea:	e8 91 04 00 00       	call   1780 <printf>
      break;
    12ef:	83 c4 10             	add    $0x10,%esp
    12f2:	e9 5b fe ff ff       	jmp    1152 <ls+0x52>
    12f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12fe:	66 90                	xchg   %ax,%ax
    printf(2, "ls: cannot stat %s\n", path);
    1300:	83 ec 04             	sub    $0x4,%esp
    1303:	57                   	push   %edi
    1304:	68 fc 1a 00 00       	push   $0x1afc
    1309:	6a 02                	push   $0x2
    130b:	e8 70 04 00 00       	call   1780 <printf>
    close(fd);
    1310:	89 1c 24             	mov    %ebx,(%esp)
    1313:	e8 19 03 00 00       	call   1631 <close>
    return;
    1318:	83 c4 10             	add    $0x10,%esp
}
    131b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    131e:	5b                   	pop    %ebx
    131f:	5e                   	pop    %esi
    1320:	5f                   	pop    %edi
    1321:	5d                   	pop    %ebp
    1322:	c3                   	ret    
    1323:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1327:	90                   	nop
        printf(1, "ls: cannot stat %s\n", buf);
    1328:	83 ec 04             	sub    $0x4,%esp
    132b:	57                   	push   %edi
    132c:	68 fc 1a 00 00       	push   $0x1afc
    1331:	6a 01                	push   $0x1
    1333:	e8 48 04 00 00       	call   1780 <printf>
        continue;
    1338:	83 c4 10             	add    $0x10,%esp
    133b:	e9 c0 fe ff ff       	jmp    1200 <ls+0x100>

00001340 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"
char*
strcpy(char *s, const char *t)
{
    1340:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1341:	31 c0                	xor    %eax,%eax
{
    1343:	89 e5                	mov    %esp,%ebp
    1345:	53                   	push   %ebx
    1346:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1349:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    134c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    1350:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    1354:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    1357:	83 c0 01             	add    $0x1,%eax
    135a:	84 d2                	test   %dl,%dl
    135c:	75 f2                	jne    1350 <strcpy+0x10>
    ;
  return os;
}
    135e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1361:	89 c8                	mov    %ecx,%eax
    1363:	c9                   	leave  
    1364:	c3                   	ret    
    1365:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    136c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001370 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1370:	55                   	push   %ebp
    1371:	89 e5                	mov    %esp,%ebp
    1373:	53                   	push   %ebx
    1374:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1377:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    137a:	0f b6 01             	movzbl (%ecx),%eax
    137d:	0f b6 1a             	movzbl (%edx),%ebx
    1380:	84 c0                	test   %al,%al
    1382:	75 1d                	jne    13a1 <strcmp+0x31>
    1384:	eb 2a                	jmp    13b0 <strcmp+0x40>
    1386:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    138d:	8d 76 00             	lea    0x0(%esi),%esi
    1390:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    1394:	83 c1 01             	add    $0x1,%ecx
    1397:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    139a:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    139d:	84 c0                	test   %al,%al
    139f:	74 0f                	je     13b0 <strcmp+0x40>
    13a1:	38 d8                	cmp    %bl,%al
    13a3:	74 eb                	je     1390 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    13a5:	29 d8                	sub    %ebx,%eax
}
    13a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13aa:	c9                   	leave  
    13ab:	c3                   	ret    
    13ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    13b0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    13b2:	29 d8                	sub    %ebx,%eax
}
    13b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13b7:	c9                   	leave  
    13b8:	c3                   	ret    
    13b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000013c0 <strlen>:

uint
strlen(const char *s)
{
    13c0:	55                   	push   %ebp
    13c1:	89 e5                	mov    %esp,%ebp
    13c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    13c6:	80 3a 00             	cmpb   $0x0,(%edx)
    13c9:	74 15                	je     13e0 <strlen+0x20>
    13cb:	31 c0                	xor    %eax,%eax
    13cd:	8d 76 00             	lea    0x0(%esi),%esi
    13d0:	83 c0 01             	add    $0x1,%eax
    13d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    13d7:	89 c1                	mov    %eax,%ecx
    13d9:	75 f5                	jne    13d0 <strlen+0x10>
    ;
  return n;
}
    13db:	89 c8                	mov    %ecx,%eax
    13dd:	5d                   	pop    %ebp
    13de:	c3                   	ret    
    13df:	90                   	nop
  for(n = 0; s[n]; n++)
    13e0:	31 c9                	xor    %ecx,%ecx
}
    13e2:	5d                   	pop    %ebp
    13e3:	89 c8                	mov    %ecx,%eax
    13e5:	c3                   	ret    
    13e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13ed:	8d 76 00             	lea    0x0(%esi),%esi

000013f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	57                   	push   %edi
    13f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    13f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    13fd:	89 d7                	mov    %edx,%edi
    13ff:	fc                   	cld    
    1400:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1402:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1405:	89 d0                	mov    %edx,%eax
    1407:	c9                   	leave  
    1408:	c3                   	ret    
    1409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001410 <strchr>:

char*
strchr(const char *s, char c)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	8b 45 08             	mov    0x8(%ebp),%eax
    1416:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    141a:	0f b6 10             	movzbl (%eax),%edx
    141d:	84 d2                	test   %dl,%dl
    141f:	75 12                	jne    1433 <strchr+0x23>
    1421:	eb 1d                	jmp    1440 <strchr+0x30>
    1423:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1427:	90                   	nop
    1428:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    142c:	83 c0 01             	add    $0x1,%eax
    142f:	84 d2                	test   %dl,%dl
    1431:	74 0d                	je     1440 <strchr+0x30>
    if(*s == c)
    1433:	38 d1                	cmp    %dl,%cl
    1435:	75 f1                	jne    1428 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1437:	5d                   	pop    %ebp
    1438:	c3                   	ret    
    1439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    1440:	31 c0                	xor    %eax,%eax
}
    1442:	5d                   	pop    %ebp
    1443:	c3                   	ret    
    1444:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    144b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    144f:	90                   	nop

00001450 <gets>:

char*
gets(char *buf, int max)
{
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	57                   	push   %edi
    1454:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1455:	31 f6                	xor    %esi,%esi
{
    1457:	53                   	push   %ebx
    1458:	89 f3                	mov    %esi,%ebx
    145a:	83 ec 1c             	sub    $0x1c,%esp
    145d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1460:	eb 2f                	jmp    1491 <gets+0x41>
    1462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1468:	83 ec 04             	sub    $0x4,%esp
    146b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    146e:	6a 01                	push   $0x1
    1470:	50                   	push   %eax
    1471:	6a 00                	push   $0x0
    1473:	e8 a9 01 00 00       	call   1621 <read>
    if(cc < 1)
    1478:	83 c4 10             	add    $0x10,%esp
    147b:	85 c0                	test   %eax,%eax
    147d:	7e 1c                	jle    149b <gets+0x4b>
      break;
    buf[i++] = c;
    147f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    1483:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    1486:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1489:	3c 0a                	cmp    $0xa,%al
    148b:	74 23                	je     14b0 <gets+0x60>
    148d:	3c 0d                	cmp    $0xd,%al
    148f:	74 1f                	je     14b0 <gets+0x60>
  for(i=0; i+1 < max; ){
    1491:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    1494:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    1496:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1499:	7c cd                	jl     1468 <gets+0x18>
    149b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    149d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    14a0:	c6 03 00             	movb   $0x0,(%ebx)
}
    14a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14a6:	5b                   	pop    %ebx
    14a7:	5e                   	pop    %esi
    14a8:	5f                   	pop    %edi
    14a9:	5d                   	pop    %ebp
    14aa:	c3                   	ret    
    14ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    14af:	90                   	nop
  buf[i] = '\0';
    14b0:	8b 75 08             	mov    0x8(%ebp),%esi
}
    14b3:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    14b6:	01 de                	add    %ebx,%esi
    14b8:	89 f3                	mov    %esi,%ebx
    14ba:	c6 03 00             	movb   $0x0,(%ebx)
}
    14bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14c0:	5b                   	pop    %ebx
    14c1:	5e                   	pop    %esi
    14c2:	5f                   	pop    %edi
    14c3:	5d                   	pop    %ebp
    14c4:	c3                   	ret    
    14c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000014d0 <stat>:

int
stat(const char *n, struct stat *st)
{
    14d0:	55                   	push   %ebp
    14d1:	89 e5                	mov    %esp,%ebp
    14d3:	56                   	push   %esi
    14d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14d5:	83 ec 08             	sub    $0x8,%esp
    14d8:	6a 00                	push   $0x0
    14da:	ff 75 08             	pushl  0x8(%ebp)
    14dd:	e8 67 01 00 00       	call   1649 <open>
  if(fd < 0)
    14e2:	83 c4 10             	add    $0x10,%esp
    14e5:	85 c0                	test   %eax,%eax
    14e7:	78 27                	js     1510 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    14e9:	83 ec 08             	sub    $0x8,%esp
    14ec:	ff 75 0c             	pushl  0xc(%ebp)
    14ef:	89 c3                	mov    %eax,%ebx
    14f1:	50                   	push   %eax
    14f2:	e8 6a 01 00 00       	call   1661 <fstat>
  close(fd);
    14f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    14fa:	89 c6                	mov    %eax,%esi
  close(fd);
    14fc:	e8 30 01 00 00       	call   1631 <close>
  return r;
    1501:	83 c4 10             	add    $0x10,%esp
}
    1504:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1507:	89 f0                	mov    %esi,%eax
    1509:	5b                   	pop    %ebx
    150a:	5e                   	pop    %esi
    150b:	5d                   	pop    %ebp
    150c:	c3                   	ret    
    150d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1510:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1515:	eb ed                	jmp    1504 <stat+0x34>
    1517:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    151e:	66 90                	xchg   %ax,%ax

00001520 <atoi>:

int
atoi(const char *s)
{
    1520:	55                   	push   %ebp
    1521:	89 e5                	mov    %esp,%ebp
    1523:	53                   	push   %ebx
    1524:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1527:	0f be 02             	movsbl (%edx),%eax
    152a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    152d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1530:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1535:	77 1e                	ja     1555 <atoi+0x35>
    1537:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    153e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    1540:	83 c2 01             	add    $0x1,%edx
    1543:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1546:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    154a:	0f be 02             	movsbl (%edx),%eax
    154d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1550:	80 fb 09             	cmp    $0x9,%bl
    1553:	76 eb                	jbe    1540 <atoi+0x20>
  return n;
}
    1555:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1558:	89 c8                	mov    %ecx,%eax
    155a:	c9                   	leave  
    155b:	c3                   	ret    
    155c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001560 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1560:	55                   	push   %ebp
    1561:	89 e5                	mov    %esp,%ebp
    1563:	57                   	push   %edi
    1564:	8b 45 10             	mov    0x10(%ebp),%eax
    1567:	8b 55 08             	mov    0x8(%ebp),%edx
    156a:	56                   	push   %esi
    156b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    156e:	85 c0                	test   %eax,%eax
    1570:	7e 13                	jle    1585 <memmove+0x25>
    1572:	01 d0                	add    %edx,%eax
  dst = vdst;
    1574:	89 d7                	mov    %edx,%edi
    1576:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    157d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    1580:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    1581:	39 f8                	cmp    %edi,%eax
    1583:	75 fb                	jne    1580 <memmove+0x20>
  return vdst;
}
    1585:	5e                   	pop    %esi
    1586:	89 d0                	mov    %edx,%eax
    1588:	5f                   	pop    %edi
    1589:	5d                   	pop    %ebp
    158a:	c3                   	ret    
    158b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    158f:	90                   	nop

00001590 <thread_create>:


int thread_create(void (*start_routine)(void*, void*), void *arg1, void *arg2) {
    1590:	55                   	push   %ebp
    1591:	89 e5                	mov    %esp,%ebp
    1593:	53                   	push   %ebx
    1594:	83 ec 20             	sub    $0x20,%esp
  void *stack =  malloc(4096);
    1597:	68 00 10 00 00       	push   $0x1000
    159c:	e8 3f 04 00 00       	call   19e0 <malloc>
  if(stack == 0)
    15a1:	83 c4 10             	add    $0x10,%esp
    15a4:	85 c0                	test   %eax,%eax
    15a6:	74 3f                	je     15e7 <thread_create+0x57>
    return -1;
  int r= clone(start_routine, arg1, arg2, stack);
    15a8:	50                   	push   %eax
    15a9:	89 c3                	mov    %eax,%ebx
    15ab:	ff 75 10             	pushl  0x10(%ebp)
    15ae:	ff 75 0c             	pushl  0xc(%ebp)
    15b1:	ff 75 08             	pushl  0x8(%ebp)
    15b4:	e8 00 01 00 00       	call   16b9 <clone>
  if(r==-1) 
    15b9:	83 c4 10             	add    $0x10,%esp
    15bc:	83 f8 ff             	cmp    $0xffffffff,%eax
    15bf:	74 0f                	je     15d0 <thread_create+0x40>
    free(stack);
  return r;
}
    15c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15c4:	c9                   	leave  
    15c5:	c3                   	ret    
    15c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15cd:	8d 76 00             	lea    0x0(%esi),%esi
    free(stack);
    15d0:	83 ec 0c             	sub    $0xc,%esp
    15d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    15d6:	53                   	push   %ebx
    15d7:	e8 74 03 00 00       	call   1950 <free>
    15dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    15df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    free(stack);
    15e2:	83 c4 10             	add    $0x10,%esp
}
    15e5:	c9                   	leave  
    15e6:	c3                   	ret    
    return -1;
    15e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    15ec:	eb d3                	jmp    15c1 <thread_create+0x31>
    15ee:	66 90                	xchg   %ax,%ax

000015f0 <thread_join>:


int thread_join(void) {
    15f0:	55                   	push   %ebp
    15f1:	89 e5                	mov    %esp,%ebp
    15f3:	83 ec 24             	sub    $0x24,%esp
  void *stack;
  int r = join(&stack);
    15f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
    15f9:	50                   	push   %eax
    15fa:	e8 c2 00 00 00       	call   16c1 <join>
  return r;
}
    15ff:	c9                   	leave  
    1600:	c3                   	ret    

00001601 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1601:	b8 01 00 00 00       	mov    $0x1,%eax
    1606:	cd 40                	int    $0x40
    1608:	c3                   	ret    

00001609 <exit>:
SYSCALL(exit)
    1609:	b8 02 00 00 00       	mov    $0x2,%eax
    160e:	cd 40                	int    $0x40
    1610:	c3                   	ret    

00001611 <wait>:
SYSCALL(wait)
    1611:	b8 03 00 00 00       	mov    $0x3,%eax
    1616:	cd 40                	int    $0x40
    1618:	c3                   	ret    

00001619 <pipe>:
SYSCALL(pipe)
    1619:	b8 04 00 00 00       	mov    $0x4,%eax
    161e:	cd 40                	int    $0x40
    1620:	c3                   	ret    

00001621 <read>:
SYSCALL(read)
    1621:	b8 05 00 00 00       	mov    $0x5,%eax
    1626:	cd 40                	int    $0x40
    1628:	c3                   	ret    

00001629 <write>:
SYSCALL(write)
    1629:	b8 10 00 00 00       	mov    $0x10,%eax
    162e:	cd 40                	int    $0x40
    1630:	c3                   	ret    

00001631 <close>:
SYSCALL(close)
    1631:	b8 15 00 00 00       	mov    $0x15,%eax
    1636:	cd 40                	int    $0x40
    1638:	c3                   	ret    

00001639 <kill>:
SYSCALL(kill)
    1639:	b8 06 00 00 00       	mov    $0x6,%eax
    163e:	cd 40                	int    $0x40
    1640:	c3                   	ret    

00001641 <exec>:
SYSCALL(exec)
    1641:	b8 07 00 00 00       	mov    $0x7,%eax
    1646:	cd 40                	int    $0x40
    1648:	c3                   	ret    

00001649 <open>:
SYSCALL(open)
    1649:	b8 0f 00 00 00       	mov    $0xf,%eax
    164e:	cd 40                	int    $0x40
    1650:	c3                   	ret    

00001651 <mknod>:
SYSCALL(mknod)
    1651:	b8 11 00 00 00       	mov    $0x11,%eax
    1656:	cd 40                	int    $0x40
    1658:	c3                   	ret    

00001659 <unlink>:
SYSCALL(unlink)
    1659:	b8 12 00 00 00       	mov    $0x12,%eax
    165e:	cd 40                	int    $0x40
    1660:	c3                   	ret    

00001661 <fstat>:
SYSCALL(fstat)
    1661:	b8 08 00 00 00       	mov    $0x8,%eax
    1666:	cd 40                	int    $0x40
    1668:	c3                   	ret    

00001669 <link>:
SYSCALL(link)
    1669:	b8 13 00 00 00       	mov    $0x13,%eax
    166e:	cd 40                	int    $0x40
    1670:	c3                   	ret    

00001671 <mkdir>:
SYSCALL(mkdir)
    1671:	b8 14 00 00 00       	mov    $0x14,%eax
    1676:	cd 40                	int    $0x40
    1678:	c3                   	ret    

00001679 <chdir>:
SYSCALL(chdir)
    1679:	b8 09 00 00 00       	mov    $0x9,%eax
    167e:	cd 40                	int    $0x40
    1680:	c3                   	ret    

00001681 <dup>:
SYSCALL(dup)
    1681:	b8 0a 00 00 00       	mov    $0xa,%eax
    1686:	cd 40                	int    $0x40
    1688:	c3                   	ret    

00001689 <getpid>:
SYSCALL(getpid)
    1689:	b8 0b 00 00 00       	mov    $0xb,%eax
    168e:	cd 40                	int    $0x40
    1690:	c3                   	ret    

00001691 <sbrk>:
SYSCALL(sbrk)
    1691:	b8 0c 00 00 00       	mov    $0xc,%eax
    1696:	cd 40                	int    $0x40
    1698:	c3                   	ret    

00001699 <sleep>:
SYSCALL(sleep)
    1699:	b8 0d 00 00 00       	mov    $0xd,%eax
    169e:	cd 40                	int    $0x40
    16a0:	c3                   	ret    

000016a1 <uptime>:
SYSCALL(uptime)
    16a1:	b8 0e 00 00 00       	mov    $0xe,%eax
    16a6:	cd 40                	int    $0x40
    16a8:	c3                   	ret    

000016a9 <mprotect>:
SYSCALL(mprotect)
    16a9:	b8 16 00 00 00       	mov    $0x16,%eax
    16ae:	cd 40                	int    $0x40
    16b0:	c3                   	ret    

000016b1 <munprotect>:
SYSCALL(munprotect)
    16b1:	b8 17 00 00 00       	mov    $0x17,%eax
    16b6:	cd 40                	int    $0x40
    16b8:	c3                   	ret    

000016b9 <clone>:
SYSCALL(clone)
    16b9:	b8 18 00 00 00       	mov    $0x18,%eax
    16be:	cd 40                	int    $0x40
    16c0:	c3                   	ret    

000016c1 <join>:
SYSCALL(join)
    16c1:	b8 19 00 00 00       	mov    $0x19,%eax
    16c6:	cd 40                	int    $0x40
    16c8:	c3                   	ret    
    16c9:	66 90                	xchg   %ax,%ax
    16cb:	66 90                	xchg   %ax,%ax
    16cd:	66 90                	xchg   %ax,%ax
    16cf:	90                   	nop

000016d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    16d0:	55                   	push   %ebp
    16d1:	89 e5                	mov    %esp,%ebp
    16d3:	57                   	push   %edi
    16d4:	56                   	push   %esi
    16d5:	53                   	push   %ebx
    16d6:	83 ec 3c             	sub    $0x3c,%esp
    16d9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    16dc:	89 d1                	mov    %edx,%ecx
{
    16de:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    16e1:	85 d2                	test   %edx,%edx
    16e3:	0f 89 7f 00 00 00    	jns    1768 <printint+0x98>
    16e9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    16ed:	74 79                	je     1768 <printint+0x98>
    neg = 1;
    16ef:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    16f6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    16f8:	31 db                	xor    %ebx,%ebx
    16fa:	8d 75 d7             	lea    -0x29(%ebp),%esi
    16fd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1700:	89 c8                	mov    %ecx,%eax
    1702:	31 d2                	xor    %edx,%edx
    1704:	89 cf                	mov    %ecx,%edi
    1706:	f7 75 c4             	divl   -0x3c(%ebp)
    1709:	0f b6 92 3c 1b 00 00 	movzbl 0x1b3c(%edx),%edx
    1710:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1713:	89 d8                	mov    %ebx,%eax
    1715:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1718:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    171b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    171e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1721:	76 dd                	jbe    1700 <printint+0x30>
  if(neg)
    1723:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1726:	85 c9                	test   %ecx,%ecx
    1728:	74 0c                	je     1736 <printint+0x66>
    buf[i++] = '-';
    172a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    172f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1731:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1736:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1739:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    173d:	eb 07                	jmp    1746 <printint+0x76>
    173f:	90                   	nop
    putc(fd, buf[i]);
    1740:	0f b6 13             	movzbl (%ebx),%edx
    1743:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1746:	83 ec 04             	sub    $0x4,%esp
    1749:	88 55 d7             	mov    %dl,-0x29(%ebp)
    174c:	6a 01                	push   $0x1
    174e:	56                   	push   %esi
    174f:	57                   	push   %edi
    1750:	e8 d4 fe ff ff       	call   1629 <write>
  while(--i >= 0)
    1755:	83 c4 10             	add    $0x10,%esp
    1758:	39 de                	cmp    %ebx,%esi
    175a:	75 e4                	jne    1740 <printint+0x70>
}
    175c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    175f:	5b                   	pop    %ebx
    1760:	5e                   	pop    %esi
    1761:	5f                   	pop    %edi
    1762:	5d                   	pop    %ebp
    1763:	c3                   	ret    
    1764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1768:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    176f:	eb 87                	jmp    16f8 <printint+0x28>
    1771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1778:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    177f:	90                   	nop

00001780 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1780:	55                   	push   %ebp
    1781:	89 e5                	mov    %esp,%ebp
    1783:	57                   	push   %edi
    1784:	56                   	push   %esi
    1785:	53                   	push   %ebx
    1786:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1789:	8b 75 0c             	mov    0xc(%ebp),%esi
    178c:	0f b6 1e             	movzbl (%esi),%ebx
    178f:	84 db                	test   %bl,%bl
    1791:	0f 84 b8 00 00 00    	je     184f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    1797:	8d 45 10             	lea    0x10(%ebp),%eax
    179a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    179d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    17a0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    17a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    17a5:	eb 37                	jmp    17de <printf+0x5e>
    17a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17ae:	66 90                	xchg   %ax,%ax
    17b0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    17b3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    17b8:	83 f8 25             	cmp    $0x25,%eax
    17bb:	74 17                	je     17d4 <printf+0x54>
  write(fd, &c, 1);
    17bd:	83 ec 04             	sub    $0x4,%esp
    17c0:	88 5d e7             	mov    %bl,-0x19(%ebp)
    17c3:	6a 01                	push   $0x1
    17c5:	57                   	push   %edi
    17c6:	ff 75 08             	pushl  0x8(%ebp)
    17c9:	e8 5b fe ff ff       	call   1629 <write>
    17ce:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    17d1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    17d4:	0f b6 1e             	movzbl (%esi),%ebx
    17d7:	83 c6 01             	add    $0x1,%esi
    17da:	84 db                	test   %bl,%bl
    17dc:	74 71                	je     184f <printf+0xcf>
    c = fmt[i] & 0xff;
    17de:	0f be cb             	movsbl %bl,%ecx
    17e1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    17e4:	85 d2                	test   %edx,%edx
    17e6:	74 c8                	je     17b0 <printf+0x30>
      }
    } else if(state == '%'){
    17e8:	83 fa 25             	cmp    $0x25,%edx
    17eb:	75 e7                	jne    17d4 <printf+0x54>
      if(c == 'd'){
    17ed:	83 f8 64             	cmp    $0x64,%eax
    17f0:	0f 84 9a 00 00 00    	je     1890 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    17f6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    17fc:	83 f9 70             	cmp    $0x70,%ecx
    17ff:	74 5f                	je     1860 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1801:	83 f8 73             	cmp    $0x73,%eax
    1804:	0f 84 d6 00 00 00    	je     18e0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    180a:	83 f8 63             	cmp    $0x63,%eax
    180d:	0f 84 8d 00 00 00    	je     18a0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1813:	83 f8 25             	cmp    $0x25,%eax
    1816:	0f 84 b4 00 00 00    	je     18d0 <printf+0x150>
  write(fd, &c, 1);
    181c:	83 ec 04             	sub    $0x4,%esp
    181f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1823:	6a 01                	push   $0x1
    1825:	57                   	push   %edi
    1826:	ff 75 08             	pushl  0x8(%ebp)
    1829:	e8 fb fd ff ff       	call   1629 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    182e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1831:	83 c4 0c             	add    $0xc,%esp
    1834:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1836:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1839:	57                   	push   %edi
    183a:	ff 75 08             	pushl  0x8(%ebp)
    183d:	e8 e7 fd ff ff       	call   1629 <write>
  for(i = 0; fmt[i]; i++){
    1842:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    1846:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1849:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    184b:	84 db                	test   %bl,%bl
    184d:	75 8f                	jne    17de <printf+0x5e>
    }
  }
}
    184f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1852:	5b                   	pop    %ebx
    1853:	5e                   	pop    %esi
    1854:	5f                   	pop    %edi
    1855:	5d                   	pop    %ebp
    1856:	c3                   	ret    
    1857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    185e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    1860:	83 ec 0c             	sub    $0xc,%esp
    1863:	b9 10 00 00 00       	mov    $0x10,%ecx
    1868:	6a 00                	push   $0x0
    186a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    186d:	8b 45 08             	mov    0x8(%ebp),%eax
    1870:	8b 13                	mov    (%ebx),%edx
    1872:	e8 59 fe ff ff       	call   16d0 <printint>
        ap++;
    1877:	89 d8                	mov    %ebx,%eax
    1879:	83 c4 10             	add    $0x10,%esp
      state = 0;
    187c:	31 d2                	xor    %edx,%edx
        ap++;
    187e:	83 c0 04             	add    $0x4,%eax
    1881:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1884:	e9 4b ff ff ff       	jmp    17d4 <printf+0x54>
    1889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    1890:	83 ec 0c             	sub    $0xc,%esp
    1893:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1898:	6a 01                	push   $0x1
    189a:	eb ce                	jmp    186a <printf+0xea>
    189c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    18a0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    18a3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    18a6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    18a8:	6a 01                	push   $0x1
        ap++;
    18aa:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    18ad:	57                   	push   %edi
    18ae:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    18b1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    18b4:	e8 70 fd ff ff       	call   1629 <write>
        ap++;
    18b9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    18bc:	83 c4 10             	add    $0x10,%esp
      state = 0;
    18bf:	31 d2                	xor    %edx,%edx
    18c1:	e9 0e ff ff ff       	jmp    17d4 <printf+0x54>
    18c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    18cd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    18d0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    18d3:	83 ec 04             	sub    $0x4,%esp
    18d6:	e9 59 ff ff ff       	jmp    1834 <printf+0xb4>
    18db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    18df:	90                   	nop
        s = (char*)*ap;
    18e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    18e3:	8b 18                	mov    (%eax),%ebx
        ap++;
    18e5:	83 c0 04             	add    $0x4,%eax
    18e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    18eb:	85 db                	test   %ebx,%ebx
    18ed:	74 17                	je     1906 <printf+0x186>
        while(*s != 0){
    18ef:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    18f2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    18f4:	84 c0                	test   %al,%al
    18f6:	0f 84 d8 fe ff ff    	je     17d4 <printf+0x54>
    18fc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    18ff:	89 de                	mov    %ebx,%esi
    1901:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1904:	eb 1a                	jmp    1920 <printf+0x1a0>
          s = "(null)";
    1906:	bb 32 1b 00 00       	mov    $0x1b32,%ebx
        while(*s != 0){
    190b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    190e:	b8 28 00 00 00       	mov    $0x28,%eax
    1913:	89 de                	mov    %ebx,%esi
    1915:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1918:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    191f:	90                   	nop
  write(fd, &c, 1);
    1920:	83 ec 04             	sub    $0x4,%esp
          s++;
    1923:	83 c6 01             	add    $0x1,%esi
    1926:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1929:	6a 01                	push   $0x1
    192b:	57                   	push   %edi
    192c:	53                   	push   %ebx
    192d:	e8 f7 fc ff ff       	call   1629 <write>
        while(*s != 0){
    1932:	0f b6 06             	movzbl (%esi),%eax
    1935:	83 c4 10             	add    $0x10,%esp
    1938:	84 c0                	test   %al,%al
    193a:	75 e4                	jne    1920 <printf+0x1a0>
      state = 0;
    193c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    193f:	31 d2                	xor    %edx,%edx
    1941:	e9 8e fe ff ff       	jmp    17d4 <printf+0x54>
    1946:	66 90                	xchg   %ax,%ax
    1948:	66 90                	xchg   %ax,%ax
    194a:	66 90                	xchg   %ax,%ax
    194c:	66 90                	xchg   %ax,%ax
    194e:	66 90                	xchg   %ax,%ax

00001950 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1950:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1951:	a1 c8 1e 00 00       	mov    0x1ec8,%eax
{
    1956:	89 e5                	mov    %esp,%ebp
    1958:	57                   	push   %edi
    1959:	56                   	push   %esi
    195a:	53                   	push   %ebx
    195b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    195e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1968:	89 c2                	mov    %eax,%edx
    196a:	8b 00                	mov    (%eax),%eax
    196c:	39 ca                	cmp    %ecx,%edx
    196e:	73 30                	jae    19a0 <free+0x50>
    1970:	39 c1                	cmp    %eax,%ecx
    1972:	72 04                	jb     1978 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1974:	39 c2                	cmp    %eax,%edx
    1976:	72 f0                	jb     1968 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1978:	8b 73 fc             	mov    -0x4(%ebx),%esi
    197b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    197e:	39 f8                	cmp    %edi,%eax
    1980:	74 30                	je     19b2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1982:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    1985:	8b 42 04             	mov    0x4(%edx),%eax
    1988:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    198b:	39 f1                	cmp    %esi,%ecx
    198d:	74 3a                	je     19c9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    198f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    1991:	5b                   	pop    %ebx
  freep = p;
    1992:	89 15 c8 1e 00 00    	mov    %edx,0x1ec8
}
    1998:	5e                   	pop    %esi
    1999:	5f                   	pop    %edi
    199a:	5d                   	pop    %ebp
    199b:	c3                   	ret    
    199c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    19a0:	39 c2                	cmp    %eax,%edx
    19a2:	72 c4                	jb     1968 <free+0x18>
    19a4:	39 c1                	cmp    %eax,%ecx
    19a6:	73 c0                	jae    1968 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    19a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    19ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    19ae:	39 f8                	cmp    %edi,%eax
    19b0:	75 d0                	jne    1982 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    19b2:	03 70 04             	add    0x4(%eax),%esi
    19b5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    19b8:	8b 02                	mov    (%edx),%eax
    19ba:	8b 00                	mov    (%eax),%eax
    19bc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    19bf:	8b 42 04             	mov    0x4(%edx),%eax
    19c2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    19c5:	39 f1                	cmp    %esi,%ecx
    19c7:	75 c6                	jne    198f <free+0x3f>
    p->s.size += bp->s.size;
    19c9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    19cc:	89 15 c8 1e 00 00    	mov    %edx,0x1ec8
    p->s.size += bp->s.size;
    19d2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    19d5:	8b 43 f8             	mov    -0x8(%ebx),%eax
    19d8:	89 02                	mov    %eax,(%edx)
}
    19da:	5b                   	pop    %ebx
    19db:	5e                   	pop    %esi
    19dc:	5f                   	pop    %edi
    19dd:	5d                   	pop    %ebp
    19de:	c3                   	ret    
    19df:	90                   	nop

000019e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    19e0:	55                   	push   %ebp
    19e1:	89 e5                	mov    %esp,%ebp
    19e3:	57                   	push   %edi
    19e4:	56                   	push   %esi
    19e5:	53                   	push   %ebx
    19e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    19e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    19ec:	8b 3d c8 1e 00 00    	mov    0x1ec8,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    19f2:	8d 70 07             	lea    0x7(%eax),%esi
    19f5:	c1 ee 03             	shr    $0x3,%esi
    19f8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    19fb:	85 ff                	test   %edi,%edi
    19fd:	0f 84 ad 00 00 00    	je     1ab0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a03:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1a05:	8b 48 04             	mov    0x4(%eax),%ecx
    1a08:	39 f1                	cmp    %esi,%ecx
    1a0a:	73 71                	jae    1a7d <malloc+0x9d>
    1a0c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1a12:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1a17:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    1a1a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1a21:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1a24:	eb 1b                	jmp    1a41 <malloc+0x61>
    1a26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1a2d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a30:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1a32:	8b 4a 04             	mov    0x4(%edx),%ecx
    1a35:	39 f1                	cmp    %esi,%ecx
    1a37:	73 4f                	jae    1a88 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1a39:	8b 3d c8 1e 00 00    	mov    0x1ec8,%edi
    1a3f:	89 d0                	mov    %edx,%eax
    1a41:	39 c7                	cmp    %eax,%edi
    1a43:	75 eb                	jne    1a30 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1a45:	83 ec 0c             	sub    $0xc,%esp
    1a48:	ff 75 e4             	pushl  -0x1c(%ebp)
    1a4b:	e8 41 fc ff ff       	call   1691 <sbrk>
  if(p == (char*)-1)
    1a50:	83 c4 10             	add    $0x10,%esp
    1a53:	83 f8 ff             	cmp    $0xffffffff,%eax
    1a56:	74 1b                	je     1a73 <malloc+0x93>
  hp->s.size = nu;
    1a58:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1a5b:	83 ec 0c             	sub    $0xc,%esp
    1a5e:	83 c0 08             	add    $0x8,%eax
    1a61:	50                   	push   %eax
    1a62:	e8 e9 fe ff ff       	call   1950 <free>
  return freep;
    1a67:	a1 c8 1e 00 00       	mov    0x1ec8,%eax
      if((p = morecore(nunits)) == 0)
    1a6c:	83 c4 10             	add    $0x10,%esp
    1a6f:	85 c0                	test   %eax,%eax
    1a71:	75 bd                	jne    1a30 <malloc+0x50>
        return 0;
  }
}
    1a73:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1a76:	31 c0                	xor    %eax,%eax
}
    1a78:	5b                   	pop    %ebx
    1a79:	5e                   	pop    %esi
    1a7a:	5f                   	pop    %edi
    1a7b:	5d                   	pop    %ebp
    1a7c:	c3                   	ret    
    if(p->s.size >= nunits){
    1a7d:	89 c2                	mov    %eax,%edx
    1a7f:	89 f8                	mov    %edi,%eax
    1a81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1a88:	39 ce                	cmp    %ecx,%esi
    1a8a:	74 54                	je     1ae0 <malloc+0x100>
        p->s.size -= nunits;
    1a8c:	29 f1                	sub    %esi,%ecx
    1a8e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    1a91:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    1a94:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    1a97:	a3 c8 1e 00 00       	mov    %eax,0x1ec8
}
    1a9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1a9f:	8d 42 08             	lea    0x8(%edx),%eax
}
    1aa2:	5b                   	pop    %ebx
    1aa3:	5e                   	pop    %esi
    1aa4:	5f                   	pop    %edi
    1aa5:	5d                   	pop    %ebp
    1aa6:	c3                   	ret    
    1aa7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1aae:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    1ab0:	c7 05 c8 1e 00 00 cc 	movl   $0x1ecc,0x1ec8
    1ab7:	1e 00 00 
    base.s.size = 0;
    1aba:	bf cc 1e 00 00       	mov    $0x1ecc,%edi
    base.s.ptr = freep = prevp = &base;
    1abf:	c7 05 cc 1e 00 00 cc 	movl   $0x1ecc,0x1ecc
    1ac6:	1e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ac9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    1acb:	c7 05 d0 1e 00 00 00 	movl   $0x0,0x1ed0
    1ad2:	00 00 00 
    if(p->s.size >= nunits){
    1ad5:	e9 32 ff ff ff       	jmp    1a0c <malloc+0x2c>
    1ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1ae0:	8b 0a                	mov    (%edx),%ecx
    1ae2:	89 08                	mov    %ecx,(%eax)
    1ae4:	eb b1                	jmp    1a97 <malloc+0xb7>
