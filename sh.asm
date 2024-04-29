
_sh:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
  return 0;
}

int
main(void)
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	51                   	push   %ecx
    100e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    1011:	eb 0e                	jmp    1021 <main+0x21>
    1013:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1017:	90                   	nop
    if(fd >= 3){
    1018:	83 f8 02             	cmp    $0x2,%eax
    101b:	0f 8f 91 00 00 00    	jg     10b2 <main+0xb2>
  while((fd = open("console", O_RDWR)) >= 0){
    1021:	83 ec 08             	sub    $0x8,%esp
    1024:	6a 02                	push   $0x2
    1026:	68 99 24 00 00       	push   $0x2499
    102b:	e8 09 0f 00 00       	call   1f39 <open>
    1030:	83 c4 10             	add    $0x10,%esp
    1033:	85 c0                	test   %eax,%eax
    1035:	79 e1                	jns    1018 <main+0x18>
    1037:	eb 2e                	jmp    1067 <main+0x67>
    1039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    1040:	80 3d 42 2b 00 00 20 	cmpb   $0x20,0x2b42
    1047:	0f 84 88 00 00 00    	je     10d5 <main+0xd5>
    104d:	8d 76 00             	lea    0x0(%esi),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
    1050:	e8 9c 0e 00 00       	call   1ef1 <fork>
  if(pid == -1)
    1055:	83 f8 ff             	cmp    $0xffffffff,%eax
    1058:	0f 84 c1 00 00 00    	je     111f <main+0x11f>
    if(fork1() == 0)
    105e:	85 c0                	test   %eax,%eax
    1060:	74 5e                	je     10c0 <main+0xc0>
    wait();
    1062:	e8 9a 0e 00 00       	call   1f01 <wait>
  printf(2, "$ ");
    1067:	83 ec 08             	sub    $0x8,%esp
    106a:	68 f8 23 00 00       	push   $0x23f8
    106f:	6a 02                	push   $0x2
    1071:	e8 1a 10 00 00       	call   2090 <printf>
  memset(buf, 0, nbuf);
    1076:	83 c4 0c             	add    $0xc,%esp
    1079:	6a 64                	push   $0x64
    107b:	6a 00                	push   $0x0
    107d:	68 40 2b 00 00       	push   $0x2b40
    1082:	e8 59 0c 00 00       	call   1ce0 <memset>
  gets(buf, nbuf);
    1087:	58                   	pop    %eax
    1088:	5a                   	pop    %edx
    1089:	6a 64                	push   $0x64
    108b:	68 40 2b 00 00       	push   $0x2b40
    1090:	e8 ab 0c 00 00       	call   1d40 <gets>
  if(buf[0] == 0) // EOF
    1095:	0f b6 05 40 2b 00 00 	movzbl 0x2b40,%eax
    109c:	83 c4 10             	add    $0x10,%esp
    109f:	84 c0                	test   %al,%al
    10a1:	74 77                	je     111a <main+0x11a>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    10a3:	3c 63                	cmp    $0x63,%al
    10a5:	75 a9                	jne    1050 <main+0x50>
    10a7:	80 3d 41 2b 00 00 64 	cmpb   $0x64,0x2b41
    10ae:	75 a0                	jne    1050 <main+0x50>
    10b0:	eb 8e                	jmp    1040 <main+0x40>
      close(fd);
    10b2:	83 ec 0c             	sub    $0xc,%esp
    10b5:	50                   	push   %eax
    10b6:	e8 66 0e 00 00       	call   1f21 <close>
      break;
    10bb:	83 c4 10             	add    $0x10,%esp
    10be:	eb a7                	jmp    1067 <main+0x67>
      runcmd(parsecmd(buf));
    10c0:	83 ec 0c             	sub    $0xc,%esp
    10c3:	68 40 2b 00 00       	push   $0x2b40
    10c8:	e8 f3 0a 00 00       	call   1bc0 <parsecmd>
    10cd:	89 04 24             	mov    %eax,(%esp)
    10d0:	e8 eb 00 00 00       	call   11c0 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
    10d5:	83 ec 0c             	sub    $0xc,%esp
    10d8:	68 40 2b 00 00       	push   $0x2b40
    10dd:	e8 ce 0b 00 00       	call   1cb0 <strlen>
      if(chdir(buf+3) < 0)
    10e2:	c7 04 24 43 2b 00 00 	movl   $0x2b43,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
    10e9:	c6 80 3f 2b 00 00 00 	movb   $0x0,0x2b3f(%eax)
      if(chdir(buf+3) < 0)
    10f0:	e8 74 0e 00 00       	call   1f69 <chdir>
    10f5:	83 c4 10             	add    $0x10,%esp
    10f8:	85 c0                	test   %eax,%eax
    10fa:	0f 89 67 ff ff ff    	jns    1067 <main+0x67>
        printf(2, "cannot cd %s\n", buf+3);
    1100:	51                   	push   %ecx
    1101:	68 43 2b 00 00       	push   $0x2b43
    1106:	68 a1 24 00 00       	push   $0x24a1
    110b:	6a 02                	push   $0x2
    110d:	e8 7e 0f 00 00       	call   2090 <printf>
    1112:	83 c4 10             	add    $0x10,%esp
    1115:	e9 4d ff ff ff       	jmp    1067 <main+0x67>
  exit();
    111a:	e8 da 0d 00 00       	call   1ef9 <exit>
    panic("fork");
    111f:	83 ec 0c             	sub    $0xc,%esp
    1122:	68 fb 23 00 00       	push   $0x23fb
    1127:	e8 54 00 00 00       	call   1180 <panic>
    112c:	66 90                	xchg   %ax,%ax
    112e:	66 90                	xchg   %ax,%ax

00001130 <getcmd>:
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	56                   	push   %esi
    1134:	53                   	push   %ebx
    1135:	8b 75 0c             	mov    0xc(%ebp),%esi
    1138:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
    113b:	83 ec 08             	sub    $0x8,%esp
    113e:	68 f8 23 00 00       	push   $0x23f8
    1143:	6a 02                	push   $0x2
    1145:	e8 46 0f 00 00       	call   2090 <printf>
  memset(buf, 0, nbuf);
    114a:	83 c4 0c             	add    $0xc,%esp
    114d:	56                   	push   %esi
    114e:	6a 00                	push   $0x0
    1150:	53                   	push   %ebx
    1151:	e8 8a 0b 00 00       	call   1ce0 <memset>
  gets(buf, nbuf);
    1156:	58                   	pop    %eax
    1157:	5a                   	pop    %edx
    1158:	56                   	push   %esi
    1159:	53                   	push   %ebx
    115a:	e8 e1 0b 00 00       	call   1d40 <gets>
  if(buf[0] == 0) // EOF
    115f:	83 c4 10             	add    $0x10,%esp
    1162:	31 c0                	xor    %eax,%eax
    1164:	80 3b 00             	cmpb   $0x0,(%ebx)
    1167:	0f 94 c0             	sete   %al
}
    116a:	8d 65 f8             	lea    -0x8(%ebp),%esp
    116d:	5b                   	pop    %ebx
  if(buf[0] == 0) // EOF
    116e:	f7 d8                	neg    %eax
}
    1170:	5e                   	pop    %esi
    1171:	5d                   	pop    %ebp
    1172:	c3                   	ret    
    1173:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    117a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001180 <panic>:
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
    1186:	ff 75 08             	pushl  0x8(%ebp)
    1189:	68 95 24 00 00       	push   $0x2495
    118e:	6a 02                	push   $0x2
    1190:	e8 fb 0e 00 00       	call   2090 <printf>
  exit();
    1195:	e8 5f 0d 00 00       	call   1ef9 <exit>
    119a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000011a0 <fork1>:
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
    11a6:	e8 46 0d 00 00       	call   1ef1 <fork>
  if(pid == -1)
    11ab:	83 f8 ff             	cmp    $0xffffffff,%eax
    11ae:	74 02                	je     11b2 <fork1+0x12>
  return pid;
}
    11b0:	c9                   	leave  
    11b1:	c3                   	ret    
    panic("fork");
    11b2:	83 ec 0c             	sub    $0xc,%esp
    11b5:	68 fb 23 00 00       	push   $0x23fb
    11ba:	e8 c1 ff ff ff       	call   1180 <panic>
    11bf:	90                   	nop

000011c0 <runcmd>:
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	53                   	push   %ebx
    11c4:	83 ec 14             	sub    $0x14,%esp
    11c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
    11ca:	85 db                	test   %ebx,%ebx
    11cc:	74 42                	je     1210 <runcmd+0x50>
  switch(cmd->type){
    11ce:	83 3b 05             	cmpl   $0x5,(%ebx)
    11d1:	0f 87 e3 00 00 00    	ja     12ba <runcmd+0xfa>
    11d7:	8b 03                	mov    (%ebx),%eax
    11d9:	ff 24 85 b0 24 00 00 	jmp    *0x24b0(,%eax,4)
    if(ecmd->argv[0] == 0)
    11e0:	8b 43 04             	mov    0x4(%ebx),%eax
    11e3:	85 c0                	test   %eax,%eax
    11e5:	74 29                	je     1210 <runcmd+0x50>
    exec(ecmd->argv[0], ecmd->argv);
    11e7:	8d 53 04             	lea    0x4(%ebx),%edx
    11ea:	51                   	push   %ecx
    11eb:	51                   	push   %ecx
    11ec:	52                   	push   %edx
    11ed:	50                   	push   %eax
    11ee:	e8 3e 0d 00 00       	call   1f31 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    11f3:	83 c4 0c             	add    $0xc,%esp
    11f6:	ff 73 04             	pushl  0x4(%ebx)
    11f9:	68 07 24 00 00       	push   $0x2407
    11fe:	6a 02                	push   $0x2
    1200:	e8 8b 0e 00 00       	call   2090 <printf>
    break;
    1205:	83 c4 10             	add    $0x10,%esp
    1208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    120f:	90                   	nop
    exit();
    1210:	e8 e4 0c 00 00       	call   1ef9 <exit>
    if(fork1() == 0)
    1215:	e8 86 ff ff ff       	call   11a0 <fork1>
    121a:	85 c0                	test   %eax,%eax
    121c:	75 f2                	jne    1210 <runcmd+0x50>
    121e:	e9 8c 00 00 00       	jmp    12af <runcmd+0xef>
    if(pipe(p) < 0)
    1223:	83 ec 0c             	sub    $0xc,%esp
    1226:	8d 45 f0             	lea    -0x10(%ebp),%eax
    1229:	50                   	push   %eax
    122a:	e8 da 0c 00 00       	call   1f09 <pipe>
    122f:	83 c4 10             	add    $0x10,%esp
    1232:	85 c0                	test   %eax,%eax
    1234:	0f 88 a2 00 00 00    	js     12dc <runcmd+0x11c>
    if(fork1() == 0){
    123a:	e8 61 ff ff ff       	call   11a0 <fork1>
    123f:	85 c0                	test   %eax,%eax
    1241:	0f 84 a2 00 00 00    	je     12e9 <runcmd+0x129>
    if(fork1() == 0){
    1247:	e8 54 ff ff ff       	call   11a0 <fork1>
    124c:	85 c0                	test   %eax,%eax
    124e:	0f 84 c3 00 00 00    	je     1317 <runcmd+0x157>
    close(p[0]);
    1254:	83 ec 0c             	sub    $0xc,%esp
    1257:	ff 75 f0             	pushl  -0x10(%ebp)
    125a:	e8 c2 0c 00 00       	call   1f21 <close>
    close(p[1]);
    125f:	58                   	pop    %eax
    1260:	ff 75 f4             	pushl  -0xc(%ebp)
    1263:	e8 b9 0c 00 00       	call   1f21 <close>
    wait();
    1268:	e8 94 0c 00 00       	call   1f01 <wait>
    wait();
    126d:	e8 8f 0c 00 00       	call   1f01 <wait>
    break;
    1272:	83 c4 10             	add    $0x10,%esp
    1275:	eb 99                	jmp    1210 <runcmd+0x50>
    if(fork1() == 0)
    1277:	e8 24 ff ff ff       	call   11a0 <fork1>
    127c:	85 c0                	test   %eax,%eax
    127e:	74 2f                	je     12af <runcmd+0xef>
    wait();
    1280:	e8 7c 0c 00 00       	call   1f01 <wait>
    runcmd(lcmd->right);
    1285:	83 ec 0c             	sub    $0xc,%esp
    1288:	ff 73 08             	pushl  0x8(%ebx)
    128b:	e8 30 ff ff ff       	call   11c0 <runcmd>
    close(rcmd->fd);
    1290:	83 ec 0c             	sub    $0xc,%esp
    1293:	ff 73 14             	pushl  0x14(%ebx)
    1296:	e8 86 0c 00 00       	call   1f21 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
    129b:	58                   	pop    %eax
    129c:	5a                   	pop    %edx
    129d:	ff 73 10             	pushl  0x10(%ebx)
    12a0:	ff 73 08             	pushl  0x8(%ebx)
    12a3:	e8 91 0c 00 00       	call   1f39 <open>
    12a8:	83 c4 10             	add    $0x10,%esp
    12ab:	85 c0                	test   %eax,%eax
    12ad:	78 18                	js     12c7 <runcmd+0x107>
      runcmd(bcmd->cmd);
    12af:	83 ec 0c             	sub    $0xc,%esp
    12b2:	ff 73 04             	pushl  0x4(%ebx)
    12b5:	e8 06 ff ff ff       	call   11c0 <runcmd>
    panic("runcmd");
    12ba:	83 ec 0c             	sub    $0xc,%esp
    12bd:	68 00 24 00 00       	push   $0x2400
    12c2:	e8 b9 fe ff ff       	call   1180 <panic>
      printf(2, "open %s failed\n", rcmd->file);
    12c7:	51                   	push   %ecx
    12c8:	ff 73 08             	pushl  0x8(%ebx)
    12cb:	68 17 24 00 00       	push   $0x2417
    12d0:	6a 02                	push   $0x2
    12d2:	e8 b9 0d 00 00       	call   2090 <printf>
      exit();
    12d7:	e8 1d 0c 00 00       	call   1ef9 <exit>
      panic("pipe");
    12dc:	83 ec 0c             	sub    $0xc,%esp
    12df:	68 27 24 00 00       	push   $0x2427
    12e4:	e8 97 fe ff ff       	call   1180 <panic>
      close(1);
    12e9:	83 ec 0c             	sub    $0xc,%esp
    12ec:	6a 01                	push   $0x1
    12ee:	e8 2e 0c 00 00       	call   1f21 <close>
      dup(p[1]);
    12f3:	58                   	pop    %eax
    12f4:	ff 75 f4             	pushl  -0xc(%ebp)
    12f7:	e8 75 0c 00 00       	call   1f71 <dup>
      close(p[0]);
    12fc:	58                   	pop    %eax
    12fd:	ff 75 f0             	pushl  -0x10(%ebp)
    1300:	e8 1c 0c 00 00       	call   1f21 <close>
      close(p[1]);
    1305:	58                   	pop    %eax
    1306:	ff 75 f4             	pushl  -0xc(%ebp)
    1309:	e8 13 0c 00 00       	call   1f21 <close>
      runcmd(pcmd->left);
    130e:	5a                   	pop    %edx
    130f:	ff 73 04             	pushl  0x4(%ebx)
    1312:	e8 a9 fe ff ff       	call   11c0 <runcmd>
      close(0);
    1317:	83 ec 0c             	sub    $0xc,%esp
    131a:	6a 00                	push   $0x0
    131c:	e8 00 0c 00 00       	call   1f21 <close>
      dup(p[0]);
    1321:	5a                   	pop    %edx
    1322:	ff 75 f0             	pushl  -0x10(%ebp)
    1325:	e8 47 0c 00 00       	call   1f71 <dup>
      close(p[0]);
    132a:	59                   	pop    %ecx
    132b:	ff 75 f0             	pushl  -0x10(%ebp)
    132e:	e8 ee 0b 00 00       	call   1f21 <close>
      close(p[1]);
    1333:	58                   	pop    %eax
    1334:	ff 75 f4             	pushl  -0xc(%ebp)
    1337:	e8 e5 0b 00 00       	call   1f21 <close>
      runcmd(pcmd->right);
    133c:	58                   	pop    %eax
    133d:	ff 73 08             	pushl  0x8(%ebx)
    1340:	e8 7b fe ff ff       	call   11c0 <runcmd>
    1345:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    134c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001350 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
    1350:	55                   	push   %ebp
    1351:	89 e5                	mov    %esp,%ebp
    1353:	53                   	push   %ebx
    1354:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1357:	6a 54                	push   $0x54
    1359:	e8 92 0f 00 00       	call   22f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    135e:	83 c4 0c             	add    $0xc,%esp
    1361:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
    1363:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    1365:	6a 00                	push   $0x0
    1367:	50                   	push   %eax
    1368:	e8 73 09 00 00       	call   1ce0 <memset>
  cmd->type = EXEC;
    136d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
    1373:	89 d8                	mov    %ebx,%eax
    1375:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1378:	c9                   	leave  
    1379:	c3                   	ret    
    137a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001380 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
    1380:	55                   	push   %ebp
    1381:	89 e5                	mov    %esp,%ebp
    1383:	53                   	push   %ebx
    1384:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1387:	6a 18                	push   $0x18
    1389:	e8 62 0f 00 00       	call   22f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    138e:	83 c4 0c             	add    $0xc,%esp
    1391:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
    1393:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    1395:	6a 00                	push   $0x0
    1397:	50                   	push   %eax
    1398:	e8 43 09 00 00       	call   1ce0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
    139d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
    13a0:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
    13a6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
    13a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ac:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
    13af:	8b 45 10             	mov    0x10(%ebp),%eax
    13b2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
    13b5:	8b 45 14             	mov    0x14(%ebp),%eax
    13b8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
    13bb:	8b 45 18             	mov    0x18(%ebp),%eax
    13be:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
    13c1:	89 d8                	mov    %ebx,%eax
    13c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13c6:	c9                   	leave  
    13c7:	c3                   	ret    
    13c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13cf:	90                   	nop

000013d0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	53                   	push   %ebx
    13d4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
    13d7:	6a 0c                	push   $0xc
    13d9:	e8 12 0f 00 00       	call   22f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    13de:	83 c4 0c             	add    $0xc,%esp
    13e1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
    13e3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    13e5:	6a 00                	push   $0x0
    13e7:	50                   	push   %eax
    13e8:	e8 f3 08 00 00       	call   1ce0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
    13ed:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
    13f0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
    13f6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
    13f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13fc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
    13ff:	89 d8                	mov    %ebx,%eax
    1401:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1404:	c9                   	leave  
    1405:	c3                   	ret    
    1406:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    140d:	8d 76 00             	lea    0x0(%esi),%esi

00001410 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	53                   	push   %ebx
    1414:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1417:	6a 0c                	push   $0xc
    1419:	e8 d2 0e 00 00       	call   22f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    141e:	83 c4 0c             	add    $0xc,%esp
    1421:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
    1423:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    1425:	6a 00                	push   $0x0
    1427:	50                   	push   %eax
    1428:	e8 b3 08 00 00       	call   1ce0 <memset>
  cmd->type = LIST;
  cmd->left = left;
    142d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
    1430:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
    1436:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
    1439:	8b 45 0c             	mov    0xc(%ebp),%eax
    143c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
    143f:	89 d8                	mov    %ebx,%eax
    1441:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1444:	c9                   	leave  
    1445:	c3                   	ret    
    1446:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    144d:	8d 76 00             	lea    0x0(%esi),%esi

00001450 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	53                   	push   %ebx
    1454:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1457:	6a 08                	push   $0x8
    1459:	e8 92 0e 00 00       	call   22f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    145e:	83 c4 0c             	add    $0xc,%esp
    1461:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
    1463:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    1465:	6a 00                	push   $0x0
    1467:	50                   	push   %eax
    1468:	e8 73 08 00 00       	call   1ce0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
    146d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
    1470:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
    1476:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
    1479:	89 d8                	mov    %ebx,%eax
    147b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    147e:	c9                   	leave  
    147f:	c3                   	ret    

00001480 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
    1480:	55                   	push   %ebp
    1481:	89 e5                	mov    %esp,%ebp
    1483:	57                   	push   %edi
    1484:	56                   	push   %esi
    1485:	53                   	push   %ebx
    1486:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
    1489:	8b 45 08             	mov    0x8(%ebp),%eax
{
    148c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    148f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
    1492:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
    1494:	39 df                	cmp    %ebx,%edi
    1496:	72 0f                	jb     14a7 <gettoken+0x27>
    1498:	eb 25                	jmp    14bf <gettoken+0x3f>
    149a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
    14a0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
    14a3:	39 fb                	cmp    %edi,%ebx
    14a5:	74 18                	je     14bf <gettoken+0x3f>
    14a7:	0f be 07             	movsbl (%edi),%eax
    14aa:	83 ec 08             	sub    $0x8,%esp
    14ad:	50                   	push   %eax
    14ae:	68 38 2b 00 00       	push   $0x2b38
    14b3:	e8 48 08 00 00       	call   1d00 <strchr>
    14b8:	83 c4 10             	add    $0x10,%esp
    14bb:	85 c0                	test   %eax,%eax
    14bd:	75 e1                	jne    14a0 <gettoken+0x20>
  if(q)
    14bf:	85 f6                	test   %esi,%esi
    14c1:	74 02                	je     14c5 <gettoken+0x45>
    *q = s;
    14c3:	89 3e                	mov    %edi,(%esi)
  ret = *s;
    14c5:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
    14c8:	3c 3c                	cmp    $0x3c,%al
    14ca:	0f 8f d0 00 00 00    	jg     15a0 <gettoken+0x120>
    14d0:	3c 3a                	cmp    $0x3a,%al
    14d2:	0f 8f b4 00 00 00    	jg     158c <gettoken+0x10c>
    14d8:	84 c0                	test   %al,%al
    14da:	75 44                	jne    1520 <gettoken+0xa0>
    14dc:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
    14de:	8b 55 14             	mov    0x14(%ebp),%edx
    14e1:	85 d2                	test   %edx,%edx
    14e3:	74 05                	je     14ea <gettoken+0x6a>
    *eq = s;
    14e5:	8b 45 14             	mov    0x14(%ebp),%eax
    14e8:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
    14ea:	39 df                	cmp    %ebx,%edi
    14ec:	72 09                	jb     14f7 <gettoken+0x77>
    14ee:	eb 1f                	jmp    150f <gettoken+0x8f>
    s++;
    14f0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
    14f3:	39 fb                	cmp    %edi,%ebx
    14f5:	74 18                	je     150f <gettoken+0x8f>
    14f7:	0f be 07             	movsbl (%edi),%eax
    14fa:	83 ec 08             	sub    $0x8,%esp
    14fd:	50                   	push   %eax
    14fe:	68 38 2b 00 00       	push   $0x2b38
    1503:	e8 f8 07 00 00       	call   1d00 <strchr>
    1508:	83 c4 10             	add    $0x10,%esp
    150b:	85 c0                	test   %eax,%eax
    150d:	75 e1                	jne    14f0 <gettoken+0x70>
  *ps = s;
    150f:	8b 45 08             	mov    0x8(%ebp),%eax
    1512:	89 38                	mov    %edi,(%eax)
  return ret;
}
    1514:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1517:	89 f0                	mov    %esi,%eax
    1519:	5b                   	pop    %ebx
    151a:	5e                   	pop    %esi
    151b:	5f                   	pop    %edi
    151c:	5d                   	pop    %ebp
    151d:	c3                   	ret    
    151e:	66 90                	xchg   %ax,%ax
  switch(*s){
    1520:	79 5e                	jns    1580 <gettoken+0x100>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    1522:	39 fb                	cmp    %edi,%ebx
    1524:	77 34                	ja     155a <gettoken+0xda>
  if(eq)
    1526:	8b 45 14             	mov    0x14(%ebp),%eax
    1529:	be 61 00 00 00       	mov    $0x61,%esi
    152e:	85 c0                	test   %eax,%eax
    1530:	75 b3                	jne    14e5 <gettoken+0x65>
    1532:	eb db                	jmp    150f <gettoken+0x8f>
    1534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    1538:	0f be 07             	movsbl (%edi),%eax
    153b:	83 ec 08             	sub    $0x8,%esp
    153e:	50                   	push   %eax
    153f:	68 30 2b 00 00       	push   $0x2b30
    1544:	e8 b7 07 00 00       	call   1d00 <strchr>
    1549:	83 c4 10             	add    $0x10,%esp
    154c:	85 c0                	test   %eax,%eax
    154e:	75 22                	jne    1572 <gettoken+0xf2>
      s++;
    1550:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    1553:	39 fb                	cmp    %edi,%ebx
    1555:	74 cf                	je     1526 <gettoken+0xa6>
    1557:	0f b6 07             	movzbl (%edi),%eax
    155a:	83 ec 08             	sub    $0x8,%esp
    155d:	0f be f0             	movsbl %al,%esi
    1560:	56                   	push   %esi
    1561:	68 38 2b 00 00       	push   $0x2b38
    1566:	e8 95 07 00 00       	call   1d00 <strchr>
    156b:	83 c4 10             	add    $0x10,%esp
    156e:	85 c0                	test   %eax,%eax
    1570:	74 c6                	je     1538 <gettoken+0xb8>
    ret = 'a';
    1572:	be 61 00 00 00       	mov    $0x61,%esi
    1577:	e9 62 ff ff ff       	jmp    14de <gettoken+0x5e>
    157c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
    1580:	3c 26                	cmp    $0x26,%al
    1582:	74 08                	je     158c <gettoken+0x10c>
    1584:	8d 48 d8             	lea    -0x28(%eax),%ecx
    1587:	80 f9 01             	cmp    $0x1,%cl
    158a:	77 96                	ja     1522 <gettoken+0xa2>
  ret = *s;
    158c:	0f be f0             	movsbl %al,%esi
    s++;
    158f:	83 c7 01             	add    $0x1,%edi
    break;
    1592:	e9 47 ff ff ff       	jmp    14de <gettoken+0x5e>
    1597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    159e:	66 90                	xchg   %ax,%ax
  switch(*s){
    15a0:	3c 3e                	cmp    $0x3e,%al
    15a2:	75 1c                	jne    15c0 <gettoken+0x140>
    if(*s == '>'){
    15a4:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
    s++;
    15a8:	8d 47 01             	lea    0x1(%edi),%eax
    if(*s == '>'){
    15ab:	74 1c                	je     15c9 <gettoken+0x149>
    s++;
    15ad:	89 c7                	mov    %eax,%edi
    15af:	be 3e 00 00 00       	mov    $0x3e,%esi
    15b4:	e9 25 ff ff ff       	jmp    14de <gettoken+0x5e>
    15b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
    15c0:	3c 7c                	cmp    $0x7c,%al
    15c2:	74 c8                	je     158c <gettoken+0x10c>
    15c4:	e9 59 ff ff ff       	jmp    1522 <gettoken+0xa2>
      s++;
    15c9:	83 c7 02             	add    $0x2,%edi
      ret = '+';
    15cc:	be 2b 00 00 00       	mov    $0x2b,%esi
    15d1:	e9 08 ff ff ff       	jmp    14de <gettoken+0x5e>
    15d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15dd:	8d 76 00             	lea    0x0(%esi),%esi

000015e0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
    15e0:	55                   	push   %ebp
    15e1:	89 e5                	mov    %esp,%ebp
    15e3:	57                   	push   %edi
    15e4:	56                   	push   %esi
    15e5:	53                   	push   %ebx
    15e6:	83 ec 0c             	sub    $0xc,%esp
    15e9:	8b 7d 08             	mov    0x8(%ebp),%edi
    15ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
    15ef:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
    15f1:	39 f3                	cmp    %esi,%ebx
    15f3:	72 12                	jb     1607 <peek+0x27>
    15f5:	eb 28                	jmp    161f <peek+0x3f>
    15f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15fe:	66 90                	xchg   %ax,%ax
    s++;
    1600:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
    1603:	39 de                	cmp    %ebx,%esi
    1605:	74 18                	je     161f <peek+0x3f>
    1607:	0f be 03             	movsbl (%ebx),%eax
    160a:	83 ec 08             	sub    $0x8,%esp
    160d:	50                   	push   %eax
    160e:	68 38 2b 00 00       	push   $0x2b38
    1613:	e8 e8 06 00 00       	call   1d00 <strchr>
    1618:	83 c4 10             	add    $0x10,%esp
    161b:	85 c0                	test   %eax,%eax
    161d:	75 e1                	jne    1600 <peek+0x20>
  *ps = s;
    161f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
    1621:	0f be 03             	movsbl (%ebx),%eax
    1624:	31 d2                	xor    %edx,%edx
    1626:	84 c0                	test   %al,%al
    1628:	75 0e                	jne    1638 <peek+0x58>
}
    162a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    162d:	89 d0                	mov    %edx,%eax
    162f:	5b                   	pop    %ebx
    1630:	5e                   	pop    %esi
    1631:	5f                   	pop    %edi
    1632:	5d                   	pop    %ebp
    1633:	c3                   	ret    
    1634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
    1638:	83 ec 08             	sub    $0x8,%esp
    163b:	50                   	push   %eax
    163c:	ff 75 10             	pushl  0x10(%ebp)
    163f:	e8 bc 06 00 00       	call   1d00 <strchr>
    1644:	83 c4 10             	add    $0x10,%esp
    1647:	31 d2                	xor    %edx,%edx
    1649:	85 c0                	test   %eax,%eax
    164b:	0f 95 c2             	setne  %dl
}
    164e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1651:	5b                   	pop    %ebx
    1652:	89 d0                	mov    %edx,%eax
    1654:	5e                   	pop    %esi
    1655:	5f                   	pop    %edi
    1656:	5d                   	pop    %ebp
    1657:	c3                   	ret    
    1658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    165f:	90                   	nop

00001660 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
    1660:	55                   	push   %ebp
    1661:	89 e5                	mov    %esp,%ebp
    1663:	57                   	push   %edi
    1664:	56                   	push   %esi
    1665:	53                   	push   %ebx
    1666:	83 ec 2c             	sub    $0x2c,%esp
    1669:	8b 75 0c             	mov    0xc(%ebp),%esi
    166c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    166f:	90                   	nop
    1670:	83 ec 04             	sub    $0x4,%esp
    1673:	68 49 24 00 00       	push   $0x2449
    1678:	53                   	push   %ebx
    1679:	56                   	push   %esi
    167a:	e8 61 ff ff ff       	call   15e0 <peek>
    167f:	83 c4 10             	add    $0x10,%esp
    1682:	85 c0                	test   %eax,%eax
    1684:	0f 84 f6 00 00 00    	je     1780 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
    168a:	6a 00                	push   $0x0
    168c:	6a 00                	push   $0x0
    168e:	53                   	push   %ebx
    168f:	56                   	push   %esi
    1690:	e8 eb fd ff ff       	call   1480 <gettoken>
    1695:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
    1697:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    169a:	50                   	push   %eax
    169b:	8d 45 e0             	lea    -0x20(%ebp),%eax
    169e:	50                   	push   %eax
    169f:	53                   	push   %ebx
    16a0:	56                   	push   %esi
    16a1:	e8 da fd ff ff       	call   1480 <gettoken>
    16a6:	83 c4 20             	add    $0x20,%esp
    16a9:	83 f8 61             	cmp    $0x61,%eax
    16ac:	0f 85 d9 00 00 00    	jne    178b <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
    16b2:	83 ff 3c             	cmp    $0x3c,%edi
    16b5:	74 69                	je     1720 <parseredirs+0xc0>
    16b7:	83 ff 3e             	cmp    $0x3e,%edi
    16ba:	74 05                	je     16c1 <parseredirs+0x61>
    16bc:	83 ff 2b             	cmp    $0x2b,%edi
    16bf:	75 af                	jne    1670 <parseredirs+0x10>
  cmd = malloc(sizeof(*cmd));
    16c1:	83 ec 0c             	sub    $0xc,%esp
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    16c4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    16c7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
    16ca:	6a 18                	push   $0x18
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    16cc:	89 55 d0             	mov    %edx,-0x30(%ebp)
    16cf:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
    16d2:	e8 19 0c 00 00       	call   22f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    16d7:	83 c4 0c             	add    $0xc,%esp
    16da:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
    16dc:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
    16de:	6a 00                	push   $0x0
    16e0:	50                   	push   %eax
    16e1:	e8 fa 05 00 00       	call   1ce0 <memset>
  cmd->type = REDIR;
    16e6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
    16ec:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
    16ef:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
    16f2:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
    16f5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    16f8:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
    16fb:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
    16fe:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
    1705:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
    1708:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      break;
    170f:	89 7d 08             	mov    %edi,0x8(%ebp)
    1712:	e9 59 ff ff ff       	jmp    1670 <parseredirs+0x10>
    1717:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    171e:	66 90                	xchg   %ax,%ax
  cmd = malloc(sizeof(*cmd));
    1720:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
    1723:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1726:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
    1729:	6a 18                	push   $0x18
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
    172b:	89 55 d0             	mov    %edx,-0x30(%ebp)
    172e:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
    1731:	e8 ba 0b 00 00       	call   22f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    1736:	83 c4 0c             	add    $0xc,%esp
    1739:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
    173b:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
    173d:	6a 00                	push   $0x0
    173f:	50                   	push   %eax
    1740:	e8 9b 05 00 00       	call   1ce0 <memset>
  cmd->cmd = subcmd;
    1745:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
    1748:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
    174b:	89 7d 08             	mov    %edi,0x8(%ebp)
  cmd->efile = efile;
    174e:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
    1751:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
      break;
    1757:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
    175a:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
    175d:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
    1760:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
    1763:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
    176a:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      break;
    1771:	e9 fa fe ff ff       	jmp    1670 <parseredirs+0x10>
    1776:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    177d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
  return cmd;
}
    1780:	8b 45 08             	mov    0x8(%ebp),%eax
    1783:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1786:	5b                   	pop    %ebx
    1787:	5e                   	pop    %esi
    1788:	5f                   	pop    %edi
    1789:	5d                   	pop    %ebp
    178a:	c3                   	ret    
      panic("missing file for redirection");
    178b:	83 ec 0c             	sub    $0xc,%esp
    178e:	68 2c 24 00 00       	push   $0x242c
    1793:	e8 e8 f9 ff ff       	call   1180 <panic>
    1798:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    179f:	90                   	nop

000017a0 <parseexec.part.0>:
  cmd = parseredirs(cmd, ps, es);
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
    17a0:	55                   	push   %ebp
    17a1:	89 e5                	mov    %esp,%ebp
    17a3:	57                   	push   %edi
    17a4:	89 d7                	mov    %edx,%edi
    17a6:	56                   	push   %esi
    17a7:	89 c6                	mov    %eax,%esi
    17a9:	53                   	push   %ebx
    17aa:	83 ec 38             	sub    $0x38,%esp
  cmd = malloc(sizeof(*cmd));
    17ad:	6a 54                	push   $0x54
    17af:	e8 3c 0b 00 00       	call   22f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    17b4:	83 c4 0c             	add    $0xc,%esp
    17b7:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
    17b9:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    17bb:	6a 00                	push   $0x0
    17bd:	50                   	push   %eax
  cmd = malloc(sizeof(*cmd));
    17be:	89 45 d0             	mov    %eax,-0x30(%ebp)
  memset(cmd, 0, sizeof(*cmd));
    17c1:	e8 1a 05 00 00       	call   1ce0 <memset>

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
    17c6:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
    17c9:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  ret = parseredirs(ret, ps, es);
    17cf:	57                   	push   %edi
    17d0:	56                   	push   %esi
    17d1:	53                   	push   %ebx
  argc = 0;
    17d2:	31 db                	xor    %ebx,%ebx
  ret = parseredirs(ret, ps, es);
    17d4:	e8 87 fe ff ff       	call   1660 <parseredirs>
  while(!peek(ps, es, "|)&;")){
    17d9:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
    17dc:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
    17df:	eb 1a                	jmp    17fb <parseexec.part.0+0x5b>
    17e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
    17e8:	83 ec 04             	sub    $0x4,%esp
    17eb:	57                   	push   %edi
    17ec:	56                   	push   %esi
    17ed:	ff 75 d4             	pushl  -0x2c(%ebp)
    17f0:	e8 6b fe ff ff       	call   1660 <parseredirs>
    17f5:	83 c4 10             	add    $0x10,%esp
    17f8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
    17fb:	83 ec 04             	sub    $0x4,%esp
    17fe:	68 61 24 00 00       	push   $0x2461
    1803:	57                   	push   %edi
    1804:	56                   	push   %esi
    1805:	e8 d6 fd ff ff       	call   15e0 <peek>
    180a:	83 c4 10             	add    $0x10,%esp
    180d:	85 c0                	test   %eax,%eax
    180f:	75 47                	jne    1858 <parseexec.part.0+0xb8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    1811:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1814:	50                   	push   %eax
    1815:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1818:	50                   	push   %eax
    1819:	57                   	push   %edi
    181a:	56                   	push   %esi
    181b:	e8 60 fc ff ff       	call   1480 <gettoken>
    1820:	83 c4 10             	add    $0x10,%esp
    1823:	85 c0                	test   %eax,%eax
    1825:	74 31                	je     1858 <parseexec.part.0+0xb8>
    if(tok != 'a')
    1827:	83 f8 61             	cmp    $0x61,%eax
    182a:	75 4a                	jne    1876 <parseexec.part.0+0xd6>
    cmd->argv[argc] = q;
    182c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    182f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    1832:	89 44 99 04          	mov    %eax,0x4(%ecx,%ebx,4)
    cmd->eargv[argc] = eq;
    1836:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1839:	89 44 99 2c          	mov    %eax,0x2c(%ecx,%ebx,4)
    argc++;
    183d:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
    1840:	83 fb 0a             	cmp    $0xa,%ebx
    1843:	75 a3                	jne    17e8 <parseexec.part.0+0x48>
      panic("too many args");
    1845:	83 ec 0c             	sub    $0xc,%esp
    1848:	68 53 24 00 00       	push   $0x2453
    184d:	e8 2e f9 ff ff       	call   1180 <panic>
    1852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  cmd->argv[argc] = 0;
    1858:	8b 45 d0             	mov    -0x30(%ebp),%eax
    185b:	c7 44 98 04 00 00 00 	movl   $0x0,0x4(%eax,%ebx,4)
    1862:	00 
  cmd->eargv[argc] = 0;
    1863:	c7 44 98 2c 00 00 00 	movl   $0x0,0x2c(%eax,%ebx,4)
    186a:	00 
  return ret;
}
    186b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    186e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1871:	5b                   	pop    %ebx
    1872:	5e                   	pop    %esi
    1873:	5f                   	pop    %edi
    1874:	5d                   	pop    %ebp
    1875:	c3                   	ret    
      panic("syntax");
    1876:	83 ec 0c             	sub    $0xc,%esp
    1879:	68 4c 24 00 00       	push   $0x244c
    187e:	e8 fd f8 ff ff       	call   1180 <panic>
    1883:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    188a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001890 <parseblock>:
{
    1890:	55                   	push   %ebp
    1891:	89 e5                	mov    %esp,%ebp
    1893:	57                   	push   %edi
    1894:	56                   	push   %esi
    1895:	53                   	push   %ebx
    1896:	83 ec 10             	sub    $0x10,%esp
    1899:	8b 5d 08             	mov    0x8(%ebp),%ebx
    189c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
    189f:	68 66 24 00 00       	push   $0x2466
    18a4:	56                   	push   %esi
    18a5:	53                   	push   %ebx
    18a6:	e8 35 fd ff ff       	call   15e0 <peek>
    18ab:	83 c4 10             	add    $0x10,%esp
    18ae:	85 c0                	test   %eax,%eax
    18b0:	74 4a                	je     18fc <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
    18b2:	6a 00                	push   $0x0
    18b4:	6a 00                	push   $0x0
    18b6:	56                   	push   %esi
    18b7:	53                   	push   %ebx
    18b8:	e8 c3 fb ff ff       	call   1480 <gettoken>
  cmd = parseline(ps, es);
    18bd:	58                   	pop    %eax
    18be:	5a                   	pop    %edx
    18bf:	56                   	push   %esi
    18c0:	53                   	push   %ebx
    18c1:	e8 1a 01 00 00       	call   19e0 <parseline>
  if(!peek(ps, es, ")"))
    18c6:	83 c4 0c             	add    $0xc,%esp
    18c9:	68 84 24 00 00       	push   $0x2484
  cmd = parseline(ps, es);
    18ce:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
    18d0:	56                   	push   %esi
    18d1:	53                   	push   %ebx
    18d2:	e8 09 fd ff ff       	call   15e0 <peek>
    18d7:	83 c4 10             	add    $0x10,%esp
    18da:	85 c0                	test   %eax,%eax
    18dc:	74 2b                	je     1909 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
    18de:	6a 00                	push   $0x0
    18e0:	6a 00                	push   $0x0
    18e2:	56                   	push   %esi
    18e3:	53                   	push   %ebx
    18e4:	e8 97 fb ff ff       	call   1480 <gettoken>
  cmd = parseredirs(cmd, ps, es);
    18e9:	83 c4 0c             	add    $0xc,%esp
    18ec:	56                   	push   %esi
    18ed:	53                   	push   %ebx
    18ee:	57                   	push   %edi
    18ef:	e8 6c fd ff ff       	call   1660 <parseredirs>
}
    18f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    18f7:	5b                   	pop    %ebx
    18f8:	5e                   	pop    %esi
    18f9:	5f                   	pop    %edi
    18fa:	5d                   	pop    %ebp
    18fb:	c3                   	ret    
    panic("parseblock");
    18fc:	83 ec 0c             	sub    $0xc,%esp
    18ff:	68 68 24 00 00       	push   $0x2468
    1904:	e8 77 f8 ff ff       	call   1180 <panic>
    panic("syntax - missing )");
    1909:	83 ec 0c             	sub    $0xc,%esp
    190c:	68 73 24 00 00       	push   $0x2473
    1911:	e8 6a f8 ff ff       	call   1180 <panic>
    1916:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    191d:	8d 76 00             	lea    0x0(%esi),%esi

00001920 <parsepipe>:
{
    1920:	55                   	push   %ebp
    1921:	89 e5                	mov    %esp,%ebp
    1923:	57                   	push   %edi
    1924:	56                   	push   %esi
    1925:	53                   	push   %ebx
    1926:	83 ec 10             	sub    $0x10,%esp
    1929:	8b 75 08             	mov    0x8(%ebp),%esi
    192c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(peek(ps, es, "("))
    192f:	68 66 24 00 00       	push   $0x2466
    1934:	57                   	push   %edi
    1935:	56                   	push   %esi
    1936:	e8 a5 fc ff ff       	call   15e0 <peek>
    193b:	83 c4 10             	add    $0x10,%esp
    193e:	85 c0                	test   %eax,%eax
    1940:	75 2e                	jne    1970 <parsepipe+0x50>
    1942:	89 fa                	mov    %edi,%edx
    1944:	89 f0                	mov    %esi,%eax
    1946:	e8 55 fe ff ff       	call   17a0 <parseexec.part.0>
    194b:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
    194d:	83 ec 04             	sub    $0x4,%esp
    1950:	68 86 24 00 00       	push   $0x2486
    1955:	57                   	push   %edi
    1956:	56                   	push   %esi
    1957:	e8 84 fc ff ff       	call   15e0 <peek>
    195c:	83 c4 10             	add    $0x10,%esp
    195f:	85 c0                	test   %eax,%eax
    1961:	75 25                	jne    1988 <parsepipe+0x68>
}
    1963:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1966:	89 d8                	mov    %ebx,%eax
    1968:	5b                   	pop    %ebx
    1969:	5e                   	pop    %esi
    196a:	5f                   	pop    %edi
    196b:	5d                   	pop    %ebp
    196c:	c3                   	ret    
    196d:	8d 76 00             	lea    0x0(%esi),%esi
    return parseblock(ps, es);
    1970:	83 ec 08             	sub    $0x8,%esp
    1973:	57                   	push   %edi
    1974:	56                   	push   %esi
    1975:	e8 16 ff ff ff       	call   1890 <parseblock>
    197a:	83 c4 10             	add    $0x10,%esp
    197d:	89 c3                	mov    %eax,%ebx
    197f:	eb cc                	jmp    194d <parsepipe+0x2d>
    1981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
    1988:	6a 00                	push   $0x0
    198a:	6a 00                	push   $0x0
    198c:	57                   	push   %edi
    198d:	56                   	push   %esi
    198e:	e8 ed fa ff ff       	call   1480 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
    1993:	58                   	pop    %eax
    1994:	5a                   	pop    %edx
    1995:	57                   	push   %edi
    1996:	56                   	push   %esi
    1997:	e8 84 ff ff ff       	call   1920 <parsepipe>
  cmd = malloc(sizeof(*cmd));
    199c:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
    19a3:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
    19a5:	e8 46 09 00 00       	call   22f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    19aa:	83 c4 0c             	add    $0xc,%esp
    19ad:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
    19af:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
    19b1:	6a 00                	push   $0x0
    19b3:	50                   	push   %eax
    19b4:	e8 27 03 00 00       	call   1ce0 <memset>
  cmd->left = left;
    19b9:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
    19bc:	83 c4 10             	add    $0x10,%esp
    19bf:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
    19c1:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
    19c7:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
    19c9:	89 7e 08             	mov    %edi,0x8(%esi)
}
    19cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19cf:	5b                   	pop    %ebx
    19d0:	5e                   	pop    %esi
    19d1:	5f                   	pop    %edi
    19d2:	5d                   	pop    %ebp
    19d3:	c3                   	ret    
    19d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    19db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    19df:	90                   	nop

000019e0 <parseline>:
{
    19e0:	55                   	push   %ebp
    19e1:	89 e5                	mov    %esp,%ebp
    19e3:	57                   	push   %edi
    19e4:	56                   	push   %esi
    19e5:	53                   	push   %ebx
    19e6:	83 ec 24             	sub    $0x24,%esp
    19e9:	8b 75 08             	mov    0x8(%ebp),%esi
    19ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
    19ef:	57                   	push   %edi
    19f0:	56                   	push   %esi
    19f1:	e8 2a ff ff ff       	call   1920 <parsepipe>
  while(peek(ps, es, "&")){
    19f6:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
    19f9:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
    19fb:	eb 3b                	jmp    1a38 <parseline+0x58>
    19fd:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
    1a00:	6a 00                	push   $0x0
    1a02:	6a 00                	push   $0x0
    1a04:	57                   	push   %edi
    1a05:	56                   	push   %esi
    1a06:	e8 75 fa ff ff       	call   1480 <gettoken>
  cmd = malloc(sizeof(*cmd));
    1a0b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1a12:	e8 d9 08 00 00       	call   22f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    1a17:	83 c4 0c             	add    $0xc,%esp
    1a1a:	6a 08                	push   $0x8
    1a1c:	6a 00                	push   $0x0
    1a1e:	50                   	push   %eax
    1a1f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1a22:	e8 b9 02 00 00       	call   1ce0 <memset>
  cmd->type = BACK;
    1a27:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
    1a2a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
    1a2d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
    1a33:	89 5a 04             	mov    %ebx,0x4(%edx)
    1a36:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
    1a38:	83 ec 04             	sub    $0x4,%esp
    1a3b:	68 88 24 00 00       	push   $0x2488
    1a40:	57                   	push   %edi
    1a41:	56                   	push   %esi
    1a42:	e8 99 fb ff ff       	call   15e0 <peek>
    1a47:	83 c4 10             	add    $0x10,%esp
    1a4a:	85 c0                	test   %eax,%eax
    1a4c:	75 b2                	jne    1a00 <parseline+0x20>
  if(peek(ps, es, ";")){
    1a4e:	83 ec 04             	sub    $0x4,%esp
    1a51:	68 64 24 00 00       	push   $0x2464
    1a56:	57                   	push   %edi
    1a57:	56                   	push   %esi
    1a58:	e8 83 fb ff ff       	call   15e0 <peek>
    1a5d:	83 c4 10             	add    $0x10,%esp
    1a60:	85 c0                	test   %eax,%eax
    1a62:	75 0c                	jne    1a70 <parseline+0x90>
}
    1a64:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a67:	89 d8                	mov    %ebx,%eax
    1a69:	5b                   	pop    %ebx
    1a6a:	5e                   	pop    %esi
    1a6b:	5f                   	pop    %edi
    1a6c:	5d                   	pop    %ebp
    1a6d:	c3                   	ret    
    1a6e:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
    1a70:	6a 00                	push   $0x0
    1a72:	6a 00                	push   $0x0
    1a74:	57                   	push   %edi
    1a75:	56                   	push   %esi
    1a76:	e8 05 fa ff ff       	call   1480 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
    1a7b:	58                   	pop    %eax
    1a7c:	5a                   	pop    %edx
    1a7d:	57                   	push   %edi
    1a7e:	56                   	push   %esi
    1a7f:	e8 5c ff ff ff       	call   19e0 <parseline>
  cmd = malloc(sizeof(*cmd));
    1a84:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
    1a8b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
    1a8d:	e8 5e 08 00 00       	call   22f0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    1a92:	83 c4 0c             	add    $0xc,%esp
    1a95:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
    1a97:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
    1a99:	6a 00                	push   $0x0
    1a9b:	50                   	push   %eax
    1a9c:	e8 3f 02 00 00       	call   1ce0 <memset>
  cmd->left = left;
    1aa1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
    1aa4:	83 c4 10             	add    $0x10,%esp
    1aa7:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
    1aa9:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
    1aaf:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
    1ab1:	89 7e 08             	mov    %edi,0x8(%esi)
}
    1ab4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ab7:	5b                   	pop    %ebx
    1ab8:	5e                   	pop    %esi
    1ab9:	5f                   	pop    %edi
    1aba:	5d                   	pop    %ebp
    1abb:	c3                   	ret    
    1abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001ac0 <parseexec>:
{
    1ac0:	55                   	push   %ebp
    1ac1:	89 e5                	mov    %esp,%ebp
    1ac3:	56                   	push   %esi
    1ac4:	53                   	push   %ebx
    1ac5:	8b 75 0c             	mov    0xc(%ebp),%esi
    1ac8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(peek(ps, es, "("))
    1acb:	83 ec 04             	sub    $0x4,%esp
    1ace:	68 66 24 00 00       	push   $0x2466
    1ad3:	56                   	push   %esi
    1ad4:	53                   	push   %ebx
    1ad5:	e8 06 fb ff ff       	call   15e0 <peek>
    1ada:	83 c4 10             	add    $0x10,%esp
    1add:	85 c0                	test   %eax,%eax
    1adf:	75 0f                	jne    1af0 <parseexec+0x30>
}
    1ae1:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1ae4:	89 f2                	mov    %esi,%edx
    1ae6:	89 d8                	mov    %ebx,%eax
    1ae8:	5b                   	pop    %ebx
    1ae9:	5e                   	pop    %esi
    1aea:	5d                   	pop    %ebp
    1aeb:	e9 b0 fc ff ff       	jmp    17a0 <parseexec.part.0>
    return parseblock(ps, es);
    1af0:	89 75 0c             	mov    %esi,0xc(%ebp)
    1af3:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
    1af6:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1af9:	5b                   	pop    %ebx
    1afa:	5e                   	pop    %esi
    1afb:	5d                   	pop    %ebp
    return parseblock(ps, es);
    1afc:	e9 8f fd ff ff       	jmp    1890 <parseblock>
    1b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1b08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1b0f:	90                   	nop

00001b10 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    1b10:	55                   	push   %ebp
    1b11:	89 e5                	mov    %esp,%ebp
    1b13:	53                   	push   %ebx
    1b14:	83 ec 04             	sub    $0x4,%esp
    1b17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    1b1a:	85 db                	test   %ebx,%ebx
    1b1c:	0f 84 8e 00 00 00    	je     1bb0 <nulterminate+0xa0>
    return 0;

  switch(cmd->type){
    1b22:	83 3b 05             	cmpl   $0x5,(%ebx)
    1b25:	77 61                	ja     1b88 <nulterminate+0x78>
    1b27:	8b 03                	mov    (%ebx),%eax
    1b29:	ff 24 85 c8 24 00 00 	jmp    *0x24c8(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
    1b30:	83 ec 0c             	sub    $0xc,%esp
    1b33:	ff 73 04             	pushl  0x4(%ebx)
    1b36:	e8 d5 ff ff ff       	call   1b10 <nulterminate>
    nulterminate(lcmd->right);
    1b3b:	58                   	pop    %eax
    1b3c:	ff 73 08             	pushl  0x8(%ebx)
    1b3f:	e8 cc ff ff ff       	call   1b10 <nulterminate>
    break;
    1b44:	83 c4 10             	add    $0x10,%esp
    1b47:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
    1b49:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1b4c:	c9                   	leave  
    1b4d:	c3                   	ret    
    1b4e:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
    1b50:	83 ec 0c             	sub    $0xc,%esp
    1b53:	ff 73 04             	pushl  0x4(%ebx)
    1b56:	e8 b5 ff ff ff       	call   1b10 <nulterminate>
    break;
    1b5b:	89 d8                	mov    %ebx,%eax
    1b5d:	83 c4 10             	add    $0x10,%esp
}
    1b60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1b63:	c9                   	leave  
    1b64:	c3                   	ret    
    1b65:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
    1b68:	8b 4b 04             	mov    0x4(%ebx),%ecx
    1b6b:	8d 43 08             	lea    0x8(%ebx),%eax
    1b6e:	85 c9                	test   %ecx,%ecx
    1b70:	74 16                	je     1b88 <nulterminate+0x78>
    1b72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
    1b78:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
    1b7b:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
    1b7e:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
    1b81:	8b 50 fc             	mov    -0x4(%eax),%edx
    1b84:	85 d2                	test   %edx,%edx
    1b86:	75 f0                	jne    1b78 <nulterminate+0x68>
  switch(cmd->type){
    1b88:	89 d8                	mov    %ebx,%eax
}
    1b8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1b8d:	c9                   	leave  
    1b8e:	c3                   	ret    
    1b8f:	90                   	nop
    nulterminate(rcmd->cmd);
    1b90:	83 ec 0c             	sub    $0xc,%esp
    1b93:	ff 73 04             	pushl  0x4(%ebx)
    1b96:	e8 75 ff ff ff       	call   1b10 <nulterminate>
    *rcmd->efile = 0;
    1b9b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
    1b9e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
    1ba1:	c6 00 00             	movb   $0x0,(%eax)
    break;
    1ba4:	89 d8                	mov    %ebx,%eax
}
    1ba6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1ba9:	c9                   	leave  
    1baa:	c3                   	ret    
    1bab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1baf:	90                   	nop
    return 0;
    1bb0:	31 c0                	xor    %eax,%eax
    1bb2:	eb 95                	jmp    1b49 <nulterminate+0x39>
    1bb4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1bbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1bbf:	90                   	nop

00001bc0 <parsecmd>:
{
    1bc0:	55                   	push   %ebp
    1bc1:	89 e5                	mov    %esp,%ebp
    1bc3:	57                   	push   %edi
    1bc4:	56                   	push   %esi
  cmd = parseline(&s, es);
    1bc5:	8d 7d 08             	lea    0x8(%ebp),%edi
{
    1bc8:	53                   	push   %ebx
    1bc9:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
    1bcc:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1bcf:	53                   	push   %ebx
    1bd0:	e8 db 00 00 00       	call   1cb0 <strlen>
  cmd = parseline(&s, es);
    1bd5:	59                   	pop    %ecx
    1bd6:	5e                   	pop    %esi
  es = s + strlen(s);
    1bd7:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
    1bd9:	53                   	push   %ebx
    1bda:	57                   	push   %edi
    1bdb:	e8 00 fe ff ff       	call   19e0 <parseline>
  peek(&s, es, "");
    1be0:	83 c4 0c             	add    $0xc,%esp
    1be3:	68 16 24 00 00       	push   $0x2416
  cmd = parseline(&s, es);
    1be8:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
    1bea:	53                   	push   %ebx
    1beb:	57                   	push   %edi
    1bec:	e8 ef f9 ff ff       	call   15e0 <peek>
  if(s != es){
    1bf1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf4:	83 c4 10             	add    $0x10,%esp
    1bf7:	39 d8                	cmp    %ebx,%eax
    1bf9:	75 13                	jne    1c0e <parsecmd+0x4e>
  nulterminate(cmd);
    1bfb:	83 ec 0c             	sub    $0xc,%esp
    1bfe:	56                   	push   %esi
    1bff:	e8 0c ff ff ff       	call   1b10 <nulterminate>
}
    1c04:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1c07:	89 f0                	mov    %esi,%eax
    1c09:	5b                   	pop    %ebx
    1c0a:	5e                   	pop    %esi
    1c0b:	5f                   	pop    %edi
    1c0c:	5d                   	pop    %ebp
    1c0d:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
    1c0e:	52                   	push   %edx
    1c0f:	50                   	push   %eax
    1c10:	68 8a 24 00 00       	push   $0x248a
    1c15:	6a 02                	push   $0x2
    1c17:	e8 74 04 00 00       	call   2090 <printf>
    panic("syntax");
    1c1c:	c7 04 24 4c 24 00 00 	movl   $0x244c,(%esp)
    1c23:	e8 58 f5 ff ff       	call   1180 <panic>
    1c28:	66 90                	xchg   %ax,%ax
    1c2a:	66 90                	xchg   %ax,%ax
    1c2c:	66 90                	xchg   %ax,%ax
    1c2e:	66 90                	xchg   %ax,%ax

00001c30 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"
char*
strcpy(char *s, const char *t)
{
    1c30:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1c31:	31 c0                	xor    %eax,%eax
{
    1c33:	89 e5                	mov    %esp,%ebp
    1c35:	53                   	push   %ebx
    1c36:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    1c40:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    1c44:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    1c47:	83 c0 01             	add    $0x1,%eax
    1c4a:	84 d2                	test   %dl,%dl
    1c4c:	75 f2                	jne    1c40 <strcpy+0x10>
    ;
  return os;
}
    1c4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1c51:	89 c8                	mov    %ecx,%eax
    1c53:	c9                   	leave  
    1c54:	c3                   	ret    
    1c55:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001c60 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1c60:	55                   	push   %ebp
    1c61:	89 e5                	mov    %esp,%ebp
    1c63:	53                   	push   %ebx
    1c64:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c67:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    1c6a:	0f b6 01             	movzbl (%ecx),%eax
    1c6d:	0f b6 1a             	movzbl (%edx),%ebx
    1c70:	84 c0                	test   %al,%al
    1c72:	75 1d                	jne    1c91 <strcmp+0x31>
    1c74:	eb 2a                	jmp    1ca0 <strcmp+0x40>
    1c76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1c7d:	8d 76 00             	lea    0x0(%esi),%esi
    1c80:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    1c84:	83 c1 01             	add    $0x1,%ecx
    1c87:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    1c8a:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    1c8d:	84 c0                	test   %al,%al
    1c8f:	74 0f                	je     1ca0 <strcmp+0x40>
    1c91:	38 d8                	cmp    %bl,%al
    1c93:	74 eb                	je     1c80 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1c95:	29 d8                	sub    %ebx,%eax
}
    1c97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1c9a:	c9                   	leave  
    1c9b:	c3                   	ret    
    1c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1ca0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1ca2:	29 d8                	sub    %ebx,%eax
}
    1ca4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1ca7:	c9                   	leave  
    1ca8:	c3                   	ret    
    1ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001cb0 <strlen>:

uint
strlen(const char *s)
{
    1cb0:	55                   	push   %ebp
    1cb1:	89 e5                	mov    %esp,%ebp
    1cb3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    1cb6:	80 3a 00             	cmpb   $0x0,(%edx)
    1cb9:	74 15                	je     1cd0 <strlen+0x20>
    1cbb:	31 c0                	xor    %eax,%eax
    1cbd:	8d 76 00             	lea    0x0(%esi),%esi
    1cc0:	83 c0 01             	add    $0x1,%eax
    1cc3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    1cc7:	89 c1                	mov    %eax,%ecx
    1cc9:	75 f5                	jne    1cc0 <strlen+0x10>
    ;
  return n;
}
    1ccb:	89 c8                	mov    %ecx,%eax
    1ccd:	5d                   	pop    %ebp
    1cce:	c3                   	ret    
    1ccf:	90                   	nop
  for(n = 0; s[n]; n++)
    1cd0:	31 c9                	xor    %ecx,%ecx
}
    1cd2:	5d                   	pop    %ebp
    1cd3:	89 c8                	mov    %ecx,%eax
    1cd5:	c3                   	ret    
    1cd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1cdd:	8d 76 00             	lea    0x0(%esi),%esi

00001ce0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1ce0:	55                   	push   %ebp
    1ce1:	89 e5                	mov    %esp,%ebp
    1ce3:	57                   	push   %edi
    1ce4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1ce7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1cea:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ced:	89 d7                	mov    %edx,%edi
    1cef:	fc                   	cld    
    1cf0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1cf2:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1cf5:	89 d0                	mov    %edx,%eax
    1cf7:	c9                   	leave  
    1cf8:	c3                   	ret    
    1cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001d00 <strchr>:

char*
strchr(const char *s, char c)
{
    1d00:	55                   	push   %ebp
    1d01:	89 e5                	mov    %esp,%ebp
    1d03:	8b 45 08             	mov    0x8(%ebp),%eax
    1d06:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    1d0a:	0f b6 10             	movzbl (%eax),%edx
    1d0d:	84 d2                	test   %dl,%dl
    1d0f:	75 12                	jne    1d23 <strchr+0x23>
    1d11:	eb 1d                	jmp    1d30 <strchr+0x30>
    1d13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1d17:	90                   	nop
    1d18:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    1d1c:	83 c0 01             	add    $0x1,%eax
    1d1f:	84 d2                	test   %dl,%dl
    1d21:	74 0d                	je     1d30 <strchr+0x30>
    if(*s == c)
    1d23:	38 d1                	cmp    %dl,%cl
    1d25:	75 f1                	jne    1d18 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1d27:	5d                   	pop    %ebp
    1d28:	c3                   	ret    
    1d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    1d30:	31 c0                	xor    %eax,%eax
}
    1d32:	5d                   	pop    %ebp
    1d33:	c3                   	ret    
    1d34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1d3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1d3f:	90                   	nop

00001d40 <gets>:

char*
gets(char *buf, int max)
{
    1d40:	55                   	push   %ebp
    1d41:	89 e5                	mov    %esp,%ebp
    1d43:	57                   	push   %edi
    1d44:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1d45:	31 f6                	xor    %esi,%esi
{
    1d47:	53                   	push   %ebx
    1d48:	89 f3                	mov    %esi,%ebx
    1d4a:	83 ec 1c             	sub    $0x1c,%esp
    1d4d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1d50:	eb 2f                	jmp    1d81 <gets+0x41>
    1d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1d58:	83 ec 04             	sub    $0x4,%esp
    1d5b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1d5e:	6a 01                	push   $0x1
    1d60:	50                   	push   %eax
    1d61:	6a 00                	push   $0x0
    1d63:	e8 a9 01 00 00       	call   1f11 <read>
    if(cc < 1)
    1d68:	83 c4 10             	add    $0x10,%esp
    1d6b:	85 c0                	test   %eax,%eax
    1d6d:	7e 1c                	jle    1d8b <gets+0x4b>
      break;
    buf[i++] = c;
    1d6f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    1d73:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    1d76:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1d79:	3c 0a                	cmp    $0xa,%al
    1d7b:	74 23                	je     1da0 <gets+0x60>
    1d7d:	3c 0d                	cmp    $0xd,%al
    1d7f:	74 1f                	je     1da0 <gets+0x60>
  for(i=0; i+1 < max; ){
    1d81:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    1d84:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    1d86:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1d89:	7c cd                	jl     1d58 <gets+0x18>
    1d8b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    1d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1d90:	c6 03 00             	movb   $0x0,(%ebx)
}
    1d93:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d96:	5b                   	pop    %ebx
    1d97:	5e                   	pop    %esi
    1d98:	5f                   	pop    %edi
    1d99:	5d                   	pop    %ebp
    1d9a:	c3                   	ret    
    1d9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1d9f:	90                   	nop
  buf[i] = '\0';
    1da0:	8b 75 08             	mov    0x8(%ebp),%esi
}
    1da3:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1da6:	01 de                	add    %ebx,%esi
    1da8:	89 f3                	mov    %esi,%ebx
    1daa:	c6 03 00             	movb   $0x0,(%ebx)
}
    1dad:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1db0:	5b                   	pop    %ebx
    1db1:	5e                   	pop    %esi
    1db2:	5f                   	pop    %edi
    1db3:	5d                   	pop    %ebp
    1db4:	c3                   	ret    
    1db5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001dc0 <stat>:

int
stat(const char *n, struct stat *st)
{
    1dc0:	55                   	push   %ebp
    1dc1:	89 e5                	mov    %esp,%ebp
    1dc3:	56                   	push   %esi
    1dc4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1dc5:	83 ec 08             	sub    $0x8,%esp
    1dc8:	6a 00                	push   $0x0
    1dca:	ff 75 08             	pushl  0x8(%ebp)
    1dcd:	e8 67 01 00 00       	call   1f39 <open>
  if(fd < 0)
    1dd2:	83 c4 10             	add    $0x10,%esp
    1dd5:	85 c0                	test   %eax,%eax
    1dd7:	78 27                	js     1e00 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1dd9:	83 ec 08             	sub    $0x8,%esp
    1ddc:	ff 75 0c             	pushl  0xc(%ebp)
    1ddf:	89 c3                	mov    %eax,%ebx
    1de1:	50                   	push   %eax
    1de2:	e8 6a 01 00 00       	call   1f51 <fstat>
  close(fd);
    1de7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    1dea:	89 c6                	mov    %eax,%esi
  close(fd);
    1dec:	e8 30 01 00 00       	call   1f21 <close>
  return r;
    1df1:	83 c4 10             	add    $0x10,%esp
}
    1df4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1df7:	89 f0                	mov    %esi,%eax
    1df9:	5b                   	pop    %ebx
    1dfa:	5e                   	pop    %esi
    1dfb:	5d                   	pop    %ebp
    1dfc:	c3                   	ret    
    1dfd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1e00:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1e05:	eb ed                	jmp    1df4 <stat+0x34>
    1e07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1e0e:	66 90                	xchg   %ax,%ax

00001e10 <atoi>:

int
atoi(const char *s)
{
    1e10:	55                   	push   %ebp
    1e11:	89 e5                	mov    %esp,%ebp
    1e13:	53                   	push   %ebx
    1e14:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1e17:	0f be 02             	movsbl (%edx),%eax
    1e1a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    1e1d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1e20:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1e25:	77 1e                	ja     1e45 <atoi+0x35>
    1e27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1e2e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    1e30:	83 c2 01             	add    $0x1,%edx
    1e33:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1e36:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    1e3a:	0f be 02             	movsbl (%edx),%eax
    1e3d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1e40:	80 fb 09             	cmp    $0x9,%bl
    1e43:	76 eb                	jbe    1e30 <atoi+0x20>
  return n;
}
    1e45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1e48:	89 c8                	mov    %ecx,%eax
    1e4a:	c9                   	leave  
    1e4b:	c3                   	ret    
    1e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001e50 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1e50:	55                   	push   %ebp
    1e51:	89 e5                	mov    %esp,%ebp
    1e53:	57                   	push   %edi
    1e54:	8b 45 10             	mov    0x10(%ebp),%eax
    1e57:	8b 55 08             	mov    0x8(%ebp),%edx
    1e5a:	56                   	push   %esi
    1e5b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1e5e:	85 c0                	test   %eax,%eax
    1e60:	7e 13                	jle    1e75 <memmove+0x25>
    1e62:	01 d0                	add    %edx,%eax
  dst = vdst;
    1e64:	89 d7                	mov    %edx,%edi
    1e66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1e6d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    1e70:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    1e71:	39 f8                	cmp    %edi,%eax
    1e73:	75 fb                	jne    1e70 <memmove+0x20>
  return vdst;
}
    1e75:	5e                   	pop    %esi
    1e76:	89 d0                	mov    %edx,%eax
    1e78:	5f                   	pop    %edi
    1e79:	5d                   	pop    %ebp
    1e7a:	c3                   	ret    
    1e7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1e7f:	90                   	nop

00001e80 <thread_create>:


int thread_create(void (*start_routine)(void*, void*), void *arg1, void *arg2) {
    1e80:	55                   	push   %ebp
    1e81:	89 e5                	mov    %esp,%ebp
    1e83:	53                   	push   %ebx
    1e84:	83 ec 20             	sub    $0x20,%esp
  void *stack =  malloc(4096);
    1e87:	68 00 10 00 00       	push   $0x1000
    1e8c:	e8 5f 04 00 00       	call   22f0 <malloc>
  if(stack == 0)
    1e91:	83 c4 10             	add    $0x10,%esp
    1e94:	85 c0                	test   %eax,%eax
    1e96:	74 3f                	je     1ed7 <thread_create+0x57>
    return -1;
  int r= clone(start_routine, arg1, arg2, stack);
    1e98:	50                   	push   %eax
    1e99:	89 c3                	mov    %eax,%ebx
    1e9b:	ff 75 10             	pushl  0x10(%ebp)
    1e9e:	ff 75 0c             	pushl  0xc(%ebp)
    1ea1:	ff 75 08             	pushl  0x8(%ebp)
    1ea4:	e8 00 01 00 00       	call   1fa9 <clone>
  if(r==-1) 
    1ea9:	83 c4 10             	add    $0x10,%esp
    1eac:	83 f8 ff             	cmp    $0xffffffff,%eax
    1eaf:	74 0f                	je     1ec0 <thread_create+0x40>
    free(stack);
  return r;
}
    1eb1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1eb4:	c9                   	leave  
    1eb5:	c3                   	ret    
    1eb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1ebd:	8d 76 00             	lea    0x0(%esi),%esi
    free(stack);
    1ec0:	83 ec 0c             	sub    $0xc,%esp
    1ec3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1ec6:	53                   	push   %ebx
    1ec7:	e8 94 03 00 00       	call   2260 <free>
    1ecc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1ecf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    free(stack);
    1ed2:	83 c4 10             	add    $0x10,%esp
}
    1ed5:	c9                   	leave  
    1ed6:	c3                   	ret    
    return -1;
    1ed7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1edc:	eb d3                	jmp    1eb1 <thread_create+0x31>
    1ede:	66 90                	xchg   %ax,%ax

00001ee0 <thread_join>:


int thread_join(void) {
    1ee0:	55                   	push   %ebp
    1ee1:	89 e5                	mov    %esp,%ebp
    1ee3:	83 ec 24             	sub    $0x24,%esp
  void *stack;
  int r = join(&stack);
    1ee6:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1ee9:	50                   	push   %eax
    1eea:	e8 c2 00 00 00       	call   1fb1 <join>
  return r;
}
    1eef:	c9                   	leave  
    1ef0:	c3                   	ret    

00001ef1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1ef1:	b8 01 00 00 00       	mov    $0x1,%eax
    1ef6:	cd 40                	int    $0x40
    1ef8:	c3                   	ret    

00001ef9 <exit>:
SYSCALL(exit)
    1ef9:	b8 02 00 00 00       	mov    $0x2,%eax
    1efe:	cd 40                	int    $0x40
    1f00:	c3                   	ret    

00001f01 <wait>:
SYSCALL(wait)
    1f01:	b8 03 00 00 00       	mov    $0x3,%eax
    1f06:	cd 40                	int    $0x40
    1f08:	c3                   	ret    

00001f09 <pipe>:
SYSCALL(pipe)
    1f09:	b8 04 00 00 00       	mov    $0x4,%eax
    1f0e:	cd 40                	int    $0x40
    1f10:	c3                   	ret    

00001f11 <read>:
SYSCALL(read)
    1f11:	b8 05 00 00 00       	mov    $0x5,%eax
    1f16:	cd 40                	int    $0x40
    1f18:	c3                   	ret    

00001f19 <write>:
SYSCALL(write)
    1f19:	b8 10 00 00 00       	mov    $0x10,%eax
    1f1e:	cd 40                	int    $0x40
    1f20:	c3                   	ret    

00001f21 <close>:
SYSCALL(close)
    1f21:	b8 15 00 00 00       	mov    $0x15,%eax
    1f26:	cd 40                	int    $0x40
    1f28:	c3                   	ret    

00001f29 <kill>:
SYSCALL(kill)
    1f29:	b8 06 00 00 00       	mov    $0x6,%eax
    1f2e:	cd 40                	int    $0x40
    1f30:	c3                   	ret    

00001f31 <exec>:
SYSCALL(exec)
    1f31:	b8 07 00 00 00       	mov    $0x7,%eax
    1f36:	cd 40                	int    $0x40
    1f38:	c3                   	ret    

00001f39 <open>:
SYSCALL(open)
    1f39:	b8 0f 00 00 00       	mov    $0xf,%eax
    1f3e:	cd 40                	int    $0x40
    1f40:	c3                   	ret    

00001f41 <mknod>:
SYSCALL(mknod)
    1f41:	b8 11 00 00 00       	mov    $0x11,%eax
    1f46:	cd 40                	int    $0x40
    1f48:	c3                   	ret    

00001f49 <unlink>:
SYSCALL(unlink)
    1f49:	b8 12 00 00 00       	mov    $0x12,%eax
    1f4e:	cd 40                	int    $0x40
    1f50:	c3                   	ret    

00001f51 <fstat>:
SYSCALL(fstat)
    1f51:	b8 08 00 00 00       	mov    $0x8,%eax
    1f56:	cd 40                	int    $0x40
    1f58:	c3                   	ret    

00001f59 <link>:
SYSCALL(link)
    1f59:	b8 13 00 00 00       	mov    $0x13,%eax
    1f5e:	cd 40                	int    $0x40
    1f60:	c3                   	ret    

00001f61 <mkdir>:
SYSCALL(mkdir)
    1f61:	b8 14 00 00 00       	mov    $0x14,%eax
    1f66:	cd 40                	int    $0x40
    1f68:	c3                   	ret    

00001f69 <chdir>:
SYSCALL(chdir)
    1f69:	b8 09 00 00 00       	mov    $0x9,%eax
    1f6e:	cd 40                	int    $0x40
    1f70:	c3                   	ret    

00001f71 <dup>:
SYSCALL(dup)
    1f71:	b8 0a 00 00 00       	mov    $0xa,%eax
    1f76:	cd 40                	int    $0x40
    1f78:	c3                   	ret    

00001f79 <getpid>:
SYSCALL(getpid)
    1f79:	b8 0b 00 00 00       	mov    $0xb,%eax
    1f7e:	cd 40                	int    $0x40
    1f80:	c3                   	ret    

00001f81 <sbrk>:
SYSCALL(sbrk)
    1f81:	b8 0c 00 00 00       	mov    $0xc,%eax
    1f86:	cd 40                	int    $0x40
    1f88:	c3                   	ret    

00001f89 <sleep>:
SYSCALL(sleep)
    1f89:	b8 0d 00 00 00       	mov    $0xd,%eax
    1f8e:	cd 40                	int    $0x40
    1f90:	c3                   	ret    

00001f91 <uptime>:
SYSCALL(uptime)
    1f91:	b8 0e 00 00 00       	mov    $0xe,%eax
    1f96:	cd 40                	int    $0x40
    1f98:	c3                   	ret    

00001f99 <mprotect>:
SYSCALL(mprotect)
    1f99:	b8 16 00 00 00       	mov    $0x16,%eax
    1f9e:	cd 40                	int    $0x40
    1fa0:	c3                   	ret    

00001fa1 <munprotect>:
SYSCALL(munprotect)
    1fa1:	b8 17 00 00 00       	mov    $0x17,%eax
    1fa6:	cd 40                	int    $0x40
    1fa8:	c3                   	ret    

00001fa9 <clone>:
SYSCALL(clone)
    1fa9:	b8 18 00 00 00       	mov    $0x18,%eax
    1fae:	cd 40                	int    $0x40
    1fb0:	c3                   	ret    

00001fb1 <join>:
SYSCALL(join)
    1fb1:	b8 19 00 00 00       	mov    $0x19,%eax
    1fb6:	cd 40                	int    $0x40
    1fb8:	c3                   	ret    

00001fb9 <getNumProc>:
SYSCALL(getNumProc)
    1fb9:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1fbe:	cd 40                	int    $0x40
    1fc0:	c3                   	ret    

00001fc1 <getMaxPid>:
SYSCALL(getMaxPid)
    1fc1:	b8 1b 00 00 00       	mov    $0x1b,%eax
    1fc6:	cd 40                	int    $0x40
    1fc8:	c3                   	ret    

00001fc9 <getProcInfo>:
SYSCALL(getProcInfo)
    1fc9:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1fce:	cd 40                	int    $0x40
    1fd0:	c3                   	ret    
    1fd1:	66 90                	xchg   %ax,%ax
    1fd3:	66 90                	xchg   %ax,%ax
    1fd5:	66 90                	xchg   %ax,%ax
    1fd7:	66 90                	xchg   %ax,%ax
    1fd9:	66 90                	xchg   %ax,%ax
    1fdb:	66 90                	xchg   %ax,%ax
    1fdd:	66 90                	xchg   %ax,%ax
    1fdf:	90                   	nop

00001fe0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1fe0:	55                   	push   %ebp
    1fe1:	89 e5                	mov    %esp,%ebp
    1fe3:	57                   	push   %edi
    1fe4:	56                   	push   %esi
    1fe5:	53                   	push   %ebx
    1fe6:	83 ec 3c             	sub    $0x3c,%esp
    1fe9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    1fec:	89 d1                	mov    %edx,%ecx
{
    1fee:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    1ff1:	85 d2                	test   %edx,%edx
    1ff3:	0f 89 7f 00 00 00    	jns    2078 <printint+0x98>
    1ff9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    1ffd:	74 79                	je     2078 <printint+0x98>
    neg = 1;
    1fff:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    2006:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    2008:	31 db                	xor    %ebx,%ebx
    200a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    200d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    2010:	89 c8                	mov    %ecx,%eax
    2012:	31 d2                	xor    %edx,%edx
    2014:	89 cf                	mov    %ecx,%edi
    2016:	f7 75 c4             	divl   -0x3c(%ebp)
    2019:	0f b6 92 e8 24 00 00 	movzbl 0x24e8(%edx),%edx
    2020:	89 45 c0             	mov    %eax,-0x40(%ebp)
    2023:	89 d8                	mov    %ebx,%eax
    2025:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    2028:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    202b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    202e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    2031:	76 dd                	jbe    2010 <printint+0x30>
  if(neg)
    2033:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    2036:	85 c9                	test   %ecx,%ecx
    2038:	74 0c                	je     2046 <printint+0x66>
    buf[i++] = '-';
    203a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    203f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    2041:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    2046:	8b 7d b8             	mov    -0x48(%ebp),%edi
    2049:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    204d:	eb 07                	jmp    2056 <printint+0x76>
    204f:	90                   	nop
    putc(fd, buf[i]);
    2050:	0f b6 13             	movzbl (%ebx),%edx
    2053:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    2056:	83 ec 04             	sub    $0x4,%esp
    2059:	88 55 d7             	mov    %dl,-0x29(%ebp)
    205c:	6a 01                	push   $0x1
    205e:	56                   	push   %esi
    205f:	57                   	push   %edi
    2060:	e8 b4 fe ff ff       	call   1f19 <write>
  while(--i >= 0)
    2065:	83 c4 10             	add    $0x10,%esp
    2068:	39 de                	cmp    %ebx,%esi
    206a:	75 e4                	jne    2050 <printint+0x70>
}
    206c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    206f:	5b                   	pop    %ebx
    2070:	5e                   	pop    %esi
    2071:	5f                   	pop    %edi
    2072:	5d                   	pop    %ebp
    2073:	c3                   	ret    
    2074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    2078:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    207f:	eb 87                	jmp    2008 <printint+0x28>
    2081:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2088:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    208f:	90                   	nop

00002090 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    2090:	55                   	push   %ebp
    2091:	89 e5                	mov    %esp,%ebp
    2093:	57                   	push   %edi
    2094:	56                   	push   %esi
    2095:	53                   	push   %ebx
    2096:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2099:	8b 75 0c             	mov    0xc(%ebp),%esi
    209c:	0f b6 1e             	movzbl (%esi),%ebx
    209f:	84 db                	test   %bl,%bl
    20a1:	0f 84 b8 00 00 00    	je     215f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    20a7:	8d 45 10             	lea    0x10(%ebp),%eax
    20aa:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    20ad:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    20b0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    20b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    20b5:	eb 37                	jmp    20ee <printf+0x5e>
    20b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    20be:	66 90                	xchg   %ax,%ax
    20c0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    20c3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    20c8:	83 f8 25             	cmp    $0x25,%eax
    20cb:	74 17                	je     20e4 <printf+0x54>
  write(fd, &c, 1);
    20cd:	83 ec 04             	sub    $0x4,%esp
    20d0:	88 5d e7             	mov    %bl,-0x19(%ebp)
    20d3:	6a 01                	push   $0x1
    20d5:	57                   	push   %edi
    20d6:	ff 75 08             	pushl  0x8(%ebp)
    20d9:	e8 3b fe ff ff       	call   1f19 <write>
    20de:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    20e1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    20e4:	0f b6 1e             	movzbl (%esi),%ebx
    20e7:	83 c6 01             	add    $0x1,%esi
    20ea:	84 db                	test   %bl,%bl
    20ec:	74 71                	je     215f <printf+0xcf>
    c = fmt[i] & 0xff;
    20ee:	0f be cb             	movsbl %bl,%ecx
    20f1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    20f4:	85 d2                	test   %edx,%edx
    20f6:	74 c8                	je     20c0 <printf+0x30>
      }
    } else if(state == '%'){
    20f8:	83 fa 25             	cmp    $0x25,%edx
    20fb:	75 e7                	jne    20e4 <printf+0x54>
      if(c == 'd'){
    20fd:	83 f8 64             	cmp    $0x64,%eax
    2100:	0f 84 9a 00 00 00    	je     21a0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    2106:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    210c:	83 f9 70             	cmp    $0x70,%ecx
    210f:	74 5f                	je     2170 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    2111:	83 f8 73             	cmp    $0x73,%eax
    2114:	0f 84 d6 00 00 00    	je     21f0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    211a:	83 f8 63             	cmp    $0x63,%eax
    211d:	0f 84 8d 00 00 00    	je     21b0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    2123:	83 f8 25             	cmp    $0x25,%eax
    2126:	0f 84 b4 00 00 00    	je     21e0 <printf+0x150>
  write(fd, &c, 1);
    212c:	83 ec 04             	sub    $0x4,%esp
    212f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    2133:	6a 01                	push   $0x1
    2135:	57                   	push   %edi
    2136:	ff 75 08             	pushl  0x8(%ebp)
    2139:	e8 db fd ff ff       	call   1f19 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    213e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    2141:	83 c4 0c             	add    $0xc,%esp
    2144:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    2146:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    2149:	57                   	push   %edi
    214a:	ff 75 08             	pushl  0x8(%ebp)
    214d:	e8 c7 fd ff ff       	call   1f19 <write>
  for(i = 0; fmt[i]; i++){
    2152:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    2156:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    2159:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    215b:	84 db                	test   %bl,%bl
    215d:	75 8f                	jne    20ee <printf+0x5e>
    }
  }
}
    215f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2162:	5b                   	pop    %ebx
    2163:	5e                   	pop    %esi
    2164:	5f                   	pop    %edi
    2165:	5d                   	pop    %ebp
    2166:	c3                   	ret    
    2167:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    216e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    2170:	83 ec 0c             	sub    $0xc,%esp
    2173:	b9 10 00 00 00       	mov    $0x10,%ecx
    2178:	6a 00                	push   $0x0
    217a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    217d:	8b 45 08             	mov    0x8(%ebp),%eax
    2180:	8b 13                	mov    (%ebx),%edx
    2182:	e8 59 fe ff ff       	call   1fe0 <printint>
        ap++;
    2187:	89 d8                	mov    %ebx,%eax
    2189:	83 c4 10             	add    $0x10,%esp
      state = 0;
    218c:	31 d2                	xor    %edx,%edx
        ap++;
    218e:	83 c0 04             	add    $0x4,%eax
    2191:	89 45 d0             	mov    %eax,-0x30(%ebp)
    2194:	e9 4b ff ff ff       	jmp    20e4 <printf+0x54>
    2199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    21a0:	83 ec 0c             	sub    $0xc,%esp
    21a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    21a8:	6a 01                	push   $0x1
    21aa:	eb ce                	jmp    217a <printf+0xea>
    21ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    21b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    21b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    21b6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    21b8:	6a 01                	push   $0x1
        ap++;
    21ba:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    21bd:	57                   	push   %edi
    21be:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    21c1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    21c4:	e8 50 fd ff ff       	call   1f19 <write>
        ap++;
    21c9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    21cc:	83 c4 10             	add    $0x10,%esp
      state = 0;
    21cf:	31 d2                	xor    %edx,%edx
    21d1:	e9 0e ff ff ff       	jmp    20e4 <printf+0x54>
    21d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    21dd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    21e0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    21e3:	83 ec 04             	sub    $0x4,%esp
    21e6:	e9 59 ff ff ff       	jmp    2144 <printf+0xb4>
    21eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    21ef:	90                   	nop
        s = (char*)*ap;
    21f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    21f3:	8b 18                	mov    (%eax),%ebx
        ap++;
    21f5:	83 c0 04             	add    $0x4,%eax
    21f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    21fb:	85 db                	test   %ebx,%ebx
    21fd:	74 17                	je     2216 <printf+0x186>
        while(*s != 0){
    21ff:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    2202:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    2204:	84 c0                	test   %al,%al
    2206:	0f 84 d8 fe ff ff    	je     20e4 <printf+0x54>
    220c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    220f:	89 de                	mov    %ebx,%esi
    2211:	8b 5d 08             	mov    0x8(%ebp),%ebx
    2214:	eb 1a                	jmp    2230 <printf+0x1a0>
          s = "(null)";
    2216:	bb e0 24 00 00       	mov    $0x24e0,%ebx
        while(*s != 0){
    221b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    221e:	b8 28 00 00 00       	mov    $0x28,%eax
    2223:	89 de                	mov    %ebx,%esi
    2225:	8b 5d 08             	mov    0x8(%ebp),%ebx
    2228:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    222f:	90                   	nop
  write(fd, &c, 1);
    2230:	83 ec 04             	sub    $0x4,%esp
          s++;
    2233:	83 c6 01             	add    $0x1,%esi
    2236:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    2239:	6a 01                	push   $0x1
    223b:	57                   	push   %edi
    223c:	53                   	push   %ebx
    223d:	e8 d7 fc ff ff       	call   1f19 <write>
        while(*s != 0){
    2242:	0f b6 06             	movzbl (%esi),%eax
    2245:	83 c4 10             	add    $0x10,%esp
    2248:	84 c0                	test   %al,%al
    224a:	75 e4                	jne    2230 <printf+0x1a0>
      state = 0;
    224c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    224f:	31 d2                	xor    %edx,%edx
    2251:	e9 8e fe ff ff       	jmp    20e4 <printf+0x54>
    2256:	66 90                	xchg   %ax,%ax
    2258:	66 90                	xchg   %ax,%ax
    225a:	66 90                	xchg   %ax,%ax
    225c:	66 90                	xchg   %ax,%ax
    225e:	66 90                	xchg   %ax,%ax

00002260 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    2260:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2261:	a1 a4 2b 00 00       	mov    0x2ba4,%eax
{
    2266:	89 e5                	mov    %esp,%ebp
    2268:	57                   	push   %edi
    2269:	56                   	push   %esi
    226a:	53                   	push   %ebx
    226b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    226e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2278:	89 c2                	mov    %eax,%edx
    227a:	8b 00                	mov    (%eax),%eax
    227c:	39 ca                	cmp    %ecx,%edx
    227e:	73 30                	jae    22b0 <free+0x50>
    2280:	39 c1                	cmp    %eax,%ecx
    2282:	72 04                	jb     2288 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    2284:	39 c2                	cmp    %eax,%edx
    2286:	72 f0                	jb     2278 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    2288:	8b 73 fc             	mov    -0x4(%ebx),%esi
    228b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    228e:	39 f8                	cmp    %edi,%eax
    2290:	74 30                	je     22c2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    2292:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    2295:	8b 42 04             	mov    0x4(%edx),%eax
    2298:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    229b:	39 f1                	cmp    %esi,%ecx
    229d:	74 3a                	je     22d9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    229f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    22a1:	5b                   	pop    %ebx
  freep = p;
    22a2:	89 15 a4 2b 00 00    	mov    %edx,0x2ba4
}
    22a8:	5e                   	pop    %esi
    22a9:	5f                   	pop    %edi
    22aa:	5d                   	pop    %ebp
    22ab:	c3                   	ret    
    22ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    22b0:	39 c2                	cmp    %eax,%edx
    22b2:	72 c4                	jb     2278 <free+0x18>
    22b4:	39 c1                	cmp    %eax,%ecx
    22b6:	73 c0                	jae    2278 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    22b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    22bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    22be:	39 f8                	cmp    %edi,%eax
    22c0:	75 d0                	jne    2292 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    22c2:	03 70 04             	add    0x4(%eax),%esi
    22c5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    22c8:	8b 02                	mov    (%edx),%eax
    22ca:	8b 00                	mov    (%eax),%eax
    22cc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    22cf:	8b 42 04             	mov    0x4(%edx),%eax
    22d2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    22d5:	39 f1                	cmp    %esi,%ecx
    22d7:	75 c6                	jne    229f <free+0x3f>
    p->s.size += bp->s.size;
    22d9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    22dc:	89 15 a4 2b 00 00    	mov    %edx,0x2ba4
    p->s.size += bp->s.size;
    22e2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    22e5:	8b 43 f8             	mov    -0x8(%ebx),%eax
    22e8:	89 02                	mov    %eax,(%edx)
}
    22ea:	5b                   	pop    %ebx
    22eb:	5e                   	pop    %esi
    22ec:	5f                   	pop    %edi
    22ed:	5d                   	pop    %ebp
    22ee:	c3                   	ret    
    22ef:	90                   	nop

000022f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    22f0:	55                   	push   %ebp
    22f1:	89 e5                	mov    %esp,%ebp
    22f3:	57                   	push   %edi
    22f4:	56                   	push   %esi
    22f5:	53                   	push   %ebx
    22f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    22f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    22fc:	8b 3d a4 2b 00 00    	mov    0x2ba4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2302:	8d 70 07             	lea    0x7(%eax),%esi
    2305:	c1 ee 03             	shr    $0x3,%esi
    2308:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    230b:	85 ff                	test   %edi,%edi
    230d:	0f 84 ad 00 00 00    	je     23c0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2313:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    2315:	8b 48 04             	mov    0x4(%eax),%ecx
    2318:	39 f1                	cmp    %esi,%ecx
    231a:	73 71                	jae    238d <malloc+0x9d>
    231c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    2322:	bb 00 10 00 00       	mov    $0x1000,%ebx
    2327:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    232a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    2331:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    2334:	eb 1b                	jmp    2351 <malloc+0x61>
    2336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    233d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2340:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    2342:	8b 4a 04             	mov    0x4(%edx),%ecx
    2345:	39 f1                	cmp    %esi,%ecx
    2347:	73 4f                	jae    2398 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    2349:	8b 3d a4 2b 00 00    	mov    0x2ba4,%edi
    234f:	89 d0                	mov    %edx,%eax
    2351:	39 c7                	cmp    %eax,%edi
    2353:	75 eb                	jne    2340 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    2355:	83 ec 0c             	sub    $0xc,%esp
    2358:	ff 75 e4             	pushl  -0x1c(%ebp)
    235b:	e8 21 fc ff ff       	call   1f81 <sbrk>
  if(p == (char*)-1)
    2360:	83 c4 10             	add    $0x10,%esp
    2363:	83 f8 ff             	cmp    $0xffffffff,%eax
    2366:	74 1b                	je     2383 <malloc+0x93>
  hp->s.size = nu;
    2368:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    236b:	83 ec 0c             	sub    $0xc,%esp
    236e:	83 c0 08             	add    $0x8,%eax
    2371:	50                   	push   %eax
    2372:	e8 e9 fe ff ff       	call   2260 <free>
  return freep;
    2377:	a1 a4 2b 00 00       	mov    0x2ba4,%eax
      if((p = morecore(nunits)) == 0)
    237c:	83 c4 10             	add    $0x10,%esp
    237f:	85 c0                	test   %eax,%eax
    2381:	75 bd                	jne    2340 <malloc+0x50>
        return 0;
  }
}
    2383:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    2386:	31 c0                	xor    %eax,%eax
}
    2388:	5b                   	pop    %ebx
    2389:	5e                   	pop    %esi
    238a:	5f                   	pop    %edi
    238b:	5d                   	pop    %ebp
    238c:	c3                   	ret    
    if(p->s.size >= nunits){
    238d:	89 c2                	mov    %eax,%edx
    238f:	89 f8                	mov    %edi,%eax
    2391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    2398:	39 ce                	cmp    %ecx,%esi
    239a:	74 54                	je     23f0 <malloc+0x100>
        p->s.size -= nunits;
    239c:	29 f1                	sub    %esi,%ecx
    239e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    23a1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    23a4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    23a7:	a3 a4 2b 00 00       	mov    %eax,0x2ba4
}
    23ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    23af:	8d 42 08             	lea    0x8(%edx),%eax
}
    23b2:	5b                   	pop    %ebx
    23b3:	5e                   	pop    %esi
    23b4:	5f                   	pop    %edi
    23b5:	5d                   	pop    %ebp
    23b6:	c3                   	ret    
    23b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    23be:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    23c0:	c7 05 a4 2b 00 00 a8 	movl   $0x2ba8,0x2ba4
    23c7:	2b 00 00 
    base.s.size = 0;
    23ca:	bf a8 2b 00 00       	mov    $0x2ba8,%edi
    base.s.ptr = freep = prevp = &base;
    23cf:	c7 05 a8 2b 00 00 a8 	movl   $0x2ba8,0x2ba8
    23d6:	2b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    23d9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    23db:	c7 05 ac 2b 00 00 00 	movl   $0x0,0x2bac
    23e2:	00 00 00 
    if(p->s.size >= nunits){
    23e5:	e9 32 ff ff ff       	jmp    231c <malloc+0x2c>
    23ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    23f0:	8b 0a                	mov    (%edx),%ecx
    23f2:	89 08                	mov    %ecx,(%eax)
    23f4:	eb b1                	jmp    23a7 <malloc+0xb7>
