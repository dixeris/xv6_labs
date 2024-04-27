
_grep:     file format elf32-i386


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
    100f:	53                   	push   %ebx
    1010:	51                   	push   %ecx
    1011:	83 ec 18             	sub    $0x18,%esp
    1014:	8b 01                	mov    (%ecx),%eax
    1016:	8b 59 04             	mov    0x4(%ecx),%ebx
    1019:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
    101c:	83 f8 01             	cmp    $0x1,%eax
    101f:	7e 6f                	jle    1090 <main+0x90>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
    1021:	8b 43 04             	mov    0x4(%ebx),%eax
    1024:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
    1027:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    102b:	be 02 00 00 00       	mov    $0x2,%esi
  pattern = argv[1];
    1030:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
    1033:	75 2d                	jne    1062 <main+0x62>
    1035:	eb 6c                	jmp    10a3 <main+0xa3>
    1037:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    103e:	66 90                	xchg   %ax,%ax
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
    1040:	83 ec 08             	sub    $0x8,%esp
  for(i = 2; i < argc; i++){
    1043:	83 c6 01             	add    $0x1,%esi
    1046:	83 c3 04             	add    $0x4,%ebx
    grep(pattern, fd);
    1049:	50                   	push   %eax
    104a:	ff 75 e0             	pushl  -0x20(%ebp)
    104d:	e8 7e 01 00 00       	call   11d0 <grep>
    close(fd);
    1052:	89 3c 24             	mov    %edi,(%esp)
    1055:	e8 07 06 00 00       	call   1661 <close>
  for(i = 2; i < argc; i++){
    105a:	83 c4 10             	add    $0x10,%esp
    105d:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
    1060:	7e 29                	jle    108b <main+0x8b>
    if((fd = open(argv[i], 0)) < 0){
    1062:	83 ec 08             	sub    $0x8,%esp
    1065:	6a 00                	push   $0x0
    1067:	ff 33                	pushl  (%ebx)
    1069:	e8 0b 06 00 00       	call   1679 <open>
    106e:	83 c4 10             	add    $0x10,%esp
    1071:	89 c7                	mov    %eax,%edi
    1073:	85 c0                	test   %eax,%eax
    1075:	79 c9                	jns    1040 <main+0x40>
      printf(1, "grep: cannot open %s\n", argv[i]);
    1077:	50                   	push   %eax
    1078:	ff 33                	pushl  (%ebx)
    107a:	68 38 1b 00 00       	push   $0x1b38
    107f:	6a 01                	push   $0x1
    1081:	e8 2a 07 00 00       	call   17b0 <printf>
      exit();
    1086:	e8 ae 05 00 00       	call   1639 <exit>
  }
  exit();
    108b:	e8 a9 05 00 00       	call   1639 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
    1090:	51                   	push   %ecx
    1091:	51                   	push   %ecx
    1092:	68 18 1b 00 00       	push   $0x1b18
    1097:	6a 02                	push   $0x2
    1099:	e8 12 07 00 00       	call   17b0 <printf>
    exit();
    109e:	e8 96 05 00 00       	call   1639 <exit>
    grep(pattern, 0);
    10a3:	52                   	push   %edx
    10a4:	52                   	push   %edx
    10a5:	6a 00                	push   $0x0
    10a7:	50                   	push   %eax
    10a8:	e8 23 01 00 00       	call   11d0 <grep>
    exit();
    10ad:	e8 87 05 00 00       	call   1639 <exit>
    10b2:	66 90                	xchg   %ax,%ax
    10b4:	66 90                	xchg   %ax,%ax
    10b6:	66 90                	xchg   %ax,%ax
    10b8:	66 90                	xchg   %ax,%ax
    10ba:	66 90                	xchg   %ax,%ax
    10bc:	66 90                	xchg   %ax,%ax
    10be:	66 90                	xchg   %ax,%ax

000010c0 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	57                   	push   %edi
    10c4:	56                   	push   %esi
    10c5:	53                   	push   %ebx
    10c6:	83 ec 0c             	sub    $0xc,%esp
    10c9:	8b 75 08             	mov    0x8(%ebp),%esi
    10cc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '\0')
    10cf:	0f b6 06             	movzbl (%esi),%eax
    10d2:	84 c0                	test   %al,%al
    10d4:	75 2d                	jne    1103 <matchhere+0x43>
    10d6:	e9 7d 00 00 00       	jmp    1158 <matchhere+0x98>
    10db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10df:	90                   	nop
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
    10e0:	0f b6 0b             	movzbl (%ebx),%ecx
  if(re[0] == '$' && re[1] == '\0')
    10e3:	80 fa 24             	cmp    $0x24,%dl
    10e6:	75 04                	jne    10ec <matchhere+0x2c>
    10e8:	84 c0                	test   %al,%al
    10ea:	74 79                	je     1165 <matchhere+0xa5>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    10ec:	84 c9                	test   %cl,%cl
    10ee:	74 58                	je     1148 <matchhere+0x88>
    10f0:	38 d1                	cmp    %dl,%cl
    10f2:	74 05                	je     10f9 <matchhere+0x39>
    10f4:	80 fa 2e             	cmp    $0x2e,%dl
    10f7:	75 4f                	jne    1148 <matchhere+0x88>
    return matchhere(re+1, text+1);
    10f9:	83 c3 01             	add    $0x1,%ebx
    10fc:	83 c6 01             	add    $0x1,%esi
  if(re[0] == '\0')
    10ff:	84 c0                	test   %al,%al
    1101:	74 55                	je     1158 <matchhere+0x98>
  if(re[1] == '*')
    1103:	89 c2                	mov    %eax,%edx
    1105:	0f b6 46 01          	movzbl 0x1(%esi),%eax
    1109:	3c 2a                	cmp    $0x2a,%al
    110b:	75 d3                	jne    10e0 <matchhere+0x20>
    return matchstar(re[0], re+2, text);
    110d:	83 c6 02             	add    $0x2,%esi
    1110:	0f be fa             	movsbl %dl,%edi
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
    1113:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1117:	90                   	nop
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
    1118:	83 ec 08             	sub    $0x8,%esp
    111b:	53                   	push   %ebx
    111c:	56                   	push   %esi
    111d:	e8 9e ff ff ff       	call   10c0 <matchhere>
    1122:	83 c4 10             	add    $0x10,%esp
    1125:	85 c0                	test   %eax,%eax
    1127:	75 2f                	jne    1158 <matchhere+0x98>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
    1129:	0f be 13             	movsbl (%ebx),%edx
    112c:	84 d2                	test   %dl,%dl
    112e:	74 0c                	je     113c <matchhere+0x7c>
    1130:	83 c3 01             	add    $0x1,%ebx
    1133:	83 ff 2e             	cmp    $0x2e,%edi
    1136:	74 e0                	je     1118 <matchhere+0x58>
    1138:	39 fa                	cmp    %edi,%edx
    113a:	74 dc                	je     1118 <matchhere+0x58>
}
    113c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    113f:	5b                   	pop    %ebx
    1140:	5e                   	pop    %esi
    1141:	5f                   	pop    %edi
    1142:	5d                   	pop    %ebp
    1143:	c3                   	ret    
    1144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1148:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
    114b:	31 c0                	xor    %eax,%eax
}
    114d:	5b                   	pop    %ebx
    114e:	5e                   	pop    %esi
    114f:	5f                   	pop    %edi
    1150:	5d                   	pop    %ebp
    1151:	c3                   	ret    
    1152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1158:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 1;
    115b:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1160:	5b                   	pop    %ebx
    1161:	5e                   	pop    %esi
    1162:	5f                   	pop    %edi
    1163:	5d                   	pop    %ebp
    1164:	c3                   	ret    
    return *text == '\0';
    1165:	31 c0                	xor    %eax,%eax
    1167:	84 c9                	test   %cl,%cl
    1169:	0f 94 c0             	sete   %al
    116c:	eb ce                	jmp    113c <matchhere+0x7c>
    116e:	66 90                	xchg   %ax,%ax

00001170 <match>:
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	56                   	push   %esi
    1174:	53                   	push   %ebx
    1175:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1178:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(re[0] == '^')
    117b:	80 3b 5e             	cmpb   $0x5e,(%ebx)
    117e:	75 11                	jne    1191 <match+0x21>
    1180:	eb 2e                	jmp    11b0 <match+0x40>
    1182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
    1188:	83 c6 01             	add    $0x1,%esi
    118b:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
    118f:	74 16                	je     11a7 <match+0x37>
    if(matchhere(re, text))
    1191:	83 ec 08             	sub    $0x8,%esp
    1194:	56                   	push   %esi
    1195:	53                   	push   %ebx
    1196:	e8 25 ff ff ff       	call   10c0 <matchhere>
    119b:	83 c4 10             	add    $0x10,%esp
    119e:	85 c0                	test   %eax,%eax
    11a0:	74 e6                	je     1188 <match+0x18>
      return 1;
    11a2:	b8 01 00 00 00       	mov    $0x1,%eax
}
    11a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11aa:	5b                   	pop    %ebx
    11ab:	5e                   	pop    %esi
    11ac:	5d                   	pop    %ebp
    11ad:	c3                   	ret    
    11ae:	66 90                	xchg   %ax,%ax
    return matchhere(re+1, text);
    11b0:	83 c3 01             	add    $0x1,%ebx
    11b3:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
    11b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11b9:	5b                   	pop    %ebx
    11ba:	5e                   	pop    %esi
    11bb:	5d                   	pop    %ebp
    return matchhere(re+1, text);
    11bc:	e9 ff fe ff ff       	jmp    10c0 <matchhere>
    11c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11cf:	90                   	nop

000011d0 <grep>:
{
    11d0:	55                   	push   %ebp
    11d1:	89 e5                	mov    %esp,%ebp
    11d3:	57                   	push   %edi
    11d4:	56                   	push   %esi
    11d5:	53                   	push   %ebx
    11d6:	83 ec 1c             	sub    $0x1c,%esp
    11d9:	8b 7d 08             	mov    0x8(%ebp),%edi
  m = 0;
    11dc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    return matchhere(re+1, text);
    11e3:	8d 47 01             	lea    0x1(%edi),%eax
    11e6:	89 45 d8             	mov    %eax,-0x28(%ebp)
    11e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    11f0:	8b 4d dc             	mov    -0x24(%ebp),%ecx
    11f3:	b8 ff 03 00 00       	mov    $0x3ff,%eax
    11f8:	83 ec 04             	sub    $0x4,%esp
    11fb:	29 c8                	sub    %ecx,%eax
    11fd:	50                   	push   %eax
    11fe:	8d 81 60 1f 00 00    	lea    0x1f60(%ecx),%eax
    1204:	50                   	push   %eax
    1205:	ff 75 0c             	pushl  0xc(%ebp)
    1208:	e8 44 04 00 00       	call   1651 <read>
    120d:	83 c4 10             	add    $0x10,%esp
    1210:	85 c0                	test   %eax,%eax
    1212:	0f 8e e5 00 00 00    	jle    12fd <grep+0x12d>
    m += n;
    1218:	01 45 dc             	add    %eax,-0x24(%ebp)
    121b:	8b 4d dc             	mov    -0x24(%ebp),%ecx
    p = buf;
    121e:	c7 45 e4 60 1f 00 00 	movl   $0x1f60,-0x1c(%ebp)
    buf[m] = '\0';
    1225:	c6 81 60 1f 00 00 00 	movb   $0x0,0x1f60(%ecx)
    while((q = strchr(p, '\n')) != 0){
    122c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1230:	83 ec 08             	sub    $0x8,%esp
    1233:	6a 0a                	push   $0xa
    1235:	ff 75 e4             	pushl  -0x1c(%ebp)
    1238:	e8 03 02 00 00       	call   1440 <strchr>
    123d:	83 c4 10             	add    $0x10,%esp
    1240:	89 c3                	mov    %eax,%ebx
    1242:	85 c0                	test   %eax,%eax
    1244:	74 72                	je     12b8 <grep+0xe8>
      *q = 0;
    1246:	c6 03 00             	movb   $0x0,(%ebx)
        write(1, p, q+1 - p);
    1249:	8d 43 01             	lea    0x1(%ebx),%eax
  if(re[0] == '^')
    124c:	80 3f 5e             	cmpb   $0x5e,(%edi)
        write(1, p, q+1 - p);
    124f:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1252:	8b 75 e4             	mov    -0x1c(%ebp),%esi
  if(re[0] == '^')
    1255:	75 12                	jne    1269 <grep+0x99>
    1257:	eb 47                	jmp    12a0 <grep+0xd0>
    1259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }while(*text++ != '\0');
    1260:	83 c6 01             	add    $0x1,%esi
    1263:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
    1267:	74 2b                	je     1294 <grep+0xc4>
    if(matchhere(re, text))
    1269:	83 ec 08             	sub    $0x8,%esp
    126c:	56                   	push   %esi
    126d:	57                   	push   %edi
    126e:	e8 4d fe ff ff       	call   10c0 <matchhere>
    1273:	83 c4 10             	add    $0x10,%esp
    1276:	85 c0                	test   %eax,%eax
    1278:	74 e6                	je     1260 <grep+0x90>
        write(1, p, q+1 - p);
    127a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    127d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1280:	83 ec 04             	sub    $0x4,%esp
        *q = '\n';
    1283:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
    1286:	29 d0                	sub    %edx,%eax
    1288:	50                   	push   %eax
    1289:	52                   	push   %edx
    128a:	6a 01                	push   $0x1
    128c:	e8 c8 03 00 00       	call   1659 <write>
    1291:	83 c4 10             	add    $0x10,%esp
      p = q+1;
    1294:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1297:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    129a:	eb 94                	jmp    1230 <grep+0x60>
    129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return matchhere(re+1, text);
    12a0:	83 ec 08             	sub    $0x8,%esp
    12a3:	56                   	push   %esi
    12a4:	ff 75 d8             	pushl  -0x28(%ebp)
    12a7:	e8 14 fe ff ff       	call   10c0 <matchhere>
    12ac:	83 c4 10             	add    $0x10,%esp
      if(match(pattern, p)){
    12af:	85 c0                	test   %eax,%eax
    12b1:	74 e1                	je     1294 <grep+0xc4>
    12b3:	eb c5                	jmp    127a <grep+0xaa>
    12b5:	8d 76 00             	lea    0x0(%esi),%esi
    if(p == buf)
    12b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    12bb:	81 fa 60 1f 00 00    	cmp    $0x1f60,%edx
    12c1:	74 2e                	je     12f1 <grep+0x121>
    if(m > 0){
    12c3:	8b 4d dc             	mov    -0x24(%ebp),%ecx
    12c6:	85 c9                	test   %ecx,%ecx
    12c8:	0f 8e 22 ff ff ff    	jle    11f0 <grep+0x20>
      m -= p - buf;
    12ce:	89 d0                	mov    %edx,%eax
      memmove(buf, p, m);
    12d0:	83 ec 04             	sub    $0x4,%esp
      m -= p - buf;
    12d3:	2d 60 1f 00 00       	sub    $0x1f60,%eax
    12d8:	29 c1                	sub    %eax,%ecx
      memmove(buf, p, m);
    12da:	51                   	push   %ecx
    12db:	52                   	push   %edx
    12dc:	68 60 1f 00 00       	push   $0x1f60
      m -= p - buf;
    12e1:	89 4d dc             	mov    %ecx,-0x24(%ebp)
      memmove(buf, p, m);
    12e4:	e8 a7 02 00 00       	call   1590 <memmove>
    12e9:	83 c4 10             	add    $0x10,%esp
    12ec:	e9 ff fe ff ff       	jmp    11f0 <grep+0x20>
      m = 0;
    12f1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    12f8:	e9 f3 fe ff ff       	jmp    11f0 <grep+0x20>
}
    12fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1300:	5b                   	pop    %ebx
    1301:	5e                   	pop    %esi
    1302:	5f                   	pop    %edi
    1303:	5d                   	pop    %ebp
    1304:	c3                   	ret    
    1305:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    130c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001310 <matchstar>:
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	57                   	push   %edi
    1314:	56                   	push   %esi
    1315:	53                   	push   %ebx
    1316:	83 ec 0c             	sub    $0xc,%esp
    1319:	8b 5d 08             	mov    0x8(%ebp),%ebx
    131c:	8b 75 0c             	mov    0xc(%ebp),%esi
    131f:	8b 7d 10             	mov    0x10(%ebp),%edi
    1322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(matchhere(re, text))
    1328:	83 ec 08             	sub    $0x8,%esp
    132b:	57                   	push   %edi
    132c:	56                   	push   %esi
    132d:	e8 8e fd ff ff       	call   10c0 <matchhere>
    1332:	83 c4 10             	add    $0x10,%esp
    1335:	89 c2                	mov    %eax,%edx
    1337:	85 c0                	test   %eax,%eax
    1339:	75 25                	jne    1360 <matchstar+0x50>
  }while(*text!='\0' && (*text++==c || c=='.'));
    133b:	0f be 07             	movsbl (%edi),%eax
    133e:	84 c0                	test   %al,%al
    1340:	74 0c                	je     134e <matchstar+0x3e>
    1342:	83 c7 01             	add    $0x1,%edi
    1345:	39 d8                	cmp    %ebx,%eax
    1347:	74 df                	je     1328 <matchstar+0x18>
    1349:	83 fb 2e             	cmp    $0x2e,%ebx
    134c:	74 da                	je     1328 <matchstar+0x18>
}
    134e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1351:	89 d0                	mov    %edx,%eax
    1353:	5b                   	pop    %ebx
    1354:	5e                   	pop    %esi
    1355:	5f                   	pop    %edi
    1356:	5d                   	pop    %ebp
    1357:	c3                   	ret    
    1358:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    135f:	90                   	nop
    1360:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 1;
    1363:	ba 01 00 00 00       	mov    $0x1,%edx
}
    1368:	5b                   	pop    %ebx
    1369:	89 d0                	mov    %edx,%eax
    136b:	5e                   	pop    %esi
    136c:	5f                   	pop    %edi
    136d:	5d                   	pop    %ebp
    136e:	c3                   	ret    
    136f:	90                   	nop

00001370 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"
char*
strcpy(char *s, const char *t)
{
    1370:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1371:	31 c0                	xor    %eax,%eax
{
    1373:	89 e5                	mov    %esp,%ebp
    1375:	53                   	push   %ebx
    1376:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1379:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    137c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    1380:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    1384:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    1387:	83 c0 01             	add    $0x1,%eax
    138a:	84 d2                	test   %dl,%dl
    138c:	75 f2                	jne    1380 <strcpy+0x10>
    ;
  return os;
}
    138e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1391:	89 c8                	mov    %ecx,%eax
    1393:	c9                   	leave  
    1394:	c3                   	ret    
    1395:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    139c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000013a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	53                   	push   %ebx
    13a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    13a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    13aa:	0f b6 01             	movzbl (%ecx),%eax
    13ad:	0f b6 1a             	movzbl (%edx),%ebx
    13b0:	84 c0                	test   %al,%al
    13b2:	75 1d                	jne    13d1 <strcmp+0x31>
    13b4:	eb 2a                	jmp    13e0 <strcmp+0x40>
    13b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13bd:	8d 76 00             	lea    0x0(%esi),%esi
    13c0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    13c4:	83 c1 01             	add    $0x1,%ecx
    13c7:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    13ca:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    13cd:	84 c0                	test   %al,%al
    13cf:	74 0f                	je     13e0 <strcmp+0x40>
    13d1:	38 d8                	cmp    %bl,%al
    13d3:	74 eb                	je     13c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    13d5:	29 d8                	sub    %ebx,%eax
}
    13d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13da:	c9                   	leave  
    13db:	c3                   	ret    
    13dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    13e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    13e2:	29 d8                	sub    %ebx,%eax
}
    13e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13e7:	c9                   	leave  
    13e8:	c3                   	ret    
    13e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000013f0 <strlen>:

uint
strlen(const char *s)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    13f6:	80 3a 00             	cmpb   $0x0,(%edx)
    13f9:	74 15                	je     1410 <strlen+0x20>
    13fb:	31 c0                	xor    %eax,%eax
    13fd:	8d 76 00             	lea    0x0(%esi),%esi
    1400:	83 c0 01             	add    $0x1,%eax
    1403:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    1407:	89 c1                	mov    %eax,%ecx
    1409:	75 f5                	jne    1400 <strlen+0x10>
    ;
  return n;
}
    140b:	89 c8                	mov    %ecx,%eax
    140d:	5d                   	pop    %ebp
    140e:	c3                   	ret    
    140f:	90                   	nop
  for(n = 0; s[n]; n++)
    1410:	31 c9                	xor    %ecx,%ecx
}
    1412:	5d                   	pop    %ebp
    1413:	89 c8                	mov    %ecx,%eax
    1415:	c3                   	ret    
    1416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    141d:	8d 76 00             	lea    0x0(%esi),%esi

00001420 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	57                   	push   %edi
    1424:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1427:	8b 4d 10             	mov    0x10(%ebp),%ecx
    142a:	8b 45 0c             	mov    0xc(%ebp),%eax
    142d:	89 d7                	mov    %edx,%edi
    142f:	fc                   	cld    
    1430:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1432:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1435:	89 d0                	mov    %edx,%eax
    1437:	c9                   	leave  
    1438:	c3                   	ret    
    1439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001440 <strchr>:

char*
strchr(const char *s, char c)
{
    1440:	55                   	push   %ebp
    1441:	89 e5                	mov    %esp,%ebp
    1443:	8b 45 08             	mov    0x8(%ebp),%eax
    1446:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    144a:	0f b6 10             	movzbl (%eax),%edx
    144d:	84 d2                	test   %dl,%dl
    144f:	75 12                	jne    1463 <strchr+0x23>
    1451:	eb 1d                	jmp    1470 <strchr+0x30>
    1453:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1457:	90                   	nop
    1458:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    145c:	83 c0 01             	add    $0x1,%eax
    145f:	84 d2                	test   %dl,%dl
    1461:	74 0d                	je     1470 <strchr+0x30>
    if(*s == c)
    1463:	38 d1                	cmp    %dl,%cl
    1465:	75 f1                	jne    1458 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1467:	5d                   	pop    %ebp
    1468:	c3                   	ret    
    1469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    1470:	31 c0                	xor    %eax,%eax
}
    1472:	5d                   	pop    %ebp
    1473:	c3                   	ret    
    1474:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    147b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    147f:	90                   	nop

00001480 <gets>:

char*
gets(char *buf, int max)
{
    1480:	55                   	push   %ebp
    1481:	89 e5                	mov    %esp,%ebp
    1483:	57                   	push   %edi
    1484:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1485:	31 f6                	xor    %esi,%esi
{
    1487:	53                   	push   %ebx
    1488:	89 f3                	mov    %esi,%ebx
    148a:	83 ec 1c             	sub    $0x1c,%esp
    148d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1490:	eb 2f                	jmp    14c1 <gets+0x41>
    1492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1498:	83 ec 04             	sub    $0x4,%esp
    149b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    149e:	6a 01                	push   $0x1
    14a0:	50                   	push   %eax
    14a1:	6a 00                	push   $0x0
    14a3:	e8 a9 01 00 00       	call   1651 <read>
    if(cc < 1)
    14a8:	83 c4 10             	add    $0x10,%esp
    14ab:	85 c0                	test   %eax,%eax
    14ad:	7e 1c                	jle    14cb <gets+0x4b>
      break;
    buf[i++] = c;
    14af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    14b3:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    14b6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    14b9:	3c 0a                	cmp    $0xa,%al
    14bb:	74 23                	je     14e0 <gets+0x60>
    14bd:	3c 0d                	cmp    $0xd,%al
    14bf:	74 1f                	je     14e0 <gets+0x60>
  for(i=0; i+1 < max; ){
    14c1:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    14c4:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    14c6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    14c9:	7c cd                	jl     1498 <gets+0x18>
    14cb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    14cd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    14d0:	c6 03 00             	movb   $0x0,(%ebx)
}
    14d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14d6:	5b                   	pop    %ebx
    14d7:	5e                   	pop    %esi
    14d8:	5f                   	pop    %edi
    14d9:	5d                   	pop    %ebp
    14da:	c3                   	ret    
    14db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    14df:	90                   	nop
  buf[i] = '\0';
    14e0:	8b 75 08             	mov    0x8(%ebp),%esi
}
    14e3:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    14e6:	01 de                	add    %ebx,%esi
    14e8:	89 f3                	mov    %esi,%ebx
    14ea:	c6 03 00             	movb   $0x0,(%ebx)
}
    14ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14f0:	5b                   	pop    %ebx
    14f1:	5e                   	pop    %esi
    14f2:	5f                   	pop    %edi
    14f3:	5d                   	pop    %ebp
    14f4:	c3                   	ret    
    14f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001500 <stat>:

int
stat(const char *n, struct stat *st)
{
    1500:	55                   	push   %ebp
    1501:	89 e5                	mov    %esp,%ebp
    1503:	56                   	push   %esi
    1504:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1505:	83 ec 08             	sub    $0x8,%esp
    1508:	6a 00                	push   $0x0
    150a:	ff 75 08             	pushl  0x8(%ebp)
    150d:	e8 67 01 00 00       	call   1679 <open>
  if(fd < 0)
    1512:	83 c4 10             	add    $0x10,%esp
    1515:	85 c0                	test   %eax,%eax
    1517:	78 27                	js     1540 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1519:	83 ec 08             	sub    $0x8,%esp
    151c:	ff 75 0c             	pushl  0xc(%ebp)
    151f:	89 c3                	mov    %eax,%ebx
    1521:	50                   	push   %eax
    1522:	e8 6a 01 00 00       	call   1691 <fstat>
  close(fd);
    1527:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    152a:	89 c6                	mov    %eax,%esi
  close(fd);
    152c:	e8 30 01 00 00       	call   1661 <close>
  return r;
    1531:	83 c4 10             	add    $0x10,%esp
}
    1534:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1537:	89 f0                	mov    %esi,%eax
    1539:	5b                   	pop    %ebx
    153a:	5e                   	pop    %esi
    153b:	5d                   	pop    %ebp
    153c:	c3                   	ret    
    153d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1540:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1545:	eb ed                	jmp    1534 <stat+0x34>
    1547:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    154e:	66 90                	xchg   %ax,%ax

00001550 <atoi>:

int
atoi(const char *s)
{
    1550:	55                   	push   %ebp
    1551:	89 e5                	mov    %esp,%ebp
    1553:	53                   	push   %ebx
    1554:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1557:	0f be 02             	movsbl (%edx),%eax
    155a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    155d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1560:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1565:	77 1e                	ja     1585 <atoi+0x35>
    1567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    156e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    1570:	83 c2 01             	add    $0x1,%edx
    1573:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1576:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    157a:	0f be 02             	movsbl (%edx),%eax
    157d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1580:	80 fb 09             	cmp    $0x9,%bl
    1583:	76 eb                	jbe    1570 <atoi+0x20>
  return n;
}
    1585:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1588:	89 c8                	mov    %ecx,%eax
    158a:	c9                   	leave  
    158b:	c3                   	ret    
    158c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001590 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1590:	55                   	push   %ebp
    1591:	89 e5                	mov    %esp,%ebp
    1593:	57                   	push   %edi
    1594:	8b 45 10             	mov    0x10(%ebp),%eax
    1597:	8b 55 08             	mov    0x8(%ebp),%edx
    159a:	56                   	push   %esi
    159b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    159e:	85 c0                	test   %eax,%eax
    15a0:	7e 13                	jle    15b5 <memmove+0x25>
    15a2:	01 d0                	add    %edx,%eax
  dst = vdst;
    15a4:	89 d7                	mov    %edx,%edi
    15a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15ad:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    15b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    15b1:	39 f8                	cmp    %edi,%eax
    15b3:	75 fb                	jne    15b0 <memmove+0x20>
  return vdst;
}
    15b5:	5e                   	pop    %esi
    15b6:	89 d0                	mov    %edx,%eax
    15b8:	5f                   	pop    %edi
    15b9:	5d                   	pop    %ebp
    15ba:	c3                   	ret    
    15bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    15bf:	90                   	nop

000015c0 <thread_create>:


int thread_create(void (*start_routine)(void*, void*), void *arg1, void *arg2) {
    15c0:	55                   	push   %ebp
    15c1:	89 e5                	mov    %esp,%ebp
    15c3:	53                   	push   %ebx
    15c4:	83 ec 20             	sub    $0x20,%esp
  void *stack =  malloc(4096);
    15c7:	68 00 10 00 00       	push   $0x1000
    15cc:	e8 3f 04 00 00       	call   1a10 <malloc>
  if(stack == 0)
    15d1:	83 c4 10             	add    $0x10,%esp
    15d4:	85 c0                	test   %eax,%eax
    15d6:	74 3f                	je     1617 <thread_create+0x57>
    return -1;
  int r= clone(start_routine, arg1, arg2, stack);
    15d8:	50                   	push   %eax
    15d9:	89 c3                	mov    %eax,%ebx
    15db:	ff 75 10             	pushl  0x10(%ebp)
    15de:	ff 75 0c             	pushl  0xc(%ebp)
    15e1:	ff 75 08             	pushl  0x8(%ebp)
    15e4:	e8 00 01 00 00       	call   16e9 <clone>
  if(r==-1) 
    15e9:	83 c4 10             	add    $0x10,%esp
    15ec:	83 f8 ff             	cmp    $0xffffffff,%eax
    15ef:	74 0f                	je     1600 <thread_create+0x40>
    free(stack);
  return r;
}
    15f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15f4:	c9                   	leave  
    15f5:	c3                   	ret    
    15f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15fd:	8d 76 00             	lea    0x0(%esi),%esi
    free(stack);
    1600:	83 ec 0c             	sub    $0xc,%esp
    1603:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1606:	53                   	push   %ebx
    1607:	e8 74 03 00 00       	call   1980 <free>
    160c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    160f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    free(stack);
    1612:	83 c4 10             	add    $0x10,%esp
}
    1615:	c9                   	leave  
    1616:	c3                   	ret    
    return -1;
    1617:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    161c:	eb d3                	jmp    15f1 <thread_create+0x31>
    161e:	66 90                	xchg   %ax,%ax

00001620 <thread_join>:


int thread_join(void) {
    1620:	55                   	push   %ebp
    1621:	89 e5                	mov    %esp,%ebp
    1623:	83 ec 24             	sub    $0x24,%esp
  void *stack;
  int r = join(&stack);
    1626:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1629:	50                   	push   %eax
    162a:	e8 c2 00 00 00       	call   16f1 <join>
  return r;
}
    162f:	c9                   	leave  
    1630:	c3                   	ret    

00001631 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1631:	b8 01 00 00 00       	mov    $0x1,%eax
    1636:	cd 40                	int    $0x40
    1638:	c3                   	ret    

00001639 <exit>:
SYSCALL(exit)
    1639:	b8 02 00 00 00       	mov    $0x2,%eax
    163e:	cd 40                	int    $0x40
    1640:	c3                   	ret    

00001641 <wait>:
SYSCALL(wait)
    1641:	b8 03 00 00 00       	mov    $0x3,%eax
    1646:	cd 40                	int    $0x40
    1648:	c3                   	ret    

00001649 <pipe>:
SYSCALL(pipe)
    1649:	b8 04 00 00 00       	mov    $0x4,%eax
    164e:	cd 40                	int    $0x40
    1650:	c3                   	ret    

00001651 <read>:
SYSCALL(read)
    1651:	b8 05 00 00 00       	mov    $0x5,%eax
    1656:	cd 40                	int    $0x40
    1658:	c3                   	ret    

00001659 <write>:
SYSCALL(write)
    1659:	b8 10 00 00 00       	mov    $0x10,%eax
    165e:	cd 40                	int    $0x40
    1660:	c3                   	ret    

00001661 <close>:
SYSCALL(close)
    1661:	b8 15 00 00 00       	mov    $0x15,%eax
    1666:	cd 40                	int    $0x40
    1668:	c3                   	ret    

00001669 <kill>:
SYSCALL(kill)
    1669:	b8 06 00 00 00       	mov    $0x6,%eax
    166e:	cd 40                	int    $0x40
    1670:	c3                   	ret    

00001671 <exec>:
SYSCALL(exec)
    1671:	b8 07 00 00 00       	mov    $0x7,%eax
    1676:	cd 40                	int    $0x40
    1678:	c3                   	ret    

00001679 <open>:
SYSCALL(open)
    1679:	b8 0f 00 00 00       	mov    $0xf,%eax
    167e:	cd 40                	int    $0x40
    1680:	c3                   	ret    

00001681 <mknod>:
SYSCALL(mknod)
    1681:	b8 11 00 00 00       	mov    $0x11,%eax
    1686:	cd 40                	int    $0x40
    1688:	c3                   	ret    

00001689 <unlink>:
SYSCALL(unlink)
    1689:	b8 12 00 00 00       	mov    $0x12,%eax
    168e:	cd 40                	int    $0x40
    1690:	c3                   	ret    

00001691 <fstat>:
SYSCALL(fstat)
    1691:	b8 08 00 00 00       	mov    $0x8,%eax
    1696:	cd 40                	int    $0x40
    1698:	c3                   	ret    

00001699 <link>:
SYSCALL(link)
    1699:	b8 13 00 00 00       	mov    $0x13,%eax
    169e:	cd 40                	int    $0x40
    16a0:	c3                   	ret    

000016a1 <mkdir>:
SYSCALL(mkdir)
    16a1:	b8 14 00 00 00       	mov    $0x14,%eax
    16a6:	cd 40                	int    $0x40
    16a8:	c3                   	ret    

000016a9 <chdir>:
SYSCALL(chdir)
    16a9:	b8 09 00 00 00       	mov    $0x9,%eax
    16ae:	cd 40                	int    $0x40
    16b0:	c3                   	ret    

000016b1 <dup>:
SYSCALL(dup)
    16b1:	b8 0a 00 00 00       	mov    $0xa,%eax
    16b6:	cd 40                	int    $0x40
    16b8:	c3                   	ret    

000016b9 <getpid>:
SYSCALL(getpid)
    16b9:	b8 0b 00 00 00       	mov    $0xb,%eax
    16be:	cd 40                	int    $0x40
    16c0:	c3                   	ret    

000016c1 <sbrk>:
SYSCALL(sbrk)
    16c1:	b8 0c 00 00 00       	mov    $0xc,%eax
    16c6:	cd 40                	int    $0x40
    16c8:	c3                   	ret    

000016c9 <sleep>:
SYSCALL(sleep)
    16c9:	b8 0d 00 00 00       	mov    $0xd,%eax
    16ce:	cd 40                	int    $0x40
    16d0:	c3                   	ret    

000016d1 <uptime>:
SYSCALL(uptime)
    16d1:	b8 0e 00 00 00       	mov    $0xe,%eax
    16d6:	cd 40                	int    $0x40
    16d8:	c3                   	ret    

000016d9 <mprotect>:
SYSCALL(mprotect)
    16d9:	b8 16 00 00 00       	mov    $0x16,%eax
    16de:	cd 40                	int    $0x40
    16e0:	c3                   	ret    

000016e1 <munprotect>:
SYSCALL(munprotect)
    16e1:	b8 17 00 00 00       	mov    $0x17,%eax
    16e6:	cd 40                	int    $0x40
    16e8:	c3                   	ret    

000016e9 <clone>:
SYSCALL(clone)
    16e9:	b8 18 00 00 00       	mov    $0x18,%eax
    16ee:	cd 40                	int    $0x40
    16f0:	c3                   	ret    

000016f1 <join>:
SYSCALL(join)
    16f1:	b8 19 00 00 00       	mov    $0x19,%eax
    16f6:	cd 40                	int    $0x40
    16f8:	c3                   	ret    
    16f9:	66 90                	xchg   %ax,%ax
    16fb:	66 90                	xchg   %ax,%ax
    16fd:	66 90                	xchg   %ax,%ax
    16ff:	90                   	nop

00001700 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1700:	55                   	push   %ebp
    1701:	89 e5                	mov    %esp,%ebp
    1703:	57                   	push   %edi
    1704:	56                   	push   %esi
    1705:	53                   	push   %ebx
    1706:	83 ec 3c             	sub    $0x3c,%esp
    1709:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    170c:	89 d1                	mov    %edx,%ecx
{
    170e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    1711:	85 d2                	test   %edx,%edx
    1713:	0f 89 7f 00 00 00    	jns    1798 <printint+0x98>
    1719:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    171d:	74 79                	je     1798 <printint+0x98>
    neg = 1;
    171f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    1726:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    1728:	31 db                	xor    %ebx,%ebx
    172a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    172d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1730:	89 c8                	mov    %ecx,%eax
    1732:	31 d2                	xor    %edx,%edx
    1734:	89 cf                	mov    %ecx,%edi
    1736:	f7 75 c4             	divl   -0x3c(%ebp)
    1739:	0f b6 92 58 1b 00 00 	movzbl 0x1b58(%edx),%edx
    1740:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1743:	89 d8                	mov    %ebx,%eax
    1745:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1748:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    174b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    174e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1751:	76 dd                	jbe    1730 <printint+0x30>
  if(neg)
    1753:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1756:	85 c9                	test   %ecx,%ecx
    1758:	74 0c                	je     1766 <printint+0x66>
    buf[i++] = '-';
    175a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    175f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1761:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1766:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1769:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    176d:	eb 07                	jmp    1776 <printint+0x76>
    176f:	90                   	nop
    putc(fd, buf[i]);
    1770:	0f b6 13             	movzbl (%ebx),%edx
    1773:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1776:	83 ec 04             	sub    $0x4,%esp
    1779:	88 55 d7             	mov    %dl,-0x29(%ebp)
    177c:	6a 01                	push   $0x1
    177e:	56                   	push   %esi
    177f:	57                   	push   %edi
    1780:	e8 d4 fe ff ff       	call   1659 <write>
  while(--i >= 0)
    1785:	83 c4 10             	add    $0x10,%esp
    1788:	39 de                	cmp    %ebx,%esi
    178a:	75 e4                	jne    1770 <printint+0x70>
}
    178c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    178f:	5b                   	pop    %ebx
    1790:	5e                   	pop    %esi
    1791:	5f                   	pop    %edi
    1792:	5d                   	pop    %ebp
    1793:	c3                   	ret    
    1794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1798:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    179f:	eb 87                	jmp    1728 <printint+0x28>
    17a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17af:	90                   	nop

000017b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    17b0:	55                   	push   %ebp
    17b1:	89 e5                	mov    %esp,%ebp
    17b3:	57                   	push   %edi
    17b4:	56                   	push   %esi
    17b5:	53                   	push   %ebx
    17b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    17b9:	8b 75 0c             	mov    0xc(%ebp),%esi
    17bc:	0f b6 1e             	movzbl (%esi),%ebx
    17bf:	84 db                	test   %bl,%bl
    17c1:	0f 84 b8 00 00 00    	je     187f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    17c7:	8d 45 10             	lea    0x10(%ebp),%eax
    17ca:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    17cd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    17d0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    17d2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    17d5:	eb 37                	jmp    180e <printf+0x5e>
    17d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17de:	66 90                	xchg   %ax,%ax
    17e0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    17e3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    17e8:	83 f8 25             	cmp    $0x25,%eax
    17eb:	74 17                	je     1804 <printf+0x54>
  write(fd, &c, 1);
    17ed:	83 ec 04             	sub    $0x4,%esp
    17f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
    17f3:	6a 01                	push   $0x1
    17f5:	57                   	push   %edi
    17f6:	ff 75 08             	pushl  0x8(%ebp)
    17f9:	e8 5b fe ff ff       	call   1659 <write>
    17fe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    1801:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1804:	0f b6 1e             	movzbl (%esi),%ebx
    1807:	83 c6 01             	add    $0x1,%esi
    180a:	84 db                	test   %bl,%bl
    180c:	74 71                	je     187f <printf+0xcf>
    c = fmt[i] & 0xff;
    180e:	0f be cb             	movsbl %bl,%ecx
    1811:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1814:	85 d2                	test   %edx,%edx
    1816:	74 c8                	je     17e0 <printf+0x30>
      }
    } else if(state == '%'){
    1818:	83 fa 25             	cmp    $0x25,%edx
    181b:	75 e7                	jne    1804 <printf+0x54>
      if(c == 'd'){
    181d:	83 f8 64             	cmp    $0x64,%eax
    1820:	0f 84 9a 00 00 00    	je     18c0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1826:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    182c:	83 f9 70             	cmp    $0x70,%ecx
    182f:	74 5f                	je     1890 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1831:	83 f8 73             	cmp    $0x73,%eax
    1834:	0f 84 d6 00 00 00    	je     1910 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    183a:	83 f8 63             	cmp    $0x63,%eax
    183d:	0f 84 8d 00 00 00    	je     18d0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1843:	83 f8 25             	cmp    $0x25,%eax
    1846:	0f 84 b4 00 00 00    	je     1900 <printf+0x150>
  write(fd, &c, 1);
    184c:	83 ec 04             	sub    $0x4,%esp
    184f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1853:	6a 01                	push   $0x1
    1855:	57                   	push   %edi
    1856:	ff 75 08             	pushl  0x8(%ebp)
    1859:	e8 fb fd ff ff       	call   1659 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    185e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1861:	83 c4 0c             	add    $0xc,%esp
    1864:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1866:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1869:	57                   	push   %edi
    186a:	ff 75 08             	pushl  0x8(%ebp)
    186d:	e8 e7 fd ff ff       	call   1659 <write>
  for(i = 0; fmt[i]; i++){
    1872:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    1876:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1879:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    187b:	84 db                	test   %bl,%bl
    187d:	75 8f                	jne    180e <printf+0x5e>
    }
  }
}
    187f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1882:	5b                   	pop    %ebx
    1883:	5e                   	pop    %esi
    1884:	5f                   	pop    %edi
    1885:	5d                   	pop    %ebp
    1886:	c3                   	ret    
    1887:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    188e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    1890:	83 ec 0c             	sub    $0xc,%esp
    1893:	b9 10 00 00 00       	mov    $0x10,%ecx
    1898:	6a 00                	push   $0x0
    189a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    189d:	8b 45 08             	mov    0x8(%ebp),%eax
    18a0:	8b 13                	mov    (%ebx),%edx
    18a2:	e8 59 fe ff ff       	call   1700 <printint>
        ap++;
    18a7:	89 d8                	mov    %ebx,%eax
    18a9:	83 c4 10             	add    $0x10,%esp
      state = 0;
    18ac:	31 d2                	xor    %edx,%edx
        ap++;
    18ae:	83 c0 04             	add    $0x4,%eax
    18b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    18b4:	e9 4b ff ff ff       	jmp    1804 <printf+0x54>
    18b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    18c0:	83 ec 0c             	sub    $0xc,%esp
    18c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    18c8:	6a 01                	push   $0x1
    18ca:	eb ce                	jmp    189a <printf+0xea>
    18cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    18d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    18d3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    18d6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    18d8:	6a 01                	push   $0x1
        ap++;
    18da:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    18dd:	57                   	push   %edi
    18de:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    18e1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    18e4:	e8 70 fd ff ff       	call   1659 <write>
        ap++;
    18e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    18ec:	83 c4 10             	add    $0x10,%esp
      state = 0;
    18ef:	31 d2                	xor    %edx,%edx
    18f1:	e9 0e ff ff ff       	jmp    1804 <printf+0x54>
    18f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    18fd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    1900:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1903:	83 ec 04             	sub    $0x4,%esp
    1906:	e9 59 ff ff ff       	jmp    1864 <printf+0xb4>
    190b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    190f:	90                   	nop
        s = (char*)*ap;
    1910:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1913:	8b 18                	mov    (%eax),%ebx
        ap++;
    1915:	83 c0 04             	add    $0x4,%eax
    1918:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    191b:	85 db                	test   %ebx,%ebx
    191d:	74 17                	je     1936 <printf+0x186>
        while(*s != 0){
    191f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1922:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1924:	84 c0                	test   %al,%al
    1926:	0f 84 d8 fe ff ff    	je     1804 <printf+0x54>
    192c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    192f:	89 de                	mov    %ebx,%esi
    1931:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1934:	eb 1a                	jmp    1950 <printf+0x1a0>
          s = "(null)";
    1936:	bb 4e 1b 00 00       	mov    $0x1b4e,%ebx
        while(*s != 0){
    193b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    193e:	b8 28 00 00 00       	mov    $0x28,%eax
    1943:	89 de                	mov    %ebx,%esi
    1945:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    194f:	90                   	nop
  write(fd, &c, 1);
    1950:	83 ec 04             	sub    $0x4,%esp
          s++;
    1953:	83 c6 01             	add    $0x1,%esi
    1956:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1959:	6a 01                	push   $0x1
    195b:	57                   	push   %edi
    195c:	53                   	push   %ebx
    195d:	e8 f7 fc ff ff       	call   1659 <write>
        while(*s != 0){
    1962:	0f b6 06             	movzbl (%esi),%eax
    1965:	83 c4 10             	add    $0x10,%esp
    1968:	84 c0                	test   %al,%al
    196a:	75 e4                	jne    1950 <printf+0x1a0>
      state = 0;
    196c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    196f:	31 d2                	xor    %edx,%edx
    1971:	e9 8e fe ff ff       	jmp    1804 <printf+0x54>
    1976:	66 90                	xchg   %ax,%ax
    1978:	66 90                	xchg   %ax,%ax
    197a:	66 90                	xchg   %ax,%ax
    197c:	66 90                	xchg   %ax,%ax
    197e:	66 90                	xchg   %ax,%ax

00001980 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1980:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1981:	a1 60 23 00 00       	mov    0x2360,%eax
{
    1986:	89 e5                	mov    %esp,%ebp
    1988:	57                   	push   %edi
    1989:	56                   	push   %esi
    198a:	53                   	push   %ebx
    198b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    198e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1998:	89 c2                	mov    %eax,%edx
    199a:	8b 00                	mov    (%eax),%eax
    199c:	39 ca                	cmp    %ecx,%edx
    199e:	73 30                	jae    19d0 <free+0x50>
    19a0:	39 c1                	cmp    %eax,%ecx
    19a2:	72 04                	jb     19a8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    19a4:	39 c2                	cmp    %eax,%edx
    19a6:	72 f0                	jb     1998 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    19a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    19ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    19ae:	39 f8                	cmp    %edi,%eax
    19b0:	74 30                	je     19e2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    19b2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    19b5:	8b 42 04             	mov    0x4(%edx),%eax
    19b8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    19bb:	39 f1                	cmp    %esi,%ecx
    19bd:	74 3a                	je     19f9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    19bf:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    19c1:	5b                   	pop    %ebx
  freep = p;
    19c2:	89 15 60 23 00 00    	mov    %edx,0x2360
}
    19c8:	5e                   	pop    %esi
    19c9:	5f                   	pop    %edi
    19ca:	5d                   	pop    %ebp
    19cb:	c3                   	ret    
    19cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    19d0:	39 c2                	cmp    %eax,%edx
    19d2:	72 c4                	jb     1998 <free+0x18>
    19d4:	39 c1                	cmp    %eax,%ecx
    19d6:	73 c0                	jae    1998 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    19d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    19db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    19de:	39 f8                	cmp    %edi,%eax
    19e0:	75 d0                	jne    19b2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    19e2:	03 70 04             	add    0x4(%eax),%esi
    19e5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    19e8:	8b 02                	mov    (%edx),%eax
    19ea:	8b 00                	mov    (%eax),%eax
    19ec:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    19ef:	8b 42 04             	mov    0x4(%edx),%eax
    19f2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    19f5:	39 f1                	cmp    %esi,%ecx
    19f7:	75 c6                	jne    19bf <free+0x3f>
    p->s.size += bp->s.size;
    19f9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    19fc:	89 15 60 23 00 00    	mov    %edx,0x2360
    p->s.size += bp->s.size;
    1a02:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1a05:	8b 43 f8             	mov    -0x8(%ebx),%eax
    1a08:	89 02                	mov    %eax,(%edx)
}
    1a0a:	5b                   	pop    %ebx
    1a0b:	5e                   	pop    %esi
    1a0c:	5f                   	pop    %edi
    1a0d:	5d                   	pop    %ebp
    1a0e:	c3                   	ret    
    1a0f:	90                   	nop

00001a10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1a10:	55                   	push   %ebp
    1a11:	89 e5                	mov    %esp,%ebp
    1a13:	57                   	push   %edi
    1a14:	56                   	push   %esi
    1a15:	53                   	push   %ebx
    1a16:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1a19:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    1a1c:	8b 3d 60 23 00 00    	mov    0x2360,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1a22:	8d 70 07             	lea    0x7(%eax),%esi
    1a25:	c1 ee 03             	shr    $0x3,%esi
    1a28:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    1a2b:	85 ff                	test   %edi,%edi
    1a2d:	0f 84 ad 00 00 00    	je     1ae0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a33:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1a35:	8b 48 04             	mov    0x4(%eax),%ecx
    1a38:	39 f1                	cmp    %esi,%ecx
    1a3a:	73 71                	jae    1aad <malloc+0x9d>
    1a3c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1a42:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1a47:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    1a4a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1a51:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1a54:	eb 1b                	jmp    1a71 <malloc+0x61>
    1a56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1a5d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a60:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1a62:	8b 4a 04             	mov    0x4(%edx),%ecx
    1a65:	39 f1                	cmp    %esi,%ecx
    1a67:	73 4f                	jae    1ab8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1a69:	8b 3d 60 23 00 00    	mov    0x2360,%edi
    1a6f:	89 d0                	mov    %edx,%eax
    1a71:	39 c7                	cmp    %eax,%edi
    1a73:	75 eb                	jne    1a60 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1a75:	83 ec 0c             	sub    $0xc,%esp
    1a78:	ff 75 e4             	pushl  -0x1c(%ebp)
    1a7b:	e8 41 fc ff ff       	call   16c1 <sbrk>
  if(p == (char*)-1)
    1a80:	83 c4 10             	add    $0x10,%esp
    1a83:	83 f8 ff             	cmp    $0xffffffff,%eax
    1a86:	74 1b                	je     1aa3 <malloc+0x93>
  hp->s.size = nu;
    1a88:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1a8b:	83 ec 0c             	sub    $0xc,%esp
    1a8e:	83 c0 08             	add    $0x8,%eax
    1a91:	50                   	push   %eax
    1a92:	e8 e9 fe ff ff       	call   1980 <free>
  return freep;
    1a97:	a1 60 23 00 00       	mov    0x2360,%eax
      if((p = morecore(nunits)) == 0)
    1a9c:	83 c4 10             	add    $0x10,%esp
    1a9f:	85 c0                	test   %eax,%eax
    1aa1:	75 bd                	jne    1a60 <malloc+0x50>
        return 0;
  }
}
    1aa3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1aa6:	31 c0                	xor    %eax,%eax
}
    1aa8:	5b                   	pop    %ebx
    1aa9:	5e                   	pop    %esi
    1aaa:	5f                   	pop    %edi
    1aab:	5d                   	pop    %ebp
    1aac:	c3                   	ret    
    if(p->s.size >= nunits){
    1aad:	89 c2                	mov    %eax,%edx
    1aaf:	89 f8                	mov    %edi,%eax
    1ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1ab8:	39 ce                	cmp    %ecx,%esi
    1aba:	74 54                	je     1b10 <malloc+0x100>
        p->s.size -= nunits;
    1abc:	29 f1                	sub    %esi,%ecx
    1abe:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    1ac1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    1ac4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    1ac7:	a3 60 23 00 00       	mov    %eax,0x2360
}
    1acc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1acf:	8d 42 08             	lea    0x8(%edx),%eax
}
    1ad2:	5b                   	pop    %ebx
    1ad3:	5e                   	pop    %esi
    1ad4:	5f                   	pop    %edi
    1ad5:	5d                   	pop    %ebp
    1ad6:	c3                   	ret    
    1ad7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1ade:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    1ae0:	c7 05 60 23 00 00 64 	movl   $0x2364,0x2360
    1ae7:	23 00 00 
    base.s.size = 0;
    1aea:	bf 64 23 00 00       	mov    $0x2364,%edi
    base.s.ptr = freep = prevp = &base;
    1aef:	c7 05 64 23 00 00 64 	movl   $0x2364,0x2364
    1af6:	23 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1af9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    1afb:	c7 05 68 23 00 00 00 	movl   $0x0,0x2368
    1b02:	00 00 00 
    if(p->s.size >= nunits){
    1b05:	e9 32 ff ff ff       	jmp    1a3c <malloc+0x2c>
    1b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1b10:	8b 0a                	mov    (%edx),%ecx
    1b12:	89 08                	mov    %ecx,(%eax)
    1b14:	eb b1                	jmp    1ac7 <malloc+0xb7>
