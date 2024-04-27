
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 65 11 80       	mov    $0x801165d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 80 31 10 80       	mov    $0x80103180,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 00 78 10 80       	push   $0x80107800
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 05 47 00 00       	call   80104760 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 78 10 80       	push   $0x80107807
80100097:	50                   	push   %eax
80100098:	e8 93 45 00 00       	call   80104630 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 47 48 00 00       	call   80104930 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 69 47 00 00       	call   801048d0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 44 00 00       	call   80104670 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 6f 22 00 00       	call   80102400 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 0e 78 10 80       	push   $0x8010780e
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 4d 45 00 00       	call   80104710 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 27 22 00 00       	jmp    80102400 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 1f 78 10 80       	push   $0x8010781f
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 0c 45 00 00       	call   80104710 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 bc 44 00 00       	call   801046d0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 10 47 00 00       	call   80104930 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 5f 46 00 00       	jmp    801048d0 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 26 78 10 80       	push   $0x80107826
80100279:	e8 02 01 00 00       	call   80100380 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	pushl  0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 e7 16 00 00       	call   80101980 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002a0:	e8 8b 46 00 00       	call   80104930 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 ff 10 80       	push   $0x8010ff20
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 ae 3e 00 00       	call   80104180 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 b9 37 00 00       	call   80103aa0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ff 10 80       	push   $0x8010ff20
801002f6:	e8 d5 45 00 00       	call   801048d0 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	pushl  0x8(%ebp)
801002ff:	e8 9c 15 00 00       	call   801018a0 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret    
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 ff 10 80       	push   $0x8010ff20
8010034c:	e8 7f 45 00 00       	call   801048d0 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	pushl  0x8(%ebp)
80100355:	e8 46 15 00 00       	call   801018a0 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret    
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  cons.locking = 0;
80100389:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 72 26 00 00       	call   80102a10 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 2d 78 10 80       	push   $0x8010782d
801003a7:	e8 d4 02 00 00       	call   80100680 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	pushl  0x8(%ebp)
801003b0:	e8 cb 02 00 00       	call   80100680 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 67 81 10 80 	movl   $0x80108167,(%esp)
801003bc:	e8 bf 02 00 00       	call   80100680 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 b3 43 00 00       	call   80104780 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	pushl  (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 41 78 10 80       	push   $0x80107841
801003dd:	e8 9e 02 00 00       	call   80100680 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <cgaputc>:
{
80100400:	55                   	push   %ebp
80100401:	89 c1                	mov    %eax,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100403:	b8 0e 00 00 00       	mov    $0xe,%eax
80100408:	89 e5                	mov    %esp,%ebp
8010040a:	57                   	push   %edi
8010040b:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100410:	56                   	push   %esi
80100411:	89 fa                	mov    %edi,%edx
80100413:	53                   	push   %ebx
80100414:	83 ec 1c             	sub    $0x1c,%esp
80100417:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100418:	be d5 03 00 00       	mov    $0x3d5,%esi
8010041d:	89 f2                	mov    %esi,%edx
8010041f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100420:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100423:	89 fa                	mov    %edi,%edx
80100425:	c1 e0 08             	shl    $0x8,%eax
80100428:	89 c3                	mov    %eax,%ebx
8010042a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010042f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100430:	89 f2                	mov    %esi,%edx
80100432:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100433:	0f b6 c0             	movzbl %al,%eax
80100436:	09 d8                	or     %ebx,%eax
  if(c == '\n')
80100438:	83 f9 0a             	cmp    $0xa,%ecx
8010043b:	0f 84 97 00 00 00    	je     801004d8 <cgaputc+0xd8>
  else if(c == BACKSPACE){
80100441:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
80100447:	74 77                	je     801004c0 <cgaputc+0xc0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100449:	0f b6 c9             	movzbl %cl,%ecx
8010044c:	8d 58 01             	lea    0x1(%eax),%ebx
8010044f:	80 cd 07             	or     $0x7,%ch
80100452:	66 89 8c 00 00 80 0b 	mov    %cx,-0x7ff48000(%eax,%eax,1)
80100459:	80 
  if(pos < 0 || pos > 25*80)
8010045a:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
80100460:	0f 8f cc 00 00 00    	jg     80100532 <cgaputc+0x132>
  if((pos/80) >= 24){  // Scroll up.
80100466:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
8010046c:	0f 8f 7e 00 00 00    	jg     801004f0 <cgaputc+0xf0>
  outb(CRTPORT+1, pos>>8);
80100472:	0f b6 c7             	movzbl %bh,%eax
  outb(CRTPORT+1, pos);
80100475:	89 df                	mov    %ebx,%edi
  crt[pos] = ' ' | 0x0700;
80100477:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
  outb(CRTPORT+1, pos>>8);
8010047e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100481:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100486:	b8 0e 00 00 00       	mov    $0xe,%eax
8010048b:	89 da                	mov    %ebx,%edx
8010048d:	ee                   	out    %al,(%dx)
8010048e:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100493:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
80100497:	89 ca                	mov    %ecx,%edx
80100499:	ee                   	out    %al,(%dx)
8010049a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010049f:	89 da                	mov    %ebx,%edx
801004a1:	ee                   	out    %al,(%dx)
801004a2:	89 f8                	mov    %edi,%eax
801004a4:	89 ca                	mov    %ecx,%edx
801004a6:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004a7:	b8 20 07 00 00       	mov    $0x720,%eax
801004ac:	66 89 06             	mov    %ax,(%esi)
}
801004af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004b2:	5b                   	pop    %ebx
801004b3:	5e                   	pop    %esi
801004b4:	5f                   	pop    %edi
801004b5:	5d                   	pop    %ebp
801004b6:	c3                   	ret    
801004b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801004be:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
801004c0:	8d 58 ff             	lea    -0x1(%eax),%ebx
801004c3:	85 c0                	test   %eax,%eax
801004c5:	75 93                	jne    8010045a <cgaputc+0x5a>
801004c7:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
801004cb:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004d0:	31 ff                	xor    %edi,%edi
801004d2:	eb ad                	jmp    80100481 <cgaputc+0x81>
801004d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004d8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004dd:	f7 e2                	mul    %edx
801004df:	c1 ea 06             	shr    $0x6,%edx
801004e2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004e5:	c1 e0 04             	shl    $0x4,%eax
801004e8:	8d 58 50             	lea    0x50(%eax),%ebx
801004eb:	e9 6a ff ff ff       	jmp    8010045a <cgaputc+0x5a>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f0:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004f3:	8d 7b b0             	lea    -0x50(%ebx),%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004f6:	8d b4 1b 60 7f 0b 80 	lea    -0x7ff480a0(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fd:	68 60 0e 00 00       	push   $0xe60
80100502:	68 a0 80 0b 80       	push   $0x800b80a0
80100507:	68 00 80 0b 80       	push   $0x800b8000
8010050c:	e8 7f 45 00 00       	call   80104a90 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100511:	b8 80 07 00 00       	mov    $0x780,%eax
80100516:	83 c4 0c             	add    $0xc,%esp
80100519:	29 f8                	sub    %edi,%eax
8010051b:	01 c0                	add    %eax,%eax
8010051d:	50                   	push   %eax
8010051e:	6a 00                	push   $0x0
80100520:	56                   	push   %esi
80100521:	e8 ca 44 00 00       	call   801049f0 <memset>
  outb(CRTPORT+1, pos);
80100526:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010052a:	83 c4 10             	add    $0x10,%esp
8010052d:	e9 4f ff ff ff       	jmp    80100481 <cgaputc+0x81>
    panic("pos under/overflow");
80100532:	83 ec 0c             	sub    $0xc,%esp
80100535:	68 45 78 10 80       	push   $0x80107845
8010053a:	e8 41 fe ff ff       	call   80100380 <panic>
8010053f:	90                   	nop

80100540 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100540:	55                   	push   %ebp
80100541:	89 e5                	mov    %esp,%ebp
80100543:	57                   	push   %edi
80100544:	56                   	push   %esi
80100545:	53                   	push   %ebx
80100546:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100549:	ff 75 08             	pushl  0x8(%ebp)
{
8010054c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010054f:	e8 2c 14 00 00       	call   80101980 <iunlock>
  acquire(&cons.lock);
80100554:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
8010055b:	e8 d0 43 00 00       	call   80104930 <acquire>
  for(i = 0; i < n; i++)
80100560:	83 c4 10             	add    $0x10,%esp
80100563:	85 f6                	test   %esi,%esi
80100565:	7e 3a                	jle    801005a1 <consolewrite+0x61>
80100567:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010056a:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
8010056d:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100573:	85 d2                	test   %edx,%edx
80100575:	74 09                	je     80100580 <consolewrite+0x40>
  asm volatile("cli");
80100577:	fa                   	cli    
    for(;;)
80100578:	eb fe                	jmp    80100578 <consolewrite+0x38>
8010057a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100580:	0f b6 03             	movzbl (%ebx),%eax
    uartputc(c);
80100583:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < n; i++)
80100586:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100589:	50                   	push   %eax
8010058a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010058d:	e8 2e 5c 00 00       	call   801061c0 <uartputc>
  cgaputc(c);
80100592:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100595:	e8 66 fe ff ff       	call   80100400 <cgaputc>
  for(i = 0; i < n; i++)
8010059a:	83 c4 10             	add    $0x10,%esp
8010059d:	39 df                	cmp    %ebx,%edi
8010059f:	75 cc                	jne    8010056d <consolewrite+0x2d>
  release(&cons.lock);
801005a1:	83 ec 0c             	sub    $0xc,%esp
801005a4:	68 20 ff 10 80       	push   $0x8010ff20
801005a9:	e8 22 43 00 00       	call   801048d0 <release>
  ilock(ip);
801005ae:	58                   	pop    %eax
801005af:	ff 75 08             	pushl  0x8(%ebp)
801005b2:	e8 e9 12 00 00       	call   801018a0 <ilock>

  return n;
}
801005b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005ba:	89 f0                	mov    %esi,%eax
801005bc:	5b                   	pop    %ebx
801005bd:	5e                   	pop    %esi
801005be:	5f                   	pop    %edi
801005bf:	5d                   	pop    %ebp
801005c0:	c3                   	ret    
801005c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801005c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801005cf:	90                   	nop

801005d0 <printint>:
{
801005d0:	55                   	push   %ebp
801005d1:	89 e5                	mov    %esp,%ebp
801005d3:	57                   	push   %edi
801005d4:	56                   	push   %esi
801005d5:	53                   	push   %ebx
801005d6:	83 ec 2c             	sub    $0x2c,%esp
801005d9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801005dc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
801005df:	85 c9                	test   %ecx,%ecx
801005e1:	74 04                	je     801005e7 <printint+0x17>
801005e3:	85 c0                	test   %eax,%eax
801005e5:	78 7e                	js     80100665 <printint+0x95>
    x = xx;
801005e7:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
801005ee:	89 c1                	mov    %eax,%ecx
  i = 0;
801005f0:	31 db                	xor    %ebx,%ebx
801005f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
801005f8:	89 c8                	mov    %ecx,%eax
801005fa:	31 d2                	xor    %edx,%edx
801005fc:	89 de                	mov    %ebx,%esi
801005fe:	89 cf                	mov    %ecx,%edi
80100600:	f7 75 d4             	divl   -0x2c(%ebp)
80100603:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100606:	0f b6 92 70 78 10 80 	movzbl -0x7fef8790(%edx),%edx
  }while((x /= base) != 0);
8010060d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010060f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100613:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100616:	73 e0                	jae    801005f8 <printint+0x28>
  if(sign)
80100618:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010061b:	85 c9                	test   %ecx,%ecx
8010061d:	74 0c                	je     8010062b <printint+0x5b>
    buf[i++] = '-';
8010061f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100624:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100626:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010062b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
  if(panicked){
8010062f:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100634:	85 c0                	test   %eax,%eax
80100636:	74 08                	je     80100640 <printint+0x70>
80100638:	fa                   	cli    
    for(;;)
80100639:	eb fe                	jmp    80100639 <printint+0x69>
8010063b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010063f:	90                   	nop
    consputc(buf[i]);
80100640:	0f be f2             	movsbl %dl,%esi
    uartputc(c);
80100643:	83 ec 0c             	sub    $0xc,%esp
80100646:	56                   	push   %esi
80100647:	e8 74 5b 00 00       	call   801061c0 <uartputc>
  cgaputc(c);
8010064c:	89 f0                	mov    %esi,%eax
8010064e:	e8 ad fd ff ff       	call   80100400 <cgaputc>
  while(--i >= 0)
80100653:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100656:	83 c4 10             	add    $0x10,%esp
80100659:	39 c3                	cmp    %eax,%ebx
8010065b:	74 0e                	je     8010066b <printint+0x9b>
    consputc(buf[i]);
8010065d:	0f b6 13             	movzbl (%ebx),%edx
80100660:	83 eb 01             	sub    $0x1,%ebx
80100663:	eb ca                	jmp    8010062f <printint+0x5f>
    x = -xx;
80100665:	f7 d8                	neg    %eax
80100667:	89 c1                	mov    %eax,%ecx
80100669:	eb 85                	jmp    801005f0 <printint+0x20>
}
8010066b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010066e:	5b                   	pop    %ebx
8010066f:	5e                   	pop    %esi
80100670:	5f                   	pop    %edi
80100671:	5d                   	pop    %ebp
80100672:	c3                   	ret    
80100673:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010067a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100680 <cprintf>:
{
80100680:	55                   	push   %ebp
80100681:	89 e5                	mov    %esp,%ebp
80100683:	57                   	push   %edi
80100684:	56                   	push   %esi
80100685:	53                   	push   %ebx
80100686:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100689:	a1 54 ff 10 80       	mov    0x8010ff54,%eax
8010068e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
80100691:	85 c0                	test   %eax,%eax
80100693:	0f 85 37 01 00 00    	jne    801007d0 <cprintf+0x150>
  if (fmt == 0)
80100699:	8b 75 08             	mov    0x8(%ebp),%esi
8010069c:	85 f6                	test   %esi,%esi
8010069e:	0f 84 3f 02 00 00    	je     801008e3 <cprintf+0x263>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006a4:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
801006a7:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006aa:	31 db                	xor    %ebx,%ebx
801006ac:	85 c0                	test   %eax,%eax
801006ae:	74 56                	je     80100706 <cprintf+0x86>
    if(c != '%'){
801006b0:	83 f8 25             	cmp    $0x25,%eax
801006b3:	0f 85 d7 00 00 00    	jne    80100790 <cprintf+0x110>
    c = fmt[++i] & 0xff;
801006b9:	83 c3 01             	add    $0x1,%ebx
801006bc:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
801006c0:	85 d2                	test   %edx,%edx
801006c2:	74 42                	je     80100706 <cprintf+0x86>
    switch(c){
801006c4:	83 fa 70             	cmp    $0x70,%edx
801006c7:	0f 84 94 00 00 00    	je     80100761 <cprintf+0xe1>
801006cd:	7f 51                	jg     80100720 <cprintf+0xa0>
801006cf:	83 fa 25             	cmp    $0x25,%edx
801006d2:	0f 84 48 01 00 00    	je     80100820 <cprintf+0x1a0>
801006d8:	83 fa 64             	cmp    $0x64,%edx
801006db:	0f 85 04 01 00 00    	jne    801007e5 <cprintf+0x165>
      printint(*argp++, 10, 1);
801006e1:	8d 47 04             	lea    0x4(%edi),%eax
801006e4:	b9 01 00 00 00       	mov    $0x1,%ecx
801006e9:	ba 0a 00 00 00       	mov    $0xa,%edx
801006ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
801006f1:	8b 07                	mov    (%edi),%eax
801006f3:	e8 d8 fe ff ff       	call   801005d0 <printint>
801006f8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fb:	83 c3 01             	add    $0x1,%ebx
801006fe:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100702:	85 c0                	test   %eax,%eax
80100704:	75 aa                	jne    801006b0 <cprintf+0x30>
  if(locking)
80100706:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100709:	85 c0                	test   %eax,%eax
8010070b:	0f 85 b5 01 00 00    	jne    801008c6 <cprintf+0x246>
}
80100711:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100714:	5b                   	pop    %ebx
80100715:	5e                   	pop    %esi
80100716:	5f                   	pop    %edi
80100717:	5d                   	pop    %ebp
80100718:	c3                   	ret    
80100719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	75 33                	jne    80100758 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100725:	8d 47 04             	lea    0x4(%edi),%eax
80100728:	8b 3f                	mov    (%edi),%edi
8010072a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010072d:	85 ff                	test   %edi,%edi
8010072f:	0f 85 33 01 00 00    	jne    80100868 <cprintf+0x1e8>
        s = "(null)";
80100735:	bf 58 78 10 80       	mov    $0x80107858,%edi
      for(; *s; s++)
8010073a:	89 5d dc             	mov    %ebx,-0x24(%ebp)
8010073d:	b8 28 00 00 00       	mov    $0x28,%eax
80100742:	89 fb                	mov    %edi,%ebx
  if(panicked){
80100744:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
8010074a:	85 d2                	test   %edx,%edx
8010074c:	0f 84 27 01 00 00    	je     80100879 <cprintf+0x1f9>
80100752:	fa                   	cli    
    for(;;)
80100753:	eb fe                	jmp    80100753 <cprintf+0xd3>
80100755:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100758:	83 fa 78             	cmp    $0x78,%edx
8010075b:	0f 85 84 00 00 00    	jne    801007e5 <cprintf+0x165>
      printint(*argp++, 16, 0);
80100761:	8d 47 04             	lea    0x4(%edi),%eax
80100764:	31 c9                	xor    %ecx,%ecx
80100766:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010076b:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
8010076e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100771:	8b 07                	mov    (%edi),%eax
80100773:	e8 58 fe ff ff       	call   801005d0 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100778:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
8010077c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010077f:	85 c0                	test   %eax,%eax
80100781:	0f 85 29 ff ff ff    	jne    801006b0 <cprintf+0x30>
80100787:	e9 7a ff ff ff       	jmp    80100706 <cprintf+0x86>
8010078c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
80100790:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100796:	85 c9                	test   %ecx,%ecx
80100798:	74 06                	je     801007a0 <cprintf+0x120>
8010079a:	fa                   	cli    
    for(;;)
8010079b:	eb fe                	jmp    8010079b <cprintf+0x11b>
8010079d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
801007a0:	83 ec 0c             	sub    $0xc,%esp
801007a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007a6:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
801007a9:	50                   	push   %eax
801007aa:	e8 11 5a 00 00       	call   801061c0 <uartputc>
  cgaputc(c);
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	e8 49 fc ff ff       	call   80100400 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b7:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      continue;
801007bb:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007be:	85 c0                	test   %eax,%eax
801007c0:	0f 85 ea fe ff ff    	jne    801006b0 <cprintf+0x30>
801007c6:	e9 3b ff ff ff       	jmp    80100706 <cprintf+0x86>
801007cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801007cf:	90                   	nop
    acquire(&cons.lock);
801007d0:	83 ec 0c             	sub    $0xc,%esp
801007d3:	68 20 ff 10 80       	push   $0x8010ff20
801007d8:	e8 53 41 00 00       	call   80104930 <acquire>
801007dd:	83 c4 10             	add    $0x10,%esp
801007e0:	e9 b4 fe ff ff       	jmp    80100699 <cprintf+0x19>
  if(panicked){
801007e5:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007eb:	85 c9                	test   %ecx,%ecx
801007ed:	75 71                	jne    80100860 <cprintf+0x1e0>
    uartputc(c);
801007ef:	83 ec 0c             	sub    $0xc,%esp
801007f2:	89 55 e0             	mov    %edx,-0x20(%ebp)
801007f5:	6a 25                	push   $0x25
801007f7:	e8 c4 59 00 00       	call   801061c0 <uartputc>
  cgaputc(c);
801007fc:	b8 25 00 00 00       	mov    $0x25,%eax
80100801:	e8 fa fb ff ff       	call   80100400 <cgaputc>
  if(panicked){
80100806:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
8010080c:	83 c4 10             	add    $0x10,%esp
8010080f:	85 d2                	test   %edx,%edx
80100811:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100814:	0f 84 8e 00 00 00    	je     801008a8 <cprintf+0x228>
8010081a:	fa                   	cli    
    for(;;)
8010081b:	eb fe                	jmp    8010081b <cprintf+0x19b>
8010081d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100820:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100825:	85 c0                	test   %eax,%eax
80100827:	74 07                	je     80100830 <cprintf+0x1b0>
80100829:	fa                   	cli    
    for(;;)
8010082a:	eb fe                	jmp    8010082a <cprintf+0x1aa>
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
80100830:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100833:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100836:	6a 25                	push   $0x25
80100838:	e8 83 59 00 00       	call   801061c0 <uartputc>
  cgaputc(c);
8010083d:	b8 25 00 00 00       	mov    $0x25,%eax
80100842:	e8 b9 fb ff ff       	call   80100400 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100847:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
}
8010084b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010084e:	85 c0                	test   %eax,%eax
80100850:	0f 85 5a fe ff ff    	jne    801006b0 <cprintf+0x30>
80100856:	e9 ab fe ff ff       	jmp    80100706 <cprintf+0x86>
8010085b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010085f:	90                   	nop
80100860:	fa                   	cli    
    for(;;)
80100861:	eb fe                	jmp    80100861 <cprintf+0x1e1>
80100863:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100867:	90                   	nop
      for(; *s; s++)
80100868:	0f b6 07             	movzbl (%edi),%eax
8010086b:	84 c0                	test   %al,%al
8010086d:	74 6c                	je     801008db <cprintf+0x25b>
8010086f:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80100872:	89 fb                	mov    %edi,%ebx
80100874:	e9 cb fe ff ff       	jmp    80100744 <cprintf+0xc4>
    uartputc(c);
80100879:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
8010087c:	0f be f8             	movsbl %al,%edi
      for(; *s; s++)
8010087f:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100882:	57                   	push   %edi
80100883:	e8 38 59 00 00       	call   801061c0 <uartputc>
  cgaputc(c);
80100888:	89 f8                	mov    %edi,%eax
8010088a:	e8 71 fb ff ff       	call   80100400 <cgaputc>
      for(; *s; s++)
8010088f:	0f b6 03             	movzbl (%ebx),%eax
80100892:	83 c4 10             	add    $0x10,%esp
80100895:	84 c0                	test   %al,%al
80100897:	0f 85 a7 fe ff ff    	jne    80100744 <cprintf+0xc4>
      if((s = (char*)*argp++) == 0)
8010089d:	8b 5d dc             	mov    -0x24(%ebp),%ebx
801008a0:	8b 7d e0             	mov    -0x20(%ebp),%edi
801008a3:	e9 53 fe ff ff       	jmp    801006fb <cprintf+0x7b>
    uartputc(c);
801008a8:	83 ec 0c             	sub    $0xc,%esp
801008ab:	89 55 e0             	mov    %edx,-0x20(%ebp)
801008ae:	52                   	push   %edx
801008af:	e8 0c 59 00 00       	call   801061c0 <uartputc>
  cgaputc(c);
801008b4:	8b 55 e0             	mov    -0x20(%ebp),%edx
801008b7:	89 d0                	mov    %edx,%eax
801008b9:	e8 42 fb ff ff       	call   80100400 <cgaputc>
}
801008be:	83 c4 10             	add    $0x10,%esp
801008c1:	e9 35 fe ff ff       	jmp    801006fb <cprintf+0x7b>
    release(&cons.lock);
801008c6:	83 ec 0c             	sub    $0xc,%esp
801008c9:	68 20 ff 10 80       	push   $0x8010ff20
801008ce:	e8 fd 3f 00 00       	call   801048d0 <release>
801008d3:	83 c4 10             	add    $0x10,%esp
}
801008d6:	e9 36 fe ff ff       	jmp    80100711 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
801008db:	8b 7d e0             	mov    -0x20(%ebp),%edi
801008de:	e9 18 fe ff ff       	jmp    801006fb <cprintf+0x7b>
    panic("null fmt");
801008e3:	83 ec 0c             	sub    $0xc,%esp
801008e6:	68 5f 78 10 80       	push   $0x8010785f
801008eb:	e8 90 fa ff ff       	call   80100380 <panic>

801008f0 <consoleintr>:
{
801008f0:	55                   	push   %ebp
801008f1:	89 e5                	mov    %esp,%ebp
801008f3:	57                   	push   %edi
801008f4:	56                   	push   %esi
801008f5:	53                   	push   %ebx
  int c, doprocdump = 0;
801008f6:	31 db                	xor    %ebx,%ebx
{
801008f8:	83 ec 28             	sub    $0x28,%esp
801008fb:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
801008fe:	68 20 ff 10 80       	push   $0x8010ff20
80100903:	e8 28 40 00 00       	call   80104930 <acquire>
  while((c = getc()) >= 0){
80100908:	83 c4 10             	add    $0x10,%esp
8010090b:	eb 1a                	jmp    80100927 <consoleintr+0x37>
8010090d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100910:	83 f8 08             	cmp    $0x8,%eax
80100913:	0f 84 17 01 00 00    	je     80100a30 <consoleintr+0x140>
80100919:	83 f8 10             	cmp    $0x10,%eax
8010091c:	0f 85 9a 01 00 00    	jne    80100abc <consoleintr+0x1cc>
80100922:	bb 01 00 00 00       	mov    $0x1,%ebx
  while((c = getc()) >= 0){
80100927:	ff d6                	call   *%esi
80100929:	85 c0                	test   %eax,%eax
8010092b:	0f 88 6f 01 00 00    	js     80100aa0 <consoleintr+0x1b0>
    switch(c){
80100931:	83 f8 15             	cmp    $0x15,%eax
80100934:	0f 84 b6 00 00 00    	je     801009f0 <consoleintr+0x100>
8010093a:	7e d4                	jle    80100910 <consoleintr+0x20>
8010093c:	83 f8 7f             	cmp    $0x7f,%eax
8010093f:	0f 84 eb 00 00 00    	je     80100a30 <consoleintr+0x140>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100945:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
8010094b:	89 d1                	mov    %edx,%ecx
8010094d:	2b 0d 00 ff 10 80    	sub    0x8010ff00,%ecx
80100953:	83 f9 7f             	cmp    $0x7f,%ecx
80100956:	77 cf                	ja     80100927 <consoleintr+0x37>
        input.buf[input.e++ % INPUT_BUF] = c;
80100958:	89 d1                	mov    %edx,%ecx
8010095a:	83 c2 01             	add    $0x1,%edx
  if(panicked){
8010095d:	8b 3d 58 ff 10 80    	mov    0x8010ff58,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100963:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
80100969:	83 e1 7f             	and    $0x7f,%ecx
        c = (c == '\r') ? '\n' : c;
8010096c:	83 f8 0d             	cmp    $0xd,%eax
8010096f:	0f 84 9b 01 00 00    	je     80100b10 <consoleintr+0x220>
        input.buf[input.e++ % INPUT_BUF] = c;
80100975:	88 81 80 fe 10 80    	mov    %al,-0x7fef0180(%ecx)
  if(panicked){
8010097b:	85 ff                	test   %edi,%edi
8010097d:	0f 85 98 01 00 00    	jne    80100b1b <consoleintr+0x22b>
  if(c == BACKSPACE){
80100983:	3d 00 01 00 00       	cmp    $0x100,%eax
80100988:	0f 85 b3 01 00 00    	jne    80100b41 <consoleintr+0x251>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010098e:	83 ec 0c             	sub    $0xc,%esp
80100991:	6a 08                	push   $0x8
80100993:	e8 28 58 00 00       	call   801061c0 <uartputc>
80100998:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010099f:	e8 1c 58 00 00       	call   801061c0 <uartputc>
801009a4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801009ab:	e8 10 58 00 00       	call   801061c0 <uartputc>
  cgaputc(c);
801009b0:	b8 00 01 00 00       	mov    $0x100,%eax
801009b5:	e8 46 fa ff ff       	call   80100400 <cgaputc>
801009ba:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009bd:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801009c2:	83 e8 80             	sub    $0xffffff80,%eax
801009c5:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
801009cb:	0f 85 56 ff ff ff    	jne    80100927 <consoleintr+0x37>
          wakeup(&input.r);
801009d1:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
801009d4:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          wakeup(&input.r);
801009d9:	68 00 ff 10 80       	push   $0x8010ff00
801009de:	e8 5d 38 00 00       	call   80104240 <wakeup>
801009e3:	83 c4 10             	add    $0x10,%esp
801009e6:	e9 3c ff ff ff       	jmp    80100927 <consoleintr+0x37>
801009eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009ef:	90                   	nop
      while(input.e != input.w &&
801009f0:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009f5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009fb:	0f 84 26 ff ff ff    	je     80100927 <consoleintr+0x37>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100a01:	83 e8 01             	sub    $0x1,%eax
80100a04:	89 c2                	mov    %eax,%edx
80100a06:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100a09:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80100a10:	0f 84 11 ff ff ff    	je     80100927 <consoleintr+0x37>
  if(panicked){
80100a16:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.e--;
80100a1c:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100a21:	85 d2                	test   %edx,%edx
80100a23:	74 33                	je     80100a58 <consoleintr+0x168>
80100a25:	fa                   	cli    
    for(;;)
80100a26:	eb fe                	jmp    80100a26 <consoleintr+0x136>
80100a28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a2f:	90                   	nop
      if(input.e != input.w){
80100a30:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100a35:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100a3b:	0f 84 e6 fe ff ff    	je     80100927 <consoleintr+0x37>
        input.e--;
80100a41:	83 e8 01             	sub    $0x1,%eax
80100a44:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100a49:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100a4e:	85 c0                	test   %eax,%eax
80100a50:	74 7e                	je     80100ad0 <consoleintr+0x1e0>
80100a52:	fa                   	cli    
    for(;;)
80100a53:	eb fe                	jmp    80100a53 <consoleintr+0x163>
80100a55:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100a58:	83 ec 0c             	sub    $0xc,%esp
80100a5b:	6a 08                	push   $0x8
80100a5d:	e8 5e 57 00 00       	call   801061c0 <uartputc>
80100a62:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100a69:	e8 52 57 00 00       	call   801061c0 <uartputc>
80100a6e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100a75:	e8 46 57 00 00       	call   801061c0 <uartputc>
  cgaputc(c);
80100a7a:	b8 00 01 00 00       	mov    $0x100,%eax
80100a7f:	e8 7c f9 ff ff       	call   80100400 <cgaputc>
      while(input.e != input.w &&
80100a84:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100a89:	83 c4 10             	add    $0x10,%esp
80100a8c:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100a92:	0f 85 69 ff ff ff    	jne    80100a01 <consoleintr+0x111>
80100a98:	e9 8a fe ff ff       	jmp    80100927 <consoleintr+0x37>
80100a9d:	8d 76 00             	lea    0x0(%esi),%esi
  release(&cons.lock);
80100aa0:	83 ec 0c             	sub    $0xc,%esp
80100aa3:	68 20 ff 10 80       	push   $0x8010ff20
80100aa8:	e8 23 3e 00 00       	call   801048d0 <release>
  if(doprocdump) {
80100aad:	83 c4 10             	add    $0x10,%esp
80100ab0:	85 db                	test   %ebx,%ebx
80100ab2:	75 50                	jne    80100b04 <consoleintr+0x214>
}
80100ab4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ab7:	5b                   	pop    %ebx
80100ab8:	5e                   	pop    %esi
80100ab9:	5f                   	pop    %edi
80100aba:	5d                   	pop    %ebp
80100abb:	c3                   	ret    
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100abc:	85 c0                	test   %eax,%eax
80100abe:	0f 84 63 fe ff ff    	je     80100927 <consoleintr+0x37>
80100ac4:	e9 7c fe ff ff       	jmp    80100945 <consoleintr+0x55>
80100ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100ad0:	83 ec 0c             	sub    $0xc,%esp
80100ad3:	6a 08                	push   $0x8
80100ad5:	e8 e6 56 00 00       	call   801061c0 <uartputc>
80100ada:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100ae1:	e8 da 56 00 00       	call   801061c0 <uartputc>
80100ae6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100aed:	e8 ce 56 00 00       	call   801061c0 <uartputc>
  cgaputc(c);
80100af2:	b8 00 01 00 00       	mov    $0x100,%eax
80100af7:	e8 04 f9 ff ff       	call   80100400 <cgaputc>
}
80100afc:	83 c4 10             	add    $0x10,%esp
80100aff:	e9 23 fe ff ff       	jmp    80100927 <consoleintr+0x37>
}
80100b04:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b07:	5b                   	pop    %ebx
80100b08:	5e                   	pop    %esi
80100b09:	5f                   	pop    %edi
80100b0a:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100b0b:	e9 10 38 00 00       	jmp    80104320 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
80100b10:	c6 81 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%ecx)
  if(panicked){
80100b17:	85 ff                	test   %edi,%edi
80100b19:	74 05                	je     80100b20 <consoleintr+0x230>
80100b1b:	fa                   	cli    
    for(;;)
80100b1c:	eb fe                	jmp    80100b1c <consoleintr+0x22c>
80100b1e:	66 90                	xchg   %ax,%ax
    uartputc(c);
80100b20:	83 ec 0c             	sub    $0xc,%esp
80100b23:	6a 0a                	push   $0xa
80100b25:	e8 96 56 00 00       	call   801061c0 <uartputc>
  cgaputc(c);
80100b2a:	b8 0a 00 00 00       	mov    $0xa,%eax
80100b2f:	e8 cc f8 ff ff       	call   80100400 <cgaputc>
          input.w = input.e;
80100b34:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100b39:	83 c4 10             	add    $0x10,%esp
80100b3c:	e9 90 fe ff ff       	jmp    801009d1 <consoleintr+0xe1>
    uartputc(c);
80100b41:	83 ec 0c             	sub    $0xc,%esp
80100b44:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100b47:	50                   	push   %eax
80100b48:	e8 73 56 00 00       	call   801061c0 <uartputc>
  cgaputc(c);
80100b4d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100b50:	e8 ab f8 ff ff       	call   80100400 <cgaputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100b55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100b58:	83 c4 10             	add    $0x10,%esp
80100b5b:	83 f8 0a             	cmp    $0xa,%eax
80100b5e:	74 09                	je     80100b69 <consoleintr+0x279>
80100b60:	83 f8 04             	cmp    $0x4,%eax
80100b63:	0f 85 54 fe ff ff    	jne    801009bd <consoleintr+0xcd>
          input.w = input.e;
80100b69:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100b6e:	e9 5e fe ff ff       	jmp    801009d1 <consoleintr+0xe1>
80100b73:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100b80 <consoleinit>:

void
consoleinit(void)
{
80100b80:	55                   	push   %ebp
80100b81:	89 e5                	mov    %esp,%ebp
80100b83:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100b86:	68 68 78 10 80       	push   $0x80107868
80100b8b:	68 20 ff 10 80       	push   $0x8010ff20
80100b90:	e8 cb 3b 00 00       	call   80104760 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100b95:	58                   	pop    %eax
80100b96:	5a                   	pop    %edx
80100b97:	6a 00                	push   $0x0
80100b99:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100b9b:	c7 05 0c 09 11 80 40 	movl   $0x80100540,0x8011090c
80100ba2:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100ba5:	c7 05 08 09 11 80 80 	movl   $0x80100280,0x80110908
80100bac:	02 10 80 
  cons.locking = 1;
80100baf:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100bb6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100bb9:	e8 e2 19 00 00       	call   801025a0 <ioapicenable>
}
80100bbe:	83 c4 10             	add    $0x10,%esp
80100bc1:	c9                   	leave  
80100bc2:	c3                   	ret    
80100bc3:	66 90                	xchg   %ax,%ax
80100bc5:	66 90                	xchg   %ax,%ax
80100bc7:	66 90                	xchg   %ax,%ax
80100bc9:	66 90                	xchg   %ax,%ax
80100bcb:	66 90                	xchg   %ax,%ax
80100bcd:	66 90                	xchg   %ax,%ax
80100bcf:	90                   	nop

80100bd0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100bd0:	55                   	push   %ebp
80100bd1:	89 e5                	mov    %esp,%ebp
80100bd3:	57                   	push   %edi
80100bd4:	56                   	push   %esi
80100bd5:	53                   	push   %ebx
80100bd6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100bdc:	e8 bf 2e 00 00       	call   80103aa0 <myproc>
80100be1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100be7:	e8 94 22 00 00       	call   80102e80 <begin_op>

  if((ip = namei(path)) == 0){
80100bec:	83 ec 0c             	sub    $0xc,%esp
80100bef:	ff 75 08             	pushl  0x8(%ebp)
80100bf2:	e8 c9 15 00 00       	call   801021c0 <namei>
80100bf7:	83 c4 10             	add    $0x10,%esp
80100bfa:	85 c0                	test   %eax,%eax
80100bfc:	0f 84 02 03 00 00    	je     80100f04 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100c02:	83 ec 0c             	sub    $0xc,%esp
80100c05:	89 c3                	mov    %eax,%ebx
80100c07:	50                   	push   %eax
80100c08:	e8 93 0c 00 00       	call   801018a0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100c0d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100c13:	6a 34                	push   $0x34
80100c15:	6a 00                	push   $0x0
80100c17:	50                   	push   %eax
80100c18:	53                   	push   %ebx
80100c19:	e8 92 0f 00 00       	call   80101bb0 <readi>
80100c1e:	83 c4 20             	add    $0x20,%esp
80100c21:	83 f8 34             	cmp    $0x34,%eax
80100c24:	74 22                	je     80100c48 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100c26:	83 ec 0c             	sub    $0xc,%esp
80100c29:	53                   	push   %ebx
80100c2a:	e8 01 0f 00 00       	call   80101b30 <iunlockput>
    end_op();
80100c2f:	e8 bc 22 00 00       	call   80102ef0 <end_op>
80100c34:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100c37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100c3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c3f:	5b                   	pop    %ebx
80100c40:	5e                   	pop    %esi
80100c41:	5f                   	pop    %edi
80100c42:	5d                   	pop    %ebp
80100c43:	c3                   	ret    
80100c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100c48:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100c4f:	45 4c 46 
80100c52:	75 d2                	jne    80100c26 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100c54:	e8 f7 66 00 00       	call   80107350 <setupkvm>
80100c59:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100c5f:	85 c0                	test   %eax,%eax
80100c61:	74 c3                	je     80100c26 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c63:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100c6a:	00 
80100c6b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100c71:	0f 84 ac 02 00 00    	je     80100f23 <exec+0x353>
  sz = PGSIZE;
80100c77:	c7 85 f0 fe ff ff 00 	movl   $0x1000,-0x110(%ebp)
80100c7e:	10 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c81:	31 ff                	xor    %edi,%edi
80100c83:	e9 8e 00 00 00       	jmp    80100d16 <exec+0x146>
80100c88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c8f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80100c90:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100c97:	75 6c                	jne    80100d05 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100c99:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100c9f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ca5:	0f 82 87 00 00 00    	jb     80100d32 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100cab:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100cb1:	72 7f                	jb     80100d32 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100cb3:	83 ec 04             	sub    $0x4,%esp
80100cb6:	50                   	push   %eax
80100cb7:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100cbd:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100cc3:	e8 a8 64 00 00       	call   80107170 <allocuvm>
80100cc8:	83 c4 10             	add    $0x10,%esp
80100ccb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100cd1:	85 c0                	test   %eax,%eax
80100cd3:	74 5d                	je     80100d32 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100cd5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100cdb:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100ce0:	75 50                	jne    80100d32 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100ce2:	83 ec 0c             	sub    $0xc,%esp
80100ce5:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100ceb:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100cf1:	53                   	push   %ebx
80100cf2:	50                   	push   %eax
80100cf3:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100cf9:	e8 82 63 00 00       	call   80107080 <loaduvm>
80100cfe:	83 c4 20             	add    $0x20,%esp
80100d01:	85 c0                	test   %eax,%eax
80100d03:	78 2d                	js     80100d32 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d05:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100d0c:	83 c7 01             	add    $0x1,%edi
80100d0f:	83 c6 20             	add    $0x20,%esi
80100d12:	39 f8                	cmp    %edi,%eax
80100d14:	7e 3a                	jle    80100d50 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100d16:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100d1c:	6a 20                	push   $0x20
80100d1e:	56                   	push   %esi
80100d1f:	50                   	push   %eax
80100d20:	53                   	push   %ebx
80100d21:	e8 8a 0e 00 00       	call   80101bb0 <readi>
80100d26:	83 c4 10             	add    $0x10,%esp
80100d29:	83 f8 20             	cmp    $0x20,%eax
80100d2c:	0f 84 5e ff ff ff    	je     80100c90 <exec+0xc0>
    freevm(pgdir);
80100d32:	83 ec 0c             	sub    $0xc,%esp
80100d35:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100d3b:	e8 90 65 00 00       	call   801072d0 <freevm>
  if(ip){
80100d40:	83 c4 10             	add    $0x10,%esp
80100d43:	e9 de fe ff ff       	jmp    80100c26 <exec+0x56>
80100d48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100d4f:	90                   	nop
  sz = PGROUNDUP(sz);
80100d50:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100d56:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100d5c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d62:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100d68:	83 ec 0c             	sub    $0xc,%esp
80100d6b:	53                   	push   %ebx
80100d6c:	e8 bf 0d 00 00       	call   80101b30 <iunlockput>
  end_op();
80100d71:	e8 7a 21 00 00       	call   80102ef0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d76:	83 c4 0c             	add    $0xc,%esp
80100d79:	56                   	push   %esi
80100d7a:	57                   	push   %edi
80100d7b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100d81:	57                   	push   %edi
80100d82:	e8 e9 63 00 00       	call   80107170 <allocuvm>
80100d87:	83 c4 10             	add    $0x10,%esp
80100d8a:	89 c6                	mov    %eax,%esi
80100d8c:	85 c0                	test   %eax,%eax
80100d8e:	0f 84 94 00 00 00    	je     80100e28 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d94:	83 ec 08             	sub    $0x8,%esp
80100d97:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100d9d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d9f:	50                   	push   %eax
80100da0:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100da1:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100da3:	e8 48 66 00 00       	call   801073f0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100da8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dab:	83 c4 10             	add    $0x10,%esp
80100dae:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100db4:	8b 00                	mov    (%eax),%eax
80100db6:	85 c0                	test   %eax,%eax
80100db8:	0f 84 8b 00 00 00    	je     80100e49 <exec+0x279>
80100dbe:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100dc4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100dca:	eb 23                	jmp    80100def <exec+0x21f>
80100dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100dd0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100dd3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100dda:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100ddd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100de3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100de6:	85 c0                	test   %eax,%eax
80100de8:	74 59                	je     80100e43 <exec+0x273>
    if(argc >= MAXARG)
80100dea:	83 ff 20             	cmp    $0x20,%edi
80100ded:	74 39                	je     80100e28 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100def:	83 ec 0c             	sub    $0xc,%esp
80100df2:	50                   	push   %eax
80100df3:	e8 f8 3d 00 00       	call   80104bf0 <strlen>
80100df8:	f7 d0                	not    %eax
80100dfa:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100dfc:	58                   	pop    %eax
80100dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e00:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e03:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e06:	e8 e5 3d 00 00       	call   80104bf0 <strlen>
80100e0b:	83 c0 01             	add    $0x1,%eax
80100e0e:	50                   	push   %eax
80100e0f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e12:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e15:	53                   	push   %ebx
80100e16:	56                   	push   %esi
80100e17:	e8 a4 67 00 00       	call   801075c0 <copyout>
80100e1c:	83 c4 20             	add    $0x20,%esp
80100e1f:	85 c0                	test   %eax,%eax
80100e21:	79 ad                	jns    80100dd0 <exec+0x200>
80100e23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e27:	90                   	nop
    freevm(pgdir);
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100e31:	e8 9a 64 00 00       	call   801072d0 <freevm>
80100e36:	83 c4 10             	add    $0x10,%esp
  return -1;
80100e39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100e3e:	e9 f9 fd ff ff       	jmp    80100c3c <exec+0x6c>
80100e43:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e49:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100e50:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100e52:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100e59:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e5d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100e5f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100e62:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100e68:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e6a:	50                   	push   %eax
80100e6b:	52                   	push   %edx
80100e6c:	53                   	push   %ebx
80100e6d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100e73:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100e7a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e7d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e83:	e8 38 67 00 00       	call   801075c0 <copyout>
80100e88:	83 c4 10             	add    $0x10,%esp
80100e8b:	85 c0                	test   %eax,%eax
80100e8d:	78 99                	js     80100e28 <exec+0x258>
  for(last=s=path; *s; s++)
80100e8f:	8b 45 08             	mov    0x8(%ebp),%eax
80100e92:	8b 55 08             	mov    0x8(%ebp),%edx
80100e95:	0f b6 00             	movzbl (%eax),%eax
80100e98:	84 c0                	test   %al,%al
80100e9a:	74 13                	je     80100eaf <exec+0x2df>
80100e9c:	89 d1                	mov    %edx,%ecx
80100e9e:	66 90                	xchg   %ax,%ax
      last = s+1;
80100ea0:	83 c1 01             	add    $0x1,%ecx
80100ea3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100ea5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100ea8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100eab:	84 c0                	test   %al,%al
80100ead:	75 f1                	jne    80100ea0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100eaf:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100eb5:	83 ec 04             	sub    $0x4,%esp
80100eb8:	6a 10                	push   $0x10
80100eba:	89 f8                	mov    %edi,%eax
80100ebc:	52                   	push   %edx
80100ebd:	83 c0 6c             	add    $0x6c,%eax
80100ec0:	50                   	push   %eax
80100ec1:	e8 ea 3c 00 00       	call   80104bb0 <safestrcpy>
  curproc->pgdir = pgdir;
80100ec6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100ecc:	89 f8                	mov    %edi,%eax
80100ece:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100ed1:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100ed3:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100ed6:	89 c1                	mov    %eax,%ecx
80100ed8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100ede:	8b 40 18             	mov    0x18(%eax),%eax
80100ee1:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100ee4:	8b 41 18             	mov    0x18(%ecx),%eax
80100ee7:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100eea:	89 0c 24             	mov    %ecx,(%esp)
80100eed:	e8 fe 5f 00 00       	call   80106ef0 <switchuvm>
  freevm(oldpgdir);
80100ef2:	89 3c 24             	mov    %edi,(%esp)
80100ef5:	e8 d6 63 00 00       	call   801072d0 <freevm>
  return 0;
80100efa:	83 c4 10             	add    $0x10,%esp
80100efd:	31 c0                	xor    %eax,%eax
80100eff:	e9 38 fd ff ff       	jmp    80100c3c <exec+0x6c>
    end_op();
80100f04:	e8 e7 1f 00 00       	call   80102ef0 <end_op>
    cprintf("exec: fail\n");
80100f09:	83 ec 0c             	sub    $0xc,%esp
80100f0c:	68 81 78 10 80       	push   $0x80107881
80100f11:	e8 6a f7 ff ff       	call   80100680 <cprintf>
    return -1;
80100f16:	83 c4 10             	add    $0x10,%esp
80100f19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f1e:	e9 19 fd ff ff       	jmp    80100c3c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100f23:	bf 00 10 00 00       	mov    $0x1000,%edi
80100f28:	be 00 30 00 00       	mov    $0x3000,%esi
80100f2d:	e9 36 fe ff ff       	jmp    80100d68 <exec+0x198>
80100f32:	66 90                	xchg   %ax,%ax
80100f34:	66 90                	xchg   %ax,%ax
80100f36:	66 90                	xchg   %ax,%ax
80100f38:	66 90                	xchg   %ax,%ax
80100f3a:	66 90                	xchg   %ax,%ax
80100f3c:	66 90                	xchg   %ax,%ax
80100f3e:	66 90                	xchg   %ax,%ax

80100f40 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100f46:	68 8d 78 10 80       	push   $0x8010788d
80100f4b:	68 60 ff 10 80       	push   $0x8010ff60
80100f50:	e8 0b 38 00 00       	call   80104760 <initlock>
}
80100f55:	83 c4 10             	add    $0x10,%esp
80100f58:	c9                   	leave  
80100f59:	c3                   	ret    
80100f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f64:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80100f69:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100f6c:	68 60 ff 10 80       	push   $0x8010ff60
80100f71:	e8 ba 39 00 00       	call   80104930 <acquire>
80100f76:	83 c4 10             	add    $0x10,%esp
80100f79:	eb 10                	jmp    80100f8b <filealloc+0x2b>
80100f7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f7f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f80:	83 c3 18             	add    $0x18,%ebx
80100f83:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100f89:	74 25                	je     80100fb0 <filealloc+0x50>
    if(f->ref == 0){
80100f8b:	8b 43 04             	mov    0x4(%ebx),%eax
80100f8e:	85 c0                	test   %eax,%eax
80100f90:	75 ee                	jne    80100f80 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100f92:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100f95:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100f9c:	68 60 ff 10 80       	push   $0x8010ff60
80100fa1:	e8 2a 39 00 00       	call   801048d0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100fa6:	89 d8                	mov    %ebx,%eax
      return f;
80100fa8:	83 c4 10             	add    $0x10,%esp
}
80100fab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fae:	c9                   	leave  
80100faf:	c3                   	ret    
  release(&ftable.lock);
80100fb0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100fb3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100fb5:	68 60 ff 10 80       	push   $0x8010ff60
80100fba:	e8 11 39 00 00       	call   801048d0 <release>
}
80100fbf:	89 d8                	mov    %ebx,%eax
  return 0;
80100fc1:	83 c4 10             	add    $0x10,%esp
}
80100fc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fc7:	c9                   	leave  
80100fc8:	c3                   	ret    
80100fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100fd0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	53                   	push   %ebx
80100fd4:	83 ec 10             	sub    $0x10,%esp
80100fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100fda:	68 60 ff 10 80       	push   $0x8010ff60
80100fdf:	e8 4c 39 00 00       	call   80104930 <acquire>
  if(f->ref < 1)
80100fe4:	8b 43 04             	mov    0x4(%ebx),%eax
80100fe7:	83 c4 10             	add    $0x10,%esp
80100fea:	85 c0                	test   %eax,%eax
80100fec:	7e 1a                	jle    80101008 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100fee:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ff1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ff4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ff7:	68 60 ff 10 80       	push   $0x8010ff60
80100ffc:	e8 cf 38 00 00       	call   801048d0 <release>
  return f;
}
80101001:	89 d8                	mov    %ebx,%eax
80101003:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101006:	c9                   	leave  
80101007:	c3                   	ret    
    panic("filedup");
80101008:	83 ec 0c             	sub    $0xc,%esp
8010100b:	68 94 78 10 80       	push   $0x80107894
80101010:	e8 6b f3 ff ff       	call   80100380 <panic>
80101015:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101020 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	57                   	push   %edi
80101024:	56                   	push   %esi
80101025:	53                   	push   %ebx
80101026:	83 ec 28             	sub    $0x28,%esp
80101029:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
8010102c:	68 60 ff 10 80       	push   $0x8010ff60
80101031:	e8 fa 38 00 00       	call   80104930 <acquire>
  if(f->ref < 1)
80101036:	8b 53 04             	mov    0x4(%ebx),%edx
80101039:	83 c4 10             	add    $0x10,%esp
8010103c:	85 d2                	test   %edx,%edx
8010103e:	0f 8e a5 00 00 00    	jle    801010e9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101044:	83 ea 01             	sub    $0x1,%edx
80101047:	89 53 04             	mov    %edx,0x4(%ebx)
8010104a:	75 44                	jne    80101090 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010104c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101050:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101053:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101055:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010105b:	8b 73 0c             	mov    0xc(%ebx),%esi
8010105e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101061:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101064:	68 60 ff 10 80       	push   $0x8010ff60
  ff = *f;
80101069:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
8010106c:	e8 5f 38 00 00       	call   801048d0 <release>

  if(ff.type == FD_PIPE)
80101071:	83 c4 10             	add    $0x10,%esp
80101074:	83 ff 01             	cmp    $0x1,%edi
80101077:	74 57                	je     801010d0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101079:	83 ff 02             	cmp    $0x2,%edi
8010107c:	74 2a                	je     801010a8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010107e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101081:	5b                   	pop    %ebx
80101082:	5e                   	pop    %esi
80101083:	5f                   	pop    %edi
80101084:	5d                   	pop    %ebp
80101085:	c3                   	ret    
80101086:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010108d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101090:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80101097:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010109a:	5b                   	pop    %ebx
8010109b:	5e                   	pop    %esi
8010109c:	5f                   	pop    %edi
8010109d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010109e:	e9 2d 38 00 00       	jmp    801048d0 <release>
801010a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801010a7:	90                   	nop
    begin_op();
801010a8:	e8 d3 1d 00 00       	call   80102e80 <begin_op>
    iput(ff.ip);
801010ad:	83 ec 0c             	sub    $0xc,%esp
801010b0:	ff 75 e0             	pushl  -0x20(%ebp)
801010b3:	e8 18 09 00 00       	call   801019d0 <iput>
    end_op();
801010b8:	83 c4 10             	add    $0x10,%esp
}
801010bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010be:	5b                   	pop    %ebx
801010bf:	5e                   	pop    %esi
801010c0:	5f                   	pop    %edi
801010c1:	5d                   	pop    %ebp
    end_op();
801010c2:	e9 29 1e 00 00       	jmp    80102ef0 <end_op>
801010c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010ce:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
801010d0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801010d4:	83 ec 08             	sub    $0x8,%esp
801010d7:	53                   	push   %ebx
801010d8:	56                   	push   %esi
801010d9:	e8 72 25 00 00       	call   80103650 <pipeclose>
801010de:	83 c4 10             	add    $0x10,%esp
}
801010e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e4:	5b                   	pop    %ebx
801010e5:	5e                   	pop    %esi
801010e6:	5f                   	pop    %edi
801010e7:	5d                   	pop    %ebp
801010e8:	c3                   	ret    
    panic("fileclose");
801010e9:	83 ec 0c             	sub    $0xc,%esp
801010ec:	68 9c 78 10 80       	push   $0x8010789c
801010f1:	e8 8a f2 ff ff       	call   80100380 <panic>
801010f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010fd:	8d 76 00             	lea    0x0(%esi),%esi

80101100 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	53                   	push   %ebx
80101104:	83 ec 04             	sub    $0x4,%esp
80101107:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010110a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010110d:	75 31                	jne    80101140 <filestat+0x40>
    ilock(f->ip);
8010110f:	83 ec 0c             	sub    $0xc,%esp
80101112:	ff 73 10             	pushl  0x10(%ebx)
80101115:	e8 86 07 00 00       	call   801018a0 <ilock>
    stati(f->ip, st);
8010111a:	58                   	pop    %eax
8010111b:	5a                   	pop    %edx
8010111c:	ff 75 0c             	pushl  0xc(%ebp)
8010111f:	ff 73 10             	pushl  0x10(%ebx)
80101122:	e8 59 0a 00 00       	call   80101b80 <stati>
    iunlock(f->ip);
80101127:	59                   	pop    %ecx
80101128:	ff 73 10             	pushl  0x10(%ebx)
8010112b:	e8 50 08 00 00       	call   80101980 <iunlock>
    return 0;
  }
  return -1;
}
80101130:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101133:	83 c4 10             	add    $0x10,%esp
80101136:	31 c0                	xor    %eax,%eax
}
80101138:	c9                   	leave  
80101139:	c3                   	ret    
8010113a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101140:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101143:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101148:	c9                   	leave  
80101149:	c3                   	ret    
8010114a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101150 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101150:	55                   	push   %ebp
80101151:	89 e5                	mov    %esp,%ebp
80101153:	57                   	push   %edi
80101154:	56                   	push   %esi
80101155:	53                   	push   %ebx
80101156:	83 ec 0c             	sub    $0xc,%esp
80101159:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010115c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010115f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101162:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101166:	74 60                	je     801011c8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101168:	8b 03                	mov    (%ebx),%eax
8010116a:	83 f8 01             	cmp    $0x1,%eax
8010116d:	74 41                	je     801011b0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010116f:	83 f8 02             	cmp    $0x2,%eax
80101172:	75 5b                	jne    801011cf <fileread+0x7f>
    ilock(f->ip);
80101174:	83 ec 0c             	sub    $0xc,%esp
80101177:	ff 73 10             	pushl  0x10(%ebx)
8010117a:	e8 21 07 00 00       	call   801018a0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010117f:	57                   	push   %edi
80101180:	ff 73 14             	pushl  0x14(%ebx)
80101183:	56                   	push   %esi
80101184:	ff 73 10             	pushl  0x10(%ebx)
80101187:	e8 24 0a 00 00       	call   80101bb0 <readi>
8010118c:	83 c4 20             	add    $0x20,%esp
8010118f:	89 c6                	mov    %eax,%esi
80101191:	85 c0                	test   %eax,%eax
80101193:	7e 03                	jle    80101198 <fileread+0x48>
      f->off += r;
80101195:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101198:	83 ec 0c             	sub    $0xc,%esp
8010119b:	ff 73 10             	pushl  0x10(%ebx)
8010119e:	e8 dd 07 00 00       	call   80101980 <iunlock>
    return r;
801011a3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801011a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a9:	89 f0                	mov    %esi,%eax
801011ab:	5b                   	pop    %ebx
801011ac:	5e                   	pop    %esi
801011ad:	5f                   	pop    %edi
801011ae:	5d                   	pop    %ebp
801011af:	c3                   	ret    
    return piperead(f->pipe, addr, n);
801011b0:	8b 43 0c             	mov    0xc(%ebx),%eax
801011b3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011b9:	5b                   	pop    %ebx
801011ba:	5e                   	pop    %esi
801011bb:	5f                   	pop    %edi
801011bc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801011bd:	e9 2e 26 00 00       	jmp    801037f0 <piperead>
801011c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801011c8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801011cd:	eb d7                	jmp    801011a6 <fileread+0x56>
  panic("fileread");
801011cf:	83 ec 0c             	sub    $0xc,%esp
801011d2:	68 a6 78 10 80       	push   $0x801078a6
801011d7:	e8 a4 f1 ff ff       	call   80100380 <panic>
801011dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801011e0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011e0:	55                   	push   %ebp
801011e1:	89 e5                	mov    %esp,%ebp
801011e3:	57                   	push   %edi
801011e4:	56                   	push   %esi
801011e5:	53                   	push   %ebx
801011e6:	83 ec 1c             	sub    $0x1c,%esp
801011e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801011ec:	8b 75 08             	mov    0x8(%ebp),%esi
801011ef:	89 45 dc             	mov    %eax,-0x24(%ebp)
801011f2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801011f5:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
801011f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801011fc:	0f 84 bd 00 00 00    	je     801012bf <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
80101202:	8b 06                	mov    (%esi),%eax
80101204:	83 f8 01             	cmp    $0x1,%eax
80101207:	0f 84 bf 00 00 00    	je     801012cc <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010120d:	83 f8 02             	cmp    $0x2,%eax
80101210:	0f 85 c8 00 00 00    	jne    801012de <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101216:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101219:	31 ff                	xor    %edi,%edi
    while(i < n){
8010121b:	85 c0                	test   %eax,%eax
8010121d:	7f 30                	jg     8010124f <filewrite+0x6f>
8010121f:	e9 94 00 00 00       	jmp    801012b8 <filewrite+0xd8>
80101224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101228:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010122b:	83 ec 0c             	sub    $0xc,%esp
8010122e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101231:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101234:	e8 47 07 00 00       	call   80101980 <iunlock>
      end_op();
80101239:	e8 b2 1c 00 00       	call   80102ef0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010123e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101241:	83 c4 10             	add    $0x10,%esp
80101244:	39 c3                	cmp    %eax,%ebx
80101246:	75 60                	jne    801012a8 <filewrite+0xc8>
        panic("short filewrite");
      i += r;
80101248:	01 df                	add    %ebx,%edi
    while(i < n){
8010124a:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
8010124d:	7e 69                	jle    801012b8 <filewrite+0xd8>
      int n1 = n - i;
8010124f:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101252:	b8 00 06 00 00       	mov    $0x600,%eax
80101257:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
80101259:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
8010125f:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101262:	e8 19 1c 00 00       	call   80102e80 <begin_op>
      ilock(f->ip);
80101267:	83 ec 0c             	sub    $0xc,%esp
8010126a:	ff 76 10             	pushl  0x10(%esi)
8010126d:	e8 2e 06 00 00       	call   801018a0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101272:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101275:	53                   	push   %ebx
80101276:	ff 76 14             	pushl  0x14(%esi)
80101279:	01 f8                	add    %edi,%eax
8010127b:	50                   	push   %eax
8010127c:	ff 76 10             	pushl  0x10(%esi)
8010127f:	e8 2c 0a 00 00       	call   80101cb0 <writei>
80101284:	83 c4 20             	add    $0x20,%esp
80101287:	85 c0                	test   %eax,%eax
80101289:	7f 9d                	jg     80101228 <filewrite+0x48>
      iunlock(f->ip);
8010128b:	83 ec 0c             	sub    $0xc,%esp
8010128e:	ff 76 10             	pushl  0x10(%esi)
80101291:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101294:	e8 e7 06 00 00       	call   80101980 <iunlock>
      end_op();
80101299:	e8 52 1c 00 00       	call   80102ef0 <end_op>
      if(r < 0)
8010129e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801012a1:	83 c4 10             	add    $0x10,%esp
801012a4:	85 c0                	test   %eax,%eax
801012a6:	75 17                	jne    801012bf <filewrite+0xdf>
        panic("short filewrite");
801012a8:	83 ec 0c             	sub    $0xc,%esp
801012ab:	68 af 78 10 80       	push   $0x801078af
801012b0:	e8 cb f0 ff ff       	call   80100380 <panic>
801012b5:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
801012b8:	89 f8                	mov    %edi,%eax
801012ba:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801012bd:	74 05                	je     801012c4 <filewrite+0xe4>
801012bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801012c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012c7:	5b                   	pop    %ebx
801012c8:	5e                   	pop    %esi
801012c9:	5f                   	pop    %edi
801012ca:	5d                   	pop    %ebp
801012cb:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801012cc:	8b 46 0c             	mov    0xc(%esi),%eax
801012cf:	89 45 08             	mov    %eax,0x8(%ebp)
}
801012d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012d5:	5b                   	pop    %ebx
801012d6:	5e                   	pop    %esi
801012d7:	5f                   	pop    %edi
801012d8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801012d9:	e9 12 24 00 00       	jmp    801036f0 <pipewrite>
  panic("filewrite");
801012de:	83 ec 0c             	sub    $0xc,%esp
801012e1:	68 b5 78 10 80       	push   $0x801078b5
801012e6:	e8 95 f0 ff ff       	call   80100380 <panic>
801012eb:	66 90                	xchg   %ax,%ax
801012ed:	66 90                	xchg   %ax,%ax
801012ef:	90                   	nop

801012f0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801012f0:	55                   	push   %ebp
801012f1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801012f3:	89 d0                	mov    %edx,%eax
801012f5:	c1 e8 0c             	shr    $0xc,%eax
801012f8:	03 05 cc 25 11 80    	add    0x801125cc,%eax
{
801012fe:	89 e5                	mov    %esp,%ebp
80101300:	56                   	push   %esi
80101301:	53                   	push   %ebx
80101302:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101304:	83 ec 08             	sub    $0x8,%esp
80101307:	50                   	push   %eax
80101308:	51                   	push   %ecx
80101309:	e8 c2 ed ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010130e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101310:	c1 fb 03             	sar    $0x3,%ebx
80101313:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101316:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101318:	83 e1 07             	and    $0x7,%ecx
8010131b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101320:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101326:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101328:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010132d:	85 c1                	test   %eax,%ecx
8010132f:	74 23                	je     80101354 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101331:	f7 d0                	not    %eax
  log_write(bp);
80101333:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101336:	21 c8                	and    %ecx,%eax
80101338:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010133c:	56                   	push   %esi
8010133d:	e8 1e 1d 00 00       	call   80103060 <log_write>
  brelse(bp);
80101342:	89 34 24             	mov    %esi,(%esp)
80101345:	e8 a6 ee ff ff       	call   801001f0 <brelse>
}
8010134a:	83 c4 10             	add    $0x10,%esp
8010134d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101350:	5b                   	pop    %ebx
80101351:	5e                   	pop    %esi
80101352:	5d                   	pop    %ebp
80101353:	c3                   	ret    
    panic("freeing free block");
80101354:	83 ec 0c             	sub    $0xc,%esp
80101357:	68 bf 78 10 80       	push   $0x801078bf
8010135c:	e8 1f f0 ff ff       	call   80100380 <panic>
80101361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101368:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010136f:	90                   	nop

80101370 <balloc>:
{
80101370:	55                   	push   %ebp
80101371:	89 e5                	mov    %esp,%ebp
80101373:	57                   	push   %edi
80101374:	56                   	push   %esi
80101375:	53                   	push   %ebx
80101376:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101379:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
{
8010137f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101382:	85 c9                	test   %ecx,%ecx
80101384:	0f 84 87 00 00 00    	je     80101411 <balloc+0xa1>
8010138a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101391:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101394:	83 ec 08             	sub    $0x8,%esp
80101397:	89 f0                	mov    %esi,%eax
80101399:	c1 f8 0c             	sar    $0xc,%eax
8010139c:	03 05 cc 25 11 80    	add    0x801125cc,%eax
801013a2:	50                   	push   %eax
801013a3:	ff 75 d8             	pushl  -0x28(%ebp)
801013a6:	e8 25 ed ff ff       	call   801000d0 <bread>
801013ab:	83 c4 10             	add    $0x10,%esp
801013ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013b1:	a1 b4 25 11 80       	mov    0x801125b4,%eax
801013b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801013b9:	31 c0                	xor    %eax,%eax
801013bb:	eb 2f                	jmp    801013ec <balloc+0x7c>
801013bd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801013c0:	89 c1                	mov    %eax,%ecx
801013c2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801013c7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801013ca:	83 e1 07             	and    $0x7,%ecx
801013cd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801013cf:	89 c1                	mov    %eax,%ecx
801013d1:	c1 f9 03             	sar    $0x3,%ecx
801013d4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801013d9:	89 fa                	mov    %edi,%edx
801013db:	85 df                	test   %ebx,%edi
801013dd:	74 41                	je     80101420 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013df:	83 c0 01             	add    $0x1,%eax
801013e2:	83 c6 01             	add    $0x1,%esi
801013e5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801013ea:	74 05                	je     801013f1 <balloc+0x81>
801013ec:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801013ef:	77 cf                	ja     801013c0 <balloc+0x50>
    brelse(bp);
801013f1:	83 ec 0c             	sub    $0xc,%esp
801013f4:	ff 75 e4             	pushl  -0x1c(%ebp)
801013f7:	e8 f4 ed ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801013fc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101403:	83 c4 10             	add    $0x10,%esp
80101406:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101409:	39 05 b4 25 11 80    	cmp    %eax,0x801125b4
8010140f:	77 80                	ja     80101391 <balloc+0x21>
  panic("balloc: out of blocks");
80101411:	83 ec 0c             	sub    $0xc,%esp
80101414:	68 d2 78 10 80       	push   $0x801078d2
80101419:	e8 62 ef ff ff       	call   80100380 <panic>
8010141e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101420:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101423:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101426:	09 da                	or     %ebx,%edx
80101428:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010142c:	57                   	push   %edi
8010142d:	e8 2e 1c 00 00       	call   80103060 <log_write>
        brelse(bp);
80101432:	89 3c 24             	mov    %edi,(%esp)
80101435:	e8 b6 ed ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010143a:	58                   	pop    %eax
8010143b:	5a                   	pop    %edx
8010143c:	56                   	push   %esi
8010143d:	ff 75 d8             	pushl  -0x28(%ebp)
80101440:	e8 8b ec ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101445:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101448:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010144a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010144d:	68 00 02 00 00       	push   $0x200
80101452:	6a 00                	push   $0x0
80101454:	50                   	push   %eax
80101455:	e8 96 35 00 00       	call   801049f0 <memset>
  log_write(bp);
8010145a:	89 1c 24             	mov    %ebx,(%esp)
8010145d:	e8 fe 1b 00 00       	call   80103060 <log_write>
  brelse(bp);
80101462:	89 1c 24             	mov    %ebx,(%esp)
80101465:	e8 86 ed ff ff       	call   801001f0 <brelse>
}
8010146a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010146d:	89 f0                	mov    %esi,%eax
8010146f:	5b                   	pop    %ebx
80101470:	5e                   	pop    %esi
80101471:	5f                   	pop    %edi
80101472:	5d                   	pop    %ebp
80101473:	c3                   	ret    
80101474:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010147b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010147f:	90                   	nop

80101480 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	57                   	push   %edi
80101484:	89 c7                	mov    %eax,%edi
80101486:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101487:	31 f6                	xor    %esi,%esi
{
80101489:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010148a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
8010148f:	83 ec 28             	sub    $0x28,%esp
80101492:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101495:	68 60 09 11 80       	push   $0x80110960
8010149a:	e8 91 34 00 00       	call   80104930 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010149f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801014a2:	83 c4 10             	add    $0x10,%esp
801014a5:	eb 1b                	jmp    801014c2 <iget+0x42>
801014a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014ae:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014b0:	39 3b                	cmp    %edi,(%ebx)
801014b2:	74 6c                	je     80101520 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014b4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ba:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801014c0:	73 26                	jae    801014e8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014c2:	8b 43 08             	mov    0x8(%ebx),%eax
801014c5:	85 c0                	test   %eax,%eax
801014c7:	7f e7                	jg     801014b0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801014c9:	85 f6                	test   %esi,%esi
801014cb:	75 e7                	jne    801014b4 <iget+0x34>
801014cd:	89 d9                	mov    %ebx,%ecx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014cf:	81 c3 90 00 00 00    	add    $0x90,%ebx
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801014d5:	85 c0                	test   %eax,%eax
801014d7:	75 6e                	jne    80101547 <iget+0xc7>
801014d9:	89 ce                	mov    %ecx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014db:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801014e1:	72 df                	jb     801014c2 <iget+0x42>
801014e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801014e7:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801014e8:	85 f6                	test   %esi,%esi
801014ea:	74 73                	je     8010155f <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801014ec:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801014ef:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801014f1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801014f4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801014fb:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101502:	68 60 09 11 80       	push   $0x80110960
80101507:	e8 c4 33 00 00       	call   801048d0 <release>

  return ip;
8010150c:	83 c4 10             	add    $0x10,%esp
}
8010150f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101512:	89 f0                	mov    %esi,%eax
80101514:	5b                   	pop    %ebx
80101515:	5e                   	pop    %esi
80101516:	5f                   	pop    %edi
80101517:	5d                   	pop    %ebp
80101518:	c3                   	ret    
80101519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101520:	39 53 04             	cmp    %edx,0x4(%ebx)
80101523:	75 8f                	jne    801014b4 <iget+0x34>
      release(&icache.lock);
80101525:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101528:	83 c0 01             	add    $0x1,%eax
      return ip;
8010152b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010152d:	68 60 09 11 80       	push   $0x80110960
      ip->ref++;
80101532:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101535:	e8 96 33 00 00       	call   801048d0 <release>
      return ip;
8010153a:	83 c4 10             	add    $0x10,%esp
}
8010153d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101540:	89 f0                	mov    %esi,%eax
80101542:	5b                   	pop    %ebx
80101543:	5e                   	pop    %esi
80101544:	5f                   	pop    %edi
80101545:	5d                   	pop    %ebp
80101546:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101547:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
8010154d:	73 10                	jae    8010155f <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010154f:	8b 43 08             	mov    0x8(%ebx),%eax
80101552:	85 c0                	test   %eax,%eax
80101554:	0f 8f 56 ff ff ff    	jg     801014b0 <iget+0x30>
8010155a:	e9 6e ff ff ff       	jmp    801014cd <iget+0x4d>
    panic("iget: no inodes");
8010155f:	83 ec 0c             	sub    $0xc,%esp
80101562:	68 e8 78 10 80       	push   $0x801078e8
80101567:	e8 14 ee ff ff       	call   80100380 <panic>
8010156c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101570 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	57                   	push   %edi
80101574:	56                   	push   %esi
80101575:	89 c6                	mov    %eax,%esi
80101577:	53                   	push   %ebx
80101578:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010157b:	83 fa 0b             	cmp    $0xb,%edx
8010157e:	0f 86 8c 00 00 00    	jbe    80101610 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101584:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101587:	83 fb 7f             	cmp    $0x7f,%ebx
8010158a:	0f 87 a2 00 00 00    	ja     80101632 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101590:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
      ip->addrs[bn] = addr = balloc(ip->dev);
80101596:	8b 16                	mov    (%esi),%edx
    if((addr = ip->addrs[NDIRECT]) == 0)
80101598:	85 c0                	test   %eax,%eax
8010159a:	74 5c                	je     801015f8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010159c:	83 ec 08             	sub    $0x8,%esp
8010159f:	50                   	push   %eax
801015a0:	52                   	push   %edx
801015a1:	e8 2a eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801015a6:	83 c4 10             	add    $0x10,%esp
801015a9:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
801015ad:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
801015af:	8b 3b                	mov    (%ebx),%edi
801015b1:	85 ff                	test   %edi,%edi
801015b3:	74 1b                	je     801015d0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801015b5:	83 ec 0c             	sub    $0xc,%esp
801015b8:	52                   	push   %edx
801015b9:	e8 32 ec ff ff       	call   801001f0 <brelse>
801015be:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801015c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015c4:	89 f8                	mov    %edi,%eax
801015c6:	5b                   	pop    %ebx
801015c7:	5e                   	pop    %esi
801015c8:	5f                   	pop    %edi
801015c9:	5d                   	pop    %ebp
801015ca:	c3                   	ret    
801015cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801015cf:	90                   	nop
801015d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801015d3:	8b 06                	mov    (%esi),%eax
801015d5:	e8 96 fd ff ff       	call   80101370 <balloc>
      log_write(bp);
801015da:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015dd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801015e0:	89 03                	mov    %eax,(%ebx)
801015e2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801015e4:	52                   	push   %edx
801015e5:	e8 76 1a 00 00       	call   80103060 <log_write>
801015ea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015ed:	83 c4 10             	add    $0x10,%esp
801015f0:	eb c3                	jmp    801015b5 <bmap+0x45>
801015f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801015f8:	89 d0                	mov    %edx,%eax
801015fa:	e8 71 fd ff ff       	call   80101370 <balloc>
    bp = bread(ip->dev, addr);
801015ff:	8b 16                	mov    (%esi),%edx
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101601:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101607:	eb 93                	jmp    8010159c <bmap+0x2c>
80101609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101610:	8d 5a 14             	lea    0x14(%edx),%ebx
80101613:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101617:	85 ff                	test   %edi,%edi
80101619:	75 a6                	jne    801015c1 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010161b:	8b 00                	mov    (%eax),%eax
8010161d:	e8 4e fd ff ff       	call   80101370 <balloc>
80101622:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101626:	89 c7                	mov    %eax,%edi
}
80101628:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010162b:	5b                   	pop    %ebx
8010162c:	89 f8                	mov    %edi,%eax
8010162e:	5e                   	pop    %esi
8010162f:	5f                   	pop    %edi
80101630:	5d                   	pop    %ebp
80101631:	c3                   	ret    
  panic("bmap: out of range");
80101632:	83 ec 0c             	sub    $0xc,%esp
80101635:	68 f8 78 10 80       	push   $0x801078f8
8010163a:	e8 41 ed ff ff       	call   80100380 <panic>
8010163f:	90                   	nop

80101640 <readsb>:
{
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	56                   	push   %esi
80101644:	53                   	push   %ebx
80101645:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101648:	83 ec 08             	sub    $0x8,%esp
8010164b:	6a 01                	push   $0x1
8010164d:	ff 75 08             	pushl  0x8(%ebp)
80101650:	e8 7b ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101655:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101658:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010165a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010165d:	6a 1c                	push   $0x1c
8010165f:	50                   	push   %eax
80101660:	56                   	push   %esi
80101661:	e8 2a 34 00 00       	call   80104a90 <memmove>
  brelse(bp);
80101666:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101669:	83 c4 10             	add    $0x10,%esp
}
8010166c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010166f:	5b                   	pop    %ebx
80101670:	5e                   	pop    %esi
80101671:	5d                   	pop    %ebp
  brelse(bp);
80101672:	e9 79 eb ff ff       	jmp    801001f0 <brelse>
80101677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010167e:	66 90                	xchg   %ax,%ax

80101680 <iinit>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	53                   	push   %ebx
80101684:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101689:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010168c:	68 0b 79 10 80       	push   $0x8010790b
80101691:	68 60 09 11 80       	push   $0x80110960
80101696:	e8 c5 30 00 00       	call   80104760 <initlock>
  for(i = 0; i < NINODE; i++) {
8010169b:	83 c4 10             	add    $0x10,%esp
8010169e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801016a0:	83 ec 08             	sub    $0x8,%esp
801016a3:	68 12 79 10 80       	push   $0x80107912
801016a8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801016a9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801016af:	e8 7c 2f 00 00       	call   80104630 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801016b4:	83 c4 10             	add    $0x10,%esp
801016b7:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
801016bd:	75 e1                	jne    801016a0 <iinit+0x20>
  bp = bread(dev, 1);
801016bf:	83 ec 08             	sub    $0x8,%esp
801016c2:	6a 01                	push   $0x1
801016c4:	ff 75 08             	pushl  0x8(%ebp)
801016c7:	e8 04 ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801016cc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801016cf:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801016d1:	8d 40 5c             	lea    0x5c(%eax),%eax
801016d4:	6a 1c                	push   $0x1c
801016d6:	50                   	push   %eax
801016d7:	68 b4 25 11 80       	push   $0x801125b4
801016dc:	e8 af 33 00 00       	call   80104a90 <memmove>
  brelse(bp);
801016e1:	89 1c 24             	mov    %ebx,(%esp)
801016e4:	e8 07 eb ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801016e9:	ff 35 cc 25 11 80    	pushl  0x801125cc
801016ef:	ff 35 c8 25 11 80    	pushl  0x801125c8
801016f5:	ff 35 c4 25 11 80    	pushl  0x801125c4
801016fb:	ff 35 c0 25 11 80    	pushl  0x801125c0
80101701:	ff 35 bc 25 11 80    	pushl  0x801125bc
80101707:	ff 35 b8 25 11 80    	pushl  0x801125b8
8010170d:	ff 35 b4 25 11 80    	pushl  0x801125b4
80101713:	68 78 79 10 80       	push   $0x80107978
80101718:	e8 63 ef ff ff       	call   80100680 <cprintf>
}
8010171d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101720:	83 c4 30             	add    $0x30,%esp
80101723:	c9                   	leave  
80101724:	c3                   	ret    
80101725:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010172c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101730 <ialloc>:
{
80101730:	55                   	push   %ebp
80101731:	89 e5                	mov    %esp,%ebp
80101733:	57                   	push   %edi
80101734:	56                   	push   %esi
80101735:	53                   	push   %ebx
80101736:	83 ec 1c             	sub    $0x1c,%esp
80101739:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010173c:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
{
80101743:	8b 75 08             	mov    0x8(%ebp),%esi
80101746:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101749:	0f 86 91 00 00 00    	jbe    801017e0 <ialloc+0xb0>
8010174f:	bf 01 00 00 00       	mov    $0x1,%edi
80101754:	eb 21                	jmp    80101777 <ialloc+0x47>
80101756:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010175d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101760:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101763:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101766:	53                   	push   %ebx
80101767:	e8 84 ea ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010176c:	83 c4 10             	add    $0x10,%esp
8010176f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
80101775:	73 69                	jae    801017e0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101777:	89 f8                	mov    %edi,%eax
80101779:	83 ec 08             	sub    $0x8,%esp
8010177c:	c1 e8 03             	shr    $0x3,%eax
8010177f:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101785:	50                   	push   %eax
80101786:	56                   	push   %esi
80101787:	e8 44 e9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010178c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010178f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101791:	89 f8                	mov    %edi,%eax
80101793:	83 e0 07             	and    $0x7,%eax
80101796:	c1 e0 06             	shl    $0x6,%eax
80101799:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010179d:	66 83 39 00          	cmpw   $0x0,(%ecx)
801017a1:	75 bd                	jne    80101760 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801017a3:	83 ec 04             	sub    $0x4,%esp
801017a6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801017a9:	6a 40                	push   $0x40
801017ab:	6a 00                	push   $0x0
801017ad:	51                   	push   %ecx
801017ae:	e8 3d 32 00 00       	call   801049f0 <memset>
      dip->type = type;
801017b3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801017b7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801017ba:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801017bd:	89 1c 24             	mov    %ebx,(%esp)
801017c0:	e8 9b 18 00 00       	call   80103060 <log_write>
      brelse(bp);
801017c5:	89 1c 24             	mov    %ebx,(%esp)
801017c8:	e8 23 ea ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801017cd:	83 c4 10             	add    $0x10,%esp
}
801017d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801017d3:	89 fa                	mov    %edi,%edx
}
801017d5:	5b                   	pop    %ebx
      return iget(dev, inum);
801017d6:	89 f0                	mov    %esi,%eax
}
801017d8:	5e                   	pop    %esi
801017d9:	5f                   	pop    %edi
801017da:	5d                   	pop    %ebp
      return iget(dev, inum);
801017db:	e9 a0 fc ff ff       	jmp    80101480 <iget>
  panic("ialloc: no inodes");
801017e0:	83 ec 0c             	sub    $0xc,%esp
801017e3:	68 18 79 10 80       	push   $0x80107918
801017e8:	e8 93 eb ff ff       	call   80100380 <panic>
801017ed:	8d 76 00             	lea    0x0(%esi),%esi

801017f0 <iupdate>:
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	56                   	push   %esi
801017f4:	53                   	push   %ebx
801017f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017f8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017fb:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017fe:	83 ec 08             	sub    $0x8,%esp
80101801:	c1 e8 03             	shr    $0x3,%eax
80101804:	03 05 c8 25 11 80    	add    0x801125c8,%eax
8010180a:	50                   	push   %eax
8010180b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010180e:	e8 bd e8 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101813:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101817:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010181a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010181c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010181f:	83 e0 07             	and    $0x7,%eax
80101822:	c1 e0 06             	shl    $0x6,%eax
80101825:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101829:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010182c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101830:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101833:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101837:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010183b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010183f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101843:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101847:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010184a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010184d:	6a 34                	push   $0x34
8010184f:	53                   	push   %ebx
80101850:	50                   	push   %eax
80101851:	e8 3a 32 00 00       	call   80104a90 <memmove>
  log_write(bp);
80101856:	89 34 24             	mov    %esi,(%esp)
80101859:	e8 02 18 00 00       	call   80103060 <log_write>
  brelse(bp);
8010185e:	89 75 08             	mov    %esi,0x8(%ebp)
80101861:	83 c4 10             	add    $0x10,%esp
}
80101864:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101867:	5b                   	pop    %ebx
80101868:	5e                   	pop    %esi
80101869:	5d                   	pop    %ebp
  brelse(bp);
8010186a:	e9 81 e9 ff ff       	jmp    801001f0 <brelse>
8010186f:	90                   	nop

80101870 <idup>:
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	53                   	push   %ebx
80101874:	83 ec 10             	sub    $0x10,%esp
80101877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010187a:	68 60 09 11 80       	push   $0x80110960
8010187f:	e8 ac 30 00 00       	call   80104930 <acquire>
  ip->ref++;
80101884:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101888:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010188f:	e8 3c 30 00 00       	call   801048d0 <release>
}
80101894:	89 d8                	mov    %ebx,%eax
80101896:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101899:	c9                   	leave  
8010189a:	c3                   	ret    
8010189b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010189f:	90                   	nop

801018a0 <ilock>:
{
801018a0:	55                   	push   %ebp
801018a1:	89 e5                	mov    %esp,%ebp
801018a3:	56                   	push   %esi
801018a4:	53                   	push   %ebx
801018a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801018a8:	85 db                	test   %ebx,%ebx
801018aa:	0f 84 b7 00 00 00    	je     80101967 <ilock+0xc7>
801018b0:	8b 53 08             	mov    0x8(%ebx),%edx
801018b3:	85 d2                	test   %edx,%edx
801018b5:	0f 8e ac 00 00 00    	jle    80101967 <ilock+0xc7>
  acquiresleep(&ip->lock);
801018bb:	83 ec 0c             	sub    $0xc,%esp
801018be:	8d 43 0c             	lea    0xc(%ebx),%eax
801018c1:	50                   	push   %eax
801018c2:	e8 a9 2d 00 00       	call   80104670 <acquiresleep>
  if(ip->valid == 0){
801018c7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801018ca:	83 c4 10             	add    $0x10,%esp
801018cd:	85 c0                	test   %eax,%eax
801018cf:	74 0f                	je     801018e0 <ilock+0x40>
}
801018d1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018d4:	5b                   	pop    %ebx
801018d5:	5e                   	pop    %esi
801018d6:	5d                   	pop    %ebp
801018d7:	c3                   	ret    
801018d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018df:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018e0:	8b 43 04             	mov    0x4(%ebx),%eax
801018e3:	83 ec 08             	sub    $0x8,%esp
801018e6:	c1 e8 03             	shr    $0x3,%eax
801018e9:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801018ef:	50                   	push   %eax
801018f0:	ff 33                	pushl  (%ebx)
801018f2:	e8 d9 e7 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018f7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018fa:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018fc:	8b 43 04             	mov    0x4(%ebx),%eax
801018ff:	83 e0 07             	and    $0x7,%eax
80101902:	c1 e0 06             	shl    $0x6,%eax
80101905:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101909:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010190c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010190f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101913:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101917:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010191b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010191f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101923:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101927:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010192b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010192e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101931:	6a 34                	push   $0x34
80101933:	50                   	push   %eax
80101934:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101937:	50                   	push   %eax
80101938:	e8 53 31 00 00       	call   80104a90 <memmove>
    brelse(bp);
8010193d:	89 34 24             	mov    %esi,(%esp)
80101940:	e8 ab e8 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101945:	83 c4 10             	add    $0x10,%esp
80101948:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010194d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101954:	0f 85 77 ff ff ff    	jne    801018d1 <ilock+0x31>
      panic("ilock: no type");
8010195a:	83 ec 0c             	sub    $0xc,%esp
8010195d:	68 30 79 10 80       	push   $0x80107930
80101962:	e8 19 ea ff ff       	call   80100380 <panic>
    panic("ilock");
80101967:	83 ec 0c             	sub    $0xc,%esp
8010196a:	68 2a 79 10 80       	push   $0x8010792a
8010196f:	e8 0c ea ff ff       	call   80100380 <panic>
80101974:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010197b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010197f:	90                   	nop

80101980 <iunlock>:
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	56                   	push   %esi
80101984:	53                   	push   %ebx
80101985:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101988:	85 db                	test   %ebx,%ebx
8010198a:	74 28                	je     801019b4 <iunlock+0x34>
8010198c:	83 ec 0c             	sub    $0xc,%esp
8010198f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101992:	56                   	push   %esi
80101993:	e8 78 2d 00 00       	call   80104710 <holdingsleep>
80101998:	83 c4 10             	add    $0x10,%esp
8010199b:	85 c0                	test   %eax,%eax
8010199d:	74 15                	je     801019b4 <iunlock+0x34>
8010199f:	8b 43 08             	mov    0x8(%ebx),%eax
801019a2:	85 c0                	test   %eax,%eax
801019a4:	7e 0e                	jle    801019b4 <iunlock+0x34>
  releasesleep(&ip->lock);
801019a6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801019a9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019ac:	5b                   	pop    %ebx
801019ad:	5e                   	pop    %esi
801019ae:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801019af:	e9 1c 2d 00 00       	jmp    801046d0 <releasesleep>
    panic("iunlock");
801019b4:	83 ec 0c             	sub    $0xc,%esp
801019b7:	68 3f 79 10 80       	push   $0x8010793f
801019bc:	e8 bf e9 ff ff       	call   80100380 <panic>
801019c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019cf:	90                   	nop

801019d0 <iput>:
{
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	57                   	push   %edi
801019d4:	56                   	push   %esi
801019d5:	53                   	push   %ebx
801019d6:	83 ec 28             	sub    $0x28,%esp
801019d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801019dc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801019df:	57                   	push   %edi
801019e0:	e8 8b 2c 00 00       	call   80104670 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801019e5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801019e8:	83 c4 10             	add    $0x10,%esp
801019eb:	85 d2                	test   %edx,%edx
801019ed:	74 07                	je     801019f6 <iput+0x26>
801019ef:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801019f4:	74 32                	je     80101a28 <iput+0x58>
  releasesleep(&ip->lock);
801019f6:	83 ec 0c             	sub    $0xc,%esp
801019f9:	57                   	push   %edi
801019fa:	e8 d1 2c 00 00       	call   801046d0 <releasesleep>
  acquire(&icache.lock);
801019ff:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101a06:	e8 25 2f 00 00       	call   80104930 <acquire>
  ip->ref--;
80101a0b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101a0f:	83 c4 10             	add    $0x10,%esp
80101a12:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
80101a19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a1c:	5b                   	pop    %ebx
80101a1d:	5e                   	pop    %esi
80101a1e:	5f                   	pop    %edi
80101a1f:	5d                   	pop    %ebp
  release(&icache.lock);
80101a20:	e9 ab 2e 00 00       	jmp    801048d0 <release>
80101a25:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101a28:	83 ec 0c             	sub    $0xc,%esp
80101a2b:	68 60 09 11 80       	push   $0x80110960
80101a30:	e8 fb 2e 00 00       	call   80104930 <acquire>
    int r = ip->ref;
80101a35:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101a38:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101a3f:	e8 8c 2e 00 00       	call   801048d0 <release>
    if(r == 1){
80101a44:	83 c4 10             	add    $0x10,%esp
80101a47:	83 fe 01             	cmp    $0x1,%esi
80101a4a:	75 aa                	jne    801019f6 <iput+0x26>
80101a4c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101a52:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a55:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101a58:	89 cf                	mov    %ecx,%edi
80101a5a:	eb 0b                	jmp    80101a67 <iput+0x97>
80101a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a60:	83 c6 04             	add    $0x4,%esi
80101a63:	39 fe                	cmp    %edi,%esi
80101a65:	74 19                	je     80101a80 <iput+0xb0>
    if(ip->addrs[i]){
80101a67:	8b 16                	mov    (%esi),%edx
80101a69:	85 d2                	test   %edx,%edx
80101a6b:	74 f3                	je     80101a60 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101a6d:	8b 03                	mov    (%ebx),%eax
80101a6f:	e8 7c f8 ff ff       	call   801012f0 <bfree>
      ip->addrs[i] = 0;
80101a74:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101a7a:	eb e4                	jmp    80101a60 <iput+0x90>
80101a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101a80:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101a86:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a89:	85 c0                	test   %eax,%eax
80101a8b:	75 2d                	jne    80101aba <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101a8d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101a90:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101a97:	53                   	push   %ebx
80101a98:	e8 53 fd ff ff       	call   801017f0 <iupdate>
      ip->type = 0;
80101a9d:	31 c0                	xor    %eax,%eax
80101a9f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101aa3:	89 1c 24             	mov    %ebx,(%esp)
80101aa6:	e8 45 fd ff ff       	call   801017f0 <iupdate>
      ip->valid = 0;
80101aab:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101ab2:	83 c4 10             	add    $0x10,%esp
80101ab5:	e9 3c ff ff ff       	jmp    801019f6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101aba:	83 ec 08             	sub    $0x8,%esp
80101abd:	50                   	push   %eax
80101abe:	ff 33                	pushl  (%ebx)
80101ac0:	e8 0b e6 ff ff       	call   801000d0 <bread>
80101ac5:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101ac8:	83 c4 10             	add    $0x10,%esp
80101acb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101ad1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101ad4:	8d 70 5c             	lea    0x5c(%eax),%esi
80101ad7:	89 cf                	mov    %ecx,%edi
80101ad9:	eb 0c                	jmp    80101ae7 <iput+0x117>
80101adb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101adf:	90                   	nop
80101ae0:	83 c6 04             	add    $0x4,%esi
80101ae3:	39 f7                	cmp    %esi,%edi
80101ae5:	74 0f                	je     80101af6 <iput+0x126>
      if(a[j])
80101ae7:	8b 16                	mov    (%esi),%edx
80101ae9:	85 d2                	test   %edx,%edx
80101aeb:	74 f3                	je     80101ae0 <iput+0x110>
        bfree(ip->dev, a[j]);
80101aed:	8b 03                	mov    (%ebx),%eax
80101aef:	e8 fc f7 ff ff       	call   801012f0 <bfree>
80101af4:	eb ea                	jmp    80101ae0 <iput+0x110>
    brelse(bp);
80101af6:	83 ec 0c             	sub    $0xc,%esp
80101af9:	ff 75 e4             	pushl  -0x1c(%ebp)
80101afc:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101aff:	e8 ec e6 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101b04:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101b0a:	8b 03                	mov    (%ebx),%eax
80101b0c:	e8 df f7 ff ff       	call   801012f0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101b11:	83 c4 10             	add    $0x10,%esp
80101b14:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101b1b:	00 00 00 
80101b1e:	e9 6a ff ff ff       	jmp    80101a8d <iput+0xbd>
80101b23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101b30 <iunlockput>:
{
80101b30:	55                   	push   %ebp
80101b31:	89 e5                	mov    %esp,%ebp
80101b33:	56                   	push   %esi
80101b34:	53                   	push   %ebx
80101b35:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101b38:	85 db                	test   %ebx,%ebx
80101b3a:	74 34                	je     80101b70 <iunlockput+0x40>
80101b3c:	83 ec 0c             	sub    $0xc,%esp
80101b3f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101b42:	56                   	push   %esi
80101b43:	e8 c8 2b 00 00       	call   80104710 <holdingsleep>
80101b48:	83 c4 10             	add    $0x10,%esp
80101b4b:	85 c0                	test   %eax,%eax
80101b4d:	74 21                	je     80101b70 <iunlockput+0x40>
80101b4f:	8b 43 08             	mov    0x8(%ebx),%eax
80101b52:	85 c0                	test   %eax,%eax
80101b54:	7e 1a                	jle    80101b70 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101b56:	83 ec 0c             	sub    $0xc,%esp
80101b59:	56                   	push   %esi
80101b5a:	e8 71 2b 00 00       	call   801046d0 <releasesleep>
  iput(ip);
80101b5f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101b62:	83 c4 10             	add    $0x10,%esp
}
80101b65:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b68:	5b                   	pop    %ebx
80101b69:	5e                   	pop    %esi
80101b6a:	5d                   	pop    %ebp
  iput(ip);
80101b6b:	e9 60 fe ff ff       	jmp    801019d0 <iput>
    panic("iunlock");
80101b70:	83 ec 0c             	sub    $0xc,%esp
80101b73:	68 3f 79 10 80       	push   $0x8010793f
80101b78:	e8 03 e8 ff ff       	call   80100380 <panic>
80101b7d:	8d 76 00             	lea    0x0(%esi),%esi

80101b80 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101b80:	55                   	push   %ebp
80101b81:	89 e5                	mov    %esp,%ebp
80101b83:	8b 55 08             	mov    0x8(%ebp),%edx
80101b86:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101b89:	8b 0a                	mov    (%edx),%ecx
80101b8b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101b8e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101b91:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101b94:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101b98:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101b9b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101b9f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101ba3:	8b 52 58             	mov    0x58(%edx),%edx
80101ba6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101ba9:	5d                   	pop    %ebp
80101baa:	c3                   	ret    
80101bab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101baf:	90                   	nop

80101bb0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	57                   	push   %edi
80101bb4:	56                   	push   %esi
80101bb5:	53                   	push   %ebx
80101bb6:	83 ec 1c             	sub    $0x1c,%esp
80101bb9:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101bbc:	8b 45 08             	mov    0x8(%ebp),%eax
80101bbf:	8b 75 10             	mov    0x10(%ebp),%esi
80101bc2:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101bc5:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101bc8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101bcd:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bd0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101bd3:	0f 84 a7 00 00 00    	je     80101c80 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101bd9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bdc:	8b 40 58             	mov    0x58(%eax),%eax
80101bdf:	39 c6                	cmp    %eax,%esi
80101be1:	0f 87 ba 00 00 00    	ja     80101ca1 <readi+0xf1>
80101be7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101bea:	31 c9                	xor    %ecx,%ecx
80101bec:	89 da                	mov    %ebx,%edx
80101bee:	01 f2                	add    %esi,%edx
80101bf0:	0f 92 c1             	setb   %cl
80101bf3:	89 cf                	mov    %ecx,%edi
80101bf5:	0f 82 a6 00 00 00    	jb     80101ca1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101bfb:	89 c1                	mov    %eax,%ecx
80101bfd:	29 f1                	sub    %esi,%ecx
80101bff:	39 d0                	cmp    %edx,%eax
80101c01:	0f 43 cb             	cmovae %ebx,%ecx
80101c04:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c07:	85 c9                	test   %ecx,%ecx
80101c09:	74 67                	je     80101c72 <readi+0xc2>
80101c0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c0f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c10:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101c13:	89 f2                	mov    %esi,%edx
80101c15:	c1 ea 09             	shr    $0x9,%edx
80101c18:	89 d8                	mov    %ebx,%eax
80101c1a:	e8 51 f9 ff ff       	call   80101570 <bmap>
80101c1f:	83 ec 08             	sub    $0x8,%esp
80101c22:	50                   	push   %eax
80101c23:	ff 33                	pushl  (%ebx)
80101c25:	e8 a6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c2a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101c2d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c32:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c35:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101c37:	89 f0                	mov    %esi,%eax
80101c39:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c3e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c40:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101c43:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101c45:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c49:	39 d9                	cmp    %ebx,%ecx
80101c4b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c4e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c4f:	01 df                	add    %ebx,%edi
80101c51:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101c53:	50                   	push   %eax
80101c54:	ff 75 e0             	pushl  -0x20(%ebp)
80101c57:	e8 34 2e 00 00       	call   80104a90 <memmove>
    brelse(bp);
80101c5c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101c5f:	89 14 24             	mov    %edx,(%esp)
80101c62:	e8 89 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c67:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101c6a:	83 c4 10             	add    $0x10,%esp
80101c6d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101c70:	77 9e                	ja     80101c10 <readi+0x60>
  }
  return n;
80101c72:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101c75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c78:	5b                   	pop    %ebx
80101c79:	5e                   	pop    %esi
80101c7a:	5f                   	pop    %edi
80101c7b:	5d                   	pop    %ebp
80101c7c:	c3                   	ret    
80101c7d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101c80:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c84:	66 83 f8 09          	cmp    $0x9,%ax
80101c88:	77 17                	ja     80101ca1 <readi+0xf1>
80101c8a:	8b 04 c5 00 09 11 80 	mov    -0x7feef700(,%eax,8),%eax
80101c91:	85 c0                	test   %eax,%eax
80101c93:	74 0c                	je     80101ca1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101c95:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c9b:	5b                   	pop    %ebx
80101c9c:	5e                   	pop    %esi
80101c9d:	5f                   	pop    %edi
80101c9e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101c9f:	ff e0                	jmp    *%eax
      return -1;
80101ca1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ca6:	eb cd                	jmp    80101c75 <readi+0xc5>
80101ca8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101caf:	90                   	nop

80101cb0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101cb0:	55                   	push   %ebp
80101cb1:	89 e5                	mov    %esp,%ebp
80101cb3:	57                   	push   %edi
80101cb4:	56                   	push   %esi
80101cb5:	53                   	push   %ebx
80101cb6:	83 ec 1c             	sub    $0x1c,%esp
80101cb9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cbc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101cbf:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101cc2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101cc7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101cca:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ccd:	8b 75 10             	mov    0x10(%ebp),%esi
80101cd0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101cd3:	0f 84 b7 00 00 00    	je     80101d90 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101cd9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101cdc:	3b 70 58             	cmp    0x58(%eax),%esi
80101cdf:	0f 87 e7 00 00 00    	ja     80101dcc <writei+0x11c>
80101ce5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ce8:	31 d2                	xor    %edx,%edx
80101cea:	89 f8                	mov    %edi,%eax
80101cec:	01 f0                	add    %esi,%eax
80101cee:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101cf1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101cf6:	0f 87 d0 00 00 00    	ja     80101dcc <writei+0x11c>
80101cfc:	85 d2                	test   %edx,%edx
80101cfe:	0f 85 c8 00 00 00    	jne    80101dcc <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d04:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101d0b:	85 ff                	test   %edi,%edi
80101d0d:	74 72                	je     80101d81 <writei+0xd1>
80101d0f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d10:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101d13:	89 f2                	mov    %esi,%edx
80101d15:	c1 ea 09             	shr    $0x9,%edx
80101d18:	89 f8                	mov    %edi,%eax
80101d1a:	e8 51 f8 ff ff       	call   80101570 <bmap>
80101d1f:	83 ec 08             	sub    $0x8,%esp
80101d22:	50                   	push   %eax
80101d23:	ff 37                	pushl  (%edi)
80101d25:	e8 a6 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101d2a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101d2f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101d32:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d35:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101d37:	89 f0                	mov    %esi,%eax
80101d39:	83 c4 0c             	add    $0xc,%esp
80101d3c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d41:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101d43:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101d47:	39 d9                	cmp    %ebx,%ecx
80101d49:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101d4c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d4d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101d4f:	ff 75 dc             	pushl  -0x24(%ebp)
80101d52:	50                   	push   %eax
80101d53:	e8 38 2d 00 00       	call   80104a90 <memmove>
    log_write(bp);
80101d58:	89 3c 24             	mov    %edi,(%esp)
80101d5b:	e8 00 13 00 00       	call   80103060 <log_write>
    brelse(bp);
80101d60:	89 3c 24             	mov    %edi,(%esp)
80101d63:	e8 88 e4 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d68:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101d6b:	83 c4 10             	add    $0x10,%esp
80101d6e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d71:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101d74:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101d77:	77 97                	ja     80101d10 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101d79:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d7c:	3b 70 58             	cmp    0x58(%eax),%esi
80101d7f:	77 37                	ja     80101db8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101d81:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101d84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d87:	5b                   	pop    %ebx
80101d88:	5e                   	pop    %esi
80101d89:	5f                   	pop    %edi
80101d8a:	5d                   	pop    %ebp
80101d8b:	c3                   	ret    
80101d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101d90:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101d94:	66 83 f8 09          	cmp    $0x9,%ax
80101d98:	77 32                	ja     80101dcc <writei+0x11c>
80101d9a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101da1:	85 c0                	test   %eax,%eax
80101da3:	74 27                	je     80101dcc <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101da5:	89 55 10             	mov    %edx,0x10(%ebp)
}
80101da8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dab:	5b                   	pop    %ebx
80101dac:	5e                   	pop    %esi
80101dad:	5f                   	pop    %edi
80101dae:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101daf:	ff e0                	jmp    *%eax
80101db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101db8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101dbb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101dbe:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101dc1:	50                   	push   %eax
80101dc2:	e8 29 fa ff ff       	call   801017f0 <iupdate>
80101dc7:	83 c4 10             	add    $0x10,%esp
80101dca:	eb b5                	jmp    80101d81 <writei+0xd1>
      return -1;
80101dcc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101dd1:	eb b1                	jmp    80101d84 <writei+0xd4>
80101dd3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101de0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101de0:	55                   	push   %ebp
80101de1:	89 e5                	mov    %esp,%ebp
80101de3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101de6:	6a 0e                	push   $0xe
80101de8:	ff 75 0c             	pushl  0xc(%ebp)
80101deb:	ff 75 08             	pushl  0x8(%ebp)
80101dee:	e8 0d 2d 00 00       	call   80104b00 <strncmp>
}
80101df3:	c9                   	leave  
80101df4:	c3                   	ret    
80101df5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e00 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	57                   	push   %edi
80101e04:	56                   	push   %esi
80101e05:	53                   	push   %ebx
80101e06:	83 ec 1c             	sub    $0x1c,%esp
80101e09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101e0c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101e11:	0f 85 85 00 00 00    	jne    80101e9c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101e17:	8b 53 58             	mov    0x58(%ebx),%edx
80101e1a:	31 ff                	xor    %edi,%edi
80101e1c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e1f:	85 d2                	test   %edx,%edx
80101e21:	74 3e                	je     80101e61 <dirlookup+0x61>
80101e23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e27:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e28:	6a 10                	push   $0x10
80101e2a:	57                   	push   %edi
80101e2b:	56                   	push   %esi
80101e2c:	53                   	push   %ebx
80101e2d:	e8 7e fd ff ff       	call   80101bb0 <readi>
80101e32:	83 c4 10             	add    $0x10,%esp
80101e35:	83 f8 10             	cmp    $0x10,%eax
80101e38:	75 55                	jne    80101e8f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101e3a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e3f:	74 18                	je     80101e59 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101e41:	83 ec 04             	sub    $0x4,%esp
80101e44:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e47:	6a 0e                	push   $0xe
80101e49:	50                   	push   %eax
80101e4a:	ff 75 0c             	pushl  0xc(%ebp)
80101e4d:	e8 ae 2c 00 00       	call   80104b00 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101e52:	83 c4 10             	add    $0x10,%esp
80101e55:	85 c0                	test   %eax,%eax
80101e57:	74 17                	je     80101e70 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e59:	83 c7 10             	add    $0x10,%edi
80101e5c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e5f:	72 c7                	jb     80101e28 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101e61:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101e64:	31 c0                	xor    %eax,%eax
}
80101e66:	5b                   	pop    %ebx
80101e67:	5e                   	pop    %esi
80101e68:	5f                   	pop    %edi
80101e69:	5d                   	pop    %ebp
80101e6a:	c3                   	ret    
80101e6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e6f:	90                   	nop
      if(poff)
80101e70:	8b 45 10             	mov    0x10(%ebp),%eax
80101e73:	85 c0                	test   %eax,%eax
80101e75:	74 05                	je     80101e7c <dirlookup+0x7c>
        *poff = off;
80101e77:	8b 45 10             	mov    0x10(%ebp),%eax
80101e7a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101e7c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101e80:	8b 03                	mov    (%ebx),%eax
80101e82:	e8 f9 f5 ff ff       	call   80101480 <iget>
}
80101e87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e8a:	5b                   	pop    %ebx
80101e8b:	5e                   	pop    %esi
80101e8c:	5f                   	pop    %edi
80101e8d:	5d                   	pop    %ebp
80101e8e:	c3                   	ret    
      panic("dirlookup read");
80101e8f:	83 ec 0c             	sub    $0xc,%esp
80101e92:	68 59 79 10 80       	push   $0x80107959
80101e97:	e8 e4 e4 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101e9c:	83 ec 0c             	sub    $0xc,%esp
80101e9f:	68 47 79 10 80       	push   $0x80107947
80101ea4:	e8 d7 e4 ff ff       	call   80100380 <panic>
80101ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101eb0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101eb0:	55                   	push   %ebp
80101eb1:	89 e5                	mov    %esp,%ebp
80101eb3:	57                   	push   %edi
80101eb4:	56                   	push   %esi
80101eb5:	53                   	push   %ebx
80101eb6:	89 c3                	mov    %eax,%ebx
80101eb8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101ebb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101ebe:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ec1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101ec4:	0f 84 64 01 00 00    	je     8010202e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101eca:	e8 d1 1b 00 00       	call   80103aa0 <myproc>
  acquire(&icache.lock);
80101ecf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101ed2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ed5:	68 60 09 11 80       	push   $0x80110960
80101eda:	e8 51 2a 00 00       	call   80104930 <acquire>
  ip->ref++;
80101edf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ee3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101eea:	e8 e1 29 00 00       	call   801048d0 <release>
80101eef:	83 c4 10             	add    $0x10,%esp
80101ef2:	eb 07                	jmp    80101efb <namex+0x4b>
80101ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101ef8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101efb:	0f b6 03             	movzbl (%ebx),%eax
80101efe:	3c 2f                	cmp    $0x2f,%al
80101f00:	74 f6                	je     80101ef8 <namex+0x48>
  if(*path == 0)
80101f02:	84 c0                	test   %al,%al
80101f04:	0f 84 06 01 00 00    	je     80102010 <namex+0x160>
  while(*path != '/' && *path != 0)
80101f0a:	0f b6 03             	movzbl (%ebx),%eax
80101f0d:	84 c0                	test   %al,%al
80101f0f:	0f 84 10 01 00 00    	je     80102025 <namex+0x175>
80101f15:	89 df                	mov    %ebx,%edi
80101f17:	3c 2f                	cmp    $0x2f,%al
80101f19:	0f 84 06 01 00 00    	je     80102025 <namex+0x175>
80101f1f:	90                   	nop
80101f20:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101f24:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101f27:	3c 2f                	cmp    $0x2f,%al
80101f29:	74 04                	je     80101f2f <namex+0x7f>
80101f2b:	84 c0                	test   %al,%al
80101f2d:	75 f1                	jne    80101f20 <namex+0x70>
  len = path - s;
80101f2f:	89 f8                	mov    %edi,%eax
80101f31:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101f33:	83 f8 0d             	cmp    $0xd,%eax
80101f36:	0f 8e ac 00 00 00    	jle    80101fe8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101f3c:	83 ec 04             	sub    $0x4,%esp
80101f3f:	6a 0e                	push   $0xe
80101f41:	53                   	push   %ebx
    path++;
80101f42:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80101f44:	ff 75 e4             	pushl  -0x1c(%ebp)
80101f47:	e8 44 2b 00 00       	call   80104a90 <memmove>
80101f4c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101f4f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101f52:	75 0c                	jne    80101f60 <namex+0xb0>
80101f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101f58:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101f5b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101f5e:	74 f8                	je     80101f58 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101f60:	83 ec 0c             	sub    $0xc,%esp
80101f63:	56                   	push   %esi
80101f64:	e8 37 f9 ff ff       	call   801018a0 <ilock>
    if(ip->type != T_DIR){
80101f69:	83 c4 10             	add    $0x10,%esp
80101f6c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101f71:	0f 85 cd 00 00 00    	jne    80102044 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101f77:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f7a:	85 c0                	test   %eax,%eax
80101f7c:	74 09                	je     80101f87 <namex+0xd7>
80101f7e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101f81:	0f 84 22 01 00 00    	je     801020a9 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101f87:	83 ec 04             	sub    $0x4,%esp
80101f8a:	6a 00                	push   $0x0
80101f8c:	ff 75 e4             	pushl  -0x1c(%ebp)
80101f8f:	56                   	push   %esi
80101f90:	e8 6b fe ff ff       	call   80101e00 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f95:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80101f98:	83 c4 10             	add    $0x10,%esp
80101f9b:	89 c7                	mov    %eax,%edi
80101f9d:	85 c0                	test   %eax,%eax
80101f9f:	0f 84 e1 00 00 00    	je     80102086 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fa5:	83 ec 0c             	sub    $0xc,%esp
80101fa8:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101fab:	52                   	push   %edx
80101fac:	e8 5f 27 00 00       	call   80104710 <holdingsleep>
80101fb1:	83 c4 10             	add    $0x10,%esp
80101fb4:	85 c0                	test   %eax,%eax
80101fb6:	0f 84 30 01 00 00    	je     801020ec <namex+0x23c>
80101fbc:	8b 56 08             	mov    0x8(%esi),%edx
80101fbf:	85 d2                	test   %edx,%edx
80101fc1:	0f 8e 25 01 00 00    	jle    801020ec <namex+0x23c>
  releasesleep(&ip->lock);
80101fc7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101fca:	83 ec 0c             	sub    $0xc,%esp
80101fcd:	52                   	push   %edx
80101fce:	e8 fd 26 00 00       	call   801046d0 <releasesleep>
  iput(ip);
80101fd3:	89 34 24             	mov    %esi,(%esp)
80101fd6:	89 fe                	mov    %edi,%esi
80101fd8:	e8 f3 f9 ff ff       	call   801019d0 <iput>
80101fdd:	83 c4 10             	add    $0x10,%esp
80101fe0:	e9 16 ff ff ff       	jmp    80101efb <namex+0x4b>
80101fe5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101fe8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101feb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80101fee:	83 ec 04             	sub    $0x4,%esp
80101ff1:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101ff4:	50                   	push   %eax
80101ff5:	53                   	push   %ebx
    name[len] = 0;
80101ff6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101ff8:	ff 75 e4             	pushl  -0x1c(%ebp)
80101ffb:	e8 90 2a 00 00       	call   80104a90 <memmove>
    name[len] = 0;
80102000:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102003:	83 c4 10             	add    $0x10,%esp
80102006:	c6 02 00             	movb   $0x0,(%edx)
80102009:	e9 41 ff ff ff       	jmp    80101f4f <namex+0x9f>
8010200e:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102010:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102013:	85 c0                	test   %eax,%eax
80102015:	0f 85 be 00 00 00    	jne    801020d9 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
8010201b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010201e:	89 f0                	mov    %esi,%eax
80102020:	5b                   	pop    %ebx
80102021:	5e                   	pop    %esi
80102022:	5f                   	pop    %edi
80102023:	5d                   	pop    %ebp
80102024:	c3                   	ret    
  while(*path != '/' && *path != 0)
80102025:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102028:	89 df                	mov    %ebx,%edi
8010202a:	31 c0                	xor    %eax,%eax
8010202c:	eb c0                	jmp    80101fee <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
8010202e:	ba 01 00 00 00       	mov    $0x1,%edx
80102033:	b8 01 00 00 00       	mov    $0x1,%eax
80102038:	e8 43 f4 ff ff       	call   80101480 <iget>
8010203d:	89 c6                	mov    %eax,%esi
8010203f:	e9 b7 fe ff ff       	jmp    80101efb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102044:	83 ec 0c             	sub    $0xc,%esp
80102047:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010204a:	53                   	push   %ebx
8010204b:	e8 c0 26 00 00       	call   80104710 <holdingsleep>
80102050:	83 c4 10             	add    $0x10,%esp
80102053:	85 c0                	test   %eax,%eax
80102055:	0f 84 91 00 00 00    	je     801020ec <namex+0x23c>
8010205b:	8b 46 08             	mov    0x8(%esi),%eax
8010205e:	85 c0                	test   %eax,%eax
80102060:	0f 8e 86 00 00 00    	jle    801020ec <namex+0x23c>
  releasesleep(&ip->lock);
80102066:	83 ec 0c             	sub    $0xc,%esp
80102069:	53                   	push   %ebx
8010206a:	e8 61 26 00 00       	call   801046d0 <releasesleep>
  iput(ip);
8010206f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102072:	31 f6                	xor    %esi,%esi
  iput(ip);
80102074:	e8 57 f9 ff ff       	call   801019d0 <iput>
      return 0;
80102079:	83 c4 10             	add    $0x10,%esp
}
8010207c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010207f:	89 f0                	mov    %esi,%eax
80102081:	5b                   	pop    %ebx
80102082:	5e                   	pop    %esi
80102083:	5f                   	pop    %edi
80102084:	5d                   	pop    %ebp
80102085:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102086:	83 ec 0c             	sub    $0xc,%esp
80102089:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010208c:	52                   	push   %edx
8010208d:	e8 7e 26 00 00       	call   80104710 <holdingsleep>
80102092:	83 c4 10             	add    $0x10,%esp
80102095:	85 c0                	test   %eax,%eax
80102097:	74 53                	je     801020ec <namex+0x23c>
80102099:	8b 4e 08             	mov    0x8(%esi),%ecx
8010209c:	85 c9                	test   %ecx,%ecx
8010209e:	7e 4c                	jle    801020ec <namex+0x23c>
  releasesleep(&ip->lock);
801020a0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801020a3:	83 ec 0c             	sub    $0xc,%esp
801020a6:	52                   	push   %edx
801020a7:	eb c1                	jmp    8010206a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801020a9:	83 ec 0c             	sub    $0xc,%esp
801020ac:	8d 5e 0c             	lea    0xc(%esi),%ebx
801020af:	53                   	push   %ebx
801020b0:	e8 5b 26 00 00       	call   80104710 <holdingsleep>
801020b5:	83 c4 10             	add    $0x10,%esp
801020b8:	85 c0                	test   %eax,%eax
801020ba:	74 30                	je     801020ec <namex+0x23c>
801020bc:	8b 7e 08             	mov    0x8(%esi),%edi
801020bf:	85 ff                	test   %edi,%edi
801020c1:	7e 29                	jle    801020ec <namex+0x23c>
  releasesleep(&ip->lock);
801020c3:	83 ec 0c             	sub    $0xc,%esp
801020c6:	53                   	push   %ebx
801020c7:	e8 04 26 00 00       	call   801046d0 <releasesleep>
}
801020cc:	83 c4 10             	add    $0x10,%esp
}
801020cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020d2:	89 f0                	mov    %esi,%eax
801020d4:	5b                   	pop    %ebx
801020d5:	5e                   	pop    %esi
801020d6:	5f                   	pop    %edi
801020d7:	5d                   	pop    %ebp
801020d8:	c3                   	ret    
    iput(ip);
801020d9:	83 ec 0c             	sub    $0xc,%esp
801020dc:	56                   	push   %esi
    return 0;
801020dd:	31 f6                	xor    %esi,%esi
    iput(ip);
801020df:	e8 ec f8 ff ff       	call   801019d0 <iput>
    return 0;
801020e4:	83 c4 10             	add    $0x10,%esp
801020e7:	e9 2f ff ff ff       	jmp    8010201b <namex+0x16b>
    panic("iunlock");
801020ec:	83 ec 0c             	sub    $0xc,%esp
801020ef:	68 3f 79 10 80       	push   $0x8010793f
801020f4:	e8 87 e2 ff ff       	call   80100380 <panic>
801020f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102100 <dirlink>:
{
80102100:	55                   	push   %ebp
80102101:	89 e5                	mov    %esp,%ebp
80102103:	57                   	push   %edi
80102104:	56                   	push   %esi
80102105:	53                   	push   %ebx
80102106:	83 ec 20             	sub    $0x20,%esp
80102109:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010210c:	6a 00                	push   $0x0
8010210e:	ff 75 0c             	pushl  0xc(%ebp)
80102111:	53                   	push   %ebx
80102112:	e8 e9 fc ff ff       	call   80101e00 <dirlookup>
80102117:	83 c4 10             	add    $0x10,%esp
8010211a:	85 c0                	test   %eax,%eax
8010211c:	75 67                	jne    80102185 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010211e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102121:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102124:	85 ff                	test   %edi,%edi
80102126:	74 29                	je     80102151 <dirlink+0x51>
80102128:	31 ff                	xor    %edi,%edi
8010212a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010212d:	eb 09                	jmp    80102138 <dirlink+0x38>
8010212f:	90                   	nop
80102130:	83 c7 10             	add    $0x10,%edi
80102133:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102136:	73 19                	jae    80102151 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102138:	6a 10                	push   $0x10
8010213a:	57                   	push   %edi
8010213b:	56                   	push   %esi
8010213c:	53                   	push   %ebx
8010213d:	e8 6e fa ff ff       	call   80101bb0 <readi>
80102142:	83 c4 10             	add    $0x10,%esp
80102145:	83 f8 10             	cmp    $0x10,%eax
80102148:	75 4e                	jne    80102198 <dirlink+0x98>
    if(de.inum == 0)
8010214a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010214f:	75 df                	jne    80102130 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102151:	83 ec 04             	sub    $0x4,%esp
80102154:	8d 45 da             	lea    -0x26(%ebp),%eax
80102157:	6a 0e                	push   $0xe
80102159:	ff 75 0c             	pushl  0xc(%ebp)
8010215c:	50                   	push   %eax
8010215d:	e8 ee 29 00 00       	call   80104b50 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102162:	6a 10                	push   $0x10
  de.inum = inum;
80102164:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102167:	57                   	push   %edi
80102168:	56                   	push   %esi
80102169:	53                   	push   %ebx
  de.inum = inum;
8010216a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010216e:	e8 3d fb ff ff       	call   80101cb0 <writei>
80102173:	83 c4 20             	add    $0x20,%esp
80102176:	83 f8 10             	cmp    $0x10,%eax
80102179:	75 2a                	jne    801021a5 <dirlink+0xa5>
  return 0;
8010217b:	31 c0                	xor    %eax,%eax
}
8010217d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102180:	5b                   	pop    %ebx
80102181:	5e                   	pop    %esi
80102182:	5f                   	pop    %edi
80102183:	5d                   	pop    %ebp
80102184:	c3                   	ret    
    iput(ip);
80102185:	83 ec 0c             	sub    $0xc,%esp
80102188:	50                   	push   %eax
80102189:	e8 42 f8 ff ff       	call   801019d0 <iput>
    return -1;
8010218e:	83 c4 10             	add    $0x10,%esp
80102191:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102196:	eb e5                	jmp    8010217d <dirlink+0x7d>
      panic("dirlink read");
80102198:	83 ec 0c             	sub    $0xc,%esp
8010219b:	68 68 79 10 80       	push   $0x80107968
801021a0:	e8 db e1 ff ff       	call   80100380 <panic>
    panic("dirlink");
801021a5:	83 ec 0c             	sub    $0xc,%esp
801021a8:	68 4e 7f 10 80       	push   $0x80107f4e
801021ad:	e8 ce e1 ff ff       	call   80100380 <panic>
801021b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021c0 <namei>:

struct inode*
namei(char *path)
{
801021c0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801021c1:	31 d2                	xor    %edx,%edx
{
801021c3:	89 e5                	mov    %esp,%ebp
801021c5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801021c8:	8b 45 08             	mov    0x8(%ebp),%eax
801021cb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801021ce:	e8 dd fc ff ff       	call   80101eb0 <namex>
}
801021d3:	c9                   	leave  
801021d4:	c3                   	ret    
801021d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801021e0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801021e0:	55                   	push   %ebp
  return namex(path, 1, name);
801021e1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801021e6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801021e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801021eb:	8b 45 08             	mov    0x8(%ebp),%eax
}
801021ee:	5d                   	pop    %ebp
  return namex(path, 1, name);
801021ef:	e9 bc fc ff ff       	jmp    80101eb0 <namex>
801021f4:	66 90                	xchg   %ax,%ax
801021f6:	66 90                	xchg   %ax,%ax
801021f8:	66 90                	xchg   %ax,%ax
801021fa:	66 90                	xchg   %ax,%ax
801021fc:	66 90                	xchg   %ax,%ax
801021fe:	66 90                	xchg   %ax,%ax

80102200 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	57                   	push   %edi
80102204:	56                   	push   %esi
80102205:	53                   	push   %ebx
80102206:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102209:	85 c0                	test   %eax,%eax
8010220b:	0f 84 b4 00 00 00    	je     801022c5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102211:	8b 70 08             	mov    0x8(%eax),%esi
80102214:	89 c3                	mov    %eax,%ebx
80102216:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010221c:	0f 87 96 00 00 00    	ja     801022b8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102222:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010222e:	66 90                	xchg   %ax,%ax
80102230:	89 ca                	mov    %ecx,%edx
80102232:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102233:	83 e0 c0             	and    $0xffffffc0,%eax
80102236:	3c 40                	cmp    $0x40,%al
80102238:	75 f6                	jne    80102230 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010223a:	31 ff                	xor    %edi,%edi
8010223c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102241:	89 f8                	mov    %edi,%eax
80102243:	ee                   	out    %al,(%dx)
80102244:	b8 01 00 00 00       	mov    $0x1,%eax
80102249:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010224e:	ee                   	out    %al,(%dx)
8010224f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102254:	89 f0                	mov    %esi,%eax
80102256:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102257:	89 f0                	mov    %esi,%eax
80102259:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010225e:	c1 f8 08             	sar    $0x8,%eax
80102261:	ee                   	out    %al,(%dx)
80102262:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102267:	89 f8                	mov    %edi,%eax
80102269:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010226a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010226e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102273:	c1 e0 04             	shl    $0x4,%eax
80102276:	83 e0 10             	and    $0x10,%eax
80102279:	83 c8 e0             	or     $0xffffffe0,%eax
8010227c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010227d:	f6 03 04             	testb  $0x4,(%ebx)
80102280:	75 16                	jne    80102298 <idestart+0x98>
80102282:	b8 20 00 00 00       	mov    $0x20,%eax
80102287:	89 ca                	mov    %ecx,%edx
80102289:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010228a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010228d:	5b                   	pop    %ebx
8010228e:	5e                   	pop    %esi
8010228f:	5f                   	pop    %edi
80102290:	5d                   	pop    %ebp
80102291:	c3                   	ret    
80102292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102298:	b8 30 00 00 00       	mov    $0x30,%eax
8010229d:	89 ca                	mov    %ecx,%edx
8010229f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801022a0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801022a5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801022a8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801022ad:	fc                   	cld    
801022ae:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801022b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022b3:	5b                   	pop    %ebx
801022b4:	5e                   	pop    %esi
801022b5:	5f                   	pop    %edi
801022b6:	5d                   	pop    %ebp
801022b7:	c3                   	ret    
    panic("incorrect blockno");
801022b8:	83 ec 0c             	sub    $0xc,%esp
801022bb:	68 d4 79 10 80       	push   $0x801079d4
801022c0:	e8 bb e0 ff ff       	call   80100380 <panic>
    panic("idestart");
801022c5:	83 ec 0c             	sub    $0xc,%esp
801022c8:	68 cb 79 10 80       	push   $0x801079cb
801022cd:	e8 ae e0 ff ff       	call   80100380 <panic>
801022d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801022e0 <ideinit>:
{
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801022e6:	68 e6 79 10 80       	push   $0x801079e6
801022eb:	68 00 26 11 80       	push   $0x80112600
801022f0:	e8 6b 24 00 00       	call   80104760 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1); //enable IDE_IRQ interrupt 
801022f5:	58                   	pop    %eax
801022f6:	a1 84 27 11 80       	mov    0x80112784,%eax
801022fb:	5a                   	pop    %edx
801022fc:	83 e8 01             	sub    $0x1,%eax
801022ff:	50                   	push   %eax
80102300:	6a 0e                	push   $0xe
80102302:	e8 99 02 00 00       	call   801025a0 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102307:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010230a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010230f:	90                   	nop
80102310:	ec                   	in     (%dx),%al
80102311:	83 e0 c0             	and    $0xffffffc0,%eax
80102314:	3c 40                	cmp    $0x40,%al
80102316:	75 f8                	jne    80102310 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102318:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010231d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102322:	ee                   	out    %al,(%dx)
80102323:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102328:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010232d:	eb 06                	jmp    80102335 <ideinit+0x55>
8010232f:	90                   	nop
  for(i=0; i<1000; i++){
80102330:	83 e9 01             	sub    $0x1,%ecx
80102333:	74 0f                	je     80102344 <ideinit+0x64>
80102335:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102336:	84 c0                	test   %al,%al
80102338:	74 f6                	je     80102330 <ideinit+0x50>
      havedisk1 = 1;
8010233a:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
80102341:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102344:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102349:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010234e:	ee                   	out    %al,(%dx)
}
8010234f:	c9                   	leave  
80102350:	c3                   	ret    
80102351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102358:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010235f:	90                   	nop

80102360 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102360:	55                   	push   %ebp
80102361:	89 e5                	mov    %esp,%ebp
80102363:	57                   	push   %edi
80102364:	56                   	push   %esi
80102365:	53                   	push   %ebx
80102366:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102369:	68 00 26 11 80       	push   $0x80112600
8010236e:	e8 bd 25 00 00       	call   80104930 <acquire>

  if((b = idequeue) == 0){
80102373:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102379:	83 c4 10             	add    $0x10,%esp
8010237c:	85 db                	test   %ebx,%ebx
8010237e:	74 63                	je     801023e3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102380:	8b 43 58             	mov    0x58(%ebx),%eax
80102383:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102388:	8b 33                	mov    (%ebx),%esi
8010238a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102390:	75 2f                	jne    801023c1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102392:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102397:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010239e:	66 90                	xchg   %ax,%ax
801023a0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801023a1:	89 c1                	mov    %eax,%ecx
801023a3:	83 e1 c0             	and    $0xffffffc0,%ecx
801023a6:	80 f9 40             	cmp    $0x40,%cl
801023a9:	75 f5                	jne    801023a0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801023ab:	a8 21                	test   $0x21,%al
801023ad:	75 12                	jne    801023c1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
801023af:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801023b2:	b9 80 00 00 00       	mov    $0x80,%ecx
801023b7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801023bc:	fc                   	cld    
801023bd:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801023bf:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801023c1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801023c4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801023c7:	83 ce 02             	or     $0x2,%esi
801023ca:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801023cc:	53                   	push   %ebx
801023cd:	e8 6e 1e 00 00       	call   80104240 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801023d2:	a1 e4 25 11 80       	mov    0x801125e4,%eax
801023d7:	83 c4 10             	add    $0x10,%esp
801023da:	85 c0                	test   %eax,%eax
801023dc:	74 05                	je     801023e3 <ideintr+0x83>
    idestart(idequeue);
801023de:	e8 1d fe ff ff       	call   80102200 <idestart>
    release(&idelock);
801023e3:	83 ec 0c             	sub    $0xc,%esp
801023e6:	68 00 26 11 80       	push   $0x80112600
801023eb:	e8 e0 24 00 00       	call   801048d0 <release>

  release(&idelock);
}
801023f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023f3:	5b                   	pop    %ebx
801023f4:	5e                   	pop    %esi
801023f5:	5f                   	pop    %edi
801023f6:	5d                   	pop    %ebp
801023f7:	c3                   	ret    
801023f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023ff:	90                   	nop

80102400 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b) //updates the locked buffer as indicated by the flag.
{
80102400:	55                   	push   %ebp
80102401:	89 e5                	mov    %esp,%ebp
80102403:	53                   	push   %ebx
80102404:	83 ec 10             	sub    $0x10,%esp
80102407:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010240a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010240d:	50                   	push   %eax
8010240e:	e8 fd 22 00 00       	call   80104710 <holdingsleep>
80102413:	83 c4 10             	add    $0x10,%esp
80102416:	85 c0                	test   %eax,%eax
80102418:	0f 84 c3 00 00 00    	je     801024e1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010241e:	8b 03                	mov    (%ebx),%eax
80102420:	83 e0 06             	and    $0x6,%eax
80102423:	83 f8 02             	cmp    $0x2,%eax
80102426:	0f 84 a8 00 00 00    	je     801024d4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010242c:	8b 53 04             	mov    0x4(%ebx),%edx
8010242f:	85 d2                	test   %edx,%edx
80102431:	74 0d                	je     80102440 <iderw+0x40>
80102433:	a1 e0 25 11 80       	mov    0x801125e0,%eax
80102438:	85 c0                	test   %eax,%eax
8010243a:	0f 84 87 00 00 00    	je     801024c7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102440:	83 ec 0c             	sub    $0xc,%esp
80102443:	68 00 26 11 80       	push   $0x80112600
80102448:	e8 e3 24 00 00       	call   80104930 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010244d:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
80102452:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102459:	83 c4 10             	add    $0x10,%esp
8010245c:	85 c0                	test   %eax,%eax
8010245e:	74 60                	je     801024c0 <iderw+0xc0>
80102460:	89 c2                	mov    %eax,%edx
80102462:	8b 40 58             	mov    0x58(%eax),%eax
80102465:	85 c0                	test   %eax,%eax
80102467:	75 f7                	jne    80102460 <iderw+0x60>
80102469:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010246c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010246e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
80102474:	74 3a                	je     801024b0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102476:	8b 03                	mov    (%ebx),%eax
80102478:	83 e0 06             	and    $0x6,%eax
8010247b:	83 f8 02             	cmp    $0x2,%eax
8010247e:	74 1b                	je     8010249b <iderw+0x9b>
    sleep(b, &idelock);
80102480:	83 ec 08             	sub    $0x8,%esp
80102483:	68 00 26 11 80       	push   $0x80112600
80102488:	53                   	push   %ebx
80102489:	e8 f2 1c 00 00       	call   80104180 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010248e:	8b 03                	mov    (%ebx),%eax
80102490:	83 c4 10             	add    $0x10,%esp
80102493:	83 e0 06             	and    $0x6,%eax
80102496:	83 f8 02             	cmp    $0x2,%eax
80102499:	75 e5                	jne    80102480 <iderw+0x80>
  }


  release(&idelock);
8010249b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
801024a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024a5:	c9                   	leave  
  release(&idelock);
801024a6:	e9 25 24 00 00       	jmp    801048d0 <release>
801024ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024af:	90                   	nop
    idestart(b);
801024b0:	89 d8                	mov    %ebx,%eax
801024b2:	e8 49 fd ff ff       	call   80102200 <idestart>
801024b7:	eb bd                	jmp    80102476 <iderw+0x76>
801024b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024c0:	ba e4 25 11 80       	mov    $0x801125e4,%edx
801024c5:	eb a5                	jmp    8010246c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801024c7:	83 ec 0c             	sub    $0xc,%esp
801024ca:	68 15 7a 10 80       	push   $0x80107a15
801024cf:	e8 ac de ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
801024d4:	83 ec 0c             	sub    $0xc,%esp
801024d7:	68 00 7a 10 80       	push   $0x80107a00
801024dc:	e8 9f de ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801024e1:	83 ec 0c             	sub    $0xc,%esp
801024e4:	68 ea 79 10 80       	push   $0x801079ea
801024e9:	e8 92 de ff ff       	call   80100380 <panic>
801024ee:	66 90                	xchg   %ax,%ax

801024f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801024f0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801024f1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801024f8:	00 c0 fe 
{
801024fb:	89 e5                	mov    %esp,%ebp
801024fd:	56                   	push   %esi
801024fe:	53                   	push   %ebx
  ioapic->reg = reg;
801024ff:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102506:	00 00 00 
  return ioapic->data;
80102509:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010250f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102512:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102518:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010251e:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102525:	c1 ee 10             	shr    $0x10,%esi
80102528:	89 f0                	mov    %esi,%eax
8010252a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010252d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102530:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102533:	39 c2                	cmp    %eax,%edx
80102535:	74 16                	je     8010254d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102537:	83 ec 0c             	sub    $0xc,%esp
8010253a:	68 34 7a 10 80       	push   $0x80107a34
8010253f:	e8 3c e1 ff ff       	call   80100680 <cprintf>
  ioapic->reg = reg;
80102544:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010254a:	83 c4 10             	add    $0x10,%esp
8010254d:	83 c6 21             	add    $0x21,%esi
{
80102550:	ba 10 00 00 00       	mov    $0x10,%edx
80102555:	b8 20 00 00 00       	mov    $0x20,%eax
8010255a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102560:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102562:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102564:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  for(i = 0; i <= maxintr; i++){
8010256a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010256d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102573:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102576:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80102579:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010257c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010257e:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102584:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010258b:	39 f0                	cmp    %esi,%eax
8010258d:	75 d1                	jne    80102560 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010258f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102592:	5b                   	pop    %ebx
80102593:	5e                   	pop    %esi
80102594:	5d                   	pop    %ebp
80102595:	c3                   	ret    
80102596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010259d:	8d 76 00             	lea    0x0(%esi),%esi

801025a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801025a0:	55                   	push   %ebp
  ioapic->reg = reg;
801025a1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
801025a7:	89 e5                	mov    %esp,%ebp
801025a9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801025ac:	8d 50 20             	lea    0x20(%eax),%edx
801025af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801025b3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801025b5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025bb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801025be:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801025c4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801025c6:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025cb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801025ce:	89 50 10             	mov    %edx,0x10(%eax)
}
801025d1:	5d                   	pop    %ebp
801025d2:	c3                   	ret    
801025d3:	66 90                	xchg   %ax,%ax
801025d5:	66 90                	xchg   %ax,%ax
801025d7:	66 90                	xchg   %ax,%ax
801025d9:	66 90                	xchg   %ax,%ax
801025db:	66 90                	xchg   %ax,%ax
801025dd:	66 90                	xchg   %ax,%ax
801025df:	90                   	nop

801025e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801025e0:	55                   	push   %ebp
801025e1:	89 e5                	mov    %esp,%ebp
801025e3:	53                   	push   %ebx
801025e4:	83 ec 04             	sub    $0x4,%esp
801025e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801025ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801025f0:	75 76                	jne    80102668 <kfree+0x88>
801025f2:	81 fb d0 65 11 80    	cmp    $0x801165d0,%ebx
801025f8:	72 6e                	jb     80102668 <kfree+0x88>
801025fa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102600:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102605:	77 61                	ja     80102668 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102607:	83 ec 04             	sub    $0x4,%esp
8010260a:	68 00 10 00 00       	push   $0x1000
8010260f:	6a 01                	push   $0x1
80102611:	53                   	push   %ebx
80102612:	e8 d9 23 00 00       	call   801049f0 <memset>

  if(kmem.use_lock)
80102617:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010261d:	83 c4 10             	add    $0x10,%esp
80102620:	85 d2                	test   %edx,%edx
80102622:	75 1c                	jne    80102640 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102624:	a1 78 26 11 80       	mov    0x80112678,%eax
80102629:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010262b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102630:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102636:	85 c0                	test   %eax,%eax
80102638:	75 1e                	jne    80102658 <kfree+0x78>
    release(&kmem.lock);
}
8010263a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010263d:	c9                   	leave  
8010263e:	c3                   	ret    
8010263f:	90                   	nop
    acquire(&kmem.lock);
80102640:	83 ec 0c             	sub    $0xc,%esp
80102643:	68 40 26 11 80       	push   $0x80112640
80102648:	e8 e3 22 00 00       	call   80104930 <acquire>
8010264d:	83 c4 10             	add    $0x10,%esp
80102650:	eb d2                	jmp    80102624 <kfree+0x44>
80102652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102658:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010265f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102662:	c9                   	leave  
    release(&kmem.lock);
80102663:	e9 68 22 00 00       	jmp    801048d0 <release>
    panic("kfree");
80102668:	83 ec 0c             	sub    $0xc,%esp
8010266b:	68 66 7a 10 80       	push   $0x80107a66
80102670:	e8 0b dd ff ff       	call   80100380 <panic>
80102675:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010267c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102680 <freerange>:
{
80102680:	55                   	push   %ebp
80102681:	89 e5                	mov    %esp,%ebp
80102683:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102684:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102687:	8b 75 0c             	mov    0xc(%ebp),%esi
8010268a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010268b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102691:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102697:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010269d:	39 de                	cmp    %ebx,%esi
8010269f:	72 23                	jb     801026c4 <freerange+0x44>
801026a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801026a8:	83 ec 0c             	sub    $0xc,%esp
801026ab:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026b7:	50                   	push   %eax
801026b8:	e8 23 ff ff ff       	call   801025e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026bd:	83 c4 10             	add    $0x10,%esp
801026c0:	39 f3                	cmp    %esi,%ebx
801026c2:	76 e4                	jbe    801026a8 <freerange+0x28>
}
801026c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026c7:	5b                   	pop    %ebx
801026c8:	5e                   	pop    %esi
801026c9:	5d                   	pop    %ebp
801026ca:	c3                   	ret    
801026cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026cf:	90                   	nop

801026d0 <kinit2>:
{
801026d0:	55                   	push   %ebp
801026d1:	89 e5                	mov    %esp,%ebp
801026d3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801026d4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801026d7:	8b 75 0c             	mov    0xc(%ebp),%esi
801026da:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801026db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026ed:	39 de                	cmp    %ebx,%esi
801026ef:	72 23                	jb     80102714 <kinit2+0x44>
801026f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801026f8:	83 ec 0c             	sub    $0xc,%esp
801026fb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102701:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102707:	50                   	push   %eax
80102708:	e8 d3 fe ff ff       	call   801025e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010270d:	83 c4 10             	add    $0x10,%esp
80102710:	39 de                	cmp    %ebx,%esi
80102712:	73 e4                	jae    801026f8 <kinit2+0x28>
  kmem.use_lock = 1;
80102714:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010271b:	00 00 00 
}
8010271e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102721:	5b                   	pop    %ebx
80102722:	5e                   	pop    %esi
80102723:	5d                   	pop    %ebp
80102724:	c3                   	ret    
80102725:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010272c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102730 <kinit1>:
{
80102730:	55                   	push   %ebp
80102731:	89 e5                	mov    %esp,%ebp
80102733:	56                   	push   %esi
80102734:	53                   	push   %ebx
80102735:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102738:	83 ec 08             	sub    $0x8,%esp
8010273b:	68 6c 7a 10 80       	push   $0x80107a6c
80102740:	68 40 26 11 80       	push   $0x80112640
80102745:	e8 16 20 00 00       	call   80104760 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010274a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010274d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102750:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102757:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010275a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102760:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102766:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010276c:	39 de                	cmp    %ebx,%esi
8010276e:	72 1c                	jb     8010278c <kinit1+0x5c>
    kfree(p);
80102770:	83 ec 0c             	sub    $0xc,%esp
80102773:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102779:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010277f:	50                   	push   %eax
80102780:	e8 5b fe ff ff       	call   801025e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102785:	83 c4 10             	add    $0x10,%esp
80102788:	39 de                	cmp    %ebx,%esi
8010278a:	73 e4                	jae    80102770 <kinit1+0x40>
}
8010278c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010278f:	5b                   	pop    %ebx
80102790:	5e                   	pop    %esi
80102791:	5d                   	pop    %ebp
80102792:	c3                   	ret    
80102793:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010279a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801027a0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801027a0:	a1 74 26 11 80       	mov    0x80112674,%eax
801027a5:	85 c0                	test   %eax,%eax
801027a7:	75 1f                	jne    801027c8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801027a9:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
801027ae:	85 c0                	test   %eax,%eax
801027b0:	74 0e                	je     801027c0 <kalloc+0x20>
    kmem.freelist = r->next;
801027b2:	8b 10                	mov    (%eax),%edx
801027b4:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801027ba:	c3                   	ret    
801027bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027bf:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801027c0:	c3                   	ret    
801027c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801027c8:	55                   	push   %ebp
801027c9:	89 e5                	mov    %esp,%ebp
801027cb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801027ce:	68 40 26 11 80       	push   $0x80112640
801027d3:	e8 58 21 00 00       	call   80104930 <acquire>
  r = kmem.freelist;
801027d8:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(kmem.use_lock)
801027dd:	8b 15 74 26 11 80    	mov    0x80112674,%edx
  if(r)
801027e3:	83 c4 10             	add    $0x10,%esp
801027e6:	85 c0                	test   %eax,%eax
801027e8:	74 08                	je     801027f2 <kalloc+0x52>
    kmem.freelist = r->next;
801027ea:	8b 08                	mov    (%eax),%ecx
801027ec:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
801027f2:	85 d2                	test   %edx,%edx
801027f4:	74 16                	je     8010280c <kalloc+0x6c>
    release(&kmem.lock);
801027f6:	83 ec 0c             	sub    $0xc,%esp
801027f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801027fc:	68 40 26 11 80       	push   $0x80112640
80102801:	e8 ca 20 00 00       	call   801048d0 <release>
  return (char*)r;
80102806:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102809:	83 c4 10             	add    $0x10,%esp
}
8010280c:	c9                   	leave  
8010280d:	c3                   	ret    
8010280e:	66 90                	xchg   %ax,%ax

80102810 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102810:	ba 64 00 00 00       	mov    $0x64,%edx
80102815:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102816:	a8 01                	test   $0x1,%al
80102818:	0f 84 ca 00 00 00    	je     801028e8 <kbdgetc+0xd8>
{
8010281e:	55                   	push   %ebp
8010281f:	ba 60 00 00 00       	mov    $0x60,%edx
80102824:	89 e5                	mov    %esp,%ebp
80102826:	53                   	push   %ebx
80102827:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102828:	8b 1d 7c 26 11 80    	mov    0x8011267c,%ebx
  data = inb(KBDATAP);
8010282e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102831:	3c e0                	cmp    $0xe0,%al
80102833:	74 5b                	je     80102890 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102835:	89 da                	mov    %ebx,%edx
80102837:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010283a:	84 c0                	test   %al,%al
8010283c:	78 62                	js     801028a0 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010283e:	85 d2                	test   %edx,%edx
80102840:	74 09                	je     8010284b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102842:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102845:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102848:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010284b:	0f b6 91 a0 7b 10 80 	movzbl -0x7fef8460(%ecx),%edx
  shift ^= togglecode[data];
80102852:	0f b6 81 a0 7a 10 80 	movzbl -0x7fef8560(%ecx),%eax
  shift |= shiftcode[data];
80102859:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010285b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010285d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010285f:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  c = charcode[shift & (CTL | SHIFT)][data];
80102865:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102868:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010286b:	8b 04 85 80 7a 10 80 	mov    -0x7fef8580(,%eax,4),%eax
80102872:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102876:	74 0b                	je     80102883 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102878:	8d 50 9f             	lea    -0x61(%eax),%edx
8010287b:	83 fa 19             	cmp    $0x19,%edx
8010287e:	77 50                	ja     801028d0 <kbdgetc+0xc0>
      c += 'A' - 'a';
80102880:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102883:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102886:	c9                   	leave  
80102887:	c3                   	ret    
80102888:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010288f:	90                   	nop
    shift |= E0ESC;
80102890:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102893:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102895:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
}
8010289b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010289e:	c9                   	leave  
8010289f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
801028a0:	83 e0 7f             	and    $0x7f,%eax
801028a3:	85 d2                	test   %edx,%edx
801028a5:	0f 44 c8             	cmove  %eax,%ecx
    return 0;
801028a8:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801028aa:	0f b6 91 a0 7b 10 80 	movzbl -0x7fef8460(%ecx),%edx
801028b1:	83 ca 40             	or     $0x40,%edx
801028b4:	0f b6 d2             	movzbl %dl,%edx
801028b7:	f7 d2                	not    %edx
801028b9:	21 da                	and    %ebx,%edx
}
801028bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
801028be:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
}
801028c4:	c9                   	leave  
801028c5:	c3                   	ret    
801028c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028cd:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801028d0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801028d3:	8d 50 20             	lea    0x20(%eax),%edx
}
801028d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028d9:	c9                   	leave  
      c += 'a' - 'A';
801028da:	83 f9 1a             	cmp    $0x1a,%ecx
801028dd:	0f 42 c2             	cmovb  %edx,%eax
}
801028e0:	c3                   	ret    
801028e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801028e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801028ed:	c3                   	ret    
801028ee:	66 90                	xchg   %ax,%ax

801028f0 <kbdintr>:

void
kbdintr(void)
{
801028f0:	55                   	push   %ebp
801028f1:	89 e5                	mov    %esp,%ebp
801028f3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801028f6:	68 10 28 10 80       	push   $0x80102810
801028fb:	e8 f0 df ff ff       	call   801008f0 <consoleintr>
}
80102900:	83 c4 10             	add    $0x10,%esp
80102903:	c9                   	leave  
80102904:	c3                   	ret    
80102905:	66 90                	xchg   %ax,%ax
80102907:	66 90                	xchg   %ax,%ax
80102909:	66 90                	xchg   %ax,%ax
8010290b:	66 90                	xchg   %ax,%ax
8010290d:	66 90                	xchg   %ax,%ax
8010290f:	90                   	nop

80102910 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102910:	a1 80 26 11 80       	mov    0x80112680,%eax
80102915:	85 c0                	test   %eax,%eax
80102917:	0f 84 cb 00 00 00    	je     801029e8 <lapicinit+0xd8>
  lapic[index] = value;
8010291d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102924:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102927:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010292a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102931:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102934:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102937:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010293e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102941:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102944:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010294b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010294e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102951:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102958:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010295b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010295e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102965:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102968:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010296b:	8b 50 30             	mov    0x30(%eax),%edx
8010296e:	c1 ea 10             	shr    $0x10,%edx
80102971:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102977:	75 77                	jne    801029f0 <lapicinit+0xe0>
  lapic[index] = value;
80102979:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102980:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102983:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102986:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010298d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102990:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102993:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010299a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010299d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029a0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801029a7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029aa:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029ad:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801029b4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029b7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029ba:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801029c1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801029c4:	8b 50 20             	mov    0x20(%eax),%edx
801029c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029ce:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801029d0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801029d6:	80 e6 10             	and    $0x10,%dh
801029d9:	75 f5                	jne    801029d0 <lapicinit+0xc0>
  lapic[index] = value;
801029db:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801029e2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029e5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801029e8:	c3                   	ret    
801029e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801029f0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801029f7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801029fa:	8b 50 20             	mov    0x20(%eax),%edx
}
801029fd:	e9 77 ff ff ff       	jmp    80102979 <lapicinit+0x69>
80102a02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102a10 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102a10:	a1 80 26 11 80       	mov    0x80112680,%eax
80102a15:	85 c0                	test   %eax,%eax
80102a17:	74 07                	je     80102a20 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102a19:	8b 40 20             	mov    0x20(%eax),%eax
80102a1c:	c1 e8 18             	shr    $0x18,%eax
80102a1f:	c3                   	ret    
    return 0;
80102a20:	31 c0                	xor    %eax,%eax
}
80102a22:	c3                   	ret    
80102a23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102a30 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102a30:	a1 80 26 11 80       	mov    0x80112680,%eax
80102a35:	85 c0                	test   %eax,%eax
80102a37:	74 0d                	je     80102a46 <lapiceoi+0x16>
  lapic[index] = value;
80102a39:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a40:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a43:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102a46:	c3                   	ret    
80102a47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a4e:	66 90                	xchg   %ax,%ax

80102a50 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102a50:	c3                   	ret    
80102a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a5f:	90                   	nop

80102a60 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102a60:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a61:	b8 0f 00 00 00       	mov    $0xf,%eax
80102a66:	ba 70 00 00 00       	mov    $0x70,%edx
80102a6b:	89 e5                	mov    %esp,%ebp
80102a6d:	53                   	push   %ebx
80102a6e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102a71:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102a74:	ee                   	out    %al,(%dx)
80102a75:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a7a:	ba 71 00 00 00       	mov    $0x71,%edx
80102a7f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102a80:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102a82:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102a85:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102a8b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a8d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102a90:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102a92:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a95:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102a98:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102a9e:	a1 80 26 11 80       	mov    0x80112680,%eax
80102aa3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102aa9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102aac:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102ab3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ab6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ab9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102ac0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ac3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ac6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102acc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102acf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ad5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ad8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ade:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ae1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ae7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102aea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102aed:	c9                   	leave  
80102aee:	c3                   	ret    
80102aef:	90                   	nop

80102af0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102af0:	55                   	push   %ebp
80102af1:	b8 0b 00 00 00       	mov    $0xb,%eax
80102af6:	ba 70 00 00 00       	mov    $0x70,%edx
80102afb:	89 e5                	mov    %esp,%ebp
80102afd:	57                   	push   %edi
80102afe:	56                   	push   %esi
80102aff:	53                   	push   %ebx
80102b00:	83 ec 4c             	sub    $0x4c,%esp
80102b03:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b04:	ba 71 00 00 00       	mov    $0x71,%edx
80102b09:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102b0a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b0d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102b12:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102b15:	8d 76 00             	lea    0x0(%esi),%esi
80102b18:	31 c0                	xor    %eax,%eax
80102b1a:	89 da                	mov    %ebx,%edx
80102b1c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b1d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102b22:	89 ca                	mov    %ecx,%edx
80102b24:	ec                   	in     (%dx),%al
80102b25:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b28:	89 da                	mov    %ebx,%edx
80102b2a:	b8 02 00 00 00       	mov    $0x2,%eax
80102b2f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b30:	89 ca                	mov    %ecx,%edx
80102b32:	ec                   	in     (%dx),%al
80102b33:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b36:	89 da                	mov    %ebx,%edx
80102b38:	b8 04 00 00 00       	mov    $0x4,%eax
80102b3d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b3e:	89 ca                	mov    %ecx,%edx
80102b40:	ec                   	in     (%dx),%al
80102b41:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b44:	89 da                	mov    %ebx,%edx
80102b46:	b8 07 00 00 00       	mov    $0x7,%eax
80102b4b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b4c:	89 ca                	mov    %ecx,%edx
80102b4e:	ec                   	in     (%dx),%al
80102b4f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b52:	89 da                	mov    %ebx,%edx
80102b54:	b8 08 00 00 00       	mov    $0x8,%eax
80102b59:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b5a:	89 ca                	mov    %ecx,%edx
80102b5c:	ec                   	in     (%dx),%al
80102b5d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b5f:	89 da                	mov    %ebx,%edx
80102b61:	b8 09 00 00 00       	mov    $0x9,%eax
80102b66:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b67:	89 ca                	mov    %ecx,%edx
80102b69:	ec                   	in     (%dx),%al
80102b6a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b6c:	89 da                	mov    %ebx,%edx
80102b6e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b73:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b74:	89 ca                	mov    %ecx,%edx
80102b76:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102b77:	84 c0                	test   %al,%al
80102b79:	78 9d                	js     80102b18 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102b7b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102b7f:	89 fa                	mov    %edi,%edx
80102b81:	0f b6 fa             	movzbl %dl,%edi
80102b84:	89 f2                	mov    %esi,%edx
80102b86:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102b89:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102b8d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b90:	89 da                	mov    %ebx,%edx
80102b92:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102b95:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102b98:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102b9c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102b9f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102ba2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102ba6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102ba9:	31 c0                	xor    %eax,%eax
80102bab:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bac:	89 ca                	mov    %ecx,%edx
80102bae:	ec                   	in     (%dx),%al
80102baf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bb2:	89 da                	mov    %ebx,%edx
80102bb4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102bb7:	b8 02 00 00 00       	mov    $0x2,%eax
80102bbc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bbd:	89 ca                	mov    %ecx,%edx
80102bbf:	ec                   	in     (%dx),%al
80102bc0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bc3:	89 da                	mov    %ebx,%edx
80102bc5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102bc8:	b8 04 00 00 00       	mov    $0x4,%eax
80102bcd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bce:	89 ca                	mov    %ecx,%edx
80102bd0:	ec                   	in     (%dx),%al
80102bd1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bd4:	89 da                	mov    %ebx,%edx
80102bd6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102bd9:	b8 07 00 00 00       	mov    $0x7,%eax
80102bde:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bdf:	89 ca                	mov    %ecx,%edx
80102be1:	ec                   	in     (%dx),%al
80102be2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102be5:	89 da                	mov    %ebx,%edx
80102be7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102bea:	b8 08 00 00 00       	mov    $0x8,%eax
80102bef:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bf0:	89 ca                	mov    %ecx,%edx
80102bf2:	ec                   	in     (%dx),%al
80102bf3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bf6:	89 da                	mov    %ebx,%edx
80102bf8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102bfb:	b8 09 00 00 00       	mov    $0x9,%eax
80102c00:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c01:	89 ca                	mov    %ecx,%edx
80102c03:	ec                   	in     (%dx),%al
80102c04:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c07:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102c0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c0d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102c10:	6a 18                	push   $0x18
80102c12:	50                   	push   %eax
80102c13:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102c16:	50                   	push   %eax
80102c17:	e8 24 1e 00 00       	call   80104a40 <memcmp>
80102c1c:	83 c4 10             	add    $0x10,%esp
80102c1f:	85 c0                	test   %eax,%eax
80102c21:	0f 85 f1 fe ff ff    	jne    80102b18 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102c27:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102c2b:	75 78                	jne    80102ca5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102c2d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102c30:	89 c2                	mov    %eax,%edx
80102c32:	83 e0 0f             	and    $0xf,%eax
80102c35:	c1 ea 04             	shr    $0x4,%edx
80102c38:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c3b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c3e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102c41:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102c44:	89 c2                	mov    %eax,%edx
80102c46:	83 e0 0f             	and    $0xf,%eax
80102c49:	c1 ea 04             	shr    $0x4,%edx
80102c4c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c4f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c52:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102c55:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102c58:	89 c2                	mov    %eax,%edx
80102c5a:	83 e0 0f             	and    $0xf,%eax
80102c5d:	c1 ea 04             	shr    $0x4,%edx
80102c60:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c63:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c66:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102c69:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102c6c:	89 c2                	mov    %eax,%edx
80102c6e:	83 e0 0f             	and    $0xf,%eax
80102c71:	c1 ea 04             	shr    $0x4,%edx
80102c74:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c77:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c7a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102c7d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102c80:	89 c2                	mov    %eax,%edx
80102c82:	83 e0 0f             	and    $0xf,%eax
80102c85:	c1 ea 04             	shr    $0x4,%edx
80102c88:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c8b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c8e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102c91:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102c94:	89 c2                	mov    %eax,%edx
80102c96:	83 e0 0f             	and    $0xf,%eax
80102c99:	c1 ea 04             	shr    $0x4,%edx
80102c9c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c9f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ca2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102ca5:	8b 75 08             	mov    0x8(%ebp),%esi
80102ca8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102cab:	89 06                	mov    %eax,(%esi)
80102cad:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102cb0:	89 46 04             	mov    %eax,0x4(%esi)
80102cb3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102cb6:	89 46 08             	mov    %eax,0x8(%esi)
80102cb9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102cbc:	89 46 0c             	mov    %eax,0xc(%esi)
80102cbf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102cc2:	89 46 10             	mov    %eax,0x10(%esi)
80102cc5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102cc8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102ccb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102cd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cd5:	5b                   	pop    %ebx
80102cd6:	5e                   	pop    %esi
80102cd7:	5f                   	pop    %edi
80102cd8:	5d                   	pop    %ebp
80102cd9:	c3                   	ret    
80102cda:	66 90                	xchg   %ax,%ax
80102cdc:	66 90                	xchg   %ax,%ax
80102cde:	66 90                	xchg   %ax,%ax

80102ce0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ce0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102ce6:	85 c9                	test   %ecx,%ecx
80102ce8:	0f 8e 8a 00 00 00    	jle    80102d78 <install_trans+0x98>
{
80102cee:	55                   	push   %ebp
80102cef:	89 e5                	mov    %esp,%ebp
80102cf1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102cf2:	31 ff                	xor    %edi,%edi
{
80102cf4:	56                   	push   %esi
80102cf5:	53                   	push   %ebx
80102cf6:	83 ec 0c             	sub    $0xc,%esp
80102cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102d00:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102d05:	83 ec 08             	sub    $0x8,%esp
80102d08:	01 f8                	add    %edi,%eax
80102d0a:	83 c0 01             	add    $0x1,%eax
80102d0d:	50                   	push   %eax
80102d0e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102d14:	e8 b7 d3 ff ff       	call   801000d0 <bread>
80102d19:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d1b:	58                   	pop    %eax
80102d1c:	5a                   	pop    %edx
80102d1d:	ff 34 bd ec 26 11 80 	pushl  -0x7feed914(,%edi,4)
80102d24:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102d2a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d2d:	e8 9e d3 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102d32:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d35:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102d37:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d3a:	68 00 02 00 00       	push   $0x200
80102d3f:	50                   	push   %eax
80102d40:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102d43:	50                   	push   %eax
80102d44:	e8 47 1d 00 00       	call   80104a90 <memmove>
    bwrite(dbuf);  // write dst to disk
80102d49:	89 1c 24             	mov    %ebx,(%esp)
80102d4c:	e8 5f d4 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102d51:	89 34 24             	mov    %esi,(%esp)
80102d54:	e8 97 d4 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102d59:	89 1c 24             	mov    %ebx,(%esp)
80102d5c:	e8 8f d4 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102d61:	83 c4 10             	add    $0x10,%esp
80102d64:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102d6a:	7f 94                	jg     80102d00 <install_trans+0x20>
  }
}
80102d6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d6f:	5b                   	pop    %ebx
80102d70:	5e                   	pop    %esi
80102d71:	5f                   	pop    %edi
80102d72:	5d                   	pop    %ebp
80102d73:	c3                   	ret    
80102d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d78:	c3                   	ret    
80102d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d80 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	53                   	push   %ebx
80102d84:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102d87:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102d8d:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102d93:	e8 38 d3 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102d98:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102d9e:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102da1:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102da3:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102da6:	85 c9                	test   %ecx,%ecx
80102da8:	7e 18                	jle    80102dc2 <write_head+0x42>
80102daa:	31 c0                	xor    %eax,%eax
80102dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102db0:	8b 14 85 ec 26 11 80 	mov    -0x7feed914(,%eax,4),%edx
80102db7:	89 54 83 60          	mov    %edx,0x60(%ebx,%eax,4)
  for (i = 0; i < log.lh.n; i++) {
80102dbb:	83 c0 01             	add    $0x1,%eax
80102dbe:	39 c1                	cmp    %eax,%ecx
80102dc0:	75 ee                	jne    80102db0 <write_head+0x30>
  }
  bwrite(buf);
80102dc2:	83 ec 0c             	sub    $0xc,%esp
80102dc5:	53                   	push   %ebx
80102dc6:	e8 e5 d3 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102dcb:	89 1c 24             	mov    %ebx,(%esp)
80102dce:	e8 1d d4 ff ff       	call   801001f0 <brelse>
}
80102dd3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102dd6:	83 c4 10             	add    $0x10,%esp
80102dd9:	c9                   	leave  
80102dda:	c3                   	ret    
80102ddb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ddf:	90                   	nop

80102de0 <initlog>:
{
80102de0:	55                   	push   %ebp
80102de1:	89 e5                	mov    %esp,%ebp
80102de3:	53                   	push   %ebx
80102de4:	83 ec 2c             	sub    $0x2c,%esp
80102de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102dea:	68 a0 7c 10 80       	push   $0x80107ca0
80102def:	68 a0 26 11 80       	push   $0x801126a0
80102df4:	e8 67 19 00 00       	call   80104760 <initlock>
  readsb(dev, &sb);
80102df9:	58                   	pop    %eax
80102dfa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102dfd:	5a                   	pop    %edx
80102dfe:	50                   	push   %eax
80102dff:	53                   	push   %ebx
80102e00:	e8 3b e8 ff ff       	call   80101640 <readsb>
  log.start = sb.logstart;
80102e05:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102e08:	59                   	pop    %ecx
  log.dev = dev;
80102e09:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102e0f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102e12:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102e17:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
80102e1d:	5a                   	pop    %edx
80102e1e:	50                   	push   %eax
80102e1f:	53                   	push   %ebx
80102e20:	e8 ab d2 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102e25:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102e28:	8b 58 5c             	mov    0x5c(%eax),%ebx
  struct buf *buf = bread(log.dev, log.start);
80102e2b:	89 c1                	mov    %eax,%ecx
  log.lh.n = lh->n;
80102e2d:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102e33:	85 db                	test   %ebx,%ebx
80102e35:	7e 1b                	jle    80102e52 <initlog+0x72>
80102e37:	31 c0                	xor    %eax,%eax
80102e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102e40:	8b 54 81 60          	mov    0x60(%ecx,%eax,4),%edx
80102e44:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
  for (i = 0; i < log.lh.n; i++) {
80102e4b:	83 c0 01             	add    $0x1,%eax
80102e4e:	39 c3                	cmp    %eax,%ebx
80102e50:	75 ee                	jne    80102e40 <initlog+0x60>
  brelse(buf);
80102e52:	83 ec 0c             	sub    $0xc,%esp
80102e55:	51                   	push   %ecx
80102e56:	e8 95 d3 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102e5b:	e8 80 fe ff ff       	call   80102ce0 <install_trans>
  log.lh.n = 0;
80102e60:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102e67:	00 00 00 
  write_head(); // clear the log
80102e6a:	e8 11 ff ff ff       	call   80102d80 <write_head>
}
80102e6f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e72:	83 c4 10             	add    $0x10,%esp
80102e75:	c9                   	leave  
80102e76:	c3                   	ret    
80102e77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e7e:	66 90                	xchg   %ax,%ax

80102e80 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102e80:	55                   	push   %ebp
80102e81:	89 e5                	mov    %esp,%ebp
80102e83:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102e86:	68 a0 26 11 80       	push   $0x801126a0
80102e8b:	e8 a0 1a 00 00       	call   80104930 <acquire>
80102e90:	83 c4 10             	add    $0x10,%esp
80102e93:	eb 18                	jmp    80102ead <begin_op+0x2d>
80102e95:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102e98:	83 ec 08             	sub    $0x8,%esp
80102e9b:	68 a0 26 11 80       	push   $0x801126a0
80102ea0:	68 a0 26 11 80       	push   $0x801126a0
80102ea5:	e8 d6 12 00 00       	call   80104180 <sleep>
80102eaa:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102ead:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102eb2:	85 c0                	test   %eax,%eax
80102eb4:	75 e2                	jne    80102e98 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102eb6:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102ebb:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102ec1:	83 c0 01             	add    $0x1,%eax
80102ec4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102ec7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102eca:	83 fa 1e             	cmp    $0x1e,%edx
80102ecd:	7f c9                	jg     80102e98 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102ecf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102ed2:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102ed7:	68 a0 26 11 80       	push   $0x801126a0
80102edc:	e8 ef 19 00 00       	call   801048d0 <release>
      break;
    }
  }
}
80102ee1:	83 c4 10             	add    $0x10,%esp
80102ee4:	c9                   	leave  
80102ee5:	c3                   	ret    
80102ee6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102eed:	8d 76 00             	lea    0x0(%esi),%esi

80102ef0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102ef0:	55                   	push   %ebp
80102ef1:	89 e5                	mov    %esp,%ebp
80102ef3:	57                   	push   %edi
80102ef4:	56                   	push   %esi
80102ef5:	53                   	push   %ebx
80102ef6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ef9:	68 a0 26 11 80       	push   $0x801126a0
80102efe:	e8 2d 1a 00 00       	call   80104930 <acquire>
  log.outstanding -= 1;
80102f03:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102f08:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102f0e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102f11:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102f14:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102f1a:	85 f6                	test   %esi,%esi
80102f1c:	0f 85 22 01 00 00    	jne    80103044 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102f22:	85 db                	test   %ebx,%ebx
80102f24:	0f 85 f6 00 00 00    	jne    80103020 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102f2a:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102f31:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102f34:	83 ec 0c             	sub    $0xc,%esp
80102f37:	68 a0 26 11 80       	push   $0x801126a0
80102f3c:	e8 8f 19 00 00       	call   801048d0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102f41:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102f47:	83 c4 10             	add    $0x10,%esp
80102f4a:	85 c9                	test   %ecx,%ecx
80102f4c:	7f 42                	jg     80102f90 <end_op+0xa0>
    acquire(&log.lock);
80102f4e:	83 ec 0c             	sub    $0xc,%esp
80102f51:	68 a0 26 11 80       	push   $0x801126a0
80102f56:	e8 d5 19 00 00       	call   80104930 <acquire>
    wakeup(&log);
80102f5b:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102f62:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102f69:	00 00 00 
    wakeup(&log);
80102f6c:	e8 cf 12 00 00       	call   80104240 <wakeup>
    release(&log.lock);
80102f71:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102f78:	e8 53 19 00 00       	call   801048d0 <release>
80102f7d:	83 c4 10             	add    $0x10,%esp
}
80102f80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f83:	5b                   	pop    %ebx
80102f84:	5e                   	pop    %esi
80102f85:	5f                   	pop    %edi
80102f86:	5d                   	pop    %ebp
80102f87:	c3                   	ret    
80102f88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f8f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102f90:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102f95:	83 ec 08             	sub    $0x8,%esp
80102f98:	01 d8                	add    %ebx,%eax
80102f9a:	83 c0 01             	add    $0x1,%eax
80102f9d:	50                   	push   %eax
80102f9e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102fa4:	e8 27 d1 ff ff       	call   801000d0 <bread>
80102fa9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102fab:	58                   	pop    %eax
80102fac:	5a                   	pop    %edx
80102fad:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102fb4:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102fba:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102fbd:	e8 0e d1 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102fc2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102fc5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102fc7:	8d 40 5c             	lea    0x5c(%eax),%eax
80102fca:	68 00 02 00 00       	push   $0x200
80102fcf:	50                   	push   %eax
80102fd0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102fd3:	50                   	push   %eax
80102fd4:	e8 b7 1a 00 00       	call   80104a90 <memmove>
    bwrite(to);  // write the log
80102fd9:	89 34 24             	mov    %esi,(%esp)
80102fdc:	e8 cf d1 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102fe1:	89 3c 24             	mov    %edi,(%esp)
80102fe4:	e8 07 d2 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102fe9:	89 34 24             	mov    %esi,(%esp)
80102fec:	e8 ff d1 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ff1:	83 c4 10             	add    $0x10,%esp
80102ff4:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102ffa:	7c 94                	jl     80102f90 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102ffc:	e8 7f fd ff ff       	call   80102d80 <write_head>
    install_trans(); // Now install writes to home locations
80103001:	e8 da fc ff ff       	call   80102ce0 <install_trans>
    log.lh.n = 0;
80103006:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
8010300d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103010:	e8 6b fd ff ff       	call   80102d80 <write_head>
80103015:	e9 34 ff ff ff       	jmp    80102f4e <end_op+0x5e>
8010301a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103020:	83 ec 0c             	sub    $0xc,%esp
80103023:	68 a0 26 11 80       	push   $0x801126a0
80103028:	e8 13 12 00 00       	call   80104240 <wakeup>
  release(&log.lock);
8010302d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80103034:	e8 97 18 00 00       	call   801048d0 <release>
80103039:	83 c4 10             	add    $0x10,%esp
}
8010303c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010303f:	5b                   	pop    %ebx
80103040:	5e                   	pop    %esi
80103041:	5f                   	pop    %edi
80103042:	5d                   	pop    %ebp
80103043:	c3                   	ret    
    panic("log.committing");
80103044:	83 ec 0c             	sub    $0xc,%esp
80103047:	68 a4 7c 10 80       	push   $0x80107ca4
8010304c:	e8 2f d3 ff ff       	call   80100380 <panic>
80103051:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103058:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010305f:	90                   	nop

80103060 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103060:	55                   	push   %ebp
80103061:	89 e5                	mov    %esp,%ebp
80103063:	53                   	push   %ebx
80103064:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103067:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
8010306d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103070:	83 fa 1d             	cmp    $0x1d,%edx
80103073:	0f 8f 85 00 00 00    	jg     801030fe <log_write+0x9e>
80103079:	a1 d8 26 11 80       	mov    0x801126d8,%eax
8010307e:	83 e8 01             	sub    $0x1,%eax
80103081:	39 c2                	cmp    %eax,%edx
80103083:	7d 79                	jge    801030fe <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103085:	a1 dc 26 11 80       	mov    0x801126dc,%eax
8010308a:	85 c0                	test   %eax,%eax
8010308c:	7e 7d                	jle    8010310b <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010308e:	83 ec 0c             	sub    $0xc,%esp
80103091:	68 a0 26 11 80       	push   $0x801126a0
80103096:	e8 95 18 00 00       	call   80104930 <acquire>
  for (i = 0; i < log.lh.n; i++) {
8010309b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
801030a1:	83 c4 10             	add    $0x10,%esp
801030a4:	85 d2                	test   %edx,%edx
801030a6:	7e 4a                	jle    801030f2 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801030a8:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
801030ab:	31 c0                	xor    %eax,%eax
801030ad:	eb 08                	jmp    801030b7 <log_write+0x57>
801030af:	90                   	nop
801030b0:	83 c0 01             	add    $0x1,%eax
801030b3:	39 c2                	cmp    %eax,%edx
801030b5:	74 29                	je     801030e0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801030b7:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
801030be:	75 f0                	jne    801030b0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
801030c0:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
801030c7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
801030ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
801030cd:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
801030d4:	c9                   	leave  
  release(&log.lock);
801030d5:	e9 f6 17 00 00       	jmp    801048d0 <release>
801030da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
801030e0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
801030e7:	83 c2 01             	add    $0x1,%edx
801030ea:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
801030f0:	eb d5                	jmp    801030c7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
801030f2:	8b 43 08             	mov    0x8(%ebx),%eax
801030f5:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
801030fa:	75 cb                	jne    801030c7 <log_write+0x67>
801030fc:	eb e9                	jmp    801030e7 <log_write+0x87>
    panic("too big a transaction");
801030fe:	83 ec 0c             	sub    $0xc,%esp
80103101:	68 b3 7c 10 80       	push   $0x80107cb3
80103106:	e8 75 d2 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
8010310b:	83 ec 0c             	sub    $0xc,%esp
8010310e:	68 c9 7c 10 80       	push   $0x80107cc9
80103113:	e8 68 d2 ff ff       	call   80100380 <panic>
80103118:	66 90                	xchg   %ax,%ax
8010311a:	66 90                	xchg   %ax,%ax
8010311c:	66 90                	xchg   %ax,%ax
8010311e:	66 90                	xchg   %ax,%ax

80103120 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103120:	55                   	push   %ebp
80103121:	89 e5                	mov    %esp,%ebp
80103123:	53                   	push   %ebx
80103124:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103127:	e8 54 09 00 00       	call   80103a80 <cpuid>
8010312c:	89 c3                	mov    %eax,%ebx
8010312e:	e8 4d 09 00 00       	call   80103a80 <cpuid>
80103133:	83 ec 04             	sub    $0x4,%esp
80103136:	53                   	push   %ebx
80103137:	50                   	push   %eax
80103138:	68 e4 7c 10 80       	push   $0x80107ce4
8010313d:	e8 3e d5 ff ff       	call   80100680 <cprintf>
  idtinit();       // load idt register
80103142:	e8 89 2c 00 00       	call   80105dd0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103147:	e8 c4 08 00 00       	call   80103a10 <mycpu>
8010314c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010314e:	b8 01 00 00 00       	mov    $0x1,%eax
80103153:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010315a:	e8 01 0c 00 00       	call   80103d60 <scheduler>
8010315f:	90                   	nop

80103160 <mpenter>:
{
80103160:	55                   	push   %ebp
80103161:	89 e5                	mov    %esp,%ebp
80103163:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103166:	e8 75 3d 00 00       	call   80106ee0 <switchkvm>
  seginit();
8010316b:	e8 e0 3c 00 00       	call   80106e50 <seginit>
  lapicinit();
80103170:	e8 9b f7 ff ff       	call   80102910 <lapicinit>
  mpmain();
80103175:	e8 a6 ff ff ff       	call   80103120 <mpmain>
8010317a:	66 90                	xchg   %ax,%ax
8010317c:	66 90                	xchg   %ax,%ax
8010317e:	66 90                	xchg   %ax,%ax

80103180 <main>:
{
80103180:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103184:	83 e4 f0             	and    $0xfffffff0,%esp
80103187:	ff 71 fc             	pushl  -0x4(%ecx)
8010318a:	55                   	push   %ebp
8010318b:	89 e5                	mov    %esp,%ebp
8010318d:	53                   	push   %ebx
8010318e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010318f:	83 ec 08             	sub    $0x8,%esp
80103192:	68 00 00 40 80       	push   $0x80400000
80103197:	68 d0 65 11 80       	push   $0x801165d0
8010319c:	e8 8f f5 ff ff       	call   80102730 <kinit1>
  kvmalloc();      // kernel page table
801031a1:	e8 2a 42 00 00       	call   801073d0 <kvmalloc>
  mpinit();        // detect other processors
801031a6:	e8 85 01 00 00       	call   80103330 <mpinit>
  lapicinit();     // interrupt controller
801031ab:	e8 60 f7 ff ff       	call   80102910 <lapicinit>
  seginit();       // segment descriptors
801031b0:	e8 9b 3c 00 00       	call   80106e50 <seginit>
  picinit();       // disable pic
801031b5:	e8 76 03 00 00       	call   80103530 <picinit>
  ioapicinit();    // another interrupt controller
801031ba:	e8 31 f3 ff ff       	call   801024f0 <ioapicinit>
  consoleinit();   // console hardware
801031bf:	e8 bc d9 ff ff       	call   80100b80 <consoleinit>
  uartinit();      // serial port
801031c4:	e8 f7 2e 00 00       	call   801060c0 <uartinit>
  pinit();         // process table
801031c9:	e8 22 08 00 00       	call   801039f0 <pinit>
  tvinit();        // trap vectors
801031ce:	e8 7d 2b 00 00       	call   80105d50 <tvinit>
  binit();         // buffer cache
801031d3:	e8 68 ce ff ff       	call   80100040 <binit>
  fileinit();      // file table
801031d8:	e8 63 dd ff ff       	call   80100f40 <fileinit>
  ideinit();       // disk 
801031dd:	e8 fe f0 ff ff       	call   801022e0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801031e2:	83 c4 0c             	add    $0xc,%esp
801031e5:	68 8a 00 00 00       	push   $0x8a
801031ea:	68 8c b4 10 80       	push   $0x8010b48c
801031ef:	68 00 70 00 80       	push   $0x80007000
801031f4:	e8 97 18 00 00       	call   80104a90 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801031f9:	83 c4 10             	add    $0x10,%esp
801031fc:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
80103203:	00 00 00 
80103206:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010320b:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80103210:	76 7e                	jbe    80103290 <main+0x110>
80103212:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
80103217:	eb 20                	jmp    80103239 <main+0xb9>
80103219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103220:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
80103227:	00 00 00 
8010322a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103230:	05 a0 27 11 80       	add    $0x801127a0,%eax
80103235:	39 c3                	cmp    %eax,%ebx
80103237:	73 57                	jae    80103290 <main+0x110>
    if(c == mycpu())  // We've started already.
80103239:	e8 d2 07 00 00       	call   80103a10 <mycpu>
8010323e:	39 c3                	cmp    %eax,%ebx
80103240:	74 de                	je     80103220 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103242:	e8 59 f5 ff ff       	call   801027a0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103247:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010324a:	c7 05 f8 6f 00 80 60 	movl   $0x80103160,0x80006ff8
80103251:	31 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103254:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010325b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010325e:	05 00 10 00 00       	add    $0x1000,%eax
80103263:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103268:	0f b6 03             	movzbl (%ebx),%eax
8010326b:	68 00 70 00 00       	push   $0x7000
80103270:	50                   	push   %eax
80103271:	e8 ea f7 ff ff       	call   80102a60 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103276:	83 c4 10             	add    $0x10,%esp
80103279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103280:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103286:	85 c0                	test   %eax,%eax
80103288:	74 f6                	je     80103280 <main+0x100>
8010328a:	eb 94                	jmp    80103220 <main+0xa0>
8010328c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103290:	83 ec 08             	sub    $0x8,%esp
80103293:	68 00 00 00 8e       	push   $0x8e000000
80103298:	68 00 00 40 80       	push   $0x80400000
8010329d:	e8 2e f4 ff ff       	call   801026d0 <kinit2>
  userinit();      // first user process
801032a2:	e8 29 08 00 00       	call   80103ad0 <userinit>
  mpmain();        // finish this processor's setup
801032a7:	e8 74 fe ff ff       	call   80103120 <mpmain>
801032ac:	66 90                	xchg   %ax,%ax
801032ae:	66 90                	xchg   %ax,%ax

801032b0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801032b0:	55                   	push   %ebp
801032b1:	89 e5                	mov    %esp,%ebp
801032b3:	57                   	push   %edi
801032b4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801032b5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801032bb:	53                   	push   %ebx
  e = addr+len;
801032bc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801032bf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801032c2:	39 de                	cmp    %ebx,%esi
801032c4:	72 10                	jb     801032d6 <mpsearch1+0x26>
801032c6:	eb 50                	jmp    80103318 <mpsearch1+0x68>
801032c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032cf:	90                   	nop
801032d0:	89 fe                	mov    %edi,%esi
801032d2:	39 fb                	cmp    %edi,%ebx
801032d4:	76 42                	jbe    80103318 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801032d6:	83 ec 04             	sub    $0x4,%esp
801032d9:	8d 7e 10             	lea    0x10(%esi),%edi
801032dc:	6a 04                	push   $0x4
801032de:	68 f8 7c 10 80       	push   $0x80107cf8
801032e3:	56                   	push   %esi
801032e4:	e8 57 17 00 00       	call   80104a40 <memcmp>
801032e9:	83 c4 10             	add    $0x10,%esp
801032ec:	89 c2                	mov    %eax,%edx
801032ee:	85 c0                	test   %eax,%eax
801032f0:	75 de                	jne    801032d0 <mpsearch1+0x20>
801032f2:	89 f0                	mov    %esi,%eax
801032f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801032f8:	0f b6 08             	movzbl (%eax),%ecx
  for(i=0; i<len; i++)
801032fb:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801032fe:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103300:	39 f8                	cmp    %edi,%eax
80103302:	75 f4                	jne    801032f8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103304:	84 d2                	test   %dl,%dl
80103306:	75 c8                	jne    801032d0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103308:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010330b:	89 f0                	mov    %esi,%eax
8010330d:	5b                   	pop    %ebx
8010330e:	5e                   	pop    %esi
8010330f:	5f                   	pop    %edi
80103310:	5d                   	pop    %ebp
80103311:	c3                   	ret    
80103312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103318:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010331b:	31 f6                	xor    %esi,%esi
}
8010331d:	5b                   	pop    %ebx
8010331e:	89 f0                	mov    %esi,%eax
80103320:	5e                   	pop    %esi
80103321:	5f                   	pop    %edi
80103322:	5d                   	pop    %ebp
80103323:	c3                   	ret    
80103324:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010332b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010332f:	90                   	nop

80103330 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103330:	55                   	push   %ebp
80103331:	89 e5                	mov    %esp,%ebp
80103333:	57                   	push   %edi
80103334:	56                   	push   %esi
80103335:	53                   	push   %ebx
80103336:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103339:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103340:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103347:	c1 e0 08             	shl    $0x8,%eax
8010334a:	09 d0                	or     %edx,%eax
8010334c:	c1 e0 04             	shl    $0x4,%eax
8010334f:	75 1b                	jne    8010336c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103351:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103358:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010335f:	c1 e0 08             	shl    $0x8,%eax
80103362:	09 d0                	or     %edx,%eax
80103364:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103367:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010336c:	ba 00 04 00 00       	mov    $0x400,%edx
80103371:	e8 3a ff ff ff       	call   801032b0 <mpsearch1>
80103376:	89 c3                	mov    %eax,%ebx
80103378:	85 c0                	test   %eax,%eax
8010337a:	0f 84 40 01 00 00    	je     801034c0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103380:	8b 73 04             	mov    0x4(%ebx),%esi
80103383:	85 f6                	test   %esi,%esi
80103385:	0f 84 25 01 00 00    	je     801034b0 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
8010338b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010338e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103394:	6a 04                	push   $0x4
80103396:	68 fd 7c 10 80       	push   $0x80107cfd
8010339b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010339c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010339f:	e8 9c 16 00 00       	call   80104a40 <memcmp>
801033a4:	83 c4 10             	add    $0x10,%esp
801033a7:	85 c0                	test   %eax,%eax
801033a9:	0f 85 01 01 00 00    	jne    801034b0 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
801033af:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801033b6:	3c 01                	cmp    $0x1,%al
801033b8:	74 08                	je     801033c2 <mpinit+0x92>
801033ba:	3c 04                	cmp    $0x4,%al
801033bc:	0f 85 ee 00 00 00    	jne    801034b0 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
801033c2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
801033c9:	66 85 d2             	test   %dx,%dx
801033cc:	74 22                	je     801033f0 <mpinit+0xc0>
801033ce:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801033d1:	89 f0                	mov    %esi,%eax
  sum = 0;
801033d3:	31 d2                	xor    %edx,%edx
801033d5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801033d8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
801033df:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801033e2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801033e4:	39 f8                	cmp    %edi,%eax
801033e6:	75 f0                	jne    801033d8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801033e8:	84 d2                	test   %dl,%dl
801033ea:	0f 85 c0 00 00 00    	jne    801034b0 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801033f0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
801033f6:	a3 80 26 11 80       	mov    %eax,0x80112680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033fb:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103402:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
80103408:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010340d:	03 55 e4             	add    -0x1c(%ebp),%edx
80103410:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103413:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103417:	90                   	nop
80103418:	39 d0                	cmp    %edx,%eax
8010341a:	73 15                	jae    80103431 <mpinit+0x101>
    switch(*p){
8010341c:	0f b6 08             	movzbl (%eax),%ecx
8010341f:	80 f9 02             	cmp    $0x2,%cl
80103422:	74 4c                	je     80103470 <mpinit+0x140>
80103424:	77 3a                	ja     80103460 <mpinit+0x130>
80103426:	84 c9                	test   %cl,%cl
80103428:	74 56                	je     80103480 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010342a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010342d:	39 d0                	cmp    %edx,%eax
8010342f:	72 eb                	jb     8010341c <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103431:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103434:	85 f6                	test   %esi,%esi
80103436:	0f 84 d9 00 00 00    	je     80103515 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010343c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103440:	74 15                	je     80103457 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103442:	b8 70 00 00 00       	mov    $0x70,%eax
80103447:	ba 22 00 00 00       	mov    $0x22,%edx
8010344c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010344d:	ba 23 00 00 00       	mov    $0x23,%edx
80103452:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103453:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103456:	ee                   	out    %al,(%dx)
  }
}
80103457:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010345a:	5b                   	pop    %ebx
8010345b:	5e                   	pop    %esi
8010345c:	5f                   	pop    %edi
8010345d:	5d                   	pop    %ebp
8010345e:	c3                   	ret    
8010345f:	90                   	nop
    switch(*p){
80103460:	83 e9 03             	sub    $0x3,%ecx
80103463:	80 f9 01             	cmp    $0x1,%cl
80103466:	76 c2                	jbe    8010342a <mpinit+0xfa>
80103468:	31 f6                	xor    %esi,%esi
8010346a:	eb ac                	jmp    80103418 <mpinit+0xe8>
8010346c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103470:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103474:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103477:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      continue;
8010347d:	eb 99                	jmp    80103418 <mpinit+0xe8>
8010347f:	90                   	nop
      if(ncpu < NCPU) {
80103480:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
80103486:	83 f9 07             	cmp    $0x7,%ecx
80103489:	7f 19                	jg     801034a4 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010348b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103491:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103495:	83 c1 01             	add    $0x1,%ecx
80103498:	89 0d 84 27 11 80    	mov    %ecx,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010349e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
801034a4:	83 c0 14             	add    $0x14,%eax
      continue;
801034a7:	e9 6c ff ff ff       	jmp    80103418 <mpinit+0xe8>
801034ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801034b0:	83 ec 0c             	sub    $0xc,%esp
801034b3:	68 02 7d 10 80       	push   $0x80107d02
801034b8:	e8 c3 ce ff ff       	call   80100380 <panic>
801034bd:	8d 76 00             	lea    0x0(%esi),%esi
{
801034c0:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801034c5:	eb 13                	jmp    801034da <mpinit+0x1aa>
801034c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034ce:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
801034d0:	89 f3                	mov    %esi,%ebx
801034d2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801034d8:	74 d6                	je     801034b0 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801034da:	83 ec 04             	sub    $0x4,%esp
801034dd:	8d 73 10             	lea    0x10(%ebx),%esi
801034e0:	6a 04                	push   $0x4
801034e2:	68 f8 7c 10 80       	push   $0x80107cf8
801034e7:	53                   	push   %ebx
801034e8:	e8 53 15 00 00       	call   80104a40 <memcmp>
801034ed:	83 c4 10             	add    $0x10,%esp
801034f0:	89 c2                	mov    %eax,%edx
801034f2:	85 c0                	test   %eax,%eax
801034f4:	75 da                	jne    801034d0 <mpinit+0x1a0>
801034f6:	89 d8                	mov    %ebx,%eax
801034f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034ff:	90                   	nop
    sum += addr[i];
80103500:	0f b6 08             	movzbl (%eax),%ecx
  for(i=0; i<len; i++)
80103503:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103506:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103508:	39 f0                	cmp    %esi,%eax
8010350a:	75 f4                	jne    80103500 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010350c:	84 d2                	test   %dl,%dl
8010350e:	75 c0                	jne    801034d0 <mpinit+0x1a0>
80103510:	e9 6b fe ff ff       	jmp    80103380 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103515:	83 ec 0c             	sub    $0xc,%esp
80103518:	68 1c 7d 10 80       	push   $0x80107d1c
8010351d:	e8 5e ce ff ff       	call   80100380 <panic>
80103522:	66 90                	xchg   %ax,%ax
80103524:	66 90                	xchg   %ax,%ax
80103526:	66 90                	xchg   %ax,%ax
80103528:	66 90                	xchg   %ax,%ax
8010352a:	66 90                	xchg   %ax,%ax
8010352c:	66 90                	xchg   %ax,%ax
8010352e:	66 90                	xchg   %ax,%ax

80103530 <picinit>:
80103530:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103535:	ba 21 00 00 00       	mov    $0x21,%edx
8010353a:	ee                   	out    %al,(%dx)
8010353b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103540:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103541:	c3                   	ret    
80103542:	66 90                	xchg   %ax,%ax
80103544:	66 90                	xchg   %ax,%ax
80103546:	66 90                	xchg   %ax,%ax
80103548:	66 90                	xchg   %ax,%ax
8010354a:	66 90                	xchg   %ax,%ax
8010354c:	66 90                	xchg   %ax,%ax
8010354e:	66 90                	xchg   %ax,%ax

80103550 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103550:	55                   	push   %ebp
80103551:	89 e5                	mov    %esp,%ebp
80103553:	57                   	push   %edi
80103554:	56                   	push   %esi
80103555:	53                   	push   %ebx
80103556:	83 ec 0c             	sub    $0xc,%esp
80103559:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010355c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010355f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103565:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010356b:	e8 f0 d9 ff ff       	call   80100f60 <filealloc>
80103570:	89 03                	mov    %eax,(%ebx)
80103572:	85 c0                	test   %eax,%eax
80103574:	0f 84 a8 00 00 00    	je     80103622 <pipealloc+0xd2>
8010357a:	e8 e1 d9 ff ff       	call   80100f60 <filealloc>
8010357f:	89 06                	mov    %eax,(%esi)
80103581:	85 c0                	test   %eax,%eax
80103583:	0f 84 87 00 00 00    	je     80103610 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103589:	e8 12 f2 ff ff       	call   801027a0 <kalloc>
8010358e:	89 c7                	mov    %eax,%edi
80103590:	85 c0                	test   %eax,%eax
80103592:	0f 84 b0 00 00 00    	je     80103648 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103598:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010359f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801035a2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801035a5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801035ac:	00 00 00 
  p->nwrite = 0;
801035af:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801035b6:	00 00 00 
  p->nread = 0;
801035b9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801035c0:	00 00 00 
  initlock(&p->lock, "pipe");
801035c3:	68 3b 7d 10 80       	push   $0x80107d3b
801035c8:	50                   	push   %eax
801035c9:	e8 92 11 00 00       	call   80104760 <initlock>
  (*f0)->type = FD_PIPE;
801035ce:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801035d0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801035d3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801035d9:	8b 03                	mov    (%ebx),%eax
801035db:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801035df:	8b 03                	mov    (%ebx),%eax
801035e1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801035e5:	8b 03                	mov    (%ebx),%eax
801035e7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801035ea:	8b 06                	mov    (%esi),%eax
801035ec:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801035f2:	8b 06                	mov    (%esi),%eax
801035f4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801035f8:	8b 06                	mov    (%esi),%eax
801035fa:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801035fe:	8b 06                	mov    (%esi),%eax
80103600:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103603:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103606:	31 c0                	xor    %eax,%eax
}
80103608:	5b                   	pop    %ebx
80103609:	5e                   	pop    %esi
8010360a:	5f                   	pop    %edi
8010360b:	5d                   	pop    %ebp
8010360c:	c3                   	ret    
8010360d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103610:	8b 03                	mov    (%ebx),%eax
80103612:	85 c0                	test   %eax,%eax
80103614:	74 1e                	je     80103634 <pipealloc+0xe4>
    fileclose(*f0);
80103616:	83 ec 0c             	sub    $0xc,%esp
80103619:	50                   	push   %eax
8010361a:	e8 01 da ff ff       	call   80101020 <fileclose>
8010361f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103622:	8b 06                	mov    (%esi),%eax
80103624:	85 c0                	test   %eax,%eax
80103626:	74 0c                	je     80103634 <pipealloc+0xe4>
    fileclose(*f1);
80103628:	83 ec 0c             	sub    $0xc,%esp
8010362b:	50                   	push   %eax
8010362c:	e8 ef d9 ff ff       	call   80101020 <fileclose>
80103631:	83 c4 10             	add    $0x10,%esp
}
80103634:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103637:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010363c:	5b                   	pop    %ebx
8010363d:	5e                   	pop    %esi
8010363e:	5f                   	pop    %edi
8010363f:	5d                   	pop    %ebp
80103640:	c3                   	ret    
80103641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103648:	8b 03                	mov    (%ebx),%eax
8010364a:	85 c0                	test   %eax,%eax
8010364c:	75 c8                	jne    80103616 <pipealloc+0xc6>
8010364e:	eb d2                	jmp    80103622 <pipealloc+0xd2>

80103650 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	56                   	push   %esi
80103654:	53                   	push   %ebx
80103655:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103658:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010365b:	83 ec 0c             	sub    $0xc,%esp
8010365e:	53                   	push   %ebx
8010365f:	e8 cc 12 00 00       	call   80104930 <acquire>
  if(writable){
80103664:	83 c4 10             	add    $0x10,%esp
80103667:	85 f6                	test   %esi,%esi
80103669:	74 65                	je     801036d0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010366b:	83 ec 0c             	sub    $0xc,%esp
8010366e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103674:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010367b:	00 00 00 
    wakeup(&p->nread);
8010367e:	50                   	push   %eax
8010367f:	e8 bc 0b 00 00       	call   80104240 <wakeup>
80103684:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103687:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010368d:	85 d2                	test   %edx,%edx
8010368f:	75 0a                	jne    8010369b <pipeclose+0x4b>
80103691:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103697:	85 c0                	test   %eax,%eax
80103699:	74 15                	je     801036b0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010369b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010369e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801036a1:	5b                   	pop    %ebx
801036a2:	5e                   	pop    %esi
801036a3:	5d                   	pop    %ebp
    release(&p->lock);
801036a4:	e9 27 12 00 00       	jmp    801048d0 <release>
801036a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801036b0:	83 ec 0c             	sub    $0xc,%esp
801036b3:	53                   	push   %ebx
801036b4:	e8 17 12 00 00       	call   801048d0 <release>
    kfree((char*)p);
801036b9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801036bc:	83 c4 10             	add    $0x10,%esp
}
801036bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801036c2:	5b                   	pop    %ebx
801036c3:	5e                   	pop    %esi
801036c4:	5d                   	pop    %ebp
    kfree((char*)p);
801036c5:	e9 16 ef ff ff       	jmp    801025e0 <kfree>
801036ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801036d0:	83 ec 0c             	sub    $0xc,%esp
801036d3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801036d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801036e0:	00 00 00 
    wakeup(&p->nwrite);
801036e3:	50                   	push   %eax
801036e4:	e8 57 0b 00 00       	call   80104240 <wakeup>
801036e9:	83 c4 10             	add    $0x10,%esp
801036ec:	eb 99                	jmp    80103687 <pipeclose+0x37>
801036ee:	66 90                	xchg   %ax,%ax

801036f0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	57                   	push   %edi
801036f4:	56                   	push   %esi
801036f5:	53                   	push   %ebx
801036f6:	83 ec 28             	sub    $0x28,%esp
801036f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801036fc:	53                   	push   %ebx
801036fd:	e8 2e 12 00 00       	call   80104930 <acquire>
  for(i = 0; i < n; i++){
80103702:	8b 45 10             	mov    0x10(%ebp),%eax
80103705:	83 c4 10             	add    $0x10,%esp
80103708:	85 c0                	test   %eax,%eax
8010370a:	0f 8e c0 00 00 00    	jle    801037d0 <pipewrite+0xe0>
80103710:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103713:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103719:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010371f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103722:	03 45 10             	add    0x10(%ebp),%eax
80103725:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103728:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010372e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103734:	89 ca                	mov    %ecx,%edx
80103736:	05 00 02 00 00       	add    $0x200,%eax
8010373b:	39 c1                	cmp    %eax,%ecx
8010373d:	74 3f                	je     8010377e <pipewrite+0x8e>
8010373f:	eb 67                	jmp    801037a8 <pipewrite+0xb8>
80103741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103748:	e8 53 03 00 00       	call   80103aa0 <myproc>
8010374d:	8b 48 24             	mov    0x24(%eax),%ecx
80103750:	85 c9                	test   %ecx,%ecx
80103752:	75 34                	jne    80103788 <pipewrite+0x98>
      wakeup(&p->nread);
80103754:	83 ec 0c             	sub    $0xc,%esp
80103757:	57                   	push   %edi
80103758:	e8 e3 0a 00 00       	call   80104240 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010375d:	58                   	pop    %eax
8010375e:	5a                   	pop    %edx
8010375f:	53                   	push   %ebx
80103760:	56                   	push   %esi
80103761:	e8 1a 0a 00 00       	call   80104180 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103766:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010376c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103772:	83 c4 10             	add    $0x10,%esp
80103775:	05 00 02 00 00       	add    $0x200,%eax
8010377a:	39 c2                	cmp    %eax,%edx
8010377c:	75 2a                	jne    801037a8 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010377e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103784:	85 c0                	test   %eax,%eax
80103786:	75 c0                	jne    80103748 <pipewrite+0x58>
        release(&p->lock);
80103788:	83 ec 0c             	sub    $0xc,%esp
8010378b:	53                   	push   %ebx
8010378c:	e8 3f 11 00 00       	call   801048d0 <release>
        return -1;
80103791:	83 c4 10             	add    $0x10,%esp
80103794:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103799:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010379c:	5b                   	pop    %ebx
8010379d:	5e                   	pop    %esi
8010379e:	5f                   	pop    %edi
8010379f:	5d                   	pop    %ebp
801037a0:	c3                   	ret    
801037a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801037a8:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801037ab:	8d 4a 01             	lea    0x1(%edx),%ecx
801037ae:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801037b4:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
801037ba:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
801037bd:	83 c6 01             	add    $0x1,%esi
801037c0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801037c3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801037c7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801037ca:	0f 85 58 ff ff ff    	jne    80103728 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801037d0:	83 ec 0c             	sub    $0xc,%esp
801037d3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801037d9:	50                   	push   %eax
801037da:	e8 61 0a 00 00       	call   80104240 <wakeup>
  release(&p->lock);
801037df:	89 1c 24             	mov    %ebx,(%esp)
801037e2:	e8 e9 10 00 00       	call   801048d0 <release>
  return n;
801037e7:	8b 45 10             	mov    0x10(%ebp),%eax
801037ea:	83 c4 10             	add    $0x10,%esp
801037ed:	eb aa                	jmp    80103799 <pipewrite+0xa9>
801037ef:	90                   	nop

801037f0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801037f0:	55                   	push   %ebp
801037f1:	89 e5                	mov    %esp,%ebp
801037f3:	57                   	push   %edi
801037f4:	56                   	push   %esi
801037f5:	53                   	push   %ebx
801037f6:	83 ec 18             	sub    $0x18,%esp
801037f9:	8b 75 08             	mov    0x8(%ebp),%esi
801037fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801037ff:	56                   	push   %esi
80103800:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103806:	e8 25 11 00 00       	call   80104930 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010380b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103811:	83 c4 10             	add    $0x10,%esp
80103814:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010381a:	74 2f                	je     8010384b <piperead+0x5b>
8010381c:	eb 37                	jmp    80103855 <piperead+0x65>
8010381e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103820:	e8 7b 02 00 00       	call   80103aa0 <myproc>
80103825:	8b 48 24             	mov    0x24(%eax),%ecx
80103828:	85 c9                	test   %ecx,%ecx
8010382a:	0f 85 80 00 00 00    	jne    801038b0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103830:	83 ec 08             	sub    $0x8,%esp
80103833:	56                   	push   %esi
80103834:	53                   	push   %ebx
80103835:	e8 46 09 00 00       	call   80104180 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010383a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103840:	83 c4 10             	add    $0x10,%esp
80103843:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103849:	75 0a                	jne    80103855 <piperead+0x65>
8010384b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103851:	85 c0                	test   %eax,%eax
80103853:	75 cb                	jne    80103820 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103855:	8b 55 10             	mov    0x10(%ebp),%edx
80103858:	31 db                	xor    %ebx,%ebx
8010385a:	85 d2                	test   %edx,%edx
8010385c:	7f 20                	jg     8010387e <piperead+0x8e>
8010385e:	eb 2c                	jmp    8010388c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103860:	8d 48 01             	lea    0x1(%eax),%ecx
80103863:	25 ff 01 00 00       	and    $0x1ff,%eax
80103868:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010386e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103873:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103876:	83 c3 01             	add    $0x1,%ebx
80103879:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010387c:	74 0e                	je     8010388c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010387e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103884:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010388a:	75 d4                	jne    80103860 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010388c:	83 ec 0c             	sub    $0xc,%esp
8010388f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103895:	50                   	push   %eax
80103896:	e8 a5 09 00 00       	call   80104240 <wakeup>
  release(&p->lock);
8010389b:	89 34 24             	mov    %esi,(%esp)
8010389e:	e8 2d 10 00 00       	call   801048d0 <release>
  return i;
801038a3:	83 c4 10             	add    $0x10,%esp
}
801038a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038a9:	89 d8                	mov    %ebx,%eax
801038ab:	5b                   	pop    %ebx
801038ac:	5e                   	pop    %esi
801038ad:	5f                   	pop    %edi
801038ae:	5d                   	pop    %ebp
801038af:	c3                   	ret    
      release(&p->lock);
801038b0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801038b3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801038b8:	56                   	push   %esi
801038b9:	e8 12 10 00 00       	call   801048d0 <release>
      return -1;
801038be:	83 c4 10             	add    $0x10,%esp
}
801038c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038c4:	89 d8                	mov    %ebx,%eax
801038c6:	5b                   	pop    %ebx
801038c7:	5e                   	pop    %esi
801038c8:	5f                   	pop    %edi
801038c9:	5d                   	pop    %ebp
801038ca:	c3                   	ret    
801038cb:	66 90                	xchg   %ax,%ax
801038cd:	66 90                	xchg   %ax,%ax
801038cf:	90                   	nop

801038d0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038d4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801038d9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801038dc:	68 20 2d 11 80       	push   $0x80112d20
801038e1:	e8 4a 10 00 00       	call   80104930 <acquire>
801038e6:	83 c4 10             	add    $0x10,%esp
801038e9:	eb 10                	jmp    801038fb <allocproc+0x2b>
801038eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038ef:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038f0:	83 eb 80             	sub    $0xffffff80,%ebx
801038f3:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
801038f9:	74 75                	je     80103970 <allocproc+0xa0>
    if(p->state == UNUSED)
801038fb:	8b 43 0c             	mov    0xc(%ebx),%eax
801038fe:	85 c0                	test   %eax,%eax
80103900:	75 ee                	jne    801038f0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103902:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103907:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010390a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103911:	89 43 10             	mov    %eax,0x10(%ebx)
80103914:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103917:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
8010391c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103922:	e8 a9 0f 00 00       	call   801048d0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103927:	e8 74 ee ff ff       	call   801027a0 <kalloc>
8010392c:	83 c4 10             	add    $0x10,%esp
8010392f:	89 43 08             	mov    %eax,0x8(%ebx)
80103932:	85 c0                	test   %eax,%eax
80103934:	74 53                	je     80103989 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103936:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4; //decrement; push
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010393c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010393f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103944:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103947:	c7 40 14 3f 5d 10 80 	movl   $0x80105d3f,0x14(%eax)
  p->context = (struct context*)sp;
8010394e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103951:	6a 14                	push   $0x14
80103953:	6a 00                	push   $0x0
80103955:	50                   	push   %eax
80103956:	e8 95 10 00 00       	call   801049f0 <memset>
  p->context->eip = (uint)forkret;
8010395b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010395e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103961:	c7 40 10 a0 39 10 80 	movl   $0x801039a0,0x10(%eax)
}
80103968:	89 d8                	mov    %ebx,%eax
8010396a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010396d:	c9                   	leave  
8010396e:	c3                   	ret    
8010396f:	90                   	nop
  release(&ptable.lock);
80103970:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103973:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103975:	68 20 2d 11 80       	push   $0x80112d20
8010397a:	e8 51 0f 00 00       	call   801048d0 <release>
}
8010397f:	89 d8                	mov    %ebx,%eax
  return 0;
80103981:	83 c4 10             	add    $0x10,%esp
}
80103984:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103987:	c9                   	leave  
80103988:	c3                   	ret    
    p->state = UNUSED;
80103989:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103990:	31 db                	xor    %ebx,%ebx
}
80103992:	89 d8                	mov    %ebx,%eax
80103994:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103997:	c9                   	leave  
80103998:	c3                   	ret    
80103999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801039a0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801039a6:	68 20 2d 11 80       	push   $0x80112d20
801039ab:	e8 20 0f 00 00       	call   801048d0 <release>

  if (first) {
801039b0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801039b5:	83 c4 10             	add    $0x10,%esp
801039b8:	85 c0                	test   %eax,%eax
801039ba:	75 04                	jne    801039c0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801039bc:	c9                   	leave  
801039bd:	c3                   	ret    
801039be:	66 90                	xchg   %ax,%ax
    first = 0;
801039c0:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801039c7:	00 00 00 
    iinit(ROOTDEV);
801039ca:	83 ec 0c             	sub    $0xc,%esp
801039cd:	6a 01                	push   $0x1
801039cf:	e8 ac dc ff ff       	call   80101680 <iinit>
    initlog(ROOTDEV);
801039d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801039db:	e8 00 f4 ff ff       	call   80102de0 <initlog>
}
801039e0:	83 c4 10             	add    $0x10,%esp
801039e3:	c9                   	leave  
801039e4:	c3                   	ret    
801039e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801039f0 <pinit>:
{
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801039f6:	68 40 7d 10 80       	push   $0x80107d40
801039fb:	68 20 2d 11 80       	push   $0x80112d20
80103a00:	e8 5b 0d 00 00       	call   80104760 <initlock>
}
80103a05:	83 c4 10             	add    $0x10,%esp
80103a08:	c9                   	leave  
80103a09:	c3                   	ret    
80103a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a10 <mycpu>:
{
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	56                   	push   %esi
80103a14:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103a15:	9c                   	pushf  
80103a16:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103a17:	f6 c4 02             	test   $0x2,%ah
80103a1a:	75 4e                	jne    80103a6a <mycpu+0x5a>
  apicid = lapicid();
80103a1c:	e8 ef ef ff ff       	call   80102a10 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103a21:	8b 35 84 27 11 80    	mov    0x80112784,%esi
  apicid = lapicid();
80103a27:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
80103a29:	85 f6                	test   %esi,%esi
80103a2b:	7e 30                	jle    80103a5d <mycpu+0x4d>
80103a2d:	31 c0                	xor    %eax,%eax
80103a2f:	eb 0e                	jmp    80103a3f <mycpu+0x2f>
80103a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a38:	83 c0 01             	add    $0x1,%eax
80103a3b:	39 f0                	cmp    %esi,%eax
80103a3d:	74 1e                	je     80103a5d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80103a3f:	69 d0 b0 00 00 00    	imul   $0xb0,%eax,%edx
80103a45:	0f b6 8a a0 27 11 80 	movzbl -0x7feed860(%edx),%ecx
80103a4c:	39 d9                	cmp    %ebx,%ecx
80103a4e:	75 e8                	jne    80103a38 <mycpu+0x28>
}
80103a50:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103a53:	8d 82 a0 27 11 80    	lea    -0x7feed860(%edx),%eax
}
80103a59:	5b                   	pop    %ebx
80103a5a:	5e                   	pop    %esi
80103a5b:	5d                   	pop    %ebp
80103a5c:	c3                   	ret    
  panic("unknown apicid\n");
80103a5d:	83 ec 0c             	sub    $0xc,%esp
80103a60:	68 47 7d 10 80       	push   $0x80107d47
80103a65:	e8 16 c9 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103a6a:	83 ec 0c             	sub    $0xc,%esp
80103a6d:	68 24 7e 10 80       	push   $0x80107e24
80103a72:	e8 09 c9 ff ff       	call   80100380 <panic>
80103a77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a7e:	66 90                	xchg   %ax,%ax

80103a80 <cpuid>:
cpuid() {
80103a80:	55                   	push   %ebp
80103a81:	89 e5                	mov    %esp,%ebp
80103a83:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103a86:	e8 85 ff ff ff       	call   80103a10 <mycpu>
}
80103a8b:	c9                   	leave  
  return mycpu()-cpus;
80103a8c:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103a91:	c1 f8 04             	sar    $0x4,%eax
80103a94:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103a9a:	c3                   	ret    
80103a9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a9f:	90                   	nop

80103aa0 <myproc>:
myproc(void) {
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	53                   	push   %ebx
80103aa4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103aa7:	e8 34 0d 00 00       	call   801047e0 <pushcli>
  c = mycpu();
80103aac:	e8 5f ff ff ff       	call   80103a10 <mycpu>
  p = c->proc;
80103ab1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ab7:	e8 74 0d 00 00       	call   80104830 <popcli>
}
80103abc:	89 d8                	mov    %ebx,%eax
80103abe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ac1:	c9                   	leave  
80103ac2:	c3                   	ret    
80103ac3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ad0 <userinit>:
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	53                   	push   %ebx
80103ad4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103ad7:	e8 f4 fd ff ff       	call   801038d0 <allocproc>
80103adc:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103ade:	a3 54 4d 11 80       	mov    %eax,0x80114d54
  if((p->pgdir = setupkvm()) == 0)
80103ae3:	e8 68 38 00 00       	call   80107350 <setupkvm>
80103ae8:	89 43 04             	mov    %eax,0x4(%ebx)
80103aeb:	85 c0                	test   %eax,%eax
80103aed:	0f 84 bd 00 00 00    	je     80103bb0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103af3:	83 ec 04             	sub    $0x4,%esp
80103af6:	68 2c 00 00 00       	push   $0x2c
80103afb:	68 60 b4 10 80       	push   $0x8010b460
80103b00:	50                   	push   %eax
80103b01:	e8 fa 34 00 00       	call   80107000 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103b06:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103b09:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103b0f:	6a 4c                	push   $0x4c
80103b11:	6a 00                	push   $0x0
80103b13:	ff 73 18             	pushl  0x18(%ebx)
80103b16:	e8 d5 0e 00 00       	call   801049f0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b1b:	8b 43 18             	mov    0x18(%ebx),%eax
80103b1e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b23:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b26:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b2b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b2f:	8b 43 18             	mov    0x18(%ebx),%eax
80103b32:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103b36:	8b 43 18             	mov    0x18(%ebx),%eax
80103b39:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b3d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103b41:	8b 43 18             	mov    0x18(%ebx),%eax
80103b44:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b48:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103b4c:	8b 43 18             	mov    0x18(%ebx),%eax
80103b4f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103b56:	8b 43 18             	mov    0x18(%ebx),%eax
80103b59:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103b60:	8b 43 18             	mov    0x18(%ebx),%eax
80103b63:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b6a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b6d:	6a 10                	push   $0x10
80103b6f:	68 70 7d 10 80       	push   $0x80107d70
80103b74:	50                   	push   %eax
80103b75:	e8 36 10 00 00       	call   80104bb0 <safestrcpy>
  p->cwd = namei("/");
80103b7a:	c7 04 24 79 7d 10 80 	movl   $0x80107d79,(%esp)
80103b81:	e8 3a e6 ff ff       	call   801021c0 <namei>
80103b86:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103b89:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b90:	e8 9b 0d 00 00       	call   80104930 <acquire>
  p->state = RUNNABLE;
80103b95:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103b9c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ba3:	e8 28 0d 00 00       	call   801048d0 <release>
}
80103ba8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bab:	83 c4 10             	add    $0x10,%esp
80103bae:	c9                   	leave  
80103baf:	c3                   	ret    
    panic("userinit: out of memory?");
80103bb0:	83 ec 0c             	sub    $0xc,%esp
80103bb3:	68 57 7d 10 80       	push   $0x80107d57
80103bb8:	e8 c3 c7 ff ff       	call   80100380 <panic>
80103bbd:	8d 76 00             	lea    0x0(%esi),%esi

80103bc0 <growproc>:
{
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	56                   	push   %esi
80103bc4:	53                   	push   %ebx
80103bc5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103bc8:	e8 13 0c 00 00       	call   801047e0 <pushcli>
  c = mycpu();
80103bcd:	e8 3e fe ff ff       	call   80103a10 <mycpu>
  p = c->proc;
80103bd2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103bd8:	e8 53 0c 00 00       	call   80104830 <popcli>
  sz = curproc->sz;
80103bdd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103bdf:	85 f6                	test   %esi,%esi
80103be1:	7f 1d                	jg     80103c00 <growproc+0x40>
  } else if(n < 0){
80103be3:	75 3b                	jne    80103c20 <growproc+0x60>
  switchuvm(curproc);
80103be5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103be8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103bea:	53                   	push   %ebx
80103beb:	e8 00 33 00 00       	call   80106ef0 <switchuvm>
  return 0;
80103bf0:	83 c4 10             	add    $0x10,%esp
80103bf3:	31 c0                	xor    %eax,%eax
}
80103bf5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bf8:	5b                   	pop    %ebx
80103bf9:	5e                   	pop    %esi
80103bfa:	5d                   	pop    %ebp
80103bfb:	c3                   	ret    
80103bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c00:	83 ec 04             	sub    $0x4,%esp
80103c03:	01 c6                	add    %eax,%esi
80103c05:	56                   	push   %esi
80103c06:	50                   	push   %eax
80103c07:	ff 73 04             	pushl  0x4(%ebx)
80103c0a:	e8 61 35 00 00       	call   80107170 <allocuvm>
80103c0f:	83 c4 10             	add    $0x10,%esp
80103c12:	85 c0                	test   %eax,%eax
80103c14:	75 cf                	jne    80103be5 <growproc+0x25>
      return -1;
80103c16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c1b:	eb d8                	jmp    80103bf5 <growproc+0x35>
80103c1d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c20:	83 ec 04             	sub    $0x4,%esp
80103c23:	01 c6                	add    %eax,%esi
80103c25:	56                   	push   %esi
80103c26:	50                   	push   %eax
80103c27:	ff 73 04             	pushl  0x4(%ebx)
80103c2a:	e8 71 36 00 00       	call   801072a0 <deallocuvm>
80103c2f:	83 c4 10             	add    $0x10,%esp
80103c32:	85 c0                	test   %eax,%eax
80103c34:	75 af                	jne    80103be5 <growproc+0x25>
80103c36:	eb de                	jmp    80103c16 <growproc+0x56>
80103c38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c3f:	90                   	nop

80103c40 <fork>:
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	57                   	push   %edi
80103c44:	56                   	push   %esi
80103c45:	53                   	push   %ebx
80103c46:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103c49:	e8 92 0b 00 00       	call   801047e0 <pushcli>
  c = mycpu();
80103c4e:	e8 bd fd ff ff       	call   80103a10 <mycpu>
  p = c->proc;
80103c53:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c59:	e8 d2 0b 00 00       	call   80104830 <popcli>
  if((np = allocproc()) == 0){
80103c5e:	e8 6d fc ff ff       	call   801038d0 <allocproc>
80103c63:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c66:	85 c0                	test   %eax,%eax
80103c68:	0f 84 b7 00 00 00    	je     80103d25 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103c6e:	83 ec 08             	sub    $0x8,%esp
80103c71:	ff 33                	pushl  (%ebx)
80103c73:	89 c7                	mov    %eax,%edi
80103c75:	ff 73 04             	pushl  0x4(%ebx)
80103c78:	e8 c3 37 00 00       	call   80107440 <copyuvm>
80103c7d:	83 c4 10             	add    $0x10,%esp
80103c80:	89 47 04             	mov    %eax,0x4(%edi)
80103c83:	85 c0                	test   %eax,%eax
80103c85:	0f 84 a1 00 00 00    	je     80103d2c <fork+0xec>
  np->sz = curproc->sz;
80103c8b:	8b 03                	mov    (%ebx),%eax
80103c8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103c90:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103c92:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103c95:	89 c8                	mov    %ecx,%eax
80103c97:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103c9a:	b9 13 00 00 00       	mov    $0x13,%ecx
80103c9f:	8b 73 18             	mov    0x18(%ebx),%esi
80103ca2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103ca4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103ca6:	8b 40 18             	mov    0x18(%eax),%eax
80103ca9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103cb0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103cb4:	85 c0                	test   %eax,%eax
80103cb6:	74 13                	je     80103ccb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103cb8:	83 ec 0c             	sub    $0xc,%esp
80103cbb:	50                   	push   %eax
80103cbc:	e8 0f d3 ff ff       	call   80100fd0 <filedup>
80103cc1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103cc4:	83 c4 10             	add    $0x10,%esp
80103cc7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103ccb:	83 c6 01             	add    $0x1,%esi
80103cce:	83 fe 10             	cmp    $0x10,%esi
80103cd1:	75 dd                	jne    80103cb0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103cd3:	83 ec 0c             	sub    $0xc,%esp
80103cd6:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cd9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103cdc:	e8 8f db ff ff       	call   80101870 <idup>
80103ce1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ce4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103ce7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cea:	8d 47 6c             	lea    0x6c(%edi),%eax
80103ced:	6a 10                	push   $0x10
80103cef:	53                   	push   %ebx
80103cf0:	50                   	push   %eax
80103cf1:	e8 ba 0e 00 00       	call   80104bb0 <safestrcpy>
  pid = np->pid;
80103cf6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103cf9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d00:	e8 2b 0c 00 00       	call   80104930 <acquire>
  np->state = RUNNABLE;
80103d05:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103d0c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d13:	e8 b8 0b 00 00       	call   801048d0 <release>
  return pid;
80103d18:	83 c4 10             	add    $0x10,%esp
}
80103d1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d1e:	89 d8                	mov    %ebx,%eax
80103d20:	5b                   	pop    %ebx
80103d21:	5e                   	pop    %esi
80103d22:	5f                   	pop    %edi
80103d23:	5d                   	pop    %ebp
80103d24:	c3                   	ret    
    return -1;
80103d25:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103d2a:	eb ef                	jmp    80103d1b <fork+0xdb>
    kfree(np->kstack);
80103d2c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103d2f:	83 ec 0c             	sub    $0xc,%esp
80103d32:	ff 73 08             	pushl  0x8(%ebx)
80103d35:	e8 a6 e8 ff ff       	call   801025e0 <kfree>
    np->kstack = 0;
80103d3a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103d41:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103d44:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103d4b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103d50:	eb c9                	jmp    80103d1b <fork+0xdb>
80103d52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d60 <scheduler>:
{
80103d60:	55                   	push   %ebp
80103d61:	89 e5                	mov    %esp,%ebp
80103d63:	57                   	push   %edi
80103d64:	56                   	push   %esi
80103d65:	53                   	push   %ebx
80103d66:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103d69:	e8 a2 fc ff ff       	call   80103a10 <mycpu>
  c->proc = 0;
80103d6e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103d75:	00 00 00 
  struct cpu *c = mycpu();
80103d78:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103d7a:	8d 78 04             	lea    0x4(%eax),%edi
80103d7d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103d80:	fb                   	sti    
    acquire(&ptable.lock);
80103d81:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d84:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103d89:	68 20 2d 11 80       	push   $0x80112d20
80103d8e:	e8 9d 0b 00 00       	call   80104930 <acquire>
80103d93:	83 c4 10             	add    $0x10,%esp
80103d96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d9d:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103da0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103da4:	75 33                	jne    80103dd9 <scheduler+0x79>
      switchuvm(p);
80103da6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103da9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103daf:	53                   	push   %ebx
80103db0:	e8 3b 31 00 00       	call   80106ef0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103db5:	58                   	pop    %eax
80103db6:	5a                   	pop    %edx
80103db7:	ff 73 1c             	pushl  0x1c(%ebx)
80103dba:	57                   	push   %edi
      p->state = RUNNING;
80103dbb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103dc2:	e8 44 0e 00 00       	call   80104c0b <swtch>
      switchkvm(); //scheduler context starts from here 
80103dc7:	e8 14 31 00 00       	call   80106ee0 <switchkvm>
      c->proc = 0;
80103dcc:	83 c4 10             	add    $0x10,%esp
80103dcf:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103dd6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dd9:	83 eb 80             	sub    $0xffffff80,%ebx
80103ddc:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103de2:	75 bc                	jne    80103da0 <scheduler+0x40>
    release(&ptable.lock);
80103de4:	83 ec 0c             	sub    $0xc,%esp
80103de7:	68 20 2d 11 80       	push   $0x80112d20
80103dec:	e8 df 0a 00 00       	call   801048d0 <release>
    sti();
80103df1:	83 c4 10             	add    $0x10,%esp
80103df4:	eb 8a                	jmp    80103d80 <scheduler+0x20>
80103df6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dfd:	8d 76 00             	lea    0x0(%esi),%esi

80103e00 <sched>:
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	56                   	push   %esi
80103e04:	53                   	push   %ebx
  pushcli();
80103e05:	e8 d6 09 00 00       	call   801047e0 <pushcli>
  c = mycpu();
80103e0a:	e8 01 fc ff ff       	call   80103a10 <mycpu>
  p = c->proc;
80103e0f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e15:	e8 16 0a 00 00       	call   80104830 <popcli>
  if(!holding(&ptable.lock))
80103e1a:	83 ec 0c             	sub    $0xc,%esp
80103e1d:	68 20 2d 11 80       	push   $0x80112d20
80103e22:	e8 69 0a 00 00       	call   80104890 <holding>
80103e27:	83 c4 10             	add    $0x10,%esp
80103e2a:	85 c0                	test   %eax,%eax
80103e2c:	74 4f                	je     80103e7d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103e2e:	e8 dd fb ff ff       	call   80103a10 <mycpu>
80103e33:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103e3a:	75 68                	jne    80103ea4 <sched+0xa4>
  if(p->state == RUNNING)
80103e3c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103e40:	74 55                	je     80103e97 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e42:	9c                   	pushf  
80103e43:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e44:	f6 c4 02             	test   $0x2,%ah
80103e47:	75 41                	jne    80103e8a <sched+0x8a>
  intena = mycpu()->intena;
80103e49:	e8 c2 fb ff ff       	call   80103a10 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103e4e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103e51:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103e57:	e8 b4 fb ff ff       	call   80103a10 <mycpu>
80103e5c:	83 ec 08             	sub    $0x8,%esp
80103e5f:	ff 70 04             	pushl  0x4(%eax)
80103e62:	53                   	push   %ebx
80103e63:	e8 a3 0d 00 00       	call   80104c0b <swtch>
  mycpu()->intena = intena;
80103e68:	e8 a3 fb ff ff       	call   80103a10 <mycpu>
}
80103e6d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103e70:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e76:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e79:	5b                   	pop    %ebx
80103e7a:	5e                   	pop    %esi
80103e7b:	5d                   	pop    %ebp
80103e7c:	c3                   	ret    
    panic("sched ptable.lock");
80103e7d:	83 ec 0c             	sub    $0xc,%esp
80103e80:	68 7b 7d 10 80       	push   $0x80107d7b
80103e85:	e8 f6 c4 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103e8a:	83 ec 0c             	sub    $0xc,%esp
80103e8d:	68 a7 7d 10 80       	push   $0x80107da7
80103e92:	e8 e9 c4 ff ff       	call   80100380 <panic>
    panic("sched running");
80103e97:	83 ec 0c             	sub    $0xc,%esp
80103e9a:	68 99 7d 10 80       	push   $0x80107d99
80103e9f:	e8 dc c4 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103ea4:	83 ec 0c             	sub    $0xc,%esp
80103ea7:	68 8d 7d 10 80       	push   $0x80107d8d
80103eac:	e8 cf c4 ff ff       	call   80100380 <panic>
80103eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103eb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ebf:	90                   	nop

80103ec0 <exit>:
{
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	57                   	push   %edi
80103ec4:	56                   	push   %esi
80103ec5:	53                   	push   %ebx
80103ec6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103ec9:	e8 d2 fb ff ff       	call   80103aa0 <myproc>
  if(curproc == initproc)
80103ece:	39 05 54 4d 11 80    	cmp    %eax,0x80114d54
80103ed4:	0f 84 fd 00 00 00    	je     80103fd7 <exit+0x117>
80103eda:	89 c3                	mov    %eax,%ebx
80103edc:	8d 70 28             	lea    0x28(%eax),%esi
80103edf:	8d 78 68             	lea    0x68(%eax),%edi
80103ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103ee8:	8b 06                	mov    (%esi),%eax
80103eea:	85 c0                	test   %eax,%eax
80103eec:	74 12                	je     80103f00 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103eee:	83 ec 0c             	sub    $0xc,%esp
80103ef1:	50                   	push   %eax
80103ef2:	e8 29 d1 ff ff       	call   80101020 <fileclose>
      curproc->ofile[fd] = 0;
80103ef7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103efd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103f00:	83 c6 04             	add    $0x4,%esi
80103f03:	39 f7                	cmp    %esi,%edi
80103f05:	75 e1                	jne    80103ee8 <exit+0x28>
  begin_op();
80103f07:	e8 74 ef ff ff       	call   80102e80 <begin_op>
  iput(curproc->cwd);
80103f0c:	83 ec 0c             	sub    $0xc,%esp
80103f0f:	ff 73 68             	pushl  0x68(%ebx)
80103f12:	e8 b9 da ff ff       	call   801019d0 <iput>
  end_op();
80103f17:	e8 d4 ef ff ff       	call   80102ef0 <end_op>
  curproc->cwd = 0;
80103f1c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103f23:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f2a:	e8 01 0a 00 00       	call   80104930 <acquire>
  wakeup1(curproc->parent);
80103f2f:	8b 53 14             	mov    0x14(%ebx),%edx
80103f32:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f35:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103f3a:	eb 0e                	jmp    80103f4a <exit+0x8a>
80103f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f40:	83 e8 80             	sub    $0xffffff80,%eax
80103f43:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103f48:	74 1c                	je     80103f66 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
80103f4a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f4e:	75 f0                	jne    80103f40 <exit+0x80>
80103f50:	3b 50 20             	cmp    0x20(%eax),%edx
80103f53:	75 eb                	jne    80103f40 <exit+0x80>
      p->state = RUNNABLE;
80103f55:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f5c:	83 e8 80             	sub    $0xffffff80,%eax
80103f5f:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103f64:	75 e4                	jne    80103f4a <exit+0x8a>
      p->parent = initproc;
80103f66:	8b 0d 54 4d 11 80    	mov    0x80114d54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){ //as curproc die, its child process's going to be orphan process
80103f6c:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103f71:	eb 10                	jmp    80103f83 <exit+0xc3>
80103f73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f77:	90                   	nop
80103f78:	83 ea 80             	sub    $0xffffff80,%edx
80103f7b:	81 fa 54 4d 11 80    	cmp    $0x80114d54,%edx
80103f81:	74 3b                	je     80103fbe <exit+0xfe>
    if(p->parent == curproc && p->pgdir != curproc->pgdir){ //for only child process, not thread 
80103f83:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103f86:	75 f0                	jne    80103f78 <exit+0xb8>
80103f88:	8b 43 04             	mov    0x4(%ebx),%eax
80103f8b:	39 42 04             	cmp    %eax,0x4(%edx)
80103f8e:	74 e8                	je     80103f78 <exit+0xb8>
      if(p->state == ZOMBIE)
80103f90:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103f94:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f97:	75 df                	jne    80103f78 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f99:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103f9e:	eb 0a                	jmp    80103faa <exit+0xea>
80103fa0:	83 e8 80             	sub    $0xffffff80,%eax
80103fa3:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103fa8:	74 ce                	je     80103f78 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
80103faa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103fae:	75 f0                	jne    80103fa0 <exit+0xe0>
80103fb0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103fb3:	75 eb                	jne    80103fa0 <exit+0xe0>
      p->state = RUNNABLE;
80103fb5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103fbc:	eb e2                	jmp    80103fa0 <exit+0xe0>
  curproc->state = ZOMBIE;
80103fbe:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103fc5:	e8 36 fe ff ff       	call   80103e00 <sched>
  panic("zombie exit");
80103fca:	83 ec 0c             	sub    $0xc,%esp
80103fcd:	68 c8 7d 10 80       	push   $0x80107dc8
80103fd2:	e8 a9 c3 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103fd7:	83 ec 0c             	sub    $0xc,%esp
80103fda:	68 bb 7d 10 80       	push   $0x80107dbb
80103fdf:	e8 9c c3 ff ff       	call   80100380 <panic>
80103fe4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103feb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fef:	90                   	nop

80103ff0 <wait>:
{
80103ff0:	55                   	push   %ebp
80103ff1:	89 e5                	mov    %esp,%ebp
80103ff3:	56                   	push   %esi
80103ff4:	53                   	push   %ebx
  pushcli();
80103ff5:	e8 e6 07 00 00       	call   801047e0 <pushcli>
  c = mycpu();
80103ffa:	e8 11 fa ff ff       	call   80103a10 <mycpu>
  p = c->proc;
80103fff:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104005:	e8 26 08 00 00       	call   80104830 <popcli>
  acquire(&ptable.lock);
8010400a:	83 ec 0c             	sub    $0xc,%esp
8010400d:	68 20 2d 11 80       	push   $0x80112d20
80104012:	e8 19 09 00 00       	call   80104930 <acquire>
80104017:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010401a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010401c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80104021:	eb 10                	jmp    80104033 <wait+0x43>
80104023:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104027:	90                   	nop
80104028:	83 eb 80             	sub    $0xffffff80,%ebx
8010402b:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80104031:	74 23                	je     80104056 <wait+0x66>
      if(p->parent != curproc || p->pgdir == curproc->pgdir)
80104033:	39 73 14             	cmp    %esi,0x14(%ebx)
80104036:	75 f0                	jne    80104028 <wait+0x38>
80104038:	8b 56 04             	mov    0x4(%esi),%edx
8010403b:	39 53 04             	cmp    %edx,0x4(%ebx)
8010403e:	74 e8                	je     80104028 <wait+0x38>
      if(p->state == ZOMBIE){
80104040:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104044:	74 62                	je     801040a8 <wait+0xb8>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104046:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80104049:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010404e:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80104054:	75 dd                	jne    80104033 <wait+0x43>
    if(!havekids || curproc->killed){
80104056:	85 c0                	test   %eax,%eax
80104058:	0f 84 a0 00 00 00    	je     801040fe <wait+0x10e>
8010405e:	8b 46 24             	mov    0x24(%esi),%eax
80104061:	85 c0                	test   %eax,%eax
80104063:	0f 85 95 00 00 00    	jne    801040fe <wait+0x10e>
  pushcli();
80104069:	e8 72 07 00 00       	call   801047e0 <pushcli>
  c = mycpu();
8010406e:	e8 9d f9 ff ff       	call   80103a10 <mycpu>
  p = c->proc;
80104073:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104079:	e8 b2 07 00 00       	call   80104830 <popcli>
  if(p == 0)
8010407e:	85 db                	test   %ebx,%ebx
80104080:	0f 84 8f 00 00 00    	je     80104115 <wait+0x125>
  p->chan = chan;
80104086:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104089:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104090:	e8 6b fd ff ff       	call   80103e00 <sched>
  p->chan = 0;
80104095:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010409c:	e9 79 ff ff ff       	jmp    8010401a <wait+0x2a>
801040a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
801040a8:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
801040ab:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801040ae:	ff 73 08             	pushl  0x8(%ebx)
801040b1:	e8 2a e5 ff ff       	call   801025e0 <kfree>
        p->kstack = 0;
801040b6:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801040bd:	5a                   	pop    %edx
801040be:	ff 73 04             	pushl  0x4(%ebx)
801040c1:	e8 0a 32 00 00       	call   801072d0 <freevm>
        p->pid = 0;
801040c6:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801040cd:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801040d4:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801040d8:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801040df:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801040e6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801040ed:	e8 de 07 00 00       	call   801048d0 <release>
        return pid;
801040f2:	83 c4 10             	add    $0x10,%esp
}
801040f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040f8:	89 f0                	mov    %esi,%eax
801040fa:	5b                   	pop    %ebx
801040fb:	5e                   	pop    %esi
801040fc:	5d                   	pop    %ebp
801040fd:	c3                   	ret    
      release(&ptable.lock);
801040fe:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104101:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104106:	68 20 2d 11 80       	push   $0x80112d20
8010410b:	e8 c0 07 00 00       	call   801048d0 <release>
      return -1;
80104110:	83 c4 10             	add    $0x10,%esp
80104113:	eb e0                	jmp    801040f5 <wait+0x105>
    panic("sleep");
80104115:	83 ec 0c             	sub    $0xc,%esp
80104118:	68 d4 7d 10 80       	push   $0x80107dd4
8010411d:	e8 5e c2 ff ff       	call   80100380 <panic>
80104122:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104130 <yield>:
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	53                   	push   %ebx
80104134:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104137:	68 20 2d 11 80       	push   $0x80112d20
8010413c:	e8 ef 07 00 00       	call   80104930 <acquire>
  pushcli();
80104141:	e8 9a 06 00 00       	call   801047e0 <pushcli>
  c = mycpu();
80104146:	e8 c5 f8 ff ff       	call   80103a10 <mycpu>
  p = c->proc;
8010414b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104151:	e8 da 06 00 00       	call   80104830 <popcli>
  myproc()->state = RUNNABLE;
80104156:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010415d:	e8 9e fc ff ff       	call   80103e00 <sched>
  release(&ptable.lock);
80104162:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104169:	e8 62 07 00 00       	call   801048d0 <release>
}
8010416e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104171:	83 c4 10             	add    $0x10,%esp
80104174:	c9                   	leave  
80104175:	c3                   	ret    
80104176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010417d:	8d 76 00             	lea    0x0(%esi),%esi

80104180 <sleep>:
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	57                   	push   %edi
80104184:	56                   	push   %esi
80104185:	53                   	push   %ebx
80104186:	83 ec 0c             	sub    $0xc,%esp
80104189:	8b 7d 08             	mov    0x8(%ebp),%edi
8010418c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010418f:	e8 4c 06 00 00       	call   801047e0 <pushcli>
  c = mycpu();
80104194:	e8 77 f8 ff ff       	call   80103a10 <mycpu>
  p = c->proc;
80104199:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010419f:	e8 8c 06 00 00       	call   80104830 <popcli>
  if(p == 0)
801041a4:	85 db                	test   %ebx,%ebx
801041a6:	0f 84 87 00 00 00    	je     80104233 <sleep+0xb3>
  if(lk == 0)
801041ac:	85 f6                	test   %esi,%esi
801041ae:	74 76                	je     80104226 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801041b0:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
801041b6:	74 50                	je     80104208 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801041b8:	83 ec 0c             	sub    $0xc,%esp
801041bb:	68 20 2d 11 80       	push   $0x80112d20
801041c0:	e8 6b 07 00 00       	call   80104930 <acquire>
    release(lk);
801041c5:	89 34 24             	mov    %esi,(%esp)
801041c8:	e8 03 07 00 00       	call   801048d0 <release>
  p->chan = chan;
801041cd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801041d0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801041d7:	e8 24 fc ff ff       	call   80103e00 <sched>
  p->chan = 0;
801041dc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801041e3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801041ea:	e8 e1 06 00 00       	call   801048d0 <release>
    acquire(lk);
801041ef:	89 75 08             	mov    %esi,0x8(%ebp)
801041f2:	83 c4 10             	add    $0x10,%esp
}
801041f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041f8:	5b                   	pop    %ebx
801041f9:	5e                   	pop    %esi
801041fa:	5f                   	pop    %edi
801041fb:	5d                   	pop    %ebp
    acquire(lk);
801041fc:	e9 2f 07 00 00       	jmp    80104930 <acquire>
80104201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104208:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010420b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104212:	e8 e9 fb ff ff       	call   80103e00 <sched>
  p->chan = 0;
80104217:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010421e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104221:	5b                   	pop    %ebx
80104222:	5e                   	pop    %esi
80104223:	5f                   	pop    %edi
80104224:	5d                   	pop    %ebp
80104225:	c3                   	ret    
    panic("sleep without lk");
80104226:	83 ec 0c             	sub    $0xc,%esp
80104229:	68 da 7d 10 80       	push   $0x80107dda
8010422e:	e8 4d c1 ff ff       	call   80100380 <panic>
    panic("sleep");
80104233:	83 ec 0c             	sub    $0xc,%esp
80104236:	68 d4 7d 10 80       	push   $0x80107dd4
8010423b:	e8 40 c1 ff ff       	call   80100380 <panic>

80104240 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	53                   	push   %ebx
80104244:	83 ec 10             	sub    $0x10,%esp
80104247:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010424a:	68 20 2d 11 80       	push   $0x80112d20
8010424f:	e8 dc 06 00 00       	call   80104930 <acquire>
80104254:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104257:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010425c:	eb 0c                	jmp    8010426a <wakeup+0x2a>
8010425e:	66 90                	xchg   %ax,%ax
80104260:	83 e8 80             	sub    $0xffffff80,%eax
80104263:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80104268:	74 1c                	je     80104286 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010426a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010426e:	75 f0                	jne    80104260 <wakeup+0x20>
80104270:	3b 58 20             	cmp    0x20(%eax),%ebx
80104273:	75 eb                	jne    80104260 <wakeup+0x20>
      p->state = RUNNABLE;
80104275:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010427c:	83 e8 80             	sub    $0xffffff80,%eax
8010427f:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80104284:	75 e4                	jne    8010426a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104286:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
8010428d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104290:	c9                   	leave  
  release(&ptable.lock);
80104291:	e9 3a 06 00 00       	jmp    801048d0 <release>
80104296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010429d:	8d 76 00             	lea    0x0(%esi),%esi

801042a0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
801042a4:	83 ec 10             	sub    $0x10,%esp
801042a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801042aa:	68 20 2d 11 80       	push   $0x80112d20
801042af:	e8 7c 06 00 00       	call   80104930 <acquire>
801042b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042b7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801042bc:	eb 0c                	jmp    801042ca <kill+0x2a>
801042be:	66 90                	xchg   %ax,%ax
801042c0:	83 e8 80             	sub    $0xffffff80,%eax
801042c3:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
801042c8:	74 36                	je     80104300 <kill+0x60>
    if(p->pid == pid){
801042ca:	39 58 10             	cmp    %ebx,0x10(%eax)
801042cd:	75 f1                	jne    801042c0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801042cf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801042d3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801042da:	75 07                	jne    801042e3 <kill+0x43>
        p->state = RUNNABLE;
801042dc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801042e3:	83 ec 0c             	sub    $0xc,%esp
801042e6:	68 20 2d 11 80       	push   $0x80112d20
801042eb:	e8 e0 05 00 00       	call   801048d0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801042f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801042f3:	83 c4 10             	add    $0x10,%esp
801042f6:	31 c0                	xor    %eax,%eax
}
801042f8:	c9                   	leave  
801042f9:	c3                   	ret    
801042fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104300:	83 ec 0c             	sub    $0xc,%esp
80104303:	68 20 2d 11 80       	push   $0x80112d20
80104308:	e8 c3 05 00 00       	call   801048d0 <release>
}
8010430d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104310:	83 c4 10             	add    $0x10,%esp
80104313:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104318:	c9                   	leave  
80104319:	c3                   	ret    
8010431a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104320 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	57                   	push   %edi
80104324:	56                   	push   %esi
80104325:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104328:	53                   	push   %ebx
80104329:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
8010432e:	83 ec 3c             	sub    $0x3c,%esp
80104331:	eb 24                	jmp    80104357 <procdump+0x37>
80104333:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104337:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	68 67 81 10 80       	push   $0x80108167
80104340:	e8 3b c3 ff ff       	call   80100680 <cprintf>
80104345:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104348:	83 eb 80             	sub    $0xffffff80,%ebx
8010434b:	81 fb c0 4d 11 80    	cmp    $0x80114dc0,%ebx
80104351:	0f 84 81 00 00 00    	je     801043d8 <procdump+0xb8>
    if(p->state == UNUSED)
80104357:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010435a:	85 c0                	test   %eax,%eax
8010435c:	74 ea                	je     80104348 <procdump+0x28>
      state = "???";
8010435e:	ba eb 7d 10 80       	mov    $0x80107deb,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104363:	83 f8 05             	cmp    $0x5,%eax
80104366:	77 11                	ja     80104379 <procdump+0x59>
80104368:	8b 14 85 4c 7e 10 80 	mov    -0x7fef81b4(,%eax,4),%edx
      state = "???";
8010436f:	b8 eb 7d 10 80       	mov    $0x80107deb,%eax
80104374:	85 d2                	test   %edx,%edx
80104376:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104379:	53                   	push   %ebx
8010437a:	52                   	push   %edx
8010437b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010437e:	68 ef 7d 10 80       	push   $0x80107def
80104383:	e8 f8 c2 ff ff       	call   80100680 <cprintf>
    if(p->state == SLEEPING){
80104388:	83 c4 10             	add    $0x10,%esp
8010438b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010438f:	75 a7                	jne    80104338 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104391:	83 ec 08             	sub    $0x8,%esp
80104394:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104397:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010439a:	50                   	push   %eax
8010439b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010439e:	8b 40 0c             	mov    0xc(%eax),%eax
801043a1:	83 c0 08             	add    $0x8,%eax
801043a4:	50                   	push   %eax
801043a5:	e8 d6 03 00 00       	call   80104780 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801043aa:	83 c4 10             	add    $0x10,%esp
801043ad:	8d 76 00             	lea    0x0(%esi),%esi
801043b0:	8b 17                	mov    (%edi),%edx
801043b2:	85 d2                	test   %edx,%edx
801043b4:	74 82                	je     80104338 <procdump+0x18>
        cprintf(" %p", pc[i]);
801043b6:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801043b9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801043bc:	52                   	push   %edx
801043bd:	68 41 78 10 80       	push   $0x80107841
801043c2:	e8 b9 c2 ff ff       	call   80100680 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801043c7:	83 c4 10             	add    $0x10,%esp
801043ca:	39 fe                	cmp    %edi,%esi
801043cc:	75 e2                	jne    801043b0 <procdump+0x90>
801043ce:	e9 65 ff ff ff       	jmp    80104338 <procdump+0x18>
801043d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043d7:	90                   	nop
  }
}
801043d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043db:	5b                   	pop    %ebx
801043dc:	5e                   	pop    %esi
801043dd:	5f                   	pop    %edi
801043de:	5d                   	pop    %ebp
801043df:	c3                   	ret    

801043e0 <clone>:

int
clone(void(*fcn)(void*, void*), void* arg1, void* arg2, void* stack)
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	57                   	push   %edi
801043e4:	56                   	push   %esi
801043e5:	53                   	push   %ebx
801043e6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801043e9:	e8 f2 03 00 00       	call   801047e0 <pushcli>
  c = mycpu();
801043ee:	e8 1d f6 ff ff       	call   80103a10 <mycpu>
  p = c->proc;
801043f3:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801043f9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  popcli();
801043fc:	e8 2f 04 00 00       	call   80104830 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80104401:	e8 ca f4 ff ff       	call   801038d0 <allocproc>
80104406:	85 c0                	test   %eax,%eax
80104408:	0f 84 e7 00 00 00    	je     801044f5 <clone+0x115>
    return -1;
  }

  //share address space with parent process
  np->pgdir = curproc->pgdir;
8010440e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104411:	89 c3                	mov    %eax,%ebx

  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;
80104413:	b9 13 00 00 00       	mov    $0x13,%ecx
80104418:	8b 7b 18             	mov    0x18(%ebx),%edi
  np->pgdir = curproc->pgdir;
8010441b:	8b 42 04             	mov    0x4(%edx),%eax
8010441e:	89 43 04             	mov    %eax,0x4(%ebx)
  np->sz = curproc->sz;
80104421:	8b 02                	mov    (%edx),%eax
  np->parent = curproc;
80104423:	89 53 14             	mov    %edx,0x14(%ebx)
  np->sz = curproc->sz;
80104426:	89 03                	mov    %eax,(%ebx)
  *np->tf = *curproc->tf;
80104428:	8b 72 18             	mov    0x18(%edx),%esi
8010442b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  np->tf->eip = (uint)fcn; //instruction pointer, where the kernel should return after trap
8010442d:	8b 4d 08             	mov    0x8(%ebp),%ecx


  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80104430:	31 f6                	xor    %esi,%esi
80104432:	89 d7                	mov    %edx,%edi
  np->tf->eip = (uint)fcn; //instruction pointer, where the kernel should return after trap
80104434:	8b 43 18             	mov    0x18(%ebx),%eax
80104437:	89 48 38             	mov    %ecx,0x38(%eax)
  np->usp = stack;
8010443a:	8b 45 14             	mov    0x14(%ebp),%eax
  *(uint*)sp = *(uint*)arg2;
8010443d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  np->usp = stack;
80104440:	89 43 7c             	mov    %eax,0x7c(%ebx)
  *(uint*)sp = *(uint*)arg2;
80104443:	8b 45 10             	mov    0x10(%ebp),%eax
80104446:	8b 00                	mov    (%eax),%eax
80104448:	89 81 fc 0f 00 00    	mov    %eax,0xffc(%ecx)
  *(uint*)sp = *(uint*)arg1;
8010444e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104451:	8b 00                	mov    (%eax),%eax
  *(uint*)sp = 0xffffffff;
80104453:	c7 81 f4 0f 00 00 ff 	movl   $0xffffffff,0xff4(%ecx)
8010445a:	ff ff ff 
  *(uint*)sp = *(uint*)arg1;
8010445d:	89 81 f8 0f 00 00    	mov    %eax,0xff8(%ecx)
  *(uint*)sp = 0xffffffff;
80104463:	89 c8                	mov    %ecx,%eax
  np->tf->esp = (uint)sp;
80104465:	8b 4b 18             	mov    0x18(%ebx),%ecx
  sp -= 4;
80104468:	05 f4 0f 00 00       	add    $0xff4,%eax
8010446d:	89 41 44             	mov    %eax,0x44(%ecx)
  np->tf->eax = 0;
80104470:	8b 43 18             	mov    0x18(%ebx),%eax
80104473:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
8010447a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[i])
80104480:	8b 44 b7 28          	mov    0x28(%edi,%esi,4),%eax
80104484:	85 c0                	test   %eax,%eax
80104486:	74 10                	je     80104498 <clone+0xb8>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104488:	83 ec 0c             	sub    $0xc,%esp
8010448b:	50                   	push   %eax
8010448c:	e8 3f cb ff ff       	call   80100fd0 <filedup>
80104491:	83 c4 10             	add    $0x10,%esp
80104494:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80104498:	83 c6 01             	add    $0x1,%esi
8010449b:	83 fe 10             	cmp    $0x10,%esi
8010449e:	75 e0                	jne    80104480 <clone+0xa0>
  np->cwd = idup(curproc->cwd);
801044a0:	83 ec 0c             	sub    $0xc,%esp
801044a3:	ff 77 68             	pushl  0x68(%edi)
801044a6:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801044a9:	e8 c2 d3 ff ff       	call   80101870 <idup>

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801044ae:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801044b1:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
801044b4:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801044b7:	8d 43 6c             	lea    0x6c(%ebx),%eax
801044ba:	83 c2 6c             	add    $0x6c,%edx
801044bd:	6a 10                	push   $0x10
801044bf:	52                   	push   %edx
801044c0:	50                   	push   %eax
801044c1:	e8 ea 06 00 00       	call   80104bb0 <safestrcpy>

  pid = np->pid;
801044c6:	8b 73 10             	mov    0x10(%ebx),%esi

  acquire(&ptable.lock);
801044c9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801044d0:	e8 5b 04 00 00       	call   80104930 <acquire>

  np->state = RUNNABLE;
801044d5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
801044dc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801044e3:	e8 e8 03 00 00       	call   801048d0 <release>

  return pid;
801044e8:	83 c4 10             	add    $0x10,%esp
}
801044eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044ee:	89 f0                	mov    %esi,%eax
801044f0:	5b                   	pop    %ebx
801044f1:	5e                   	pop    %esi
801044f2:	5f                   	pop    %edi
801044f3:	5d                   	pop    %ebp
801044f4:	c3                   	ret    
    return -1;
801044f5:	be ff ff ff ff       	mov    $0xffffffff,%esi
801044fa:	eb ef                	jmp    801044eb <clone+0x10b>
801044fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104500 <join>:

int
join(void** stack)
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	56                   	push   %esi
80104504:	53                   	push   %ebx
  pushcli();
80104505:	e8 d6 02 00 00       	call   801047e0 <pushcli>
  c = mycpu();
8010450a:	e8 01 f5 ff ff       	call   80103a10 <mycpu>
  p = c->proc;
8010450f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104515:	e8 16 03 00 00       	call   80104830 <popcli>
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
8010451a:	83 ec 0c             	sub    $0xc,%esp
8010451d:	68 20 2d 11 80       	push   $0x80112d20
80104522:	e8 09 04 00 00       	call   80104930 <acquire>
80104527:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
8010452a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010452c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80104531:	eb 10                	jmp    80104543 <join+0x43>
80104533:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104537:	90                   	nop
80104538:	83 eb 80             	sub    $0xffffff80,%ebx
8010453b:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80104541:	74 1b                	je     8010455e <join+0x5e>
      if(p->parent != curproc)
80104543:	39 73 14             	cmp    %esi,0x14(%ebx)
80104546:	75 f0                	jne    80104538 <join+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104548:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010454c:	74 62                	je     801045b0 <join+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010454e:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80104551:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104556:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
8010455c:	75 e5                	jne    80104543 <join+0x43>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
8010455e:	85 c0                	test   %eax,%eax
80104560:	0f 84 a6 00 00 00    	je     8010460c <join+0x10c>
80104566:	8b 46 24             	mov    0x24(%esi),%eax
80104569:	85 c0                	test   %eax,%eax
8010456b:	0f 85 9b 00 00 00    	jne    8010460c <join+0x10c>
  pushcli();
80104571:	e8 6a 02 00 00       	call   801047e0 <pushcli>
  c = mycpu();
80104576:	e8 95 f4 ff ff       	call   80103a10 <mycpu>
  p = c->proc;
8010457b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104581:	e8 aa 02 00 00       	call   80104830 <popcli>
  if(p == 0)
80104586:	85 db                	test   %ebx,%ebx
80104588:	0f 84 95 00 00 00    	je     80104623 <join+0x123>
  p->chan = chan;
8010458e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104591:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104598:	e8 63 f8 ff ff       	call   80103e00 <sched>
  p->chan = 0;
8010459d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801045a4:	eb 84                	jmp    8010452a <join+0x2a>
801045a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045ad:	8d 76 00             	lea    0x0(%esi),%esi
	*stack = p->usp; //copying its user stack pointer to stack pointer 
801045b0:	8b 53 7c             	mov    0x7c(%ebx),%edx
801045b3:	8b 45 08             	mov    0x8(%ebp),%eax
        kfree(p->kstack);
801045b6:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
801045b9:	8b 73 10             	mov    0x10(%ebx),%esi
	*stack = p->usp; //copying its user stack pointer to stack pointer 
801045bc:	89 10                	mov    %edx,(%eax)
        kfree(p->kstack);
801045be:	ff 73 08             	pushl  0x8(%ebx)
801045c1:	e8 1a e0 ff ff       	call   801025e0 <kfree>
        p->kstack = 0;
801045c6:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        p->pid = 0;
801045cd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801045d4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801045db:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801045df:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
	p->usp = 0;
801045e6:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
        p->state = UNUSED;
801045ed:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801045f4:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801045fb:	e8 d0 02 00 00       	call   801048d0 <release>
        return pid;
80104600:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104603:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104606:	89 f0                	mov    %esi,%eax
80104608:	5b                   	pop    %ebx
80104609:	5e                   	pop    %esi
8010460a:	5d                   	pop    %ebp
8010460b:	c3                   	ret    
      release(&ptable.lock);
8010460c:	83 ec 0c             	sub    $0xc,%esp
      return -1;
8010460f:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104614:	68 20 2d 11 80       	push   $0x80112d20
80104619:	e8 b2 02 00 00       	call   801048d0 <release>
      return -1;
8010461e:	83 c4 10             	add    $0x10,%esp
80104621:	eb e0                	jmp    80104603 <join+0x103>
    panic("sleep");
80104623:	83 ec 0c             	sub    $0xc,%esp
80104626:	68 d4 7d 10 80       	push   $0x80107dd4
8010462b:	e8 50 bd ff ff       	call   80100380 <panic>

80104630 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	53                   	push   %ebx
80104634:	83 ec 0c             	sub    $0xc,%esp
80104637:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010463a:	68 64 7e 10 80       	push   $0x80107e64
8010463f:	8d 43 04             	lea    0x4(%ebx),%eax
80104642:	50                   	push   %eax
80104643:	e8 18 01 00 00       	call   80104760 <initlock>
  lk->name = name;
80104648:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010464b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104651:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104654:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010465b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010465e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104661:	c9                   	leave  
80104662:	c3                   	ret    
80104663:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010466a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104670 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	56                   	push   %esi
80104674:	53                   	push   %ebx
80104675:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104678:	8d 73 04             	lea    0x4(%ebx),%esi
8010467b:	83 ec 0c             	sub    $0xc,%esp
8010467e:	56                   	push   %esi
8010467f:	e8 ac 02 00 00       	call   80104930 <acquire>
  while (lk->locked) {
80104684:	8b 13                	mov    (%ebx),%edx
80104686:	83 c4 10             	add    $0x10,%esp
80104689:	85 d2                	test   %edx,%edx
8010468b:	74 16                	je     801046a3 <acquiresleep+0x33>
8010468d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104690:	83 ec 08             	sub    $0x8,%esp
80104693:	56                   	push   %esi
80104694:	53                   	push   %ebx
80104695:	e8 e6 fa ff ff       	call   80104180 <sleep>
  while (lk->locked) {
8010469a:	8b 03                	mov    (%ebx),%eax
8010469c:	83 c4 10             	add    $0x10,%esp
8010469f:	85 c0                	test   %eax,%eax
801046a1:	75 ed                	jne    80104690 <acquiresleep+0x20>
  }
  lk->locked = 1;
801046a3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801046a9:	e8 f2 f3 ff ff       	call   80103aa0 <myproc>
801046ae:	8b 40 10             	mov    0x10(%eax),%eax
801046b1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801046b4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801046b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046ba:	5b                   	pop    %ebx
801046bb:	5e                   	pop    %esi
801046bc:	5d                   	pop    %ebp
  release(&lk->lk);
801046bd:	e9 0e 02 00 00       	jmp    801048d0 <release>
801046c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046d0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	56                   	push   %esi
801046d4:	53                   	push   %ebx
801046d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801046d8:	8d 73 04             	lea    0x4(%ebx),%esi
801046db:	83 ec 0c             	sub    $0xc,%esp
801046de:	56                   	push   %esi
801046df:	e8 4c 02 00 00       	call   80104930 <acquire>
  lk->locked = 0;
801046e4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801046ea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801046f1:	89 1c 24             	mov    %ebx,(%esp)
801046f4:	e8 47 fb ff ff       	call   80104240 <wakeup>
  release(&lk->lk);
801046f9:	89 75 08             	mov    %esi,0x8(%ebp)
801046fc:	83 c4 10             	add    $0x10,%esp
}
801046ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104702:	5b                   	pop    %ebx
80104703:	5e                   	pop    %esi
80104704:	5d                   	pop    %ebp
  release(&lk->lk);
80104705:	e9 c6 01 00 00       	jmp    801048d0 <release>
8010470a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104710 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	57                   	push   %edi
80104714:	31 ff                	xor    %edi,%edi
80104716:	56                   	push   %esi
80104717:	53                   	push   %ebx
80104718:	83 ec 18             	sub    $0x18,%esp
8010471b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010471e:	8d 73 04             	lea    0x4(%ebx),%esi
80104721:	56                   	push   %esi
80104722:	e8 09 02 00 00       	call   80104930 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104727:	8b 03                	mov    (%ebx),%eax
80104729:	83 c4 10             	add    $0x10,%esp
8010472c:	85 c0                	test   %eax,%eax
8010472e:	75 18                	jne    80104748 <holdingsleep+0x38>
  release(&lk->lk);
80104730:	83 ec 0c             	sub    $0xc,%esp
80104733:	56                   	push   %esi
80104734:	e8 97 01 00 00       	call   801048d0 <release>
  return r;
}
80104739:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010473c:	89 f8                	mov    %edi,%eax
8010473e:	5b                   	pop    %ebx
8010473f:	5e                   	pop    %esi
80104740:	5f                   	pop    %edi
80104741:	5d                   	pop    %ebp
80104742:	c3                   	ret    
80104743:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104747:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80104748:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010474b:	e8 50 f3 ff ff       	call   80103aa0 <myproc>
80104750:	39 58 10             	cmp    %ebx,0x10(%eax)
80104753:	0f 94 c0             	sete   %al
80104756:	0f b6 c0             	movzbl %al,%eax
80104759:	89 c7                	mov    %eax,%edi
8010475b:	eb d3                	jmp    80104730 <holdingsleep+0x20>
8010475d:	66 90                	xchg   %ax,%ax
8010475f:	90                   	nop

80104760 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104766:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104769:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010476f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104772:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104779:	5d                   	pop    %ebp
8010477a:	c3                   	ret    
8010477b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010477f:	90                   	nop

80104780 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104780:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104781:	31 d2                	xor    %edx,%edx
{
80104783:	89 e5                	mov    %esp,%ebp
80104785:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104786:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104789:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010478c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
8010478f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104790:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104796:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010479c:	77 1a                	ja     801047b8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010479e:	8b 58 04             	mov    0x4(%eax),%ebx
801047a1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801047a4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801047a7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801047a9:	83 fa 0a             	cmp    $0xa,%edx
801047ac:	75 e2                	jne    80104790 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801047ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047b1:	c9                   	leave  
801047b2:	c3                   	ret    
801047b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047b7:	90                   	nop
  for(; i < 10; i++)
801047b8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801047bb:	8d 51 28             	lea    0x28(%ecx),%edx
801047be:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801047c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801047c6:	83 c0 04             	add    $0x4,%eax
801047c9:	39 d0                	cmp    %edx,%eax
801047cb:	75 f3                	jne    801047c0 <getcallerpcs+0x40>
}
801047cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047d0:	c9                   	leave  
801047d1:	c3                   	ret    
801047d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047e0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	53                   	push   %ebx
801047e4:	83 ec 04             	sub    $0x4,%esp
801047e7:	9c                   	pushf  
801047e8:	5b                   	pop    %ebx
  asm volatile("cli");
801047e9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801047ea:	e8 21 f2 ff ff       	call   80103a10 <mycpu>
801047ef:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801047f5:	85 c0                	test   %eax,%eax
801047f7:	74 17                	je     80104810 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801047f9:	e8 12 f2 ff ff       	call   80103a10 <mycpu>
801047fe:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104805:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104808:	c9                   	leave  
80104809:	c3                   	ret    
8010480a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104810:	e8 fb f1 ff ff       	call   80103a10 <mycpu>
80104815:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010481b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104821:	eb d6                	jmp    801047f9 <pushcli+0x19>
80104823:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010482a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104830 <popcli>:

void
popcli(void)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104836:	9c                   	pushf  
80104837:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104838:	f6 c4 02             	test   $0x2,%ah
8010483b:	75 35                	jne    80104872 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010483d:	e8 ce f1 ff ff       	call   80103a10 <mycpu>
80104842:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104849:	78 34                	js     8010487f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010484b:	e8 c0 f1 ff ff       	call   80103a10 <mycpu>
80104850:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104856:	85 d2                	test   %edx,%edx
80104858:	74 06                	je     80104860 <popcli+0x30>
    sti();
}
8010485a:	c9                   	leave  
8010485b:	c3                   	ret    
8010485c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104860:	e8 ab f1 ff ff       	call   80103a10 <mycpu>
80104865:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010486b:	85 c0                	test   %eax,%eax
8010486d:	74 eb                	je     8010485a <popcli+0x2a>
  asm volatile("sti");
8010486f:	fb                   	sti    
}
80104870:	c9                   	leave  
80104871:	c3                   	ret    
    panic("popcli - interruptible");
80104872:	83 ec 0c             	sub    $0xc,%esp
80104875:	68 6f 7e 10 80       	push   $0x80107e6f
8010487a:	e8 01 bb ff ff       	call   80100380 <panic>
    panic("popcli");
8010487f:	83 ec 0c             	sub    $0xc,%esp
80104882:	68 86 7e 10 80       	push   $0x80107e86
80104887:	e8 f4 ba ff ff       	call   80100380 <panic>
8010488c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104890 <holding>:
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	56                   	push   %esi
80104894:	53                   	push   %ebx
80104895:	8b 75 08             	mov    0x8(%ebp),%esi
80104898:	31 db                	xor    %ebx,%ebx
  pushcli();
8010489a:	e8 41 ff ff ff       	call   801047e0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010489f:	8b 06                	mov    (%esi),%eax
801048a1:	85 c0                	test   %eax,%eax
801048a3:	75 0b                	jne    801048b0 <holding+0x20>
  popcli();
801048a5:	e8 86 ff ff ff       	call   80104830 <popcli>
}
801048aa:	89 d8                	mov    %ebx,%eax
801048ac:	5b                   	pop    %ebx
801048ad:	5e                   	pop    %esi
801048ae:	5d                   	pop    %ebp
801048af:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
801048b0:	8b 5e 08             	mov    0x8(%esi),%ebx
801048b3:	e8 58 f1 ff ff       	call   80103a10 <mycpu>
801048b8:	39 c3                	cmp    %eax,%ebx
801048ba:	0f 94 c3             	sete   %bl
  popcli();
801048bd:	e8 6e ff ff ff       	call   80104830 <popcli>
  r = lock->locked && lock->cpu == mycpu();
801048c2:	0f b6 db             	movzbl %bl,%ebx
}
801048c5:	89 d8                	mov    %ebx,%eax
801048c7:	5b                   	pop    %ebx
801048c8:	5e                   	pop    %esi
801048c9:	5d                   	pop    %ebp
801048ca:	c3                   	ret    
801048cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048cf:	90                   	nop

801048d0 <release>:
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	56                   	push   %esi
801048d4:	53                   	push   %ebx
801048d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801048d8:	e8 03 ff ff ff       	call   801047e0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801048dd:	8b 03                	mov    (%ebx),%eax
801048df:	85 c0                	test   %eax,%eax
801048e1:	75 15                	jne    801048f8 <release+0x28>
  popcli();
801048e3:	e8 48 ff ff ff       	call   80104830 <popcli>
    panic("release");
801048e8:	83 ec 0c             	sub    $0xc,%esp
801048eb:	68 8d 7e 10 80       	push   $0x80107e8d
801048f0:	e8 8b ba ff ff       	call   80100380 <panic>
801048f5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801048f8:	8b 73 08             	mov    0x8(%ebx),%esi
801048fb:	e8 10 f1 ff ff       	call   80103a10 <mycpu>
80104900:	39 c6                	cmp    %eax,%esi
80104902:	75 df                	jne    801048e3 <release+0x13>
  popcli();
80104904:	e8 27 ff ff ff       	call   80104830 <popcli>
  lk->pcs[0] = 0;
80104909:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104910:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104917:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010491c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104922:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104925:	5b                   	pop    %ebx
80104926:	5e                   	pop    %esi
80104927:	5d                   	pop    %ebp
  popcli();
80104928:	e9 03 ff ff ff       	jmp    80104830 <popcli>
8010492d:	8d 76 00             	lea    0x0(%esi),%esi

80104930 <acquire>:
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	53                   	push   %ebx
80104934:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104937:	e8 a4 fe ff ff       	call   801047e0 <pushcli>
  if(holding(lk))
8010493c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010493f:	e8 9c fe ff ff       	call   801047e0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104944:	8b 03                	mov    (%ebx),%eax
80104946:	85 c0                	test   %eax,%eax
80104948:	75 7e                	jne    801049c8 <acquire+0x98>
  popcli();
8010494a:	e8 e1 fe ff ff       	call   80104830 <popcli>
  asm volatile("lock; xchgl %0, %1" :
8010494f:	b9 01 00 00 00       	mov    $0x1,%ecx
80104954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80104958:	8b 55 08             	mov    0x8(%ebp),%edx
8010495b:	89 c8                	mov    %ecx,%eax
8010495d:	f0 87 02             	lock xchg %eax,(%edx)
80104960:	85 c0                	test   %eax,%eax
80104962:	75 f4                	jne    80104958 <acquire+0x28>
  __sync_synchronize();
80104964:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104969:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010496c:	e8 9f f0 ff ff       	call   80103a10 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104971:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80104974:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80104976:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104979:	31 c0                	xor    %eax,%eax
8010497b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010497f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104980:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104986:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010498c:	77 1a                	ja     801049a8 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
8010498e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104991:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104995:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104998:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010499a:	83 f8 0a             	cmp    $0xa,%eax
8010499d:	75 e1                	jne    80104980 <acquire+0x50>
}
8010499f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049a2:	c9                   	leave  
801049a3:	c3                   	ret    
801049a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
801049a8:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
801049ac:	8d 51 34             	lea    0x34(%ecx),%edx
801049af:	90                   	nop
    pcs[i] = 0;
801049b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801049b6:	83 c0 04             	add    $0x4,%eax
801049b9:	39 c2                	cmp    %eax,%edx
801049bb:	75 f3                	jne    801049b0 <acquire+0x80>
}
801049bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049c0:	c9                   	leave  
801049c1:	c3                   	ret    
801049c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801049c8:	8b 5b 08             	mov    0x8(%ebx),%ebx
801049cb:	e8 40 f0 ff ff       	call   80103a10 <mycpu>
801049d0:	39 c3                	cmp    %eax,%ebx
801049d2:	0f 85 72 ff ff ff    	jne    8010494a <acquire+0x1a>
  popcli();
801049d8:	e8 53 fe ff ff       	call   80104830 <popcli>
    panic("acquire");
801049dd:	83 ec 0c             	sub    $0xc,%esp
801049e0:	68 95 7e 10 80       	push   $0x80107e95
801049e5:	e8 96 b9 ff ff       	call   80100380 <panic>
801049ea:	66 90                	xchg   %ax,%ax
801049ec:	66 90                	xchg   %ax,%ax
801049ee:	66 90                	xchg   %ax,%ax

801049f0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	57                   	push   %edi
801049f4:	8b 55 08             	mov    0x8(%ebp),%edx
801049f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801049fa:	53                   	push   %ebx
801049fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
801049fe:	89 d7                	mov    %edx,%edi
80104a00:	09 cf                	or     %ecx,%edi
80104a02:	83 e7 03             	and    $0x3,%edi
80104a05:	75 29                	jne    80104a30 <memset+0x40>
    c &= 0xFF;
80104a07:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104a0a:	c1 e0 18             	shl    $0x18,%eax
80104a0d:	89 fb                	mov    %edi,%ebx
80104a0f:	c1 e9 02             	shr    $0x2,%ecx
80104a12:	c1 e3 10             	shl    $0x10,%ebx
80104a15:	09 d8                	or     %ebx,%eax
80104a17:	09 f8                	or     %edi,%eax
80104a19:	c1 e7 08             	shl    $0x8,%edi
80104a1c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104a1e:	89 d7                	mov    %edx,%edi
80104a20:	fc                   	cld    
80104a21:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104a23:	5b                   	pop    %ebx
80104a24:	89 d0                	mov    %edx,%eax
80104a26:	5f                   	pop    %edi
80104a27:	5d                   	pop    %ebp
80104a28:	c3                   	ret    
80104a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104a30:	89 d7                	mov    %edx,%edi
80104a32:	fc                   	cld    
80104a33:	f3 aa                	rep stos %al,%es:(%edi)
80104a35:	5b                   	pop    %ebx
80104a36:	89 d0                	mov    %edx,%eax
80104a38:	5f                   	pop    %edi
80104a39:	5d                   	pop    %ebp
80104a3a:	c3                   	ret    
80104a3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a3f:	90                   	nop

80104a40 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	56                   	push   %esi
80104a44:	8b 75 10             	mov    0x10(%ebp),%esi
80104a47:	8b 55 08             	mov    0x8(%ebp),%edx
80104a4a:	53                   	push   %ebx
80104a4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104a4e:	85 f6                	test   %esi,%esi
80104a50:	74 2e                	je     80104a80 <memcmp+0x40>
80104a52:	01 c6                	add    %eax,%esi
80104a54:	eb 14                	jmp    80104a6a <memcmp+0x2a>
80104a56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104a60:	83 c0 01             	add    $0x1,%eax
80104a63:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104a66:	39 f0                	cmp    %esi,%eax
80104a68:	74 16                	je     80104a80 <memcmp+0x40>
    if(*s1 != *s2)
80104a6a:	0f b6 0a             	movzbl (%edx),%ecx
80104a6d:	0f b6 18             	movzbl (%eax),%ebx
80104a70:	38 d9                	cmp    %bl,%cl
80104a72:	74 ec                	je     80104a60 <memcmp+0x20>
      return *s1 - *s2;
80104a74:	0f b6 c1             	movzbl %cl,%eax
80104a77:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104a79:	5b                   	pop    %ebx
80104a7a:	5e                   	pop    %esi
80104a7b:	5d                   	pop    %ebp
80104a7c:	c3                   	ret    
80104a7d:	8d 76 00             	lea    0x0(%esi),%esi
80104a80:	5b                   	pop    %ebx
  return 0;
80104a81:	31 c0                	xor    %eax,%eax
}
80104a83:	5e                   	pop    %esi
80104a84:	5d                   	pop    %ebp
80104a85:	c3                   	ret    
80104a86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a8d:	8d 76 00             	lea    0x0(%esi),%esi

80104a90 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	57                   	push   %edi
80104a94:	8b 55 08             	mov    0x8(%ebp),%edx
80104a97:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104a9a:	56                   	push   %esi
80104a9b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104a9e:	39 d6                	cmp    %edx,%esi
80104aa0:	73 26                	jae    80104ac8 <memmove+0x38>
80104aa2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104aa5:	39 fa                	cmp    %edi,%edx
80104aa7:	73 1f                	jae    80104ac8 <memmove+0x38>
80104aa9:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104aac:	85 c9                	test   %ecx,%ecx
80104aae:	74 0c                	je     80104abc <memmove+0x2c>
      *--d = *--s;
80104ab0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104ab4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104ab7:	83 e8 01             	sub    $0x1,%eax
80104aba:	73 f4                	jae    80104ab0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104abc:	5e                   	pop    %esi
80104abd:	89 d0                	mov    %edx,%eax
80104abf:	5f                   	pop    %edi
80104ac0:	5d                   	pop    %ebp
80104ac1:	c3                   	ret    
80104ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104ac8:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104acb:	89 d7                	mov    %edx,%edi
80104acd:	85 c9                	test   %ecx,%ecx
80104acf:	74 eb                	je     80104abc <memmove+0x2c>
80104ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104ad8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104ad9:	39 f0                	cmp    %esi,%eax
80104adb:	75 fb                	jne    80104ad8 <memmove+0x48>
}
80104add:	5e                   	pop    %esi
80104ade:	89 d0                	mov    %edx,%eax
80104ae0:	5f                   	pop    %edi
80104ae1:	5d                   	pop    %ebp
80104ae2:	c3                   	ret    
80104ae3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104af0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104af0:	eb 9e                	jmp    80104a90 <memmove>
80104af2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b00 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	56                   	push   %esi
80104b04:	8b 75 10             	mov    0x10(%ebp),%esi
80104b07:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b0a:	53                   	push   %ebx
80104b0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
80104b0e:	85 f6                	test   %esi,%esi
80104b10:	74 36                	je     80104b48 <strncmp+0x48>
80104b12:	01 c6                	add    %eax,%esi
80104b14:	eb 18                	jmp    80104b2e <strncmp+0x2e>
80104b16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b1d:	8d 76 00             	lea    0x0(%esi),%esi
80104b20:	38 da                	cmp    %bl,%dl
80104b22:	75 14                	jne    80104b38 <strncmp+0x38>
    n--, p++, q++;
80104b24:	83 c0 01             	add    $0x1,%eax
80104b27:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104b2a:	39 f0                	cmp    %esi,%eax
80104b2c:	74 1a                	je     80104b48 <strncmp+0x48>
80104b2e:	0f b6 11             	movzbl (%ecx),%edx
80104b31:	0f b6 18             	movzbl (%eax),%ebx
80104b34:	84 d2                	test   %dl,%dl
80104b36:	75 e8                	jne    80104b20 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104b38:	0f b6 c2             	movzbl %dl,%eax
80104b3b:	29 d8                	sub    %ebx,%eax
}
80104b3d:	5b                   	pop    %ebx
80104b3e:	5e                   	pop    %esi
80104b3f:	5d                   	pop    %ebp
80104b40:	c3                   	ret    
80104b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b48:	5b                   	pop    %ebx
    return 0;
80104b49:	31 c0                	xor    %eax,%eax
}
80104b4b:	5e                   	pop    %esi
80104b4c:	5d                   	pop    %ebp
80104b4d:	c3                   	ret    
80104b4e:	66 90                	xchg   %ax,%ax

80104b50 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	57                   	push   %edi
80104b54:	56                   	push   %esi
80104b55:	8b 75 08             	mov    0x8(%ebp),%esi
80104b58:	53                   	push   %ebx
80104b59:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104b5c:	89 f2                	mov    %esi,%edx
80104b5e:	eb 17                	jmp    80104b77 <strncpy+0x27>
80104b60:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104b64:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104b67:	83 c2 01             	add    $0x1,%edx
80104b6a:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104b6e:	89 f9                	mov    %edi,%ecx
80104b70:	88 4a ff             	mov    %cl,-0x1(%edx)
80104b73:	84 c9                	test   %cl,%cl
80104b75:	74 09                	je     80104b80 <strncpy+0x30>
80104b77:	89 c3                	mov    %eax,%ebx
80104b79:	83 e8 01             	sub    $0x1,%eax
80104b7c:	85 db                	test   %ebx,%ebx
80104b7e:	7f e0                	jg     80104b60 <strncpy+0x10>
    ;
  while(n-- > 0)
80104b80:	89 d1                	mov    %edx,%ecx
80104b82:	85 c0                	test   %eax,%eax
80104b84:	7e 1d                	jle    80104ba3 <strncpy+0x53>
80104b86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b8d:	8d 76 00             	lea    0x0(%esi),%esi
    *s++ = 0;
80104b90:	83 c1 01             	add    $0x1,%ecx
80104b93:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80104b97:	89 c8                	mov    %ecx,%eax
80104b99:	f7 d0                	not    %eax
80104b9b:	01 d0                	add    %edx,%eax
80104b9d:	01 d8                	add    %ebx,%eax
80104b9f:	85 c0                	test   %eax,%eax
80104ba1:	7f ed                	jg     80104b90 <strncpy+0x40>
  return os;
}
80104ba3:	5b                   	pop    %ebx
80104ba4:	89 f0                	mov    %esi,%eax
80104ba6:	5e                   	pop    %esi
80104ba7:	5f                   	pop    %edi
80104ba8:	5d                   	pop    %ebp
80104ba9:	c3                   	ret    
80104baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104bb0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	56                   	push   %esi
80104bb4:	8b 55 10             	mov    0x10(%ebp),%edx
80104bb7:	8b 75 08             	mov    0x8(%ebp),%esi
80104bba:	53                   	push   %ebx
80104bbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104bbe:	85 d2                	test   %edx,%edx
80104bc0:	7e 25                	jle    80104be7 <safestrcpy+0x37>
80104bc2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104bc6:	89 f2                	mov    %esi,%edx
80104bc8:	eb 16                	jmp    80104be0 <safestrcpy+0x30>
80104bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104bd0:	0f b6 08             	movzbl (%eax),%ecx
80104bd3:	83 c0 01             	add    $0x1,%eax
80104bd6:	83 c2 01             	add    $0x1,%edx
80104bd9:	88 4a ff             	mov    %cl,-0x1(%edx)
80104bdc:	84 c9                	test   %cl,%cl
80104bde:	74 04                	je     80104be4 <safestrcpy+0x34>
80104be0:	39 d8                	cmp    %ebx,%eax
80104be2:	75 ec                	jne    80104bd0 <safestrcpy+0x20>
    ;
  *s = 0;
80104be4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104be7:	89 f0                	mov    %esi,%eax
80104be9:	5b                   	pop    %ebx
80104bea:	5e                   	pop    %esi
80104beb:	5d                   	pop    %ebp
80104bec:	c3                   	ret    
80104bed:	8d 76 00             	lea    0x0(%esi),%esi

80104bf0 <strlen>:

int
strlen(const char *s)
{
80104bf0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104bf1:	31 c0                	xor    %eax,%eax
{
80104bf3:	89 e5                	mov    %esp,%ebp
80104bf5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104bf8:	80 3a 00             	cmpb   $0x0,(%edx)
80104bfb:	74 0c                	je     80104c09 <strlen+0x19>
80104bfd:	8d 76 00             	lea    0x0(%esi),%esi
80104c00:	83 c0 01             	add    $0x1,%eax
80104c03:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104c07:	75 f7                	jne    80104c00 <strlen+0x10>
    ;
  return n;
}
80104c09:	5d                   	pop    %ebp
80104c0a:	c3                   	ret    

80104c0b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104c0b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104c0f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104c13:	55                   	push   %ebp
  pushl %ebx
80104c14:	53                   	push   %ebx
  pushl %esi
80104c15:	56                   	push   %esi
  pushl %edi
80104c16:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104c17:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104c19:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104c1b:	5f                   	pop    %edi
  popl %esi
80104c1c:	5e                   	pop    %esi
  popl %ebx
80104c1d:	5b                   	pop    %ebx
  popl %ebp
80104c1e:	5d                   	pop    %ebp
  ret #ret assume the top-most stack variable is %eip 
80104c1f:	c3                   	ret    

80104c20 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	53                   	push   %ebx
80104c24:	83 ec 04             	sub    $0x4,%esp
80104c27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104c2a:	e8 71 ee ff ff       	call   80103aa0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c2f:	8b 00                	mov    (%eax),%eax
80104c31:	39 d8                	cmp    %ebx,%eax
80104c33:	76 1b                	jbe    80104c50 <fetchint+0x30>
80104c35:	8d 53 04             	lea    0x4(%ebx),%edx
80104c38:	39 d0                	cmp    %edx,%eax
80104c3a:	72 14                	jb     80104c50 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104c3c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c3f:	8b 13                	mov    (%ebx),%edx
80104c41:	89 10                	mov    %edx,(%eax)
  return 0;
80104c43:	31 c0                	xor    %eax,%eax
}
80104c45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c48:	c9                   	leave  
80104c49:	c3                   	ret    
80104c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104c50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c55:	eb ee                	jmp    80104c45 <fetchint+0x25>
80104c57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c5e:	66 90                	xchg   %ax,%ax

80104c60 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	53                   	push   %ebx
80104c64:	83 ec 04             	sub    $0x4,%esp
80104c67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104c6a:	e8 31 ee ff ff       	call   80103aa0 <myproc>

  if(addr >= curproc->sz)
80104c6f:	39 18                	cmp    %ebx,(%eax)
80104c71:	76 2d                	jbe    80104ca0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104c73:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c76:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104c78:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104c7a:	39 d3                	cmp    %edx,%ebx
80104c7c:	73 22                	jae    80104ca0 <fetchstr+0x40>
80104c7e:	89 d8                	mov    %ebx,%eax
80104c80:	eb 0d                	jmp    80104c8f <fetchstr+0x2f>
80104c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c88:	83 c0 01             	add    $0x1,%eax
80104c8b:	39 c2                	cmp    %eax,%edx
80104c8d:	76 11                	jbe    80104ca0 <fetchstr+0x40>
    if(*s == 0)
80104c8f:	80 38 00             	cmpb   $0x0,(%eax)
80104c92:	75 f4                	jne    80104c88 <fetchstr+0x28>
      return s - *pp;
80104c94:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104c96:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c99:	c9                   	leave  
80104c9a:	c3                   	ret    
80104c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c9f:	90                   	nop
80104ca0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104ca3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ca8:	c9                   	leave  
80104ca9:	c3                   	ret    
80104caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104cb0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104cb0:	55                   	push   %ebp
80104cb1:	89 e5                	mov    %esp,%ebp
80104cb3:	56                   	push   %esi
80104cb4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104cb5:	e8 e6 ed ff ff       	call   80103aa0 <myproc>
80104cba:	8b 55 08             	mov    0x8(%ebp),%edx
80104cbd:	8b 40 18             	mov    0x18(%eax),%eax
80104cc0:	8b 40 44             	mov    0x44(%eax),%eax
80104cc3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104cc6:	e8 d5 ed ff ff       	call   80103aa0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ccb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104cce:	8b 00                	mov    (%eax),%eax
80104cd0:	39 c6                	cmp    %eax,%esi
80104cd2:	73 1c                	jae    80104cf0 <argint+0x40>
80104cd4:	8d 53 08             	lea    0x8(%ebx),%edx
80104cd7:	39 d0                	cmp    %edx,%eax
80104cd9:	72 15                	jb     80104cf0 <argint+0x40>
  *ip = *(int*)(addr);
80104cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cde:	8b 53 04             	mov    0x4(%ebx),%edx
80104ce1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ce3:	31 c0                	xor    %eax,%eax
}
80104ce5:	5b                   	pop    %ebx
80104ce6:	5e                   	pop    %esi
80104ce7:	5d                   	pop    %ebp
80104ce8:	c3                   	ret    
80104ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104cf5:	eb ee                	jmp    80104ce5 <argint+0x35>
80104cf7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cfe:	66 90                	xchg   %ax,%ax

80104d00 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	57                   	push   %edi
80104d04:	56                   	push   %esi
80104d05:	53                   	push   %ebx
80104d06:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104d09:	e8 92 ed ff ff       	call   80103aa0 <myproc>
80104d0e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d10:	e8 8b ed ff ff       	call   80103aa0 <myproc>
80104d15:	8b 55 08             	mov    0x8(%ebp),%edx
80104d18:	8b 40 18             	mov    0x18(%eax),%eax
80104d1b:	8b 40 44             	mov    0x44(%eax),%eax
80104d1e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104d21:	e8 7a ed ff ff       	call   80103aa0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d26:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d29:	8b 00                	mov    (%eax),%eax
80104d2b:	39 c7                	cmp    %eax,%edi
80104d2d:	73 31                	jae    80104d60 <argptr+0x60>
80104d2f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104d32:	39 c8                	cmp    %ecx,%eax
80104d34:	72 2a                	jb     80104d60 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d36:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104d39:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d3c:	85 d2                	test   %edx,%edx
80104d3e:	78 20                	js     80104d60 <argptr+0x60>
80104d40:	8b 16                	mov    (%esi),%edx
80104d42:	39 c2                	cmp    %eax,%edx
80104d44:	76 1a                	jbe    80104d60 <argptr+0x60>
80104d46:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104d49:	01 c3                	add    %eax,%ebx
80104d4b:	39 da                	cmp    %ebx,%edx
80104d4d:	72 11                	jb     80104d60 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104d4f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d52:	89 02                	mov    %eax,(%edx)
  return 0;
80104d54:	31 c0                	xor    %eax,%eax
}
80104d56:	83 c4 0c             	add    $0xc,%esp
80104d59:	5b                   	pop    %ebx
80104d5a:	5e                   	pop    %esi
80104d5b:	5f                   	pop    %edi
80104d5c:	5d                   	pop    %ebp
80104d5d:	c3                   	ret    
80104d5e:	66 90                	xchg   %ax,%ax
    return -1;
80104d60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d65:	eb ef                	jmp    80104d56 <argptr+0x56>
80104d67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d6e:	66 90                	xchg   %ax,%ax

80104d70 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	56                   	push   %esi
80104d74:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d75:	e8 26 ed ff ff       	call   80103aa0 <myproc>
80104d7a:	8b 55 08             	mov    0x8(%ebp),%edx
80104d7d:	8b 40 18             	mov    0x18(%eax),%eax
80104d80:	8b 40 44             	mov    0x44(%eax),%eax
80104d83:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104d86:	e8 15 ed ff ff       	call   80103aa0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d8b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d8e:	8b 00                	mov    (%eax),%eax
80104d90:	39 c6                	cmp    %eax,%esi
80104d92:	73 44                	jae    80104dd8 <argstr+0x68>
80104d94:	8d 53 08             	lea    0x8(%ebx),%edx
80104d97:	39 d0                	cmp    %edx,%eax
80104d99:	72 3d                	jb     80104dd8 <argstr+0x68>
  *ip = *(int*)(addr);
80104d9b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104d9e:	e8 fd ec ff ff       	call   80103aa0 <myproc>
  if(addr >= curproc->sz)
80104da3:	3b 18                	cmp    (%eax),%ebx
80104da5:	73 31                	jae    80104dd8 <argstr+0x68>
  *pp = (char*)addr;
80104da7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104daa:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104dac:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104dae:	39 d3                	cmp    %edx,%ebx
80104db0:	73 26                	jae    80104dd8 <argstr+0x68>
80104db2:	89 d8                	mov    %ebx,%eax
80104db4:	eb 11                	jmp    80104dc7 <argstr+0x57>
80104db6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dbd:	8d 76 00             	lea    0x0(%esi),%esi
80104dc0:	83 c0 01             	add    $0x1,%eax
80104dc3:	39 c2                	cmp    %eax,%edx
80104dc5:	76 11                	jbe    80104dd8 <argstr+0x68>
    if(*s == 0)
80104dc7:	80 38 00             	cmpb   $0x0,(%eax)
80104dca:	75 f4                	jne    80104dc0 <argstr+0x50>
      return s - *pp;
80104dcc:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104dce:	5b                   	pop    %ebx
80104dcf:	5e                   	pop    %esi
80104dd0:	5d                   	pop    %ebp
80104dd1:	c3                   	ret    
80104dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104dd8:	5b                   	pop    %ebx
    return -1;
80104dd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104dde:	5e                   	pop    %esi
80104ddf:	5d                   	pop    %ebp
80104de0:	c3                   	ret    
80104de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104de8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104def:	90                   	nop

80104df0 <syscall>:
[SYS_join]	sys_join,
};

void
syscall(void)
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	53                   	push   %ebx
80104df4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104df7:	e8 a4 ec ff ff       	call   80103aa0 <myproc>
80104dfc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104dfe:	8b 40 18             	mov    0x18(%eax),%eax
80104e01:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104e04:	8d 50 ff             	lea    -0x1(%eax),%edx
80104e07:	83 fa 18             	cmp    $0x18,%edx
80104e0a:	77 24                	ja     80104e30 <syscall+0x40>
80104e0c:	8b 14 85 c0 7e 10 80 	mov    -0x7fef8140(,%eax,4),%edx
80104e13:	85 d2                	test   %edx,%edx
80104e15:	74 19                	je     80104e30 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104e17:	ff d2                	call   *%edx
80104e19:	89 c2                	mov    %eax,%edx
80104e1b:	8b 43 18             	mov    0x18(%ebx),%eax
80104e1e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104e21:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e24:	c9                   	leave  
80104e25:	c3                   	ret    
80104e26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e2d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104e30:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104e31:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104e34:	50                   	push   %eax
80104e35:	ff 73 10             	pushl  0x10(%ebx)
80104e38:	68 9d 7e 10 80       	push   $0x80107e9d
80104e3d:	e8 3e b8 ff ff       	call   80100680 <cprintf>
    curproc->tf->eax = -1;
80104e42:	8b 43 18             	mov    0x18(%ebx),%eax
80104e45:	83 c4 10             	add    $0x10,%esp
80104e48:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104e4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e52:	c9                   	leave  
80104e53:	c3                   	ret    
80104e54:	66 90                	xchg   %ax,%ax
80104e56:	66 90                	xchg   %ax,%ax
80104e58:	66 90                	xchg   %ax,%ax
80104e5a:	66 90                	xchg   %ax,%ax
80104e5c:	66 90                	xchg   %ax,%ax
80104e5e:	66 90                	xchg   %ax,%ax

80104e60 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	57                   	push   %edi
80104e64:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104e65:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104e68:	53                   	push   %ebx
80104e69:	83 ec 34             	sub    $0x34,%esp
80104e6c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104e6f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104e72:	57                   	push   %edi
80104e73:	50                   	push   %eax
{
80104e74:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104e77:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104e7a:	e8 61 d3 ff ff       	call   801021e0 <nameiparent>
80104e7f:	83 c4 10             	add    $0x10,%esp
80104e82:	85 c0                	test   %eax,%eax
80104e84:	0f 84 46 01 00 00    	je     80104fd0 <create+0x170>
    return 0;
  ilock(dp);
80104e8a:	83 ec 0c             	sub    $0xc,%esp
80104e8d:	89 c3                	mov    %eax,%ebx
80104e8f:	50                   	push   %eax
80104e90:	e8 0b ca ff ff       	call   801018a0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104e95:	83 c4 0c             	add    $0xc,%esp
80104e98:	6a 00                	push   $0x0
80104e9a:	57                   	push   %edi
80104e9b:	53                   	push   %ebx
80104e9c:	e8 5f cf ff ff       	call   80101e00 <dirlookup>
80104ea1:	83 c4 10             	add    $0x10,%esp
80104ea4:	89 c6                	mov    %eax,%esi
80104ea6:	85 c0                	test   %eax,%eax
80104ea8:	74 56                	je     80104f00 <create+0xa0>
    iunlockput(dp);
80104eaa:	83 ec 0c             	sub    $0xc,%esp
80104ead:	53                   	push   %ebx
80104eae:	e8 7d cc ff ff       	call   80101b30 <iunlockput>
    ilock(ip);
80104eb3:	89 34 24             	mov    %esi,(%esp)
80104eb6:	e8 e5 c9 ff ff       	call   801018a0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104ebb:	83 c4 10             	add    $0x10,%esp
80104ebe:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104ec3:	75 1b                	jne    80104ee0 <create+0x80>
80104ec5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104eca:	75 14                	jne    80104ee0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104ecc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ecf:	89 f0                	mov    %esi,%eax
80104ed1:	5b                   	pop    %ebx
80104ed2:	5e                   	pop    %esi
80104ed3:	5f                   	pop    %edi
80104ed4:	5d                   	pop    %ebp
80104ed5:	c3                   	ret    
80104ed6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104edd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80104ee0:	83 ec 0c             	sub    $0xc,%esp
80104ee3:	56                   	push   %esi
    return 0;
80104ee4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104ee6:	e8 45 cc ff ff       	call   80101b30 <iunlockput>
    return 0;
80104eeb:	83 c4 10             	add    $0x10,%esp
}
80104eee:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ef1:	89 f0                	mov    %esi,%eax
80104ef3:	5b                   	pop    %ebx
80104ef4:	5e                   	pop    %esi
80104ef5:	5f                   	pop    %edi
80104ef6:	5d                   	pop    %ebp
80104ef7:	c3                   	ret    
80104ef8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eff:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104f00:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104f04:	83 ec 08             	sub    $0x8,%esp
80104f07:	50                   	push   %eax
80104f08:	ff 33                	pushl  (%ebx)
80104f0a:	e8 21 c8 ff ff       	call   80101730 <ialloc>
80104f0f:	83 c4 10             	add    $0x10,%esp
80104f12:	89 c6                	mov    %eax,%esi
80104f14:	85 c0                	test   %eax,%eax
80104f16:	0f 84 cd 00 00 00    	je     80104fe9 <create+0x189>
  ilock(ip);
80104f1c:	83 ec 0c             	sub    $0xc,%esp
80104f1f:	50                   	push   %eax
80104f20:	e8 7b c9 ff ff       	call   801018a0 <ilock>
  ip->major = major;
80104f25:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104f29:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104f2d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104f31:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104f35:	b8 01 00 00 00       	mov    $0x1,%eax
80104f3a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104f3e:	89 34 24             	mov    %esi,(%esp)
80104f41:	e8 aa c8 ff ff       	call   801017f0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104f46:	83 c4 10             	add    $0x10,%esp
80104f49:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104f4e:	74 30                	je     80104f80 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104f50:	83 ec 04             	sub    $0x4,%esp
80104f53:	ff 76 04             	pushl  0x4(%esi)
80104f56:	57                   	push   %edi
80104f57:	53                   	push   %ebx
80104f58:	e8 a3 d1 ff ff       	call   80102100 <dirlink>
80104f5d:	83 c4 10             	add    $0x10,%esp
80104f60:	85 c0                	test   %eax,%eax
80104f62:	78 78                	js     80104fdc <create+0x17c>
  iunlockput(dp);
80104f64:	83 ec 0c             	sub    $0xc,%esp
80104f67:	53                   	push   %ebx
80104f68:	e8 c3 cb ff ff       	call   80101b30 <iunlockput>
  return ip;
80104f6d:	83 c4 10             	add    $0x10,%esp
}
80104f70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f73:	89 f0                	mov    %esi,%eax
80104f75:	5b                   	pop    %ebx
80104f76:	5e                   	pop    %esi
80104f77:	5f                   	pop    %edi
80104f78:	5d                   	pop    %ebp
80104f79:	c3                   	ret    
80104f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104f80:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104f83:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104f88:	53                   	push   %ebx
80104f89:	e8 62 c8 ff ff       	call   801017f0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104f8e:	83 c4 0c             	add    $0xc,%esp
80104f91:	ff 76 04             	pushl  0x4(%esi)
80104f94:	68 44 7f 10 80       	push   $0x80107f44
80104f99:	56                   	push   %esi
80104f9a:	e8 61 d1 ff ff       	call   80102100 <dirlink>
80104f9f:	83 c4 10             	add    $0x10,%esp
80104fa2:	85 c0                	test   %eax,%eax
80104fa4:	78 18                	js     80104fbe <create+0x15e>
80104fa6:	83 ec 04             	sub    $0x4,%esp
80104fa9:	ff 73 04             	pushl  0x4(%ebx)
80104fac:	68 43 7f 10 80       	push   $0x80107f43
80104fb1:	56                   	push   %esi
80104fb2:	e8 49 d1 ff ff       	call   80102100 <dirlink>
80104fb7:	83 c4 10             	add    $0x10,%esp
80104fba:	85 c0                	test   %eax,%eax
80104fbc:	79 92                	jns    80104f50 <create+0xf0>
      panic("create dots");
80104fbe:	83 ec 0c             	sub    $0xc,%esp
80104fc1:	68 37 7f 10 80       	push   $0x80107f37
80104fc6:	e8 b5 b3 ff ff       	call   80100380 <panic>
80104fcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fcf:	90                   	nop
}
80104fd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104fd3:	31 f6                	xor    %esi,%esi
}
80104fd5:	5b                   	pop    %ebx
80104fd6:	89 f0                	mov    %esi,%eax
80104fd8:	5e                   	pop    %esi
80104fd9:	5f                   	pop    %edi
80104fda:	5d                   	pop    %ebp
80104fdb:	c3                   	ret    
    panic("create: dirlink");
80104fdc:	83 ec 0c             	sub    $0xc,%esp
80104fdf:	68 46 7f 10 80       	push   $0x80107f46
80104fe4:	e8 97 b3 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104fe9:	83 ec 0c             	sub    $0xc,%esp
80104fec:	68 28 7f 10 80       	push   $0x80107f28
80104ff1:	e8 8a b3 ff ff       	call   80100380 <panic>
80104ff6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ffd:	8d 76 00             	lea    0x0(%esi),%esi

80105000 <sys_dup>:
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	56                   	push   %esi
80105004:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105005:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105008:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010500b:	50                   	push   %eax
8010500c:	6a 00                	push   $0x0
8010500e:	e8 9d fc ff ff       	call   80104cb0 <argint>
80105013:	83 c4 10             	add    $0x10,%esp
80105016:	85 c0                	test   %eax,%eax
80105018:	78 36                	js     80105050 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010501a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010501e:	77 30                	ja     80105050 <sys_dup+0x50>
80105020:	e8 7b ea ff ff       	call   80103aa0 <myproc>
80105025:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105028:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010502c:	85 f6                	test   %esi,%esi
8010502e:	74 20                	je     80105050 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105030:	e8 6b ea ff ff       	call   80103aa0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105035:	31 db                	xor    %ebx,%ebx
80105037:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010503e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105040:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105044:	85 d2                	test   %edx,%edx
80105046:	74 18                	je     80105060 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105048:	83 c3 01             	add    $0x1,%ebx
8010504b:	83 fb 10             	cmp    $0x10,%ebx
8010504e:	75 f0                	jne    80105040 <sys_dup+0x40>
}
80105050:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105053:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105058:	89 d8                	mov    %ebx,%eax
8010505a:	5b                   	pop    %ebx
8010505b:	5e                   	pop    %esi
8010505c:	5d                   	pop    %ebp
8010505d:	c3                   	ret    
8010505e:	66 90                	xchg   %ax,%ax
  filedup(f);
80105060:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105063:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105067:	56                   	push   %esi
80105068:	e8 63 bf ff ff       	call   80100fd0 <filedup>
  return fd;
8010506d:	83 c4 10             	add    $0x10,%esp
}
80105070:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105073:	89 d8                	mov    %ebx,%eax
80105075:	5b                   	pop    %ebx
80105076:	5e                   	pop    %esi
80105077:	5d                   	pop    %ebp
80105078:	c3                   	ret    
80105079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105080 <sys_read>:
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	56                   	push   %esi
80105084:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105085:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105088:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010508b:	53                   	push   %ebx
8010508c:	6a 00                	push   $0x0
8010508e:	e8 1d fc ff ff       	call   80104cb0 <argint>
80105093:	83 c4 10             	add    $0x10,%esp
80105096:	85 c0                	test   %eax,%eax
80105098:	78 5e                	js     801050f8 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010509a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010509e:	77 58                	ja     801050f8 <sys_read+0x78>
801050a0:	e8 fb e9 ff ff       	call   80103aa0 <myproc>
801050a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050a8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801050ac:	85 f6                	test   %esi,%esi
801050ae:	74 48                	je     801050f8 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801050b0:	83 ec 08             	sub    $0x8,%esp
801050b3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050b6:	50                   	push   %eax
801050b7:	6a 02                	push   $0x2
801050b9:	e8 f2 fb ff ff       	call   80104cb0 <argint>
801050be:	83 c4 10             	add    $0x10,%esp
801050c1:	85 c0                	test   %eax,%eax
801050c3:	78 33                	js     801050f8 <sys_read+0x78>
801050c5:	83 ec 04             	sub    $0x4,%esp
801050c8:	ff 75 f0             	pushl  -0x10(%ebp)
801050cb:	53                   	push   %ebx
801050cc:	6a 01                	push   $0x1
801050ce:	e8 2d fc ff ff       	call   80104d00 <argptr>
801050d3:	83 c4 10             	add    $0x10,%esp
801050d6:	85 c0                	test   %eax,%eax
801050d8:	78 1e                	js     801050f8 <sys_read+0x78>
  return fileread(f, p, n);
801050da:	83 ec 04             	sub    $0x4,%esp
801050dd:	ff 75 f0             	pushl  -0x10(%ebp)
801050e0:	ff 75 f4             	pushl  -0xc(%ebp)
801050e3:	56                   	push   %esi
801050e4:	e8 67 c0 ff ff       	call   80101150 <fileread>
801050e9:	83 c4 10             	add    $0x10,%esp
}
801050ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050ef:	5b                   	pop    %ebx
801050f0:	5e                   	pop    %esi
801050f1:	5d                   	pop    %ebp
801050f2:	c3                   	ret    
801050f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050f7:	90                   	nop
    return -1;
801050f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050fd:	eb ed                	jmp    801050ec <sys_read+0x6c>
801050ff:	90                   	nop

80105100 <sys_write>:
{
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	56                   	push   %esi
80105104:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105105:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105108:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010510b:	53                   	push   %ebx
8010510c:	6a 00                	push   $0x0
8010510e:	e8 9d fb ff ff       	call   80104cb0 <argint>
80105113:	83 c4 10             	add    $0x10,%esp
80105116:	85 c0                	test   %eax,%eax
80105118:	78 5e                	js     80105178 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010511a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010511e:	77 58                	ja     80105178 <sys_write+0x78>
80105120:	e8 7b e9 ff ff       	call   80103aa0 <myproc>
80105125:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105128:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010512c:	85 f6                	test   %esi,%esi
8010512e:	74 48                	je     80105178 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105130:	83 ec 08             	sub    $0x8,%esp
80105133:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105136:	50                   	push   %eax
80105137:	6a 02                	push   $0x2
80105139:	e8 72 fb ff ff       	call   80104cb0 <argint>
8010513e:	83 c4 10             	add    $0x10,%esp
80105141:	85 c0                	test   %eax,%eax
80105143:	78 33                	js     80105178 <sys_write+0x78>
80105145:	83 ec 04             	sub    $0x4,%esp
80105148:	ff 75 f0             	pushl  -0x10(%ebp)
8010514b:	53                   	push   %ebx
8010514c:	6a 01                	push   $0x1
8010514e:	e8 ad fb ff ff       	call   80104d00 <argptr>
80105153:	83 c4 10             	add    $0x10,%esp
80105156:	85 c0                	test   %eax,%eax
80105158:	78 1e                	js     80105178 <sys_write+0x78>
  return filewrite(f, p, n);
8010515a:	83 ec 04             	sub    $0x4,%esp
8010515d:	ff 75 f0             	pushl  -0x10(%ebp)
80105160:	ff 75 f4             	pushl  -0xc(%ebp)
80105163:	56                   	push   %esi
80105164:	e8 77 c0 ff ff       	call   801011e0 <filewrite>
80105169:	83 c4 10             	add    $0x10,%esp
}
8010516c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010516f:	5b                   	pop    %ebx
80105170:	5e                   	pop    %esi
80105171:	5d                   	pop    %ebp
80105172:	c3                   	ret    
80105173:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105177:	90                   	nop
    return -1;
80105178:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010517d:	eb ed                	jmp    8010516c <sys_write+0x6c>
8010517f:	90                   	nop

80105180 <sys_close>:
{
80105180:	55                   	push   %ebp
80105181:	89 e5                	mov    %esp,%ebp
80105183:	56                   	push   %esi
80105184:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105185:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105188:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010518b:	50                   	push   %eax
8010518c:	6a 00                	push   $0x0
8010518e:	e8 1d fb ff ff       	call   80104cb0 <argint>
80105193:	83 c4 10             	add    $0x10,%esp
80105196:	85 c0                	test   %eax,%eax
80105198:	78 3e                	js     801051d8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010519a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010519e:	77 38                	ja     801051d8 <sys_close+0x58>
801051a0:	e8 fb e8 ff ff       	call   80103aa0 <myproc>
801051a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801051a8:	8d 5a 08             	lea    0x8(%edx),%ebx
801051ab:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801051af:	85 f6                	test   %esi,%esi
801051b1:	74 25                	je     801051d8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801051b3:	e8 e8 e8 ff ff       	call   80103aa0 <myproc>
  fileclose(f);
801051b8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801051bb:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801051c2:	00 
  fileclose(f);
801051c3:	56                   	push   %esi
801051c4:	e8 57 be ff ff       	call   80101020 <fileclose>
  return 0;
801051c9:	83 c4 10             	add    $0x10,%esp
801051cc:	31 c0                	xor    %eax,%eax
}
801051ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051d1:	5b                   	pop    %ebx
801051d2:	5e                   	pop    %esi
801051d3:	5d                   	pop    %ebp
801051d4:	c3                   	ret    
801051d5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801051d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051dd:	eb ef                	jmp    801051ce <sys_close+0x4e>
801051df:	90                   	nop

801051e0 <sys_fstat>:
{
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	56                   	push   %esi
801051e4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801051e5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801051e8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801051eb:	53                   	push   %ebx
801051ec:	6a 00                	push   $0x0
801051ee:	e8 bd fa ff ff       	call   80104cb0 <argint>
801051f3:	83 c4 10             	add    $0x10,%esp
801051f6:	85 c0                	test   %eax,%eax
801051f8:	78 46                	js     80105240 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801051fa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801051fe:	77 40                	ja     80105240 <sys_fstat+0x60>
80105200:	e8 9b e8 ff ff       	call   80103aa0 <myproc>
80105205:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105208:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010520c:	85 f6                	test   %esi,%esi
8010520e:	74 30                	je     80105240 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105210:	83 ec 04             	sub    $0x4,%esp
80105213:	6a 14                	push   $0x14
80105215:	53                   	push   %ebx
80105216:	6a 01                	push   $0x1
80105218:	e8 e3 fa ff ff       	call   80104d00 <argptr>
8010521d:	83 c4 10             	add    $0x10,%esp
80105220:	85 c0                	test   %eax,%eax
80105222:	78 1c                	js     80105240 <sys_fstat+0x60>
  return filestat(f, st);
80105224:	83 ec 08             	sub    $0x8,%esp
80105227:	ff 75 f4             	pushl  -0xc(%ebp)
8010522a:	56                   	push   %esi
8010522b:	e8 d0 be ff ff       	call   80101100 <filestat>
80105230:	83 c4 10             	add    $0x10,%esp
}
80105233:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105236:	5b                   	pop    %ebx
80105237:	5e                   	pop    %esi
80105238:	5d                   	pop    %ebp
80105239:	c3                   	ret    
8010523a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105240:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105245:	eb ec                	jmp    80105233 <sys_fstat+0x53>
80105247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010524e:	66 90                	xchg   %ax,%ax

80105250 <sys_link>:
{
80105250:	55                   	push   %ebp
80105251:	89 e5                	mov    %esp,%ebp
80105253:	57                   	push   %edi
80105254:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105255:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105258:	53                   	push   %ebx
80105259:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010525c:	50                   	push   %eax
8010525d:	6a 00                	push   $0x0
8010525f:	e8 0c fb ff ff       	call   80104d70 <argstr>
80105264:	83 c4 10             	add    $0x10,%esp
80105267:	85 c0                	test   %eax,%eax
80105269:	0f 88 fb 00 00 00    	js     8010536a <sys_link+0x11a>
8010526f:	83 ec 08             	sub    $0x8,%esp
80105272:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105275:	50                   	push   %eax
80105276:	6a 01                	push   $0x1
80105278:	e8 f3 fa ff ff       	call   80104d70 <argstr>
8010527d:	83 c4 10             	add    $0x10,%esp
80105280:	85 c0                	test   %eax,%eax
80105282:	0f 88 e2 00 00 00    	js     8010536a <sys_link+0x11a>
  begin_op();
80105288:	e8 f3 db ff ff       	call   80102e80 <begin_op>
  if((ip = namei(old)) == 0){
8010528d:	83 ec 0c             	sub    $0xc,%esp
80105290:	ff 75 d4             	pushl  -0x2c(%ebp)
80105293:	e8 28 cf ff ff       	call   801021c0 <namei>
80105298:	83 c4 10             	add    $0x10,%esp
8010529b:	89 c3                	mov    %eax,%ebx
8010529d:	85 c0                	test   %eax,%eax
8010529f:	0f 84 e4 00 00 00    	je     80105389 <sys_link+0x139>
  ilock(ip);
801052a5:	83 ec 0c             	sub    $0xc,%esp
801052a8:	50                   	push   %eax
801052a9:	e8 f2 c5 ff ff       	call   801018a0 <ilock>
  if(ip->type == T_DIR){
801052ae:	83 c4 10             	add    $0x10,%esp
801052b1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052b6:	0f 84 b5 00 00 00    	je     80105371 <sys_link+0x121>
  iupdate(ip);
801052bc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801052bf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801052c4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801052c7:	53                   	push   %ebx
801052c8:	e8 23 c5 ff ff       	call   801017f0 <iupdate>
  iunlock(ip);
801052cd:	89 1c 24             	mov    %ebx,(%esp)
801052d0:	e8 ab c6 ff ff       	call   80101980 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801052d5:	58                   	pop    %eax
801052d6:	5a                   	pop    %edx
801052d7:	57                   	push   %edi
801052d8:	ff 75 d0             	pushl  -0x30(%ebp)
801052db:	e8 00 cf ff ff       	call   801021e0 <nameiparent>
801052e0:	83 c4 10             	add    $0x10,%esp
801052e3:	89 c6                	mov    %eax,%esi
801052e5:	85 c0                	test   %eax,%eax
801052e7:	74 5b                	je     80105344 <sys_link+0xf4>
  ilock(dp);
801052e9:	83 ec 0c             	sub    $0xc,%esp
801052ec:	50                   	push   %eax
801052ed:	e8 ae c5 ff ff       	call   801018a0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801052f2:	8b 03                	mov    (%ebx),%eax
801052f4:	83 c4 10             	add    $0x10,%esp
801052f7:	39 06                	cmp    %eax,(%esi)
801052f9:	75 3d                	jne    80105338 <sys_link+0xe8>
801052fb:	83 ec 04             	sub    $0x4,%esp
801052fe:	ff 73 04             	pushl  0x4(%ebx)
80105301:	57                   	push   %edi
80105302:	56                   	push   %esi
80105303:	e8 f8 cd ff ff       	call   80102100 <dirlink>
80105308:	83 c4 10             	add    $0x10,%esp
8010530b:	85 c0                	test   %eax,%eax
8010530d:	78 29                	js     80105338 <sys_link+0xe8>
  iunlockput(dp);
8010530f:	83 ec 0c             	sub    $0xc,%esp
80105312:	56                   	push   %esi
80105313:	e8 18 c8 ff ff       	call   80101b30 <iunlockput>
  iput(ip);
80105318:	89 1c 24             	mov    %ebx,(%esp)
8010531b:	e8 b0 c6 ff ff       	call   801019d0 <iput>
  end_op();
80105320:	e8 cb db ff ff       	call   80102ef0 <end_op>
  return 0;
80105325:	83 c4 10             	add    $0x10,%esp
80105328:	31 c0                	xor    %eax,%eax
}
8010532a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010532d:	5b                   	pop    %ebx
8010532e:	5e                   	pop    %esi
8010532f:	5f                   	pop    %edi
80105330:	5d                   	pop    %ebp
80105331:	c3                   	ret    
80105332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105338:	83 ec 0c             	sub    $0xc,%esp
8010533b:	56                   	push   %esi
8010533c:	e8 ef c7 ff ff       	call   80101b30 <iunlockput>
    goto bad;
80105341:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105344:	83 ec 0c             	sub    $0xc,%esp
80105347:	53                   	push   %ebx
80105348:	e8 53 c5 ff ff       	call   801018a0 <ilock>
  ip->nlink--;
8010534d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105352:	89 1c 24             	mov    %ebx,(%esp)
80105355:	e8 96 c4 ff ff       	call   801017f0 <iupdate>
  iunlockput(ip);
8010535a:	89 1c 24             	mov    %ebx,(%esp)
8010535d:	e8 ce c7 ff ff       	call   80101b30 <iunlockput>
  end_op();
80105362:	e8 89 db ff ff       	call   80102ef0 <end_op>
  return -1;
80105367:	83 c4 10             	add    $0x10,%esp
8010536a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010536f:	eb b9                	jmp    8010532a <sys_link+0xda>
    iunlockput(ip);
80105371:	83 ec 0c             	sub    $0xc,%esp
80105374:	53                   	push   %ebx
80105375:	e8 b6 c7 ff ff       	call   80101b30 <iunlockput>
    end_op();
8010537a:	e8 71 db ff ff       	call   80102ef0 <end_op>
    return -1;
8010537f:	83 c4 10             	add    $0x10,%esp
80105382:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105387:	eb a1                	jmp    8010532a <sys_link+0xda>
    end_op();
80105389:	e8 62 db ff ff       	call   80102ef0 <end_op>
    return -1;
8010538e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105393:	eb 95                	jmp    8010532a <sys_link+0xda>
80105395:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010539c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053a0 <sys_unlink>:
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	57                   	push   %edi
801053a4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801053a5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801053a8:	53                   	push   %ebx
801053a9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801053ac:	50                   	push   %eax
801053ad:	6a 00                	push   $0x0
801053af:	e8 bc f9 ff ff       	call   80104d70 <argstr>
801053b4:	83 c4 10             	add    $0x10,%esp
801053b7:	85 c0                	test   %eax,%eax
801053b9:	0f 88 7a 01 00 00    	js     80105539 <sys_unlink+0x199>
  begin_op();
801053bf:	e8 bc da ff ff       	call   80102e80 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801053c4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801053c7:	83 ec 08             	sub    $0x8,%esp
801053ca:	53                   	push   %ebx
801053cb:	ff 75 c0             	pushl  -0x40(%ebp)
801053ce:	e8 0d ce ff ff       	call   801021e0 <nameiparent>
801053d3:	83 c4 10             	add    $0x10,%esp
801053d6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801053d9:	85 c0                	test   %eax,%eax
801053db:	0f 84 62 01 00 00    	je     80105543 <sys_unlink+0x1a3>
  ilock(dp);
801053e1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801053e4:	83 ec 0c             	sub    $0xc,%esp
801053e7:	57                   	push   %edi
801053e8:	e8 b3 c4 ff ff       	call   801018a0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801053ed:	58                   	pop    %eax
801053ee:	5a                   	pop    %edx
801053ef:	68 44 7f 10 80       	push   $0x80107f44
801053f4:	53                   	push   %ebx
801053f5:	e8 e6 c9 ff ff       	call   80101de0 <namecmp>
801053fa:	83 c4 10             	add    $0x10,%esp
801053fd:	85 c0                	test   %eax,%eax
801053ff:	0f 84 fb 00 00 00    	je     80105500 <sys_unlink+0x160>
80105405:	83 ec 08             	sub    $0x8,%esp
80105408:	68 43 7f 10 80       	push   $0x80107f43
8010540d:	53                   	push   %ebx
8010540e:	e8 cd c9 ff ff       	call   80101de0 <namecmp>
80105413:	83 c4 10             	add    $0x10,%esp
80105416:	85 c0                	test   %eax,%eax
80105418:	0f 84 e2 00 00 00    	je     80105500 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010541e:	83 ec 04             	sub    $0x4,%esp
80105421:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105424:	50                   	push   %eax
80105425:	53                   	push   %ebx
80105426:	57                   	push   %edi
80105427:	e8 d4 c9 ff ff       	call   80101e00 <dirlookup>
8010542c:	83 c4 10             	add    $0x10,%esp
8010542f:	89 c3                	mov    %eax,%ebx
80105431:	85 c0                	test   %eax,%eax
80105433:	0f 84 c7 00 00 00    	je     80105500 <sys_unlink+0x160>
  ilock(ip);
80105439:	83 ec 0c             	sub    $0xc,%esp
8010543c:	50                   	push   %eax
8010543d:	e8 5e c4 ff ff       	call   801018a0 <ilock>
  if(ip->nlink < 1)
80105442:	83 c4 10             	add    $0x10,%esp
80105445:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010544a:	0f 8e 1c 01 00 00    	jle    8010556c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105450:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105455:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105458:	74 66                	je     801054c0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010545a:	83 ec 04             	sub    $0x4,%esp
8010545d:	6a 10                	push   $0x10
8010545f:	6a 00                	push   $0x0
80105461:	57                   	push   %edi
80105462:	e8 89 f5 ff ff       	call   801049f0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105467:	6a 10                	push   $0x10
80105469:	ff 75 c4             	pushl  -0x3c(%ebp)
8010546c:	57                   	push   %edi
8010546d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105470:	e8 3b c8 ff ff       	call   80101cb0 <writei>
80105475:	83 c4 20             	add    $0x20,%esp
80105478:	83 f8 10             	cmp    $0x10,%eax
8010547b:	0f 85 de 00 00 00    	jne    8010555f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80105481:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105486:	0f 84 94 00 00 00    	je     80105520 <sys_unlink+0x180>
  iunlockput(dp);
8010548c:	83 ec 0c             	sub    $0xc,%esp
8010548f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105492:	e8 99 c6 ff ff       	call   80101b30 <iunlockput>
  ip->nlink--;
80105497:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010549c:	89 1c 24             	mov    %ebx,(%esp)
8010549f:	e8 4c c3 ff ff       	call   801017f0 <iupdate>
  iunlockput(ip);
801054a4:	89 1c 24             	mov    %ebx,(%esp)
801054a7:	e8 84 c6 ff ff       	call   80101b30 <iunlockput>
  end_op();
801054ac:	e8 3f da ff ff       	call   80102ef0 <end_op>
  return 0;
801054b1:	83 c4 10             	add    $0x10,%esp
801054b4:	31 c0                	xor    %eax,%eax
}
801054b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054b9:	5b                   	pop    %ebx
801054ba:	5e                   	pop    %esi
801054bb:	5f                   	pop    %edi
801054bc:	5d                   	pop    %ebp
801054bd:	c3                   	ret    
801054be:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801054c0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801054c4:	76 94                	jbe    8010545a <sys_unlink+0xba>
801054c6:	be 20 00 00 00       	mov    $0x20,%esi
801054cb:	eb 0b                	jmp    801054d8 <sys_unlink+0x138>
801054cd:	8d 76 00             	lea    0x0(%esi),%esi
801054d0:	83 c6 10             	add    $0x10,%esi
801054d3:	3b 73 58             	cmp    0x58(%ebx),%esi
801054d6:	73 82                	jae    8010545a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801054d8:	6a 10                	push   $0x10
801054da:	56                   	push   %esi
801054db:	57                   	push   %edi
801054dc:	53                   	push   %ebx
801054dd:	e8 ce c6 ff ff       	call   80101bb0 <readi>
801054e2:	83 c4 10             	add    $0x10,%esp
801054e5:	83 f8 10             	cmp    $0x10,%eax
801054e8:	75 68                	jne    80105552 <sys_unlink+0x1b2>
    if(de.inum != 0)
801054ea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801054ef:	74 df                	je     801054d0 <sys_unlink+0x130>
    iunlockput(ip);
801054f1:	83 ec 0c             	sub    $0xc,%esp
801054f4:	53                   	push   %ebx
801054f5:	e8 36 c6 ff ff       	call   80101b30 <iunlockput>
    goto bad;
801054fa:	83 c4 10             	add    $0x10,%esp
801054fd:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105500:	83 ec 0c             	sub    $0xc,%esp
80105503:	ff 75 b4             	pushl  -0x4c(%ebp)
80105506:	e8 25 c6 ff ff       	call   80101b30 <iunlockput>
  end_op();
8010550b:	e8 e0 d9 ff ff       	call   80102ef0 <end_op>
  return -1;
80105510:	83 c4 10             	add    $0x10,%esp
80105513:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105518:	eb 9c                	jmp    801054b6 <sys_unlink+0x116>
8010551a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105520:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105523:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105526:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010552b:	50                   	push   %eax
8010552c:	e8 bf c2 ff ff       	call   801017f0 <iupdate>
80105531:	83 c4 10             	add    $0x10,%esp
80105534:	e9 53 ff ff ff       	jmp    8010548c <sys_unlink+0xec>
    return -1;
80105539:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010553e:	e9 73 ff ff ff       	jmp    801054b6 <sys_unlink+0x116>
    end_op();
80105543:	e8 a8 d9 ff ff       	call   80102ef0 <end_op>
    return -1;
80105548:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010554d:	e9 64 ff ff ff       	jmp    801054b6 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105552:	83 ec 0c             	sub    $0xc,%esp
80105555:	68 68 7f 10 80       	push   $0x80107f68
8010555a:	e8 21 ae ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010555f:	83 ec 0c             	sub    $0xc,%esp
80105562:	68 7a 7f 10 80       	push   $0x80107f7a
80105567:	e8 14 ae ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010556c:	83 ec 0c             	sub    $0xc,%esp
8010556f:	68 56 7f 10 80       	push   $0x80107f56
80105574:	e8 07 ae ff ff       	call   80100380 <panic>
80105579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105580 <sys_open>:

int
sys_open(void)
{
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
80105583:	57                   	push   %edi
80105584:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105585:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105588:	53                   	push   %ebx
80105589:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010558c:	50                   	push   %eax
8010558d:	6a 00                	push   $0x0
8010558f:	e8 dc f7 ff ff       	call   80104d70 <argstr>
80105594:	83 c4 10             	add    $0x10,%esp
80105597:	85 c0                	test   %eax,%eax
80105599:	0f 88 8e 00 00 00    	js     8010562d <sys_open+0xad>
8010559f:	83 ec 08             	sub    $0x8,%esp
801055a2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055a5:	50                   	push   %eax
801055a6:	6a 01                	push   $0x1
801055a8:	e8 03 f7 ff ff       	call   80104cb0 <argint>
801055ad:	83 c4 10             	add    $0x10,%esp
801055b0:	85 c0                	test   %eax,%eax
801055b2:	78 79                	js     8010562d <sys_open+0xad>
    return -1;

  begin_op();
801055b4:	e8 c7 d8 ff ff       	call   80102e80 <begin_op>

  if(omode & O_CREATE){
801055b9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801055bd:	75 79                	jne    80105638 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801055bf:	83 ec 0c             	sub    $0xc,%esp
801055c2:	ff 75 e0             	pushl  -0x20(%ebp)
801055c5:	e8 f6 cb ff ff       	call   801021c0 <namei>
801055ca:	83 c4 10             	add    $0x10,%esp
801055cd:	89 c6                	mov    %eax,%esi
801055cf:	85 c0                	test   %eax,%eax
801055d1:	0f 84 7e 00 00 00    	je     80105655 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
801055d7:	83 ec 0c             	sub    $0xc,%esp
801055da:	50                   	push   %eax
801055db:	e8 c0 c2 ff ff       	call   801018a0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801055e0:	83 c4 10             	add    $0x10,%esp
801055e3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801055e8:	0f 84 c2 00 00 00    	je     801056b0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801055ee:	e8 6d b9 ff ff       	call   80100f60 <filealloc>
801055f3:	89 c7                	mov    %eax,%edi
801055f5:	85 c0                	test   %eax,%eax
801055f7:	74 23                	je     8010561c <sys_open+0x9c>
  struct proc *curproc = myproc();
801055f9:	e8 a2 e4 ff ff       	call   80103aa0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801055fe:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105600:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105604:	85 d2                	test   %edx,%edx
80105606:	74 60                	je     80105668 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105608:	83 c3 01             	add    $0x1,%ebx
8010560b:	83 fb 10             	cmp    $0x10,%ebx
8010560e:	75 f0                	jne    80105600 <sys_open+0x80>
    if(f)
      fileclose(f);
80105610:	83 ec 0c             	sub    $0xc,%esp
80105613:	57                   	push   %edi
80105614:	e8 07 ba ff ff       	call   80101020 <fileclose>
80105619:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010561c:	83 ec 0c             	sub    $0xc,%esp
8010561f:	56                   	push   %esi
80105620:	e8 0b c5 ff ff       	call   80101b30 <iunlockput>
    end_op();
80105625:	e8 c6 d8 ff ff       	call   80102ef0 <end_op>
    return -1;
8010562a:	83 c4 10             	add    $0x10,%esp
8010562d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105632:	eb 6d                	jmp    801056a1 <sys_open+0x121>
80105634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105638:	83 ec 0c             	sub    $0xc,%esp
8010563b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010563e:	31 c9                	xor    %ecx,%ecx
80105640:	ba 02 00 00 00       	mov    $0x2,%edx
80105645:	6a 00                	push   $0x0
80105647:	e8 14 f8 ff ff       	call   80104e60 <create>
    if(ip == 0){
8010564c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010564f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105651:	85 c0                	test   %eax,%eax
80105653:	75 99                	jne    801055ee <sys_open+0x6e>
      end_op();
80105655:	e8 96 d8 ff ff       	call   80102ef0 <end_op>
      return -1;
8010565a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010565f:	eb 40                	jmp    801056a1 <sys_open+0x121>
80105661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105668:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010566b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010566f:	56                   	push   %esi
80105670:	e8 0b c3 ff ff       	call   80101980 <iunlock>
  end_op();
80105675:	e8 76 d8 ff ff       	call   80102ef0 <end_op>

  f->type = FD_INODE;
8010567a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105680:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105683:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105686:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105689:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010568b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105692:	f7 d0                	not    %eax
80105694:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105697:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010569a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010569d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801056a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056a4:	89 d8                	mov    %ebx,%eax
801056a6:	5b                   	pop    %ebx
801056a7:	5e                   	pop    %esi
801056a8:	5f                   	pop    %edi
801056a9:	5d                   	pop    %ebp
801056aa:	c3                   	ret    
801056ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056af:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
801056b0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801056b3:	85 c9                	test   %ecx,%ecx
801056b5:	0f 84 33 ff ff ff    	je     801055ee <sys_open+0x6e>
801056bb:	e9 5c ff ff ff       	jmp    8010561c <sys_open+0x9c>

801056c0 <sys_mkdir>:

int
sys_mkdir(void)
{
801056c0:	55                   	push   %ebp
801056c1:	89 e5                	mov    %esp,%ebp
801056c3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801056c6:	e8 b5 d7 ff ff       	call   80102e80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801056cb:	83 ec 08             	sub    $0x8,%esp
801056ce:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056d1:	50                   	push   %eax
801056d2:	6a 00                	push   $0x0
801056d4:	e8 97 f6 ff ff       	call   80104d70 <argstr>
801056d9:	83 c4 10             	add    $0x10,%esp
801056dc:	85 c0                	test   %eax,%eax
801056de:	78 30                	js     80105710 <sys_mkdir+0x50>
801056e0:	83 ec 0c             	sub    $0xc,%esp
801056e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056e6:	31 c9                	xor    %ecx,%ecx
801056e8:	ba 01 00 00 00       	mov    $0x1,%edx
801056ed:	6a 00                	push   $0x0
801056ef:	e8 6c f7 ff ff       	call   80104e60 <create>
801056f4:	83 c4 10             	add    $0x10,%esp
801056f7:	85 c0                	test   %eax,%eax
801056f9:	74 15                	je     80105710 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801056fb:	83 ec 0c             	sub    $0xc,%esp
801056fe:	50                   	push   %eax
801056ff:	e8 2c c4 ff ff       	call   80101b30 <iunlockput>
  end_op();
80105704:	e8 e7 d7 ff ff       	call   80102ef0 <end_op>
  return 0;
80105709:	83 c4 10             	add    $0x10,%esp
8010570c:	31 c0                	xor    %eax,%eax
}
8010570e:	c9                   	leave  
8010570f:	c3                   	ret    
    end_op();
80105710:	e8 db d7 ff ff       	call   80102ef0 <end_op>
    return -1;
80105715:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010571a:	c9                   	leave  
8010571b:	c3                   	ret    
8010571c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105720 <sys_mknod>:

int
sys_mknod(void)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105726:	e8 55 d7 ff ff       	call   80102e80 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010572b:	83 ec 08             	sub    $0x8,%esp
8010572e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105731:	50                   	push   %eax
80105732:	6a 00                	push   $0x0
80105734:	e8 37 f6 ff ff       	call   80104d70 <argstr>
80105739:	83 c4 10             	add    $0x10,%esp
8010573c:	85 c0                	test   %eax,%eax
8010573e:	78 60                	js     801057a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105740:	83 ec 08             	sub    $0x8,%esp
80105743:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105746:	50                   	push   %eax
80105747:	6a 01                	push   $0x1
80105749:	e8 62 f5 ff ff       	call   80104cb0 <argint>
  if((argstr(0, &path)) < 0 ||
8010574e:	83 c4 10             	add    $0x10,%esp
80105751:	85 c0                	test   %eax,%eax
80105753:	78 4b                	js     801057a0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105755:	83 ec 08             	sub    $0x8,%esp
80105758:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010575b:	50                   	push   %eax
8010575c:	6a 02                	push   $0x2
8010575e:	e8 4d f5 ff ff       	call   80104cb0 <argint>
     argint(1, &major) < 0 ||
80105763:	83 c4 10             	add    $0x10,%esp
80105766:	85 c0                	test   %eax,%eax
80105768:	78 36                	js     801057a0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010576a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010576e:	83 ec 0c             	sub    $0xc,%esp
80105771:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105775:	ba 03 00 00 00       	mov    $0x3,%edx
8010577a:	50                   	push   %eax
8010577b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010577e:	e8 dd f6 ff ff       	call   80104e60 <create>
     argint(2, &minor) < 0 ||
80105783:	83 c4 10             	add    $0x10,%esp
80105786:	85 c0                	test   %eax,%eax
80105788:	74 16                	je     801057a0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010578a:	83 ec 0c             	sub    $0xc,%esp
8010578d:	50                   	push   %eax
8010578e:	e8 9d c3 ff ff       	call   80101b30 <iunlockput>
  end_op();
80105793:	e8 58 d7 ff ff       	call   80102ef0 <end_op>
  return 0;
80105798:	83 c4 10             	add    $0x10,%esp
8010579b:	31 c0                	xor    %eax,%eax
}
8010579d:	c9                   	leave  
8010579e:	c3                   	ret    
8010579f:	90                   	nop
    end_op();
801057a0:	e8 4b d7 ff ff       	call   80102ef0 <end_op>
    return -1;
801057a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057aa:	c9                   	leave  
801057ab:	c3                   	ret    
801057ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057b0 <sys_chdir>:

int
sys_chdir(void)
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	56                   	push   %esi
801057b4:	53                   	push   %ebx
801057b5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801057b8:	e8 e3 e2 ff ff       	call   80103aa0 <myproc>
801057bd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801057bf:	e8 bc d6 ff ff       	call   80102e80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801057c4:	83 ec 08             	sub    $0x8,%esp
801057c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057ca:	50                   	push   %eax
801057cb:	6a 00                	push   $0x0
801057cd:	e8 9e f5 ff ff       	call   80104d70 <argstr>
801057d2:	83 c4 10             	add    $0x10,%esp
801057d5:	85 c0                	test   %eax,%eax
801057d7:	78 77                	js     80105850 <sys_chdir+0xa0>
801057d9:	83 ec 0c             	sub    $0xc,%esp
801057dc:	ff 75 f4             	pushl  -0xc(%ebp)
801057df:	e8 dc c9 ff ff       	call   801021c0 <namei>
801057e4:	83 c4 10             	add    $0x10,%esp
801057e7:	89 c3                	mov    %eax,%ebx
801057e9:	85 c0                	test   %eax,%eax
801057eb:	74 63                	je     80105850 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801057ed:	83 ec 0c             	sub    $0xc,%esp
801057f0:	50                   	push   %eax
801057f1:	e8 aa c0 ff ff       	call   801018a0 <ilock>
  if(ip->type != T_DIR){
801057f6:	83 c4 10             	add    $0x10,%esp
801057f9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057fe:	75 30                	jne    80105830 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105800:	83 ec 0c             	sub    $0xc,%esp
80105803:	53                   	push   %ebx
80105804:	e8 77 c1 ff ff       	call   80101980 <iunlock>
  iput(curproc->cwd);
80105809:	58                   	pop    %eax
8010580a:	ff 76 68             	pushl  0x68(%esi)
8010580d:	e8 be c1 ff ff       	call   801019d0 <iput>
  end_op();
80105812:	e8 d9 d6 ff ff       	call   80102ef0 <end_op>
  curproc->cwd = ip;
80105817:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010581a:	83 c4 10             	add    $0x10,%esp
8010581d:	31 c0                	xor    %eax,%eax
}
8010581f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105822:	5b                   	pop    %ebx
80105823:	5e                   	pop    %esi
80105824:	5d                   	pop    %ebp
80105825:	c3                   	ret    
80105826:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010582d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105830:	83 ec 0c             	sub    $0xc,%esp
80105833:	53                   	push   %ebx
80105834:	e8 f7 c2 ff ff       	call   80101b30 <iunlockput>
    end_op();
80105839:	e8 b2 d6 ff ff       	call   80102ef0 <end_op>
    return -1;
8010583e:	83 c4 10             	add    $0x10,%esp
80105841:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105846:	eb d7                	jmp    8010581f <sys_chdir+0x6f>
80105848:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010584f:	90                   	nop
    end_op();
80105850:	e8 9b d6 ff ff       	call   80102ef0 <end_op>
    return -1;
80105855:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010585a:	eb c3                	jmp    8010581f <sys_chdir+0x6f>
8010585c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105860 <sys_exec>:

int
sys_exec(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	57                   	push   %edi
80105864:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105865:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010586b:	53                   	push   %ebx
8010586c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105872:	50                   	push   %eax
80105873:	6a 00                	push   $0x0
80105875:	e8 f6 f4 ff ff       	call   80104d70 <argstr>
8010587a:	83 c4 10             	add    $0x10,%esp
8010587d:	85 c0                	test   %eax,%eax
8010587f:	0f 88 87 00 00 00    	js     8010590c <sys_exec+0xac>
80105885:	83 ec 08             	sub    $0x8,%esp
80105888:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010588e:	50                   	push   %eax
8010588f:	6a 01                	push   $0x1
80105891:	e8 1a f4 ff ff       	call   80104cb0 <argint>
80105896:	83 c4 10             	add    $0x10,%esp
80105899:	85 c0                	test   %eax,%eax
8010589b:	78 6f                	js     8010590c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010589d:	83 ec 04             	sub    $0x4,%esp
801058a0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801058a6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801058a8:	68 80 00 00 00       	push   $0x80
801058ad:	6a 00                	push   $0x0
801058af:	56                   	push   %esi
801058b0:	e8 3b f1 ff ff       	call   801049f0 <memset>
801058b5:	83 c4 10             	add    $0x10,%esp
801058b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058bf:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801058c0:	83 ec 08             	sub    $0x8,%esp
801058c3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801058c9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
801058d0:	50                   	push   %eax
801058d1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801058d7:	01 f8                	add    %edi,%eax
801058d9:	50                   	push   %eax
801058da:	e8 41 f3 ff ff       	call   80104c20 <fetchint>
801058df:	83 c4 10             	add    $0x10,%esp
801058e2:	85 c0                	test   %eax,%eax
801058e4:	78 26                	js     8010590c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
801058e6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801058ec:	85 c0                	test   %eax,%eax
801058ee:	74 30                	je     80105920 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801058f0:	83 ec 08             	sub    $0x8,%esp
801058f3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
801058f6:	52                   	push   %edx
801058f7:	50                   	push   %eax
801058f8:	e8 63 f3 ff ff       	call   80104c60 <fetchstr>
801058fd:	83 c4 10             	add    $0x10,%esp
80105900:	85 c0                	test   %eax,%eax
80105902:	78 08                	js     8010590c <sys_exec+0xac>
  for(i=0;; i++){
80105904:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105907:	83 fb 20             	cmp    $0x20,%ebx
8010590a:	75 b4                	jne    801058c0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010590c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010590f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105914:	5b                   	pop    %ebx
80105915:	5e                   	pop    %esi
80105916:	5f                   	pop    %edi
80105917:	5d                   	pop    %ebp
80105918:	c3                   	ret    
80105919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105920:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105927:	00 00 00 00 
  return exec(path, argv);
8010592b:	83 ec 08             	sub    $0x8,%esp
8010592e:	56                   	push   %esi
8010592f:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105935:	e8 96 b2 ff ff       	call   80100bd0 <exec>
8010593a:	83 c4 10             	add    $0x10,%esp
}
8010593d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105940:	5b                   	pop    %ebx
80105941:	5e                   	pop    %esi
80105942:	5f                   	pop    %edi
80105943:	5d                   	pop    %ebp
80105944:	c3                   	ret    
80105945:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010594c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105950 <sys_pipe>:

int
sys_pipe(void)
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	57                   	push   %edi
80105954:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105955:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105958:	53                   	push   %ebx
80105959:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010595c:	6a 08                	push   $0x8
8010595e:	50                   	push   %eax
8010595f:	6a 00                	push   $0x0
80105961:	e8 9a f3 ff ff       	call   80104d00 <argptr>
80105966:	83 c4 10             	add    $0x10,%esp
80105969:	85 c0                	test   %eax,%eax
8010596b:	78 4a                	js     801059b7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010596d:	83 ec 08             	sub    $0x8,%esp
80105970:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105973:	50                   	push   %eax
80105974:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105977:	50                   	push   %eax
80105978:	e8 d3 db ff ff       	call   80103550 <pipealloc>
8010597d:	83 c4 10             	add    $0x10,%esp
80105980:	85 c0                	test   %eax,%eax
80105982:	78 33                	js     801059b7 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105984:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105987:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105989:	e8 12 e1 ff ff       	call   80103aa0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010598e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105990:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105994:	85 f6                	test   %esi,%esi
80105996:	74 28                	je     801059c0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105998:	83 c3 01             	add    $0x1,%ebx
8010599b:	83 fb 10             	cmp    $0x10,%ebx
8010599e:	75 f0                	jne    80105990 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801059a0:	83 ec 0c             	sub    $0xc,%esp
801059a3:	ff 75 e0             	pushl  -0x20(%ebp)
801059a6:	e8 75 b6 ff ff       	call   80101020 <fileclose>
    fileclose(wf);
801059ab:	58                   	pop    %eax
801059ac:	ff 75 e4             	pushl  -0x1c(%ebp)
801059af:	e8 6c b6 ff ff       	call   80101020 <fileclose>
    return -1;
801059b4:	83 c4 10             	add    $0x10,%esp
801059b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059bc:	eb 53                	jmp    80105a11 <sys_pipe+0xc1>
801059be:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801059c0:	8d 73 08             	lea    0x8(%ebx),%esi
801059c3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801059c7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801059ca:	e8 d1 e0 ff ff       	call   80103aa0 <myproc>
801059cf:	89 c2                	mov    %eax,%edx
  for(fd = 0; fd < NOFILE; fd++){
801059d1:	31 c0                	xor    %eax,%eax
801059d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059d7:	90                   	nop
    if(curproc->ofile[fd] == 0){
801059d8:	8b 4c 82 28          	mov    0x28(%edx,%eax,4),%ecx
801059dc:	85 c9                	test   %ecx,%ecx
801059de:	74 20                	je     80105a00 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
801059e0:	83 c0 01             	add    $0x1,%eax
801059e3:	83 f8 10             	cmp    $0x10,%eax
801059e6:	75 f0                	jne    801059d8 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
801059e8:	e8 b3 e0 ff ff       	call   80103aa0 <myproc>
801059ed:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801059f4:	00 
801059f5:	eb a9                	jmp    801059a0 <sys_pipe+0x50>
801059f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059fe:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105a00:	89 7c 82 28          	mov    %edi,0x28(%edx,%eax,4)
  }
  fd[0] = fd0;
80105a04:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105a07:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
80105a09:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105a0c:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
80105a0f:	31 c0                	xor    %eax,%eax
}
80105a11:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a14:	5b                   	pop    %ebx
80105a15:	5e                   	pop    %esi
80105a16:	5f                   	pop    %edi
80105a17:	5d                   	pop    %ebp
80105a18:	c3                   	ret    
80105a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a20 <sys_mprotect>:

int
sys_mprotect(void)
{
80105a20:	55                   	push   %ebp
80105a21:	89 e5                	mov    %esp,%ebp
80105a23:	83 ec 1c             	sub    $0x1c,%esp
  void* addr;
  int len;

  if(argptr(0, (char**)&addr, sizeof(unsigned int)) < 0 || argint(1, (int*)&len) < 0){
80105a26:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a29:	6a 04                	push   $0x4
80105a2b:	50                   	push   %eax
80105a2c:	6a 00                	push   $0x0
80105a2e:	e8 cd f2 ff ff       	call   80104d00 <argptr>
80105a33:	83 c4 10             	add    $0x10,%esp
80105a36:	85 c0                	test   %eax,%eax
80105a38:	78 2e                	js     80105a68 <sys_mprotect+0x48>
80105a3a:	83 ec 08             	sub    $0x8,%esp
80105a3d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a40:	50                   	push   %eax
80105a41:	6a 01                	push   $0x1
80105a43:	e8 68 f2 ff ff       	call   80104cb0 <argint>
80105a48:	83 c4 10             	add    $0x10,%esp
80105a4b:	85 c0                	test   %eax,%eax
80105a4d:	78 19                	js     80105a68 <sys_mprotect+0x48>
    return -1;
  }
  return mprotect(addr,len);
80105a4f:	83 ec 08             	sub    $0x8,%esp
80105a52:	ff 75 f4             	pushl  -0xc(%ebp)
80105a55:	ff 75 f0             	pushl  -0x10(%ebp)
80105a58:	e8 33 1c 00 00       	call   80107690 <mprotect>
80105a5d:	83 c4 10             	add    $0x10,%esp

}
80105a60:	c9                   	leave  
80105a61:	c3                   	ret    
80105a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105a68:	c9                   	leave  
    return -1;
80105a69:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a6e:	c3                   	ret    
80105a6f:	90                   	nop

80105a70 <sys_munprotect>:

int
sys_munprotect(void)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	83 ec 1c             	sub    $0x1c,%esp
  void* addr;
  int len;

  if(argptr(0, (char**)&addr, sizeof(unsigned int)) < 0 || argint(1, (int*)&len) < 0){
80105a76:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a79:	6a 04                	push   $0x4
80105a7b:	50                   	push   %eax
80105a7c:	6a 00                	push   $0x0
80105a7e:	e8 7d f2 ff ff       	call   80104d00 <argptr>
80105a83:	83 c4 10             	add    $0x10,%esp
80105a86:	85 c0                	test   %eax,%eax
80105a88:	78 2e                	js     80105ab8 <sys_munprotect+0x48>
80105a8a:	83 ec 08             	sub    $0x8,%esp
80105a8d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a90:	50                   	push   %eax
80105a91:	6a 01                	push   $0x1
80105a93:	e8 18 f2 ff ff       	call   80104cb0 <argint>
80105a98:	83 c4 10             	add    $0x10,%esp
80105a9b:	85 c0                	test   %eax,%eax
80105a9d:	78 19                	js     80105ab8 <sys_munprotect+0x48>
    return -1;
  }
  return munprotect((void*)addr,len);
80105a9f:	83 ec 08             	sub    $0x8,%esp
80105aa2:	ff 75 f4             	pushl  -0xc(%ebp)
80105aa5:	ff 75 f0             	pushl  -0x10(%ebp)
80105aa8:	e8 93 1c 00 00       	call   80107740 <munprotect>
80105aad:	83 c4 10             	add    $0x10,%esp

}
80105ab0:	c9                   	leave  
80105ab1:	c3                   	ret    
80105ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105ab8:	c9                   	leave  
    return -1;
80105ab9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105abe:	c3                   	ret    
80105abf:	90                   	nop

80105ac0 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105ac0:	e9 7b e1 ff ff       	jmp    80103c40 <fork>
80105ac5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ad0 <sys_exit>:
}

int
sys_exit(void)
{
80105ad0:	55                   	push   %ebp
80105ad1:	89 e5                	mov    %esp,%ebp
80105ad3:	83 ec 08             	sub    $0x8,%esp
  exit();
80105ad6:	e8 e5 e3 ff ff       	call   80103ec0 <exit>
  return 0;  // not reached
}
80105adb:	31 c0                	xor    %eax,%eax
80105add:	c9                   	leave  
80105ade:	c3                   	ret    
80105adf:	90                   	nop

80105ae0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105ae0:	e9 0b e5 ff ff       	jmp    80103ff0 <wait>
80105ae5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105af0 <sys_kill>:
}

int
sys_kill(void)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105af6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105af9:	50                   	push   %eax
80105afa:	6a 00                	push   $0x0
80105afc:	e8 af f1 ff ff       	call   80104cb0 <argint>
80105b01:	83 c4 10             	add    $0x10,%esp
80105b04:	85 c0                	test   %eax,%eax
80105b06:	78 18                	js     80105b20 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105b08:	83 ec 0c             	sub    $0xc,%esp
80105b0b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b0e:	e8 8d e7 ff ff       	call   801042a0 <kill>
80105b13:	83 c4 10             	add    $0x10,%esp
}
80105b16:	c9                   	leave  
80105b17:	c3                   	ret    
80105b18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b1f:	90                   	nop
80105b20:	c9                   	leave  
    return -1;
80105b21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b26:	c3                   	ret    
80105b27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b2e:	66 90                	xchg   %ax,%ax

80105b30 <sys_getpid>:

int
sys_getpid(void)
{
80105b30:	55                   	push   %ebp
80105b31:	89 e5                	mov    %esp,%ebp
80105b33:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105b36:	e8 65 df ff ff       	call   80103aa0 <myproc>
80105b3b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105b3e:	c9                   	leave  
80105b3f:	c3                   	ret    

80105b40 <sys_sbrk>:

int
sys_sbrk(void)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105b44:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105b47:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105b4a:	50                   	push   %eax
80105b4b:	6a 00                	push   $0x0
80105b4d:	e8 5e f1 ff ff       	call   80104cb0 <argint>
80105b52:	83 c4 10             	add    $0x10,%esp
80105b55:	85 c0                	test   %eax,%eax
80105b57:	78 27                	js     80105b80 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105b59:	e8 42 df ff ff       	call   80103aa0 <myproc>
  if(growproc(n) < 0)
80105b5e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105b61:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105b63:	ff 75 f4             	pushl  -0xc(%ebp)
80105b66:	e8 55 e0 ff ff       	call   80103bc0 <growproc>
80105b6b:	83 c4 10             	add    $0x10,%esp
80105b6e:	85 c0                	test   %eax,%eax
80105b70:	78 0e                	js     80105b80 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105b72:	89 d8                	mov    %ebx,%eax
80105b74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b77:	c9                   	leave  
80105b78:	c3                   	ret    
80105b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b80:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105b85:	eb eb                	jmp    80105b72 <sys_sbrk+0x32>
80105b87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b8e:	66 90                	xchg   %ax,%ax

80105b90 <sys_sleep>:

int
sys_sleep(void)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105b94:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105b97:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105b9a:	50                   	push   %eax
80105b9b:	6a 00                	push   $0x0
80105b9d:	e8 0e f1 ff ff       	call   80104cb0 <argint>
80105ba2:	83 c4 10             	add    $0x10,%esp
80105ba5:	85 c0                	test   %eax,%eax
80105ba7:	0f 88 8a 00 00 00    	js     80105c37 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105bad:	83 ec 0c             	sub    $0xc,%esp
80105bb0:	68 80 4d 11 80       	push   $0x80114d80
80105bb5:	e8 76 ed ff ff       	call   80104930 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105bba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105bbd:	8b 1d 60 4d 11 80    	mov    0x80114d60,%ebx
  while(ticks - ticks0 < n){
80105bc3:	83 c4 10             	add    $0x10,%esp
80105bc6:	85 d2                	test   %edx,%edx
80105bc8:	75 27                	jne    80105bf1 <sys_sleep+0x61>
80105bca:	eb 54                	jmp    80105c20 <sys_sleep+0x90>
80105bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105bd0:	83 ec 08             	sub    $0x8,%esp
80105bd3:	68 80 4d 11 80       	push   $0x80114d80
80105bd8:	68 60 4d 11 80       	push   $0x80114d60
80105bdd:	e8 9e e5 ff ff       	call   80104180 <sleep>
  while(ticks - ticks0 < n){
80105be2:	a1 60 4d 11 80       	mov    0x80114d60,%eax
80105be7:	83 c4 10             	add    $0x10,%esp
80105bea:	29 d8                	sub    %ebx,%eax
80105bec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105bef:	73 2f                	jae    80105c20 <sys_sleep+0x90>
    if(myproc()->killed){
80105bf1:	e8 aa de ff ff       	call   80103aa0 <myproc>
80105bf6:	8b 40 24             	mov    0x24(%eax),%eax
80105bf9:	85 c0                	test   %eax,%eax
80105bfb:	74 d3                	je     80105bd0 <sys_sleep+0x40>
      release(&tickslock);
80105bfd:	83 ec 0c             	sub    $0xc,%esp
80105c00:	68 80 4d 11 80       	push   $0x80114d80
80105c05:	e8 c6 ec ff ff       	call   801048d0 <release>
  }
  release(&tickslock);
  return 0;
}
80105c0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80105c0d:	83 c4 10             	add    $0x10,%esp
80105c10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c15:	c9                   	leave  
80105c16:	c3                   	ret    
80105c17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c1e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105c20:	83 ec 0c             	sub    $0xc,%esp
80105c23:	68 80 4d 11 80       	push   $0x80114d80
80105c28:	e8 a3 ec ff ff       	call   801048d0 <release>
  return 0;
80105c2d:	83 c4 10             	add    $0x10,%esp
80105c30:	31 c0                	xor    %eax,%eax
}
80105c32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c35:	c9                   	leave  
80105c36:	c3                   	ret    
    return -1;
80105c37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c3c:	eb f4                	jmp    80105c32 <sys_sleep+0xa2>
80105c3e:	66 90                	xchg   %ax,%ax

80105c40 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105c40:	55                   	push   %ebp
80105c41:	89 e5                	mov    %esp,%ebp
80105c43:	53                   	push   %ebx
80105c44:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105c47:	68 80 4d 11 80       	push   $0x80114d80
80105c4c:	e8 df ec ff ff       	call   80104930 <acquire>
  xticks = ticks;
80105c51:	8b 1d 60 4d 11 80    	mov    0x80114d60,%ebx
  release(&tickslock);
80105c57:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80105c5e:	e8 6d ec ff ff       	call   801048d0 <release>
  return xticks;
}
80105c63:	89 d8                	mov    %ebx,%eax
80105c65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c68:	c9                   	leave  
80105c69:	c3                   	ret    
80105c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c70 <sys_clone>:

int
sys_clone(void)
{
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
80105c73:	83 ec 1c             	sub    $0x1c,%esp
  void *fcn, *arg1, *arg2, *stack;
  if(argptr(0, (char**)(&fcn), sizeof(void(*)(void*, void*))) < 0 ||
80105c76:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105c79:	6a 04                	push   $0x4
80105c7b:	50                   	push   %eax
80105c7c:	6a 00                	push   $0x0
80105c7e:	e8 7d f0 ff ff       	call   80104d00 <argptr>
80105c83:	83 c4 10             	add    $0x10,%esp
80105c86:	85 c0                	test   %eax,%eax
80105c88:	78 5e                	js     80105ce8 <sys_clone+0x78>
     argptr(1, (char**)(&arg1), sizeof(void*)) < 0 ||
80105c8a:	83 ec 04             	sub    $0x4,%esp
80105c8d:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105c90:	6a 04                	push   $0x4
80105c92:	50                   	push   %eax
80105c93:	6a 01                	push   $0x1
80105c95:	e8 66 f0 ff ff       	call   80104d00 <argptr>
  if(argptr(0, (char**)(&fcn), sizeof(void(*)(void*, void*))) < 0 ||
80105c9a:	83 c4 10             	add    $0x10,%esp
80105c9d:	85 c0                	test   %eax,%eax
80105c9f:	78 47                	js     80105ce8 <sys_clone+0x78>
     argptr(2, (char**)(&arg2), sizeof(void*)) < 0 ||
80105ca1:	83 ec 04             	sub    $0x4,%esp
80105ca4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ca7:	6a 04                	push   $0x4
80105ca9:	50                   	push   %eax
80105caa:	6a 02                	push   $0x2
80105cac:	e8 4f f0 ff ff       	call   80104d00 <argptr>
     argptr(1, (char**)(&arg1), sizeof(void*)) < 0 ||
80105cb1:	83 c4 10             	add    $0x10,%esp
80105cb4:	85 c0                	test   %eax,%eax
80105cb6:	78 30                	js     80105ce8 <sys_clone+0x78>
    argptr(3, (char**)(&stack), sizeof(PGSIZE)) < 0) {
80105cb8:	83 ec 04             	sub    $0x4,%esp
80105cbb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105cbe:	6a 04                	push   $0x4
80105cc0:	50                   	push   %eax
80105cc1:	6a 03                	push   $0x3
80105cc3:	e8 38 f0 ff ff       	call   80104d00 <argptr>
     argptr(2, (char**)(&arg2), sizeof(void*)) < 0 ||
80105cc8:	83 c4 10             	add    $0x10,%esp
80105ccb:	85 c0                	test   %eax,%eax
80105ccd:	78 19                	js     80105ce8 <sys_clone+0x78>
    return -1;
  }
  return clone((void(*)(void*, void*))fcn, arg1, arg2, stack);
80105ccf:	ff 75 f4             	pushl  -0xc(%ebp)
80105cd2:	ff 75 f0             	pushl  -0x10(%ebp)
80105cd5:	ff 75 ec             	pushl  -0x14(%ebp)
80105cd8:	ff 75 e8             	pushl  -0x18(%ebp)
80105cdb:	e8 00 e7 ff ff       	call   801043e0 <clone>
80105ce0:	83 c4 10             	add    $0x10,%esp
}
80105ce3:	c9                   	leave  
80105ce4:	c3                   	ret    
80105ce5:	8d 76 00             	lea    0x0(%esi),%esi
80105ce8:	c9                   	leave  
    return -1;
80105ce9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cee:	c3                   	ret    
80105cef:	90                   	nop

80105cf0 <sys_join>:

int
sys_join(void)
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
80105cf3:	53                   	push   %ebx
  void* stack;
  if(argptr(0, (char**)(&stack), sizeof(void*) < 0))
80105cf4:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105cf7:	83 ec 18             	sub    $0x18,%esp
  if(argptr(0, (char**)(&stack), sizeof(void*) < 0))
80105cfa:	6a 00                	push   $0x0
80105cfc:	53                   	push   %ebx
80105cfd:	6a 00                	push   $0x0
80105cff:	e8 fc ef ff ff       	call   80104d00 <argptr>
80105d04:	83 c4 10             	add    $0x10,%esp
80105d07:	85 c0                	test   %eax,%eax
80105d09:	75 15                	jne    80105d20 <sys_join+0x30>
      return -1;
  return join(&stack);
80105d0b:	83 ec 0c             	sub    $0xc,%esp
80105d0e:	53                   	push   %ebx
80105d0f:	e8 ec e7 ff ff       	call   80104500 <join>
80105d14:	83 c4 10             	add    $0x10,%esp
}
80105d17:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d1a:	c9                   	leave  
80105d1b:	c3                   	ret    
80105d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80105d20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d25:	eb f0                	jmp    80105d17 <sys_join+0x27>

80105d27 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105d27:	1e                   	push   %ds
  pushl %es
80105d28:	06                   	push   %es
  pushl %fs
80105d29:	0f a0                	push   %fs
  pushl %gs
80105d2b:	0f a8                	push   %gs
  pushal
80105d2d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105d2e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105d32:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105d34:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105d36:	54                   	push   %esp
  call trap
80105d37:	e8 c4 00 00 00       	call   80105e00 <trap>
  addl $4, %esp
80105d3c:	83 c4 04             	add    $0x4,%esp

80105d3f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105d3f:	61                   	popa   
  popl %gs
80105d40:	0f a9                	pop    %gs
  popl %fs
80105d42:	0f a1                	pop    %fs
  popl %es
80105d44:	07                   	pop    %es
  popl %ds
80105d45:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105d46:	83 c4 08             	add    $0x8,%esp
  iret
80105d49:	cf                   	iret   
80105d4a:	66 90                	xchg   %ax,%ax
80105d4c:	66 90                	xchg   %ax,%ax
80105d4e:	66 90                	xchg   %ax,%ax

80105d50 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105d50:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105d51:	31 c0                	xor    %eax,%eax
{
80105d53:	89 e5                	mov    %esp,%ebp
80105d55:	83 ec 08             	sub    $0x8,%esp
80105d58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d5f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105d60:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105d67:	c7 04 c5 c2 4d 11 80 	movl   $0x8e000008,-0x7feeb23e(,%eax,8)
80105d6e:	08 00 00 8e 
80105d72:	66 89 14 c5 c0 4d 11 	mov    %dx,-0x7feeb240(,%eax,8)
80105d79:	80 
80105d7a:	c1 ea 10             	shr    $0x10,%edx
80105d7d:	66 89 14 c5 c6 4d 11 	mov    %dx,-0x7feeb23a(,%eax,8)
80105d84:	80 
  for(i = 0; i < 256; i++)
80105d85:	83 c0 01             	add    $0x1,%eax
80105d88:	3d 00 01 00 00       	cmp    $0x100,%eax
80105d8d:	75 d1                	jne    80105d60 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105d8f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105d92:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105d97:	c7 05 c2 4f 11 80 08 	movl   $0xef000008,0x80114fc2
80105d9e:	00 00 ef 
  initlock(&tickslock, "time");
80105da1:	68 89 7f 10 80       	push   $0x80107f89
80105da6:	68 80 4d 11 80       	push   $0x80114d80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105dab:	66 a3 c0 4f 11 80    	mov    %ax,0x80114fc0
80105db1:	c1 e8 10             	shr    $0x10,%eax
80105db4:	66 a3 c6 4f 11 80    	mov    %ax,0x80114fc6
  initlock(&tickslock, "time");
80105dba:	e8 a1 e9 ff ff       	call   80104760 <initlock>
}
80105dbf:	83 c4 10             	add    $0x10,%esp
80105dc2:	c9                   	leave  
80105dc3:	c3                   	ret    
80105dc4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105dcf:	90                   	nop

80105dd0 <idtinit>:

void
idtinit(void)
{
80105dd0:	55                   	push   %ebp
  pd[0] = size-1;
80105dd1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105dd6:	89 e5                	mov    %esp,%ebp
80105dd8:	83 ec 10             	sub    $0x10,%esp
80105ddb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105ddf:	b8 c0 4d 11 80       	mov    $0x80114dc0,%eax
80105de4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105de8:	c1 e8 10             	shr    $0x10,%eax
80105deb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105def:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105df2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105df5:	c9                   	leave  
80105df6:	c3                   	ret    
80105df7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dfe:	66 90                	xchg   %ax,%ax

80105e00 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	57                   	push   %edi
80105e04:	56                   	push   %esi
80105e05:	53                   	push   %ebx
80105e06:	83 ec 1c             	sub    $0x1c,%esp
80105e09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105e0c:	8b 43 30             	mov    0x30(%ebx),%eax
80105e0f:	83 f8 40             	cmp    $0x40,%eax
80105e12:	0f 84 68 01 00 00    	je     80105f80 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105e18:	83 e8 20             	sub    $0x20,%eax
80105e1b:	83 f8 1f             	cmp    $0x1f,%eax
80105e1e:	0f 87 8c 00 00 00    	ja     80105eb0 <trap+0xb0>
80105e24:	ff 24 85 30 80 10 80 	jmp    *-0x7fef7fd0(,%eax,4)
80105e2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e2f:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105e30:	e8 2b c5 ff ff       	call   80102360 <ideintr>
    lapiceoi();
80105e35:	e8 f6 cb ff ff       	call   80102a30 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e3a:	e8 61 dc ff ff       	call   80103aa0 <myproc>
80105e3f:	85 c0                	test   %eax,%eax
80105e41:	74 1d                	je     80105e60 <trap+0x60>
80105e43:	e8 58 dc ff ff       	call   80103aa0 <myproc>
80105e48:	8b 50 24             	mov    0x24(%eax),%edx
80105e4b:	85 d2                	test   %edx,%edx
80105e4d:	74 11                	je     80105e60 <trap+0x60>
80105e4f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105e53:	83 e0 03             	and    $0x3,%eax
80105e56:	66 83 f8 03          	cmp    $0x3,%ax
80105e5a:	0f 84 e8 01 00 00    	je     80106048 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105e60:	e8 3b dc ff ff       	call   80103aa0 <myproc>
80105e65:	85 c0                	test   %eax,%eax
80105e67:	74 0f                	je     80105e78 <trap+0x78>
80105e69:	e8 32 dc ff ff       	call   80103aa0 <myproc>
80105e6e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105e72:	0f 84 b8 00 00 00    	je     80105f30 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e78:	e8 23 dc ff ff       	call   80103aa0 <myproc>
80105e7d:	85 c0                	test   %eax,%eax
80105e7f:	74 1d                	je     80105e9e <trap+0x9e>
80105e81:	e8 1a dc ff ff       	call   80103aa0 <myproc>
80105e86:	8b 40 24             	mov    0x24(%eax),%eax
80105e89:	85 c0                	test   %eax,%eax
80105e8b:	74 11                	je     80105e9e <trap+0x9e>
80105e8d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105e91:	83 e0 03             	and    $0x3,%eax
80105e94:	66 83 f8 03          	cmp    $0x3,%ax
80105e98:	0f 84 0f 01 00 00    	je     80105fad <trap+0x1ad>
    exit();
}
80105e9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ea1:	5b                   	pop    %ebx
80105ea2:	5e                   	pop    %esi
80105ea3:	5f                   	pop    %edi
80105ea4:	5d                   	pop    %ebp
80105ea5:	c3                   	ret    
80105ea6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ead:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80105eb0:	e8 eb db ff ff       	call   80103aa0 <myproc>
80105eb5:	8b 7b 38             	mov    0x38(%ebx),%edi
80105eb8:	85 c0                	test   %eax,%eax
80105eba:	0f 84 a2 01 00 00    	je     80106062 <trap+0x262>
80105ec0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105ec4:	0f 84 98 01 00 00    	je     80106062 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105eca:	0f 20 d1             	mov    %cr2,%ecx
80105ecd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ed0:	e8 ab db ff ff       	call   80103a80 <cpuid>
80105ed5:	8b 73 30             	mov    0x30(%ebx),%esi
80105ed8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105edb:	8b 43 34             	mov    0x34(%ebx),%eax
80105ede:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105ee1:	e8 ba db ff ff       	call   80103aa0 <myproc>
80105ee6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105ee9:	e8 b2 db ff ff       	call   80103aa0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105eee:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105ef1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105ef4:	51                   	push   %ecx
80105ef5:	57                   	push   %edi
80105ef6:	52                   	push   %edx
80105ef7:	ff 75 e4             	pushl  -0x1c(%ebp)
80105efa:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105efb:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105efe:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f01:	56                   	push   %esi
80105f02:	ff 70 10             	pushl  0x10(%eax)
80105f05:	68 ec 7f 10 80       	push   $0x80107fec
80105f0a:	e8 71 a7 ff ff       	call   80100680 <cprintf>
    myproc()->killed = 1;
80105f0f:	83 c4 20             	add    $0x20,%esp
80105f12:	e8 89 db ff ff       	call   80103aa0 <myproc>
80105f17:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f1e:	e8 7d db ff ff       	call   80103aa0 <myproc>
80105f23:	85 c0                	test   %eax,%eax
80105f25:	0f 85 18 ff ff ff    	jne    80105e43 <trap+0x43>
80105f2b:	e9 30 ff ff ff       	jmp    80105e60 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80105f30:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105f34:	0f 85 3e ff ff ff    	jne    80105e78 <trap+0x78>
    yield();
80105f3a:	e8 f1 e1 ff ff       	call   80104130 <yield>
80105f3f:	e9 34 ff ff ff       	jmp    80105e78 <trap+0x78>
80105f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105f48:	8b 7b 38             	mov    0x38(%ebx),%edi
80105f4b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105f4f:	e8 2c db ff ff       	call   80103a80 <cpuid>
80105f54:	57                   	push   %edi
80105f55:	56                   	push   %esi
80105f56:	50                   	push   %eax
80105f57:	68 94 7f 10 80       	push   $0x80107f94
80105f5c:	e8 1f a7 ff ff       	call   80100680 <cprintf>
    lapiceoi();
80105f61:	e8 ca ca ff ff       	call   80102a30 <lapiceoi>
    break;
80105f66:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f69:	e8 32 db ff ff       	call   80103aa0 <myproc>
80105f6e:	85 c0                	test   %eax,%eax
80105f70:	0f 85 cd fe ff ff    	jne    80105e43 <trap+0x43>
80105f76:	e9 e5 fe ff ff       	jmp    80105e60 <trap+0x60>
80105f7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f7f:	90                   	nop
    if(myproc()->killed)
80105f80:	e8 1b db ff ff       	call   80103aa0 <myproc>
80105f85:	8b 70 24             	mov    0x24(%eax),%esi
80105f88:	85 f6                	test   %esi,%esi
80105f8a:	0f 85 c8 00 00 00    	jne    80106058 <trap+0x258>
    myproc()->tf = tf;
80105f90:	e8 0b db ff ff       	call   80103aa0 <myproc>
80105f95:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105f98:	e8 53 ee ff ff       	call   80104df0 <syscall>
    if(myproc()->killed)
80105f9d:	e8 fe da ff ff       	call   80103aa0 <myproc>
80105fa2:	8b 48 24             	mov    0x24(%eax),%ecx
80105fa5:	85 c9                	test   %ecx,%ecx
80105fa7:	0f 84 f1 fe ff ff    	je     80105e9e <trap+0x9e>
}
80105fad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fb0:	5b                   	pop    %ebx
80105fb1:	5e                   	pop    %esi
80105fb2:	5f                   	pop    %edi
80105fb3:	5d                   	pop    %ebp
      exit();
80105fb4:	e9 07 df ff ff       	jmp    80103ec0 <exit>
80105fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105fc0:	e8 5b 02 00 00       	call   80106220 <uartintr>
    lapiceoi();
80105fc5:	e8 66 ca ff ff       	call   80102a30 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105fca:	e8 d1 da ff ff       	call   80103aa0 <myproc>
80105fcf:	85 c0                	test   %eax,%eax
80105fd1:	0f 85 6c fe ff ff    	jne    80105e43 <trap+0x43>
80105fd7:	e9 84 fe ff ff       	jmp    80105e60 <trap+0x60>
80105fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105fe0:	e8 0b c9 ff ff       	call   801028f0 <kbdintr>
    lapiceoi();
80105fe5:	e8 46 ca ff ff       	call   80102a30 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105fea:	e8 b1 da ff ff       	call   80103aa0 <myproc>
80105fef:	85 c0                	test   %eax,%eax
80105ff1:	0f 85 4c fe ff ff    	jne    80105e43 <trap+0x43>
80105ff7:	e9 64 fe ff ff       	jmp    80105e60 <trap+0x60>
80105ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106000:	e8 7b da ff ff       	call   80103a80 <cpuid>
80106005:	85 c0                	test   %eax,%eax
80106007:	0f 85 28 fe ff ff    	jne    80105e35 <trap+0x35>
      acquire(&tickslock);
8010600d:	83 ec 0c             	sub    $0xc,%esp
80106010:	68 80 4d 11 80       	push   $0x80114d80
80106015:	e8 16 e9 ff ff       	call   80104930 <acquire>
      wakeup(&ticks);
8010601a:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
      ticks++;
80106021:	83 05 60 4d 11 80 01 	addl   $0x1,0x80114d60
      wakeup(&ticks);
80106028:	e8 13 e2 ff ff       	call   80104240 <wakeup>
      release(&tickslock);
8010602d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80106034:	e8 97 e8 ff ff       	call   801048d0 <release>
80106039:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010603c:	e9 f4 fd ff ff       	jmp    80105e35 <trap+0x35>
80106041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106048:	e8 73 de ff ff       	call   80103ec0 <exit>
8010604d:	e9 0e fe ff ff       	jmp    80105e60 <trap+0x60>
80106052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106058:	e8 63 de ff ff       	call   80103ec0 <exit>
8010605d:	e9 2e ff ff ff       	jmp    80105f90 <trap+0x190>
80106062:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106065:	e8 16 da ff ff       	call   80103a80 <cpuid>
8010606a:	83 ec 0c             	sub    $0xc,%esp
8010606d:	56                   	push   %esi
8010606e:	57                   	push   %edi
8010606f:	50                   	push   %eax
80106070:	ff 73 30             	pushl  0x30(%ebx)
80106073:	68 b8 7f 10 80       	push   $0x80107fb8
80106078:	e8 03 a6 ff ff       	call   80100680 <cprintf>
      panic("trap");
8010607d:	83 c4 14             	add    $0x14,%esp
80106080:	68 8e 7f 10 80       	push   $0x80107f8e
80106085:	e8 f6 a2 ff ff       	call   80100380 <panic>
8010608a:	66 90                	xchg   %ax,%ax
8010608c:	66 90                	xchg   %ax,%ax
8010608e:	66 90                	xchg   %ax,%ax

80106090 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106090:	a1 c0 55 11 80       	mov    0x801155c0,%eax
80106095:	85 c0                	test   %eax,%eax
80106097:	74 17                	je     801060b0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106099:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010609e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010609f:	a8 01                	test   $0x1,%al
801060a1:	74 0d                	je     801060b0 <uartgetc+0x20>
801060a3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060a8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801060a9:	0f b6 c0             	movzbl %al,%eax
801060ac:	c3                   	ret    
801060ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801060b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060b5:	c3                   	ret    
801060b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060bd:	8d 76 00             	lea    0x0(%esi),%esi

801060c0 <uartinit>:
{
801060c0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801060c1:	31 c9                	xor    %ecx,%ecx
801060c3:	89 c8                	mov    %ecx,%eax
801060c5:	89 e5                	mov    %esp,%ebp
801060c7:	57                   	push   %edi
801060c8:	bf fa 03 00 00       	mov    $0x3fa,%edi
801060cd:	56                   	push   %esi
801060ce:	89 fa                	mov    %edi,%edx
801060d0:	53                   	push   %ebx
801060d1:	83 ec 1c             	sub    $0x1c,%esp
801060d4:	ee                   	out    %al,(%dx)
801060d5:	be fb 03 00 00       	mov    $0x3fb,%esi
801060da:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801060df:	89 f2                	mov    %esi,%edx
801060e1:	ee                   	out    %al,(%dx)
801060e2:	b8 0c 00 00 00       	mov    $0xc,%eax
801060e7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060ec:	ee                   	out    %al,(%dx)
801060ed:	bb f9 03 00 00       	mov    $0x3f9,%ebx
801060f2:	89 c8                	mov    %ecx,%eax
801060f4:	89 da                	mov    %ebx,%edx
801060f6:	ee                   	out    %al,(%dx)
801060f7:	b8 03 00 00 00       	mov    $0x3,%eax
801060fc:	89 f2                	mov    %esi,%edx
801060fe:	ee                   	out    %al,(%dx)
801060ff:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106104:	89 c8                	mov    %ecx,%eax
80106106:	ee                   	out    %al,(%dx)
80106107:	b8 01 00 00 00       	mov    $0x1,%eax
8010610c:	89 da                	mov    %ebx,%edx
8010610e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010610f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106114:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106115:	3c ff                	cmp    $0xff,%al
80106117:	0f 84 93 00 00 00    	je     801061b0 <uartinit+0xf0>
  uart = 1;
8010611d:	c7 05 c0 55 11 80 01 	movl   $0x1,0x801155c0
80106124:	00 00 00 
80106127:	89 fa                	mov    %edi,%edx
80106129:	ec                   	in     (%dx),%al
8010612a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010612f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106130:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106133:	bf b0 80 10 80       	mov    $0x801080b0,%edi
80106138:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
8010613d:	6a 00                	push   $0x0
8010613f:	6a 04                	push   $0x4
80106141:	e8 5a c4 ff ff       	call   801025a0 <ioapicenable>
80106146:	c6 45 e7 76          	movb   $0x76,-0x19(%ebp)
8010614a:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
8010614d:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
80106151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106158:	a1 c0 55 11 80       	mov    0x801155c0,%eax
8010615d:	bb 80 00 00 00       	mov    $0x80,%ebx
80106162:	85 c0                	test   %eax,%eax
80106164:	75 1c                	jne    80106182 <uartinit+0xc2>
80106166:	eb 2b                	jmp    80106193 <uartinit+0xd3>
80106168:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010616f:	90                   	nop
    microdelay(10);
80106170:	83 ec 0c             	sub    $0xc,%esp
80106173:	6a 0a                	push   $0xa
80106175:	e8 d6 c8 ff ff       	call   80102a50 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010617a:	83 c4 10             	add    $0x10,%esp
8010617d:	83 eb 01             	sub    $0x1,%ebx
80106180:	74 07                	je     80106189 <uartinit+0xc9>
80106182:	89 f2                	mov    %esi,%edx
80106184:	ec                   	in     (%dx),%al
80106185:	a8 20                	test   $0x20,%al
80106187:	74 e7                	je     80106170 <uartinit+0xb0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106189:	0f b6 45 e6          	movzbl -0x1a(%ebp),%eax
8010618d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106192:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106193:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80106197:	83 c7 01             	add    $0x1,%edi
8010619a:	84 c0                	test   %al,%al
8010619c:	74 12                	je     801061b0 <uartinit+0xf0>
8010619e:	88 45 e6             	mov    %al,-0x1a(%ebp)
801061a1:	0f b6 47 01          	movzbl 0x1(%edi),%eax
801061a5:	88 45 e7             	mov    %al,-0x19(%ebp)
801061a8:	eb ae                	jmp    80106158 <uartinit+0x98>
801061aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
801061b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061b3:	5b                   	pop    %ebx
801061b4:	5e                   	pop    %esi
801061b5:	5f                   	pop    %edi
801061b6:	5d                   	pop    %ebp
801061b7:	c3                   	ret    
801061b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061bf:	90                   	nop

801061c0 <uartputc>:
  if(!uart)
801061c0:	a1 c0 55 11 80       	mov    0x801155c0,%eax
801061c5:	85 c0                	test   %eax,%eax
801061c7:	74 47                	je     80106210 <uartputc+0x50>
{
801061c9:	55                   	push   %ebp
801061ca:	89 e5                	mov    %esp,%ebp
801061cc:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801061cd:	be fd 03 00 00       	mov    $0x3fd,%esi
801061d2:	53                   	push   %ebx
801061d3:	bb 80 00 00 00       	mov    $0x80,%ebx
801061d8:	eb 18                	jmp    801061f2 <uartputc+0x32>
801061da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
801061e0:	83 ec 0c             	sub    $0xc,%esp
801061e3:	6a 0a                	push   $0xa
801061e5:	e8 66 c8 ff ff       	call   80102a50 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801061ea:	83 c4 10             	add    $0x10,%esp
801061ed:	83 eb 01             	sub    $0x1,%ebx
801061f0:	74 07                	je     801061f9 <uartputc+0x39>
801061f2:	89 f2                	mov    %esi,%edx
801061f4:	ec                   	in     (%dx),%al
801061f5:	a8 20                	test   $0x20,%al
801061f7:	74 e7                	je     801061e0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801061f9:	8b 45 08             	mov    0x8(%ebp),%eax
801061fc:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106201:	ee                   	out    %al,(%dx)
}
80106202:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106205:	5b                   	pop    %ebx
80106206:	5e                   	pop    %esi
80106207:	5d                   	pop    %ebp
80106208:	c3                   	ret    
80106209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106210:	c3                   	ret    
80106211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106218:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010621f:	90                   	nop

80106220 <uartintr>:

void
uartintr(void)
{
80106220:	55                   	push   %ebp
80106221:	89 e5                	mov    %esp,%ebp
80106223:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106226:	68 90 60 10 80       	push   $0x80106090
8010622b:	e8 c0 a6 ff ff       	call   801008f0 <consoleintr>
}
80106230:	83 c4 10             	add    $0x10,%esp
80106233:	c9                   	leave  
80106234:	c3                   	ret    

80106235 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106235:	6a 00                	push   $0x0
  pushl $0
80106237:	6a 00                	push   $0x0
  jmp alltraps
80106239:	e9 e9 fa ff ff       	jmp    80105d27 <alltraps>

8010623e <vector1>:
.globl vector1
vector1:
  pushl $0
8010623e:	6a 00                	push   $0x0
  pushl $1
80106240:	6a 01                	push   $0x1
  jmp alltraps
80106242:	e9 e0 fa ff ff       	jmp    80105d27 <alltraps>

80106247 <vector2>:
.globl vector2
vector2:
  pushl $0
80106247:	6a 00                	push   $0x0
  pushl $2
80106249:	6a 02                	push   $0x2
  jmp alltraps
8010624b:	e9 d7 fa ff ff       	jmp    80105d27 <alltraps>

80106250 <vector3>:
.globl vector3
vector3:
  pushl $0
80106250:	6a 00                	push   $0x0
  pushl $3
80106252:	6a 03                	push   $0x3
  jmp alltraps
80106254:	e9 ce fa ff ff       	jmp    80105d27 <alltraps>

80106259 <vector4>:
.globl vector4
vector4:
  pushl $0
80106259:	6a 00                	push   $0x0
  pushl $4
8010625b:	6a 04                	push   $0x4
  jmp alltraps
8010625d:	e9 c5 fa ff ff       	jmp    80105d27 <alltraps>

80106262 <vector5>:
.globl vector5
vector5:
  pushl $0
80106262:	6a 00                	push   $0x0
  pushl $5
80106264:	6a 05                	push   $0x5
  jmp alltraps
80106266:	e9 bc fa ff ff       	jmp    80105d27 <alltraps>

8010626b <vector6>:
.globl vector6
vector6:
  pushl $0
8010626b:	6a 00                	push   $0x0
  pushl $6
8010626d:	6a 06                	push   $0x6
  jmp alltraps
8010626f:	e9 b3 fa ff ff       	jmp    80105d27 <alltraps>

80106274 <vector7>:
.globl vector7
vector7:
  pushl $0
80106274:	6a 00                	push   $0x0
  pushl $7
80106276:	6a 07                	push   $0x7
  jmp alltraps
80106278:	e9 aa fa ff ff       	jmp    80105d27 <alltraps>

8010627d <vector8>:
.globl vector8
vector8:
  pushl $8
8010627d:	6a 08                	push   $0x8
  jmp alltraps
8010627f:	e9 a3 fa ff ff       	jmp    80105d27 <alltraps>

80106284 <vector9>:
.globl vector9
vector9:
  pushl $0
80106284:	6a 00                	push   $0x0
  pushl $9
80106286:	6a 09                	push   $0x9
  jmp alltraps
80106288:	e9 9a fa ff ff       	jmp    80105d27 <alltraps>

8010628d <vector10>:
.globl vector10
vector10:
  pushl $10
8010628d:	6a 0a                	push   $0xa
  jmp alltraps
8010628f:	e9 93 fa ff ff       	jmp    80105d27 <alltraps>

80106294 <vector11>:
.globl vector11
vector11:
  pushl $11
80106294:	6a 0b                	push   $0xb
  jmp alltraps
80106296:	e9 8c fa ff ff       	jmp    80105d27 <alltraps>

8010629b <vector12>:
.globl vector12
vector12:
  pushl $12
8010629b:	6a 0c                	push   $0xc
  jmp alltraps
8010629d:	e9 85 fa ff ff       	jmp    80105d27 <alltraps>

801062a2 <vector13>:
.globl vector13
vector13:
  pushl $13
801062a2:	6a 0d                	push   $0xd
  jmp alltraps
801062a4:	e9 7e fa ff ff       	jmp    80105d27 <alltraps>

801062a9 <vector14>:
.globl vector14
vector14:
  pushl $14
801062a9:	6a 0e                	push   $0xe
  jmp alltraps
801062ab:	e9 77 fa ff ff       	jmp    80105d27 <alltraps>

801062b0 <vector15>:
.globl vector15
vector15:
  pushl $0
801062b0:	6a 00                	push   $0x0
  pushl $15
801062b2:	6a 0f                	push   $0xf
  jmp alltraps
801062b4:	e9 6e fa ff ff       	jmp    80105d27 <alltraps>

801062b9 <vector16>:
.globl vector16
vector16:
  pushl $0
801062b9:	6a 00                	push   $0x0
  pushl $16
801062bb:	6a 10                	push   $0x10
  jmp alltraps
801062bd:	e9 65 fa ff ff       	jmp    80105d27 <alltraps>

801062c2 <vector17>:
.globl vector17
vector17:
  pushl $17
801062c2:	6a 11                	push   $0x11
  jmp alltraps
801062c4:	e9 5e fa ff ff       	jmp    80105d27 <alltraps>

801062c9 <vector18>:
.globl vector18
vector18:
  pushl $0
801062c9:	6a 00                	push   $0x0
  pushl $18
801062cb:	6a 12                	push   $0x12
  jmp alltraps
801062cd:	e9 55 fa ff ff       	jmp    80105d27 <alltraps>

801062d2 <vector19>:
.globl vector19
vector19:
  pushl $0
801062d2:	6a 00                	push   $0x0
  pushl $19
801062d4:	6a 13                	push   $0x13
  jmp alltraps
801062d6:	e9 4c fa ff ff       	jmp    80105d27 <alltraps>

801062db <vector20>:
.globl vector20
vector20:
  pushl $0
801062db:	6a 00                	push   $0x0
  pushl $20
801062dd:	6a 14                	push   $0x14
  jmp alltraps
801062df:	e9 43 fa ff ff       	jmp    80105d27 <alltraps>

801062e4 <vector21>:
.globl vector21
vector21:
  pushl $0
801062e4:	6a 00                	push   $0x0
  pushl $21
801062e6:	6a 15                	push   $0x15
  jmp alltraps
801062e8:	e9 3a fa ff ff       	jmp    80105d27 <alltraps>

801062ed <vector22>:
.globl vector22
vector22:
  pushl $0
801062ed:	6a 00                	push   $0x0
  pushl $22
801062ef:	6a 16                	push   $0x16
  jmp alltraps
801062f1:	e9 31 fa ff ff       	jmp    80105d27 <alltraps>

801062f6 <vector23>:
.globl vector23
vector23:
  pushl $0
801062f6:	6a 00                	push   $0x0
  pushl $23
801062f8:	6a 17                	push   $0x17
  jmp alltraps
801062fa:	e9 28 fa ff ff       	jmp    80105d27 <alltraps>

801062ff <vector24>:
.globl vector24
vector24:
  pushl $0
801062ff:	6a 00                	push   $0x0
  pushl $24
80106301:	6a 18                	push   $0x18
  jmp alltraps
80106303:	e9 1f fa ff ff       	jmp    80105d27 <alltraps>

80106308 <vector25>:
.globl vector25
vector25:
  pushl $0
80106308:	6a 00                	push   $0x0
  pushl $25
8010630a:	6a 19                	push   $0x19
  jmp alltraps
8010630c:	e9 16 fa ff ff       	jmp    80105d27 <alltraps>

80106311 <vector26>:
.globl vector26
vector26:
  pushl $0
80106311:	6a 00                	push   $0x0
  pushl $26
80106313:	6a 1a                	push   $0x1a
  jmp alltraps
80106315:	e9 0d fa ff ff       	jmp    80105d27 <alltraps>

8010631a <vector27>:
.globl vector27
vector27:
  pushl $0
8010631a:	6a 00                	push   $0x0
  pushl $27
8010631c:	6a 1b                	push   $0x1b
  jmp alltraps
8010631e:	e9 04 fa ff ff       	jmp    80105d27 <alltraps>

80106323 <vector28>:
.globl vector28
vector28:
  pushl $0
80106323:	6a 00                	push   $0x0
  pushl $28
80106325:	6a 1c                	push   $0x1c
  jmp alltraps
80106327:	e9 fb f9 ff ff       	jmp    80105d27 <alltraps>

8010632c <vector29>:
.globl vector29
vector29:
  pushl $0
8010632c:	6a 00                	push   $0x0
  pushl $29
8010632e:	6a 1d                	push   $0x1d
  jmp alltraps
80106330:	e9 f2 f9 ff ff       	jmp    80105d27 <alltraps>

80106335 <vector30>:
.globl vector30
vector30:
  pushl $0
80106335:	6a 00                	push   $0x0
  pushl $30
80106337:	6a 1e                	push   $0x1e
  jmp alltraps
80106339:	e9 e9 f9 ff ff       	jmp    80105d27 <alltraps>

8010633e <vector31>:
.globl vector31
vector31:
  pushl $0
8010633e:	6a 00                	push   $0x0
  pushl $31
80106340:	6a 1f                	push   $0x1f
  jmp alltraps
80106342:	e9 e0 f9 ff ff       	jmp    80105d27 <alltraps>

80106347 <vector32>:
.globl vector32
vector32:
  pushl $0
80106347:	6a 00                	push   $0x0
  pushl $32
80106349:	6a 20                	push   $0x20
  jmp alltraps
8010634b:	e9 d7 f9 ff ff       	jmp    80105d27 <alltraps>

80106350 <vector33>:
.globl vector33
vector33:
  pushl $0
80106350:	6a 00                	push   $0x0
  pushl $33
80106352:	6a 21                	push   $0x21
  jmp alltraps
80106354:	e9 ce f9 ff ff       	jmp    80105d27 <alltraps>

80106359 <vector34>:
.globl vector34
vector34:
  pushl $0
80106359:	6a 00                	push   $0x0
  pushl $34
8010635b:	6a 22                	push   $0x22
  jmp alltraps
8010635d:	e9 c5 f9 ff ff       	jmp    80105d27 <alltraps>

80106362 <vector35>:
.globl vector35
vector35:
  pushl $0
80106362:	6a 00                	push   $0x0
  pushl $35
80106364:	6a 23                	push   $0x23
  jmp alltraps
80106366:	e9 bc f9 ff ff       	jmp    80105d27 <alltraps>

8010636b <vector36>:
.globl vector36
vector36:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $36
8010636d:	6a 24                	push   $0x24
  jmp alltraps
8010636f:	e9 b3 f9 ff ff       	jmp    80105d27 <alltraps>

80106374 <vector37>:
.globl vector37
vector37:
  pushl $0
80106374:	6a 00                	push   $0x0
  pushl $37
80106376:	6a 25                	push   $0x25
  jmp alltraps
80106378:	e9 aa f9 ff ff       	jmp    80105d27 <alltraps>

8010637d <vector38>:
.globl vector38
vector38:
  pushl $0
8010637d:	6a 00                	push   $0x0
  pushl $38
8010637f:	6a 26                	push   $0x26
  jmp alltraps
80106381:	e9 a1 f9 ff ff       	jmp    80105d27 <alltraps>

80106386 <vector39>:
.globl vector39
vector39:
  pushl $0
80106386:	6a 00                	push   $0x0
  pushl $39
80106388:	6a 27                	push   $0x27
  jmp alltraps
8010638a:	e9 98 f9 ff ff       	jmp    80105d27 <alltraps>

8010638f <vector40>:
.globl vector40
vector40:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $40
80106391:	6a 28                	push   $0x28
  jmp alltraps
80106393:	e9 8f f9 ff ff       	jmp    80105d27 <alltraps>

80106398 <vector41>:
.globl vector41
vector41:
  pushl $0
80106398:	6a 00                	push   $0x0
  pushl $41
8010639a:	6a 29                	push   $0x29
  jmp alltraps
8010639c:	e9 86 f9 ff ff       	jmp    80105d27 <alltraps>

801063a1 <vector42>:
.globl vector42
vector42:
  pushl $0
801063a1:	6a 00                	push   $0x0
  pushl $42
801063a3:	6a 2a                	push   $0x2a
  jmp alltraps
801063a5:	e9 7d f9 ff ff       	jmp    80105d27 <alltraps>

801063aa <vector43>:
.globl vector43
vector43:
  pushl $0
801063aa:	6a 00                	push   $0x0
  pushl $43
801063ac:	6a 2b                	push   $0x2b
  jmp alltraps
801063ae:	e9 74 f9 ff ff       	jmp    80105d27 <alltraps>

801063b3 <vector44>:
.globl vector44
vector44:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $44
801063b5:	6a 2c                	push   $0x2c
  jmp alltraps
801063b7:	e9 6b f9 ff ff       	jmp    80105d27 <alltraps>

801063bc <vector45>:
.globl vector45
vector45:
  pushl $0
801063bc:	6a 00                	push   $0x0
  pushl $45
801063be:	6a 2d                	push   $0x2d
  jmp alltraps
801063c0:	e9 62 f9 ff ff       	jmp    80105d27 <alltraps>

801063c5 <vector46>:
.globl vector46
vector46:
  pushl $0
801063c5:	6a 00                	push   $0x0
  pushl $46
801063c7:	6a 2e                	push   $0x2e
  jmp alltraps
801063c9:	e9 59 f9 ff ff       	jmp    80105d27 <alltraps>

801063ce <vector47>:
.globl vector47
vector47:
  pushl $0
801063ce:	6a 00                	push   $0x0
  pushl $47
801063d0:	6a 2f                	push   $0x2f
  jmp alltraps
801063d2:	e9 50 f9 ff ff       	jmp    80105d27 <alltraps>

801063d7 <vector48>:
.globl vector48
vector48:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $48
801063d9:	6a 30                	push   $0x30
  jmp alltraps
801063db:	e9 47 f9 ff ff       	jmp    80105d27 <alltraps>

801063e0 <vector49>:
.globl vector49
vector49:
  pushl $0
801063e0:	6a 00                	push   $0x0
  pushl $49
801063e2:	6a 31                	push   $0x31
  jmp alltraps
801063e4:	e9 3e f9 ff ff       	jmp    80105d27 <alltraps>

801063e9 <vector50>:
.globl vector50
vector50:
  pushl $0
801063e9:	6a 00                	push   $0x0
  pushl $50
801063eb:	6a 32                	push   $0x32
  jmp alltraps
801063ed:	e9 35 f9 ff ff       	jmp    80105d27 <alltraps>

801063f2 <vector51>:
.globl vector51
vector51:
  pushl $0
801063f2:	6a 00                	push   $0x0
  pushl $51
801063f4:	6a 33                	push   $0x33
  jmp alltraps
801063f6:	e9 2c f9 ff ff       	jmp    80105d27 <alltraps>

801063fb <vector52>:
.globl vector52
vector52:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $52
801063fd:	6a 34                	push   $0x34
  jmp alltraps
801063ff:	e9 23 f9 ff ff       	jmp    80105d27 <alltraps>

80106404 <vector53>:
.globl vector53
vector53:
  pushl $0
80106404:	6a 00                	push   $0x0
  pushl $53
80106406:	6a 35                	push   $0x35
  jmp alltraps
80106408:	e9 1a f9 ff ff       	jmp    80105d27 <alltraps>

8010640d <vector54>:
.globl vector54
vector54:
  pushl $0
8010640d:	6a 00                	push   $0x0
  pushl $54
8010640f:	6a 36                	push   $0x36
  jmp alltraps
80106411:	e9 11 f9 ff ff       	jmp    80105d27 <alltraps>

80106416 <vector55>:
.globl vector55
vector55:
  pushl $0
80106416:	6a 00                	push   $0x0
  pushl $55
80106418:	6a 37                	push   $0x37
  jmp alltraps
8010641a:	e9 08 f9 ff ff       	jmp    80105d27 <alltraps>

8010641f <vector56>:
.globl vector56
vector56:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $56
80106421:	6a 38                	push   $0x38
  jmp alltraps
80106423:	e9 ff f8 ff ff       	jmp    80105d27 <alltraps>

80106428 <vector57>:
.globl vector57
vector57:
  pushl $0
80106428:	6a 00                	push   $0x0
  pushl $57
8010642a:	6a 39                	push   $0x39
  jmp alltraps
8010642c:	e9 f6 f8 ff ff       	jmp    80105d27 <alltraps>

80106431 <vector58>:
.globl vector58
vector58:
  pushl $0
80106431:	6a 00                	push   $0x0
  pushl $58
80106433:	6a 3a                	push   $0x3a
  jmp alltraps
80106435:	e9 ed f8 ff ff       	jmp    80105d27 <alltraps>

8010643a <vector59>:
.globl vector59
vector59:
  pushl $0
8010643a:	6a 00                	push   $0x0
  pushl $59
8010643c:	6a 3b                	push   $0x3b
  jmp alltraps
8010643e:	e9 e4 f8 ff ff       	jmp    80105d27 <alltraps>

80106443 <vector60>:
.globl vector60
vector60:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $60
80106445:	6a 3c                	push   $0x3c
  jmp alltraps
80106447:	e9 db f8 ff ff       	jmp    80105d27 <alltraps>

8010644c <vector61>:
.globl vector61
vector61:
  pushl $0
8010644c:	6a 00                	push   $0x0
  pushl $61
8010644e:	6a 3d                	push   $0x3d
  jmp alltraps
80106450:	e9 d2 f8 ff ff       	jmp    80105d27 <alltraps>

80106455 <vector62>:
.globl vector62
vector62:
  pushl $0
80106455:	6a 00                	push   $0x0
  pushl $62
80106457:	6a 3e                	push   $0x3e
  jmp alltraps
80106459:	e9 c9 f8 ff ff       	jmp    80105d27 <alltraps>

8010645e <vector63>:
.globl vector63
vector63:
  pushl $0
8010645e:	6a 00                	push   $0x0
  pushl $63
80106460:	6a 3f                	push   $0x3f
  jmp alltraps
80106462:	e9 c0 f8 ff ff       	jmp    80105d27 <alltraps>

80106467 <vector64>:
.globl vector64
vector64:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $64
80106469:	6a 40                	push   $0x40
  jmp alltraps
8010646b:	e9 b7 f8 ff ff       	jmp    80105d27 <alltraps>

80106470 <vector65>:
.globl vector65
vector65:
  pushl $0
80106470:	6a 00                	push   $0x0
  pushl $65
80106472:	6a 41                	push   $0x41
  jmp alltraps
80106474:	e9 ae f8 ff ff       	jmp    80105d27 <alltraps>

80106479 <vector66>:
.globl vector66
vector66:
  pushl $0
80106479:	6a 00                	push   $0x0
  pushl $66
8010647b:	6a 42                	push   $0x42
  jmp alltraps
8010647d:	e9 a5 f8 ff ff       	jmp    80105d27 <alltraps>

80106482 <vector67>:
.globl vector67
vector67:
  pushl $0
80106482:	6a 00                	push   $0x0
  pushl $67
80106484:	6a 43                	push   $0x43
  jmp alltraps
80106486:	e9 9c f8 ff ff       	jmp    80105d27 <alltraps>

8010648b <vector68>:
.globl vector68
vector68:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $68
8010648d:	6a 44                	push   $0x44
  jmp alltraps
8010648f:	e9 93 f8 ff ff       	jmp    80105d27 <alltraps>

80106494 <vector69>:
.globl vector69
vector69:
  pushl $0
80106494:	6a 00                	push   $0x0
  pushl $69
80106496:	6a 45                	push   $0x45
  jmp alltraps
80106498:	e9 8a f8 ff ff       	jmp    80105d27 <alltraps>

8010649d <vector70>:
.globl vector70
vector70:
  pushl $0
8010649d:	6a 00                	push   $0x0
  pushl $70
8010649f:	6a 46                	push   $0x46
  jmp alltraps
801064a1:	e9 81 f8 ff ff       	jmp    80105d27 <alltraps>

801064a6 <vector71>:
.globl vector71
vector71:
  pushl $0
801064a6:	6a 00                	push   $0x0
  pushl $71
801064a8:	6a 47                	push   $0x47
  jmp alltraps
801064aa:	e9 78 f8 ff ff       	jmp    80105d27 <alltraps>

801064af <vector72>:
.globl vector72
vector72:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $72
801064b1:	6a 48                	push   $0x48
  jmp alltraps
801064b3:	e9 6f f8 ff ff       	jmp    80105d27 <alltraps>

801064b8 <vector73>:
.globl vector73
vector73:
  pushl $0
801064b8:	6a 00                	push   $0x0
  pushl $73
801064ba:	6a 49                	push   $0x49
  jmp alltraps
801064bc:	e9 66 f8 ff ff       	jmp    80105d27 <alltraps>

801064c1 <vector74>:
.globl vector74
vector74:
  pushl $0
801064c1:	6a 00                	push   $0x0
  pushl $74
801064c3:	6a 4a                	push   $0x4a
  jmp alltraps
801064c5:	e9 5d f8 ff ff       	jmp    80105d27 <alltraps>

801064ca <vector75>:
.globl vector75
vector75:
  pushl $0
801064ca:	6a 00                	push   $0x0
  pushl $75
801064cc:	6a 4b                	push   $0x4b
  jmp alltraps
801064ce:	e9 54 f8 ff ff       	jmp    80105d27 <alltraps>

801064d3 <vector76>:
.globl vector76
vector76:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $76
801064d5:	6a 4c                	push   $0x4c
  jmp alltraps
801064d7:	e9 4b f8 ff ff       	jmp    80105d27 <alltraps>

801064dc <vector77>:
.globl vector77
vector77:
  pushl $0
801064dc:	6a 00                	push   $0x0
  pushl $77
801064de:	6a 4d                	push   $0x4d
  jmp alltraps
801064e0:	e9 42 f8 ff ff       	jmp    80105d27 <alltraps>

801064e5 <vector78>:
.globl vector78
vector78:
  pushl $0
801064e5:	6a 00                	push   $0x0
  pushl $78
801064e7:	6a 4e                	push   $0x4e
  jmp alltraps
801064e9:	e9 39 f8 ff ff       	jmp    80105d27 <alltraps>

801064ee <vector79>:
.globl vector79
vector79:
  pushl $0
801064ee:	6a 00                	push   $0x0
  pushl $79
801064f0:	6a 4f                	push   $0x4f
  jmp alltraps
801064f2:	e9 30 f8 ff ff       	jmp    80105d27 <alltraps>

801064f7 <vector80>:
.globl vector80
vector80:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $80
801064f9:	6a 50                	push   $0x50
  jmp alltraps
801064fb:	e9 27 f8 ff ff       	jmp    80105d27 <alltraps>

80106500 <vector81>:
.globl vector81
vector81:
  pushl $0
80106500:	6a 00                	push   $0x0
  pushl $81
80106502:	6a 51                	push   $0x51
  jmp alltraps
80106504:	e9 1e f8 ff ff       	jmp    80105d27 <alltraps>

80106509 <vector82>:
.globl vector82
vector82:
  pushl $0
80106509:	6a 00                	push   $0x0
  pushl $82
8010650b:	6a 52                	push   $0x52
  jmp alltraps
8010650d:	e9 15 f8 ff ff       	jmp    80105d27 <alltraps>

80106512 <vector83>:
.globl vector83
vector83:
  pushl $0
80106512:	6a 00                	push   $0x0
  pushl $83
80106514:	6a 53                	push   $0x53
  jmp alltraps
80106516:	e9 0c f8 ff ff       	jmp    80105d27 <alltraps>

8010651b <vector84>:
.globl vector84
vector84:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $84
8010651d:	6a 54                	push   $0x54
  jmp alltraps
8010651f:	e9 03 f8 ff ff       	jmp    80105d27 <alltraps>

80106524 <vector85>:
.globl vector85
vector85:
  pushl $0
80106524:	6a 00                	push   $0x0
  pushl $85
80106526:	6a 55                	push   $0x55
  jmp alltraps
80106528:	e9 fa f7 ff ff       	jmp    80105d27 <alltraps>

8010652d <vector86>:
.globl vector86
vector86:
  pushl $0
8010652d:	6a 00                	push   $0x0
  pushl $86
8010652f:	6a 56                	push   $0x56
  jmp alltraps
80106531:	e9 f1 f7 ff ff       	jmp    80105d27 <alltraps>

80106536 <vector87>:
.globl vector87
vector87:
  pushl $0
80106536:	6a 00                	push   $0x0
  pushl $87
80106538:	6a 57                	push   $0x57
  jmp alltraps
8010653a:	e9 e8 f7 ff ff       	jmp    80105d27 <alltraps>

8010653f <vector88>:
.globl vector88
vector88:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $88
80106541:	6a 58                	push   $0x58
  jmp alltraps
80106543:	e9 df f7 ff ff       	jmp    80105d27 <alltraps>

80106548 <vector89>:
.globl vector89
vector89:
  pushl $0
80106548:	6a 00                	push   $0x0
  pushl $89
8010654a:	6a 59                	push   $0x59
  jmp alltraps
8010654c:	e9 d6 f7 ff ff       	jmp    80105d27 <alltraps>

80106551 <vector90>:
.globl vector90
vector90:
  pushl $0
80106551:	6a 00                	push   $0x0
  pushl $90
80106553:	6a 5a                	push   $0x5a
  jmp alltraps
80106555:	e9 cd f7 ff ff       	jmp    80105d27 <alltraps>

8010655a <vector91>:
.globl vector91
vector91:
  pushl $0
8010655a:	6a 00                	push   $0x0
  pushl $91
8010655c:	6a 5b                	push   $0x5b
  jmp alltraps
8010655e:	e9 c4 f7 ff ff       	jmp    80105d27 <alltraps>

80106563 <vector92>:
.globl vector92
vector92:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $92
80106565:	6a 5c                	push   $0x5c
  jmp alltraps
80106567:	e9 bb f7 ff ff       	jmp    80105d27 <alltraps>

8010656c <vector93>:
.globl vector93
vector93:
  pushl $0
8010656c:	6a 00                	push   $0x0
  pushl $93
8010656e:	6a 5d                	push   $0x5d
  jmp alltraps
80106570:	e9 b2 f7 ff ff       	jmp    80105d27 <alltraps>

80106575 <vector94>:
.globl vector94
vector94:
  pushl $0
80106575:	6a 00                	push   $0x0
  pushl $94
80106577:	6a 5e                	push   $0x5e
  jmp alltraps
80106579:	e9 a9 f7 ff ff       	jmp    80105d27 <alltraps>

8010657e <vector95>:
.globl vector95
vector95:
  pushl $0
8010657e:	6a 00                	push   $0x0
  pushl $95
80106580:	6a 5f                	push   $0x5f
  jmp alltraps
80106582:	e9 a0 f7 ff ff       	jmp    80105d27 <alltraps>

80106587 <vector96>:
.globl vector96
vector96:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $96
80106589:	6a 60                	push   $0x60
  jmp alltraps
8010658b:	e9 97 f7 ff ff       	jmp    80105d27 <alltraps>

80106590 <vector97>:
.globl vector97
vector97:
  pushl $0
80106590:	6a 00                	push   $0x0
  pushl $97
80106592:	6a 61                	push   $0x61
  jmp alltraps
80106594:	e9 8e f7 ff ff       	jmp    80105d27 <alltraps>

80106599 <vector98>:
.globl vector98
vector98:
  pushl $0
80106599:	6a 00                	push   $0x0
  pushl $98
8010659b:	6a 62                	push   $0x62
  jmp alltraps
8010659d:	e9 85 f7 ff ff       	jmp    80105d27 <alltraps>

801065a2 <vector99>:
.globl vector99
vector99:
  pushl $0
801065a2:	6a 00                	push   $0x0
  pushl $99
801065a4:	6a 63                	push   $0x63
  jmp alltraps
801065a6:	e9 7c f7 ff ff       	jmp    80105d27 <alltraps>

801065ab <vector100>:
.globl vector100
vector100:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $100
801065ad:	6a 64                	push   $0x64
  jmp alltraps
801065af:	e9 73 f7 ff ff       	jmp    80105d27 <alltraps>

801065b4 <vector101>:
.globl vector101
vector101:
  pushl $0
801065b4:	6a 00                	push   $0x0
  pushl $101
801065b6:	6a 65                	push   $0x65
  jmp alltraps
801065b8:	e9 6a f7 ff ff       	jmp    80105d27 <alltraps>

801065bd <vector102>:
.globl vector102
vector102:
  pushl $0
801065bd:	6a 00                	push   $0x0
  pushl $102
801065bf:	6a 66                	push   $0x66
  jmp alltraps
801065c1:	e9 61 f7 ff ff       	jmp    80105d27 <alltraps>

801065c6 <vector103>:
.globl vector103
vector103:
  pushl $0
801065c6:	6a 00                	push   $0x0
  pushl $103
801065c8:	6a 67                	push   $0x67
  jmp alltraps
801065ca:	e9 58 f7 ff ff       	jmp    80105d27 <alltraps>

801065cf <vector104>:
.globl vector104
vector104:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $104
801065d1:	6a 68                	push   $0x68
  jmp alltraps
801065d3:	e9 4f f7 ff ff       	jmp    80105d27 <alltraps>

801065d8 <vector105>:
.globl vector105
vector105:
  pushl $0
801065d8:	6a 00                	push   $0x0
  pushl $105
801065da:	6a 69                	push   $0x69
  jmp alltraps
801065dc:	e9 46 f7 ff ff       	jmp    80105d27 <alltraps>

801065e1 <vector106>:
.globl vector106
vector106:
  pushl $0
801065e1:	6a 00                	push   $0x0
  pushl $106
801065e3:	6a 6a                	push   $0x6a
  jmp alltraps
801065e5:	e9 3d f7 ff ff       	jmp    80105d27 <alltraps>

801065ea <vector107>:
.globl vector107
vector107:
  pushl $0
801065ea:	6a 00                	push   $0x0
  pushl $107
801065ec:	6a 6b                	push   $0x6b
  jmp alltraps
801065ee:	e9 34 f7 ff ff       	jmp    80105d27 <alltraps>

801065f3 <vector108>:
.globl vector108
vector108:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $108
801065f5:	6a 6c                	push   $0x6c
  jmp alltraps
801065f7:	e9 2b f7 ff ff       	jmp    80105d27 <alltraps>

801065fc <vector109>:
.globl vector109
vector109:
  pushl $0
801065fc:	6a 00                	push   $0x0
  pushl $109
801065fe:	6a 6d                	push   $0x6d
  jmp alltraps
80106600:	e9 22 f7 ff ff       	jmp    80105d27 <alltraps>

80106605 <vector110>:
.globl vector110
vector110:
  pushl $0
80106605:	6a 00                	push   $0x0
  pushl $110
80106607:	6a 6e                	push   $0x6e
  jmp alltraps
80106609:	e9 19 f7 ff ff       	jmp    80105d27 <alltraps>

8010660e <vector111>:
.globl vector111
vector111:
  pushl $0
8010660e:	6a 00                	push   $0x0
  pushl $111
80106610:	6a 6f                	push   $0x6f
  jmp alltraps
80106612:	e9 10 f7 ff ff       	jmp    80105d27 <alltraps>

80106617 <vector112>:
.globl vector112
vector112:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $112
80106619:	6a 70                	push   $0x70
  jmp alltraps
8010661b:	e9 07 f7 ff ff       	jmp    80105d27 <alltraps>

80106620 <vector113>:
.globl vector113
vector113:
  pushl $0
80106620:	6a 00                	push   $0x0
  pushl $113
80106622:	6a 71                	push   $0x71
  jmp alltraps
80106624:	e9 fe f6 ff ff       	jmp    80105d27 <alltraps>

80106629 <vector114>:
.globl vector114
vector114:
  pushl $0
80106629:	6a 00                	push   $0x0
  pushl $114
8010662b:	6a 72                	push   $0x72
  jmp alltraps
8010662d:	e9 f5 f6 ff ff       	jmp    80105d27 <alltraps>

80106632 <vector115>:
.globl vector115
vector115:
  pushl $0
80106632:	6a 00                	push   $0x0
  pushl $115
80106634:	6a 73                	push   $0x73
  jmp alltraps
80106636:	e9 ec f6 ff ff       	jmp    80105d27 <alltraps>

8010663b <vector116>:
.globl vector116
vector116:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $116
8010663d:	6a 74                	push   $0x74
  jmp alltraps
8010663f:	e9 e3 f6 ff ff       	jmp    80105d27 <alltraps>

80106644 <vector117>:
.globl vector117
vector117:
  pushl $0
80106644:	6a 00                	push   $0x0
  pushl $117
80106646:	6a 75                	push   $0x75
  jmp alltraps
80106648:	e9 da f6 ff ff       	jmp    80105d27 <alltraps>

8010664d <vector118>:
.globl vector118
vector118:
  pushl $0
8010664d:	6a 00                	push   $0x0
  pushl $118
8010664f:	6a 76                	push   $0x76
  jmp alltraps
80106651:	e9 d1 f6 ff ff       	jmp    80105d27 <alltraps>

80106656 <vector119>:
.globl vector119
vector119:
  pushl $0
80106656:	6a 00                	push   $0x0
  pushl $119
80106658:	6a 77                	push   $0x77
  jmp alltraps
8010665a:	e9 c8 f6 ff ff       	jmp    80105d27 <alltraps>

8010665f <vector120>:
.globl vector120
vector120:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $120
80106661:	6a 78                	push   $0x78
  jmp alltraps
80106663:	e9 bf f6 ff ff       	jmp    80105d27 <alltraps>

80106668 <vector121>:
.globl vector121
vector121:
  pushl $0
80106668:	6a 00                	push   $0x0
  pushl $121
8010666a:	6a 79                	push   $0x79
  jmp alltraps
8010666c:	e9 b6 f6 ff ff       	jmp    80105d27 <alltraps>

80106671 <vector122>:
.globl vector122
vector122:
  pushl $0
80106671:	6a 00                	push   $0x0
  pushl $122
80106673:	6a 7a                	push   $0x7a
  jmp alltraps
80106675:	e9 ad f6 ff ff       	jmp    80105d27 <alltraps>

8010667a <vector123>:
.globl vector123
vector123:
  pushl $0
8010667a:	6a 00                	push   $0x0
  pushl $123
8010667c:	6a 7b                	push   $0x7b
  jmp alltraps
8010667e:	e9 a4 f6 ff ff       	jmp    80105d27 <alltraps>

80106683 <vector124>:
.globl vector124
vector124:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $124
80106685:	6a 7c                	push   $0x7c
  jmp alltraps
80106687:	e9 9b f6 ff ff       	jmp    80105d27 <alltraps>

8010668c <vector125>:
.globl vector125
vector125:
  pushl $0
8010668c:	6a 00                	push   $0x0
  pushl $125
8010668e:	6a 7d                	push   $0x7d
  jmp alltraps
80106690:	e9 92 f6 ff ff       	jmp    80105d27 <alltraps>

80106695 <vector126>:
.globl vector126
vector126:
  pushl $0
80106695:	6a 00                	push   $0x0
  pushl $126
80106697:	6a 7e                	push   $0x7e
  jmp alltraps
80106699:	e9 89 f6 ff ff       	jmp    80105d27 <alltraps>

8010669e <vector127>:
.globl vector127
vector127:
  pushl $0
8010669e:	6a 00                	push   $0x0
  pushl $127
801066a0:	6a 7f                	push   $0x7f
  jmp alltraps
801066a2:	e9 80 f6 ff ff       	jmp    80105d27 <alltraps>

801066a7 <vector128>:
.globl vector128
vector128:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $128
801066a9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801066ae:	e9 74 f6 ff ff       	jmp    80105d27 <alltraps>

801066b3 <vector129>:
.globl vector129
vector129:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $129
801066b5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801066ba:	e9 68 f6 ff ff       	jmp    80105d27 <alltraps>

801066bf <vector130>:
.globl vector130
vector130:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $130
801066c1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801066c6:	e9 5c f6 ff ff       	jmp    80105d27 <alltraps>

801066cb <vector131>:
.globl vector131
vector131:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $131
801066cd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801066d2:	e9 50 f6 ff ff       	jmp    80105d27 <alltraps>

801066d7 <vector132>:
.globl vector132
vector132:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $132
801066d9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801066de:	e9 44 f6 ff ff       	jmp    80105d27 <alltraps>

801066e3 <vector133>:
.globl vector133
vector133:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $133
801066e5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801066ea:	e9 38 f6 ff ff       	jmp    80105d27 <alltraps>

801066ef <vector134>:
.globl vector134
vector134:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $134
801066f1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801066f6:	e9 2c f6 ff ff       	jmp    80105d27 <alltraps>

801066fb <vector135>:
.globl vector135
vector135:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $135
801066fd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106702:	e9 20 f6 ff ff       	jmp    80105d27 <alltraps>

80106707 <vector136>:
.globl vector136
vector136:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $136
80106709:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010670e:	e9 14 f6 ff ff       	jmp    80105d27 <alltraps>

80106713 <vector137>:
.globl vector137
vector137:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $137
80106715:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010671a:	e9 08 f6 ff ff       	jmp    80105d27 <alltraps>

8010671f <vector138>:
.globl vector138
vector138:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $138
80106721:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106726:	e9 fc f5 ff ff       	jmp    80105d27 <alltraps>

8010672b <vector139>:
.globl vector139
vector139:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $139
8010672d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106732:	e9 f0 f5 ff ff       	jmp    80105d27 <alltraps>

80106737 <vector140>:
.globl vector140
vector140:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $140
80106739:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010673e:	e9 e4 f5 ff ff       	jmp    80105d27 <alltraps>

80106743 <vector141>:
.globl vector141
vector141:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $141
80106745:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010674a:	e9 d8 f5 ff ff       	jmp    80105d27 <alltraps>

8010674f <vector142>:
.globl vector142
vector142:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $142
80106751:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106756:	e9 cc f5 ff ff       	jmp    80105d27 <alltraps>

8010675b <vector143>:
.globl vector143
vector143:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $143
8010675d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106762:	e9 c0 f5 ff ff       	jmp    80105d27 <alltraps>

80106767 <vector144>:
.globl vector144
vector144:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $144
80106769:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010676e:	e9 b4 f5 ff ff       	jmp    80105d27 <alltraps>

80106773 <vector145>:
.globl vector145
vector145:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $145
80106775:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010677a:	e9 a8 f5 ff ff       	jmp    80105d27 <alltraps>

8010677f <vector146>:
.globl vector146
vector146:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $146
80106781:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106786:	e9 9c f5 ff ff       	jmp    80105d27 <alltraps>

8010678b <vector147>:
.globl vector147
vector147:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $147
8010678d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106792:	e9 90 f5 ff ff       	jmp    80105d27 <alltraps>

80106797 <vector148>:
.globl vector148
vector148:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $148
80106799:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010679e:	e9 84 f5 ff ff       	jmp    80105d27 <alltraps>

801067a3 <vector149>:
.globl vector149
vector149:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $149
801067a5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801067aa:	e9 78 f5 ff ff       	jmp    80105d27 <alltraps>

801067af <vector150>:
.globl vector150
vector150:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $150
801067b1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801067b6:	e9 6c f5 ff ff       	jmp    80105d27 <alltraps>

801067bb <vector151>:
.globl vector151
vector151:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $151
801067bd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801067c2:	e9 60 f5 ff ff       	jmp    80105d27 <alltraps>

801067c7 <vector152>:
.globl vector152
vector152:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $152
801067c9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801067ce:	e9 54 f5 ff ff       	jmp    80105d27 <alltraps>

801067d3 <vector153>:
.globl vector153
vector153:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $153
801067d5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801067da:	e9 48 f5 ff ff       	jmp    80105d27 <alltraps>

801067df <vector154>:
.globl vector154
vector154:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $154
801067e1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801067e6:	e9 3c f5 ff ff       	jmp    80105d27 <alltraps>

801067eb <vector155>:
.globl vector155
vector155:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $155
801067ed:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801067f2:	e9 30 f5 ff ff       	jmp    80105d27 <alltraps>

801067f7 <vector156>:
.globl vector156
vector156:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $156
801067f9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801067fe:	e9 24 f5 ff ff       	jmp    80105d27 <alltraps>

80106803 <vector157>:
.globl vector157
vector157:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $157
80106805:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010680a:	e9 18 f5 ff ff       	jmp    80105d27 <alltraps>

8010680f <vector158>:
.globl vector158
vector158:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $158
80106811:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106816:	e9 0c f5 ff ff       	jmp    80105d27 <alltraps>

8010681b <vector159>:
.globl vector159
vector159:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $159
8010681d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106822:	e9 00 f5 ff ff       	jmp    80105d27 <alltraps>

80106827 <vector160>:
.globl vector160
vector160:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $160
80106829:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010682e:	e9 f4 f4 ff ff       	jmp    80105d27 <alltraps>

80106833 <vector161>:
.globl vector161
vector161:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $161
80106835:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010683a:	e9 e8 f4 ff ff       	jmp    80105d27 <alltraps>

8010683f <vector162>:
.globl vector162
vector162:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $162
80106841:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106846:	e9 dc f4 ff ff       	jmp    80105d27 <alltraps>

8010684b <vector163>:
.globl vector163
vector163:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $163
8010684d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106852:	e9 d0 f4 ff ff       	jmp    80105d27 <alltraps>

80106857 <vector164>:
.globl vector164
vector164:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $164
80106859:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010685e:	e9 c4 f4 ff ff       	jmp    80105d27 <alltraps>

80106863 <vector165>:
.globl vector165
vector165:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $165
80106865:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010686a:	e9 b8 f4 ff ff       	jmp    80105d27 <alltraps>

8010686f <vector166>:
.globl vector166
vector166:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $166
80106871:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106876:	e9 ac f4 ff ff       	jmp    80105d27 <alltraps>

8010687b <vector167>:
.globl vector167
vector167:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $167
8010687d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106882:	e9 a0 f4 ff ff       	jmp    80105d27 <alltraps>

80106887 <vector168>:
.globl vector168
vector168:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $168
80106889:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010688e:	e9 94 f4 ff ff       	jmp    80105d27 <alltraps>

80106893 <vector169>:
.globl vector169
vector169:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $169
80106895:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010689a:	e9 88 f4 ff ff       	jmp    80105d27 <alltraps>

8010689f <vector170>:
.globl vector170
vector170:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $170
801068a1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801068a6:	e9 7c f4 ff ff       	jmp    80105d27 <alltraps>

801068ab <vector171>:
.globl vector171
vector171:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $171
801068ad:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801068b2:	e9 70 f4 ff ff       	jmp    80105d27 <alltraps>

801068b7 <vector172>:
.globl vector172
vector172:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $172
801068b9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801068be:	e9 64 f4 ff ff       	jmp    80105d27 <alltraps>

801068c3 <vector173>:
.globl vector173
vector173:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $173
801068c5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801068ca:	e9 58 f4 ff ff       	jmp    80105d27 <alltraps>

801068cf <vector174>:
.globl vector174
vector174:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $174
801068d1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801068d6:	e9 4c f4 ff ff       	jmp    80105d27 <alltraps>

801068db <vector175>:
.globl vector175
vector175:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $175
801068dd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801068e2:	e9 40 f4 ff ff       	jmp    80105d27 <alltraps>

801068e7 <vector176>:
.globl vector176
vector176:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $176
801068e9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801068ee:	e9 34 f4 ff ff       	jmp    80105d27 <alltraps>

801068f3 <vector177>:
.globl vector177
vector177:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $177
801068f5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801068fa:	e9 28 f4 ff ff       	jmp    80105d27 <alltraps>

801068ff <vector178>:
.globl vector178
vector178:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $178
80106901:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106906:	e9 1c f4 ff ff       	jmp    80105d27 <alltraps>

8010690b <vector179>:
.globl vector179
vector179:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $179
8010690d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106912:	e9 10 f4 ff ff       	jmp    80105d27 <alltraps>

80106917 <vector180>:
.globl vector180
vector180:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $180
80106919:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010691e:	e9 04 f4 ff ff       	jmp    80105d27 <alltraps>

80106923 <vector181>:
.globl vector181
vector181:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $181
80106925:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010692a:	e9 f8 f3 ff ff       	jmp    80105d27 <alltraps>

8010692f <vector182>:
.globl vector182
vector182:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $182
80106931:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106936:	e9 ec f3 ff ff       	jmp    80105d27 <alltraps>

8010693b <vector183>:
.globl vector183
vector183:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $183
8010693d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106942:	e9 e0 f3 ff ff       	jmp    80105d27 <alltraps>

80106947 <vector184>:
.globl vector184
vector184:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $184
80106949:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010694e:	e9 d4 f3 ff ff       	jmp    80105d27 <alltraps>

80106953 <vector185>:
.globl vector185
vector185:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $185
80106955:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010695a:	e9 c8 f3 ff ff       	jmp    80105d27 <alltraps>

8010695f <vector186>:
.globl vector186
vector186:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $186
80106961:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106966:	e9 bc f3 ff ff       	jmp    80105d27 <alltraps>

8010696b <vector187>:
.globl vector187
vector187:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $187
8010696d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106972:	e9 b0 f3 ff ff       	jmp    80105d27 <alltraps>

80106977 <vector188>:
.globl vector188
vector188:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $188
80106979:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010697e:	e9 a4 f3 ff ff       	jmp    80105d27 <alltraps>

80106983 <vector189>:
.globl vector189
vector189:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $189
80106985:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010698a:	e9 98 f3 ff ff       	jmp    80105d27 <alltraps>

8010698f <vector190>:
.globl vector190
vector190:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $190
80106991:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106996:	e9 8c f3 ff ff       	jmp    80105d27 <alltraps>

8010699b <vector191>:
.globl vector191
vector191:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $191
8010699d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801069a2:	e9 80 f3 ff ff       	jmp    80105d27 <alltraps>

801069a7 <vector192>:
.globl vector192
vector192:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $192
801069a9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801069ae:	e9 74 f3 ff ff       	jmp    80105d27 <alltraps>

801069b3 <vector193>:
.globl vector193
vector193:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $193
801069b5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801069ba:	e9 68 f3 ff ff       	jmp    80105d27 <alltraps>

801069bf <vector194>:
.globl vector194
vector194:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $194
801069c1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801069c6:	e9 5c f3 ff ff       	jmp    80105d27 <alltraps>

801069cb <vector195>:
.globl vector195
vector195:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $195
801069cd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801069d2:	e9 50 f3 ff ff       	jmp    80105d27 <alltraps>

801069d7 <vector196>:
.globl vector196
vector196:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $196
801069d9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801069de:	e9 44 f3 ff ff       	jmp    80105d27 <alltraps>

801069e3 <vector197>:
.globl vector197
vector197:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $197
801069e5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801069ea:	e9 38 f3 ff ff       	jmp    80105d27 <alltraps>

801069ef <vector198>:
.globl vector198
vector198:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $198
801069f1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801069f6:	e9 2c f3 ff ff       	jmp    80105d27 <alltraps>

801069fb <vector199>:
.globl vector199
vector199:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $199
801069fd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106a02:	e9 20 f3 ff ff       	jmp    80105d27 <alltraps>

80106a07 <vector200>:
.globl vector200
vector200:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $200
80106a09:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106a0e:	e9 14 f3 ff ff       	jmp    80105d27 <alltraps>

80106a13 <vector201>:
.globl vector201
vector201:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $201
80106a15:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106a1a:	e9 08 f3 ff ff       	jmp    80105d27 <alltraps>

80106a1f <vector202>:
.globl vector202
vector202:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $202
80106a21:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106a26:	e9 fc f2 ff ff       	jmp    80105d27 <alltraps>

80106a2b <vector203>:
.globl vector203
vector203:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $203
80106a2d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106a32:	e9 f0 f2 ff ff       	jmp    80105d27 <alltraps>

80106a37 <vector204>:
.globl vector204
vector204:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $204
80106a39:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106a3e:	e9 e4 f2 ff ff       	jmp    80105d27 <alltraps>

80106a43 <vector205>:
.globl vector205
vector205:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $205
80106a45:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106a4a:	e9 d8 f2 ff ff       	jmp    80105d27 <alltraps>

80106a4f <vector206>:
.globl vector206
vector206:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $206
80106a51:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106a56:	e9 cc f2 ff ff       	jmp    80105d27 <alltraps>

80106a5b <vector207>:
.globl vector207
vector207:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $207
80106a5d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106a62:	e9 c0 f2 ff ff       	jmp    80105d27 <alltraps>

80106a67 <vector208>:
.globl vector208
vector208:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $208
80106a69:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106a6e:	e9 b4 f2 ff ff       	jmp    80105d27 <alltraps>

80106a73 <vector209>:
.globl vector209
vector209:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $209
80106a75:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106a7a:	e9 a8 f2 ff ff       	jmp    80105d27 <alltraps>

80106a7f <vector210>:
.globl vector210
vector210:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $210
80106a81:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106a86:	e9 9c f2 ff ff       	jmp    80105d27 <alltraps>

80106a8b <vector211>:
.globl vector211
vector211:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $211
80106a8d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106a92:	e9 90 f2 ff ff       	jmp    80105d27 <alltraps>

80106a97 <vector212>:
.globl vector212
vector212:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $212
80106a99:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106a9e:	e9 84 f2 ff ff       	jmp    80105d27 <alltraps>

80106aa3 <vector213>:
.globl vector213
vector213:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $213
80106aa5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106aaa:	e9 78 f2 ff ff       	jmp    80105d27 <alltraps>

80106aaf <vector214>:
.globl vector214
vector214:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $214
80106ab1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106ab6:	e9 6c f2 ff ff       	jmp    80105d27 <alltraps>

80106abb <vector215>:
.globl vector215
vector215:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $215
80106abd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106ac2:	e9 60 f2 ff ff       	jmp    80105d27 <alltraps>

80106ac7 <vector216>:
.globl vector216
vector216:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $216
80106ac9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106ace:	e9 54 f2 ff ff       	jmp    80105d27 <alltraps>

80106ad3 <vector217>:
.globl vector217
vector217:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $217
80106ad5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106ada:	e9 48 f2 ff ff       	jmp    80105d27 <alltraps>

80106adf <vector218>:
.globl vector218
vector218:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $218
80106ae1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106ae6:	e9 3c f2 ff ff       	jmp    80105d27 <alltraps>

80106aeb <vector219>:
.globl vector219
vector219:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $219
80106aed:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106af2:	e9 30 f2 ff ff       	jmp    80105d27 <alltraps>

80106af7 <vector220>:
.globl vector220
vector220:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $220
80106af9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106afe:	e9 24 f2 ff ff       	jmp    80105d27 <alltraps>

80106b03 <vector221>:
.globl vector221
vector221:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $221
80106b05:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106b0a:	e9 18 f2 ff ff       	jmp    80105d27 <alltraps>

80106b0f <vector222>:
.globl vector222
vector222:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $222
80106b11:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106b16:	e9 0c f2 ff ff       	jmp    80105d27 <alltraps>

80106b1b <vector223>:
.globl vector223
vector223:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $223
80106b1d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106b22:	e9 00 f2 ff ff       	jmp    80105d27 <alltraps>

80106b27 <vector224>:
.globl vector224
vector224:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $224
80106b29:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106b2e:	e9 f4 f1 ff ff       	jmp    80105d27 <alltraps>

80106b33 <vector225>:
.globl vector225
vector225:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $225
80106b35:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106b3a:	e9 e8 f1 ff ff       	jmp    80105d27 <alltraps>

80106b3f <vector226>:
.globl vector226
vector226:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $226
80106b41:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106b46:	e9 dc f1 ff ff       	jmp    80105d27 <alltraps>

80106b4b <vector227>:
.globl vector227
vector227:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $227
80106b4d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106b52:	e9 d0 f1 ff ff       	jmp    80105d27 <alltraps>

80106b57 <vector228>:
.globl vector228
vector228:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $228
80106b59:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106b5e:	e9 c4 f1 ff ff       	jmp    80105d27 <alltraps>

80106b63 <vector229>:
.globl vector229
vector229:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $229
80106b65:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106b6a:	e9 b8 f1 ff ff       	jmp    80105d27 <alltraps>

80106b6f <vector230>:
.globl vector230
vector230:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $230
80106b71:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106b76:	e9 ac f1 ff ff       	jmp    80105d27 <alltraps>

80106b7b <vector231>:
.globl vector231
vector231:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $231
80106b7d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106b82:	e9 a0 f1 ff ff       	jmp    80105d27 <alltraps>

80106b87 <vector232>:
.globl vector232
vector232:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $232
80106b89:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106b8e:	e9 94 f1 ff ff       	jmp    80105d27 <alltraps>

80106b93 <vector233>:
.globl vector233
vector233:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $233
80106b95:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106b9a:	e9 88 f1 ff ff       	jmp    80105d27 <alltraps>

80106b9f <vector234>:
.globl vector234
vector234:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $234
80106ba1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106ba6:	e9 7c f1 ff ff       	jmp    80105d27 <alltraps>

80106bab <vector235>:
.globl vector235
vector235:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $235
80106bad:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106bb2:	e9 70 f1 ff ff       	jmp    80105d27 <alltraps>

80106bb7 <vector236>:
.globl vector236
vector236:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $236
80106bb9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106bbe:	e9 64 f1 ff ff       	jmp    80105d27 <alltraps>

80106bc3 <vector237>:
.globl vector237
vector237:
  pushl $0
80106bc3:	6a 00                	push   $0x0
  pushl $237
80106bc5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106bca:	e9 58 f1 ff ff       	jmp    80105d27 <alltraps>

80106bcf <vector238>:
.globl vector238
vector238:
  pushl $0
80106bcf:	6a 00                	push   $0x0
  pushl $238
80106bd1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106bd6:	e9 4c f1 ff ff       	jmp    80105d27 <alltraps>

80106bdb <vector239>:
.globl vector239
vector239:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $239
80106bdd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106be2:	e9 40 f1 ff ff       	jmp    80105d27 <alltraps>

80106be7 <vector240>:
.globl vector240
vector240:
  pushl $0
80106be7:	6a 00                	push   $0x0
  pushl $240
80106be9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106bee:	e9 34 f1 ff ff       	jmp    80105d27 <alltraps>

80106bf3 <vector241>:
.globl vector241
vector241:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $241
80106bf5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106bfa:	e9 28 f1 ff ff       	jmp    80105d27 <alltraps>

80106bff <vector242>:
.globl vector242
vector242:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $242
80106c01:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106c06:	e9 1c f1 ff ff       	jmp    80105d27 <alltraps>

80106c0b <vector243>:
.globl vector243
vector243:
  pushl $0
80106c0b:	6a 00                	push   $0x0
  pushl $243
80106c0d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106c12:	e9 10 f1 ff ff       	jmp    80105d27 <alltraps>

80106c17 <vector244>:
.globl vector244
vector244:
  pushl $0
80106c17:	6a 00                	push   $0x0
  pushl $244
80106c19:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106c1e:	e9 04 f1 ff ff       	jmp    80105d27 <alltraps>

80106c23 <vector245>:
.globl vector245
vector245:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $245
80106c25:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106c2a:	e9 f8 f0 ff ff       	jmp    80105d27 <alltraps>

80106c2f <vector246>:
.globl vector246
vector246:
  pushl $0
80106c2f:	6a 00                	push   $0x0
  pushl $246
80106c31:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106c36:	e9 ec f0 ff ff       	jmp    80105d27 <alltraps>

80106c3b <vector247>:
.globl vector247
vector247:
  pushl $0
80106c3b:	6a 00                	push   $0x0
  pushl $247
80106c3d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106c42:	e9 e0 f0 ff ff       	jmp    80105d27 <alltraps>

80106c47 <vector248>:
.globl vector248
vector248:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $248
80106c49:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106c4e:	e9 d4 f0 ff ff       	jmp    80105d27 <alltraps>

80106c53 <vector249>:
.globl vector249
vector249:
  pushl $0
80106c53:	6a 00                	push   $0x0
  pushl $249
80106c55:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106c5a:	e9 c8 f0 ff ff       	jmp    80105d27 <alltraps>

80106c5f <vector250>:
.globl vector250
vector250:
  pushl $0
80106c5f:	6a 00                	push   $0x0
  pushl $250
80106c61:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106c66:	e9 bc f0 ff ff       	jmp    80105d27 <alltraps>

80106c6b <vector251>:
.globl vector251
vector251:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $251
80106c6d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106c72:	e9 b0 f0 ff ff       	jmp    80105d27 <alltraps>

80106c77 <vector252>:
.globl vector252
vector252:
  pushl $0
80106c77:	6a 00                	push   $0x0
  pushl $252
80106c79:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106c7e:	e9 a4 f0 ff ff       	jmp    80105d27 <alltraps>

80106c83 <vector253>:
.globl vector253
vector253:
  pushl $0
80106c83:	6a 00                	push   $0x0
  pushl $253
80106c85:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106c8a:	e9 98 f0 ff ff       	jmp    80105d27 <alltraps>

80106c8f <vector254>:
.globl vector254
vector254:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $254
80106c91:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106c96:	e9 8c f0 ff ff       	jmp    80105d27 <alltraps>

80106c9b <vector255>:
.globl vector255
vector255:
  pushl $0
80106c9b:	6a 00                	push   $0x0
  pushl $255
80106c9d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106ca2:	e9 80 f0 ff ff       	jmp    80105d27 <alltraps>
80106ca7:	66 90                	xchg   %ax,%ax
80106ca9:	66 90                	xchg   %ax,%ax
80106cab:	66 90                	xchg   %ax,%ax
80106cad:	66 90                	xchg   %ax,%ax
80106caf:	90                   	nop

80106cb0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106cb0:	55                   	push   %ebp
80106cb1:	89 e5                	mov    %esp,%ebp
80106cb3:	57                   	push   %edi
80106cb4:	56                   	push   %esi
80106cb5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106cb6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106cbc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106cc2:	83 ec 1c             	sub    $0x1c,%esp
80106cc5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106cc8:	39 d3                	cmp    %edx,%ebx
80106cca:	73 45                	jae    80106d11 <deallocuvm.part.0+0x61>
80106ccc:	89 c7                	mov    %eax,%edi
80106cce:	eb 0a                	jmp    80106cda <deallocuvm.part.0+0x2a>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106cd0:	8d 59 01             	lea    0x1(%ecx),%ebx
80106cd3:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106cd6:	39 da                	cmp    %ebx,%edx
80106cd8:	76 37                	jbe    80106d11 <deallocuvm.part.0+0x61>
  pde = &pgdir[PDX(va)];
80106cda:	89 d9                	mov    %ebx,%ecx
80106cdc:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106cdf:	8b 04 8f             	mov    (%edi,%ecx,4),%eax
80106ce2:	a8 01                	test   $0x1,%al
80106ce4:	74 ea                	je     80106cd0 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80106ce6:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106ce8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106ced:	c1 ee 0a             	shr    $0xa,%esi
80106cf0:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80106cf6:	8d b4 30 00 00 00 80 	lea    -0x80000000(%eax,%esi,1),%esi
    if(!pte)
80106cfd:	85 f6                	test   %esi,%esi
80106cff:	74 cf                	je     80106cd0 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80106d01:	8b 06                	mov    (%esi),%eax
80106d03:	a8 01                	test   $0x1,%al
80106d05:	75 19                	jne    80106d20 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
80106d07:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d0d:	39 da                	cmp    %ebx,%edx
80106d0f:	77 c9                	ja     80106cda <deallocuvm.part.0+0x2a>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106d11:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106d14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d17:	5b                   	pop    %ebx
80106d18:	5e                   	pop    %esi
80106d19:	5f                   	pop    %edi
80106d1a:	5d                   	pop    %ebp
80106d1b:	c3                   	ret    
80106d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80106d20:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d25:	74 25                	je     80106d4c <deallocuvm.part.0+0x9c>
      kfree(v);
80106d27:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106d2a:	05 00 00 00 80       	add    $0x80000000,%eax
80106d2f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106d32:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106d38:	50                   	push   %eax
80106d39:	e8 a2 b8 ff ff       	call   801025e0 <kfree>
      *pte = 0;
80106d3e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80106d44:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106d47:	83 c4 10             	add    $0x10,%esp
80106d4a:	eb 8a                	jmp    80106cd6 <deallocuvm.part.0+0x26>
        panic("kfree");
80106d4c:	83 ec 0c             	sub    $0xc,%esp
80106d4f:	68 66 7a 10 80       	push   $0x80107a66
80106d54:	e8 27 96 ff ff       	call   80100380 <panic>
80106d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106d60 <mappages>:
{
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	57                   	push   %edi
80106d64:	56                   	push   %esi
80106d65:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106d66:	89 d3                	mov    %edx,%ebx
80106d68:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106d6e:	83 ec 1c             	sub    $0x1c,%esp
80106d71:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106d74:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106d78:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d7d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106d80:	8b 45 08             	mov    0x8(%ebp),%eax
80106d83:	29 d8                	sub    %ebx,%eax
80106d85:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106d88:	eb 3d                	jmp    80106dc7 <mappages+0x67>
80106d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106d90:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106d92:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106d97:	c1 ea 0a             	shr    $0xa,%edx
80106d9a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106da0:	8d 94 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%edx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106da7:	85 d2                	test   %edx,%edx
80106da9:	74 75                	je     80106e20 <mappages+0xc0>
    if(*pte & PTE_P)
80106dab:	f6 02 01             	testb  $0x1,(%edx)
80106dae:	0f 85 86 00 00 00    	jne    80106e3a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106db4:	0b 75 0c             	or     0xc(%ebp),%esi
80106db7:	83 ce 01             	or     $0x1,%esi
80106dba:	89 32                	mov    %esi,(%edx)
    if(a == last)
80106dbc:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
80106dbf:	74 6f                	je     80106e30 <mappages+0xd0>
    a += PGSIZE;
80106dc1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106dc7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106dca:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106dcd:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80106dd0:	89 d8                	mov    %ebx,%eax
80106dd2:	c1 e8 16             	shr    $0x16,%eax
80106dd5:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106dd8:	8b 07                	mov    (%edi),%eax
80106dda:	a8 01                	test   $0x1,%al
80106ddc:	75 b2                	jne    80106d90 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106dde:	e8 bd b9 ff ff       	call   801027a0 <kalloc>
80106de3:	85 c0                	test   %eax,%eax
80106de5:	74 39                	je     80106e20 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106de7:	83 ec 04             	sub    $0x4,%esp
80106dea:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106ded:	68 00 10 00 00       	push   $0x1000
80106df2:	6a 00                	push   $0x0
80106df4:	50                   	push   %eax
80106df5:	e8 f6 db ff ff       	call   801049f0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106dfa:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106dfd:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106e00:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106e06:	83 c8 07             	or     $0x7,%eax
80106e09:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106e0b:	89 d8                	mov    %ebx,%eax
80106e0d:	c1 e8 0a             	shr    $0xa,%eax
80106e10:	25 fc 0f 00 00       	and    $0xffc,%eax
80106e15:	01 c2                	add    %eax,%edx
80106e17:	eb 92                	jmp    80106dab <mappages+0x4b>
80106e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80106e20:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106e23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e28:	5b                   	pop    %ebx
80106e29:	5e                   	pop    %esi
80106e2a:	5f                   	pop    %edi
80106e2b:	5d                   	pop    %ebp
80106e2c:	c3                   	ret    
80106e2d:	8d 76 00             	lea    0x0(%esi),%esi
80106e30:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106e33:	31 c0                	xor    %eax,%eax
}
80106e35:	5b                   	pop    %ebx
80106e36:	5e                   	pop    %esi
80106e37:	5f                   	pop    %edi
80106e38:	5d                   	pop    %ebp
80106e39:	c3                   	ret    
      panic("remap");
80106e3a:	83 ec 0c             	sub    $0xc,%esp
80106e3d:	68 b8 80 10 80       	push   $0x801080b8
80106e42:	e8 39 95 ff ff       	call   80100380 <panic>
80106e47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e4e:	66 90                	xchg   %ax,%ax

80106e50 <seginit>:
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106e56:	e8 25 cc ff ff       	call   80103a80 <cpuid>
  pd[0] = size-1;
80106e5b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106e60:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106e66:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106e6a:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80106e71:	ff 00 00 
80106e74:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
80106e7b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e7e:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80106e85:	ff 00 00 
80106e88:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
80106e8f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106e92:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
80106e99:	ff 00 00 
80106e9c:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
80106ea3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ea6:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
80106ead:	ff 00 00 
80106eb0:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80106eb7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106eba:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
80106ebf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106ec3:	c1 e8 10             	shr    $0x10,%eax
80106ec6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106eca:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ecd:	0f 01 10             	lgdtl  (%eax)
}
80106ed0:	c9                   	leave  
80106ed1:	c3                   	ret    
80106ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ee0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ee0:	a1 c4 55 11 80       	mov    0x801155c4,%eax
80106ee5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106eea:	0f 22 d8             	mov    %eax,%cr3
}
80106eed:	c3                   	ret    
80106eee:	66 90                	xchg   %ax,%ax

80106ef0 <switchuvm>:
{
80106ef0:	55                   	push   %ebp
80106ef1:	89 e5                	mov    %esp,%ebp
80106ef3:	57                   	push   %edi
80106ef4:	56                   	push   %esi
80106ef5:	53                   	push   %ebx
80106ef6:	83 ec 1c             	sub    $0x1c,%esp
80106ef9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106efc:	85 f6                	test   %esi,%esi
80106efe:	0f 84 cb 00 00 00    	je     80106fcf <switchuvm+0xdf>
  if(p->kstack == 0)
80106f04:	8b 46 08             	mov    0x8(%esi),%eax
80106f07:	85 c0                	test   %eax,%eax
80106f09:	0f 84 da 00 00 00    	je     80106fe9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106f0f:	8b 46 04             	mov    0x4(%esi),%eax
80106f12:	85 c0                	test   %eax,%eax
80106f14:	0f 84 c2 00 00 00    	je     80106fdc <switchuvm+0xec>
  pushcli();
80106f1a:	e8 c1 d8 ff ff       	call   801047e0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106f1f:	e8 ec ca ff ff       	call   80103a10 <mycpu>
80106f24:	89 c3                	mov    %eax,%ebx
80106f26:	e8 e5 ca ff ff       	call   80103a10 <mycpu>
80106f2b:	89 c7                	mov    %eax,%edi
80106f2d:	e8 de ca ff ff       	call   80103a10 <mycpu>
80106f32:	83 c7 08             	add    $0x8,%edi
80106f35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f38:	e8 d3 ca ff ff       	call   80103a10 <mycpu>
80106f3d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106f40:	ba 67 00 00 00       	mov    $0x67,%edx
80106f45:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106f4c:	83 c0 08             	add    $0x8,%eax
80106f4f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106f56:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106f5b:	83 c1 08             	add    $0x8,%ecx
80106f5e:	c1 e8 18             	shr    $0x18,%eax
80106f61:	c1 e9 10             	shr    $0x10,%ecx
80106f64:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106f6a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106f70:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106f75:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106f7c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106f81:	e8 8a ca ff ff       	call   80103a10 <mycpu>
80106f86:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106f8d:	e8 7e ca ff ff       	call   80103a10 <mycpu>
80106f92:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106f96:	8b 5e 08             	mov    0x8(%esi),%ebx
80106f99:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f9f:	e8 6c ca ff ff       	call   80103a10 <mycpu>
80106fa4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106fa7:	e8 64 ca ff ff       	call   80103a10 <mycpu>
80106fac:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106fb0:	b8 28 00 00 00       	mov    $0x28,%eax
80106fb5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106fb8:	8b 46 04             	mov    0x4(%esi),%eax
80106fbb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106fc0:	0f 22 d8             	mov    %eax,%cr3
}
80106fc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fc6:	5b                   	pop    %ebx
80106fc7:	5e                   	pop    %esi
80106fc8:	5f                   	pop    %edi
80106fc9:	5d                   	pop    %ebp
  popcli();
80106fca:	e9 61 d8 ff ff       	jmp    80104830 <popcli>
    panic("switchuvm: no process");
80106fcf:	83 ec 0c             	sub    $0xc,%esp
80106fd2:	68 be 80 10 80       	push   $0x801080be
80106fd7:	e8 a4 93 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106fdc:	83 ec 0c             	sub    $0xc,%esp
80106fdf:	68 e9 80 10 80       	push   $0x801080e9
80106fe4:	e8 97 93 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106fe9:	83 ec 0c             	sub    $0xc,%esp
80106fec:	68 d4 80 10 80       	push   $0x801080d4
80106ff1:	e8 8a 93 ff ff       	call   80100380 <panic>
80106ff6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ffd:	8d 76 00             	lea    0x0(%esi),%esi

80107000 <inituvm>:
{
80107000:	55                   	push   %ebp
80107001:	89 e5                	mov    %esp,%ebp
80107003:	57                   	push   %edi
80107004:	56                   	push   %esi
80107005:	53                   	push   %ebx
80107006:	83 ec 1c             	sub    $0x1c,%esp
80107009:	8b 45 0c             	mov    0xc(%ebp),%eax
8010700c:	8b 75 10             	mov    0x10(%ebp),%esi
8010700f:	8b 7d 08             	mov    0x8(%ebp),%edi
80107012:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107015:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010701b:	77 4b                	ja     80107068 <inituvm+0x68>
  mem = kalloc();
8010701d:	e8 7e b7 ff ff       	call   801027a0 <kalloc>
  memset(mem, 0, PGSIZE);
80107022:	83 ec 04             	sub    $0x4,%esp
80107025:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010702a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010702c:	6a 00                	push   $0x0
8010702e:	50                   	push   %eax
8010702f:	e8 bc d9 ff ff       	call   801049f0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107034:	58                   	pop    %eax
80107035:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010703b:	5a                   	pop    %edx
8010703c:	6a 06                	push   $0x6
8010703e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107043:	31 d2                	xor    %edx,%edx
80107045:	50                   	push   %eax
80107046:	89 f8                	mov    %edi,%eax
80107048:	e8 13 fd ff ff       	call   80106d60 <mappages>
  memmove(mem, init, sz);
8010704d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107050:	89 75 10             	mov    %esi,0x10(%ebp)
80107053:	83 c4 10             	add    $0x10,%esp
80107056:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107059:	89 45 0c             	mov    %eax,0xc(%ebp)
}
8010705c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010705f:	5b                   	pop    %ebx
80107060:	5e                   	pop    %esi
80107061:	5f                   	pop    %edi
80107062:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107063:	e9 28 da ff ff       	jmp    80104a90 <memmove>
    panic("inituvm: more than a page");
80107068:	83 ec 0c             	sub    $0xc,%esp
8010706b:	68 fd 80 10 80       	push   $0x801080fd
80107070:	e8 0b 93 ff ff       	call   80100380 <panic>
80107075:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010707c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107080 <loaduvm>:
{
80107080:	55                   	push   %ebp
80107081:	89 e5                	mov    %esp,%ebp
80107083:	57                   	push   %edi
80107084:	56                   	push   %esi
80107085:	53                   	push   %ebx
80107086:	83 ec 1c             	sub    $0x1c,%esp
80107089:	8b 45 0c             	mov    0xc(%ebp),%eax
8010708c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010708f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107094:	0f 85 bb 00 00 00    	jne    80107155 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
8010709a:	01 f0                	add    %esi,%eax
8010709c:	89 f3                	mov    %esi,%ebx
8010709e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801070a1:	8b 45 14             	mov    0x14(%ebp),%eax
801070a4:	01 f0                	add    %esi,%eax
801070a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801070a9:	85 f6                	test   %esi,%esi
801070ab:	0f 84 87 00 00 00    	je     80107138 <loaduvm+0xb8>
801070b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
801070b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
801070bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801070be:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
801070c0:	89 c2                	mov    %eax,%edx
801070c2:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801070c5:	8b 14 91             	mov    (%ecx,%edx,4),%edx
801070c8:	f6 c2 01             	test   $0x1,%dl
801070cb:	75 13                	jne    801070e0 <loaduvm+0x60>
      panic("loaduvm: address should exist");
801070cd:	83 ec 0c             	sub    $0xc,%esp
801070d0:	68 17 81 10 80       	push   $0x80108117
801070d5:	e8 a6 92 ff ff       	call   80100380 <panic>
801070da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801070e0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801070e3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801070e9:	25 fc 0f 00 00       	and    $0xffc,%eax
801070ee:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801070f5:	85 c0                	test   %eax,%eax
801070f7:	74 d4                	je     801070cd <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
801070f9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801070fb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
801070fe:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107103:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107108:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010710e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107111:	29 d9                	sub    %ebx,%ecx
80107113:	05 00 00 00 80       	add    $0x80000000,%eax
80107118:	57                   	push   %edi
80107119:	51                   	push   %ecx
8010711a:	50                   	push   %eax
8010711b:	ff 75 10             	pushl  0x10(%ebp)
8010711e:	e8 8d aa ff ff       	call   80101bb0 <readi>
80107123:	83 c4 10             	add    $0x10,%esp
80107126:	39 f8                	cmp    %edi,%eax
80107128:	75 1e                	jne    80107148 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
8010712a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107130:	89 f0                	mov    %esi,%eax
80107132:	29 d8                	sub    %ebx,%eax
80107134:	39 c6                	cmp    %eax,%esi
80107136:	77 80                	ja     801070b8 <loaduvm+0x38>
}
80107138:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010713b:	31 c0                	xor    %eax,%eax
}
8010713d:	5b                   	pop    %ebx
8010713e:	5e                   	pop    %esi
8010713f:	5f                   	pop    %edi
80107140:	5d                   	pop    %ebp
80107141:	c3                   	ret    
80107142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107148:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010714b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107150:	5b                   	pop    %ebx
80107151:	5e                   	pop    %esi
80107152:	5f                   	pop    %edi
80107153:	5d                   	pop    %ebp
80107154:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107155:	83 ec 0c             	sub    $0xc,%esp
80107158:	68 b8 81 10 80       	push   $0x801081b8
8010715d:	e8 1e 92 ff ff       	call   80100380 <panic>
80107162:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107170 <allocuvm>:
{
80107170:	55                   	push   %ebp
80107171:	89 e5                	mov    %esp,%ebp
80107173:	57                   	push   %edi
80107174:	56                   	push   %esi
80107175:	53                   	push   %ebx
80107176:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107179:	8b 45 10             	mov    0x10(%ebp),%eax
{
8010717c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
8010717f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107182:	85 c0                	test   %eax,%eax
80107184:	0f 88 b6 00 00 00    	js     80107240 <allocuvm+0xd0>
  if(newsz < oldsz)
8010718a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
8010718d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107190:	0f 82 9a 00 00 00    	jb     80107230 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80107196:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
8010719c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801071a2:	39 75 10             	cmp    %esi,0x10(%ebp)
801071a5:	77 44                	ja     801071eb <allocuvm+0x7b>
801071a7:	e9 87 00 00 00       	jmp    80107233 <allocuvm+0xc3>
801071ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
801071b0:	83 ec 04             	sub    $0x4,%esp
801071b3:	68 00 10 00 00       	push   $0x1000
801071b8:	6a 00                	push   $0x0
801071ba:	50                   	push   %eax
801071bb:	e8 30 d8 ff ff       	call   801049f0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801071c0:	58                   	pop    %eax
801071c1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801071c7:	5a                   	pop    %edx
801071c8:	6a 06                	push   $0x6
801071ca:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071cf:	89 f2                	mov    %esi,%edx
801071d1:	50                   	push   %eax
801071d2:	89 f8                	mov    %edi,%eax
801071d4:	e8 87 fb ff ff       	call   80106d60 <mappages>
801071d9:	83 c4 10             	add    $0x10,%esp
801071dc:	85 c0                	test   %eax,%eax
801071de:	78 78                	js     80107258 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
801071e0:	81 c6 00 10 00 00    	add    $0x1000,%esi
801071e6:	39 75 10             	cmp    %esi,0x10(%ebp)
801071e9:	76 48                	jbe    80107233 <allocuvm+0xc3>
    mem = kalloc();
801071eb:	e8 b0 b5 ff ff       	call   801027a0 <kalloc>
801071f0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801071f2:	85 c0                	test   %eax,%eax
801071f4:	75 ba                	jne    801071b0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801071f6:	83 ec 0c             	sub    $0xc,%esp
801071f9:	68 35 81 10 80       	push   $0x80108135
801071fe:	e8 7d 94 ff ff       	call   80100680 <cprintf>
  if(newsz >= oldsz)
80107203:	8b 45 0c             	mov    0xc(%ebp),%eax
80107206:	83 c4 10             	add    $0x10,%esp
80107209:	39 45 10             	cmp    %eax,0x10(%ebp)
8010720c:	74 32                	je     80107240 <allocuvm+0xd0>
8010720e:	8b 55 10             	mov    0x10(%ebp),%edx
80107211:	89 c1                	mov    %eax,%ecx
80107213:	89 f8                	mov    %edi,%eax
80107215:	e8 96 fa ff ff       	call   80106cb0 <deallocuvm.part.0>
      return 0;
8010721a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107221:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107224:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107227:	5b                   	pop    %ebx
80107228:	5e                   	pop    %esi
80107229:	5f                   	pop    %edi
8010722a:	5d                   	pop    %ebp
8010722b:	c3                   	ret    
8010722c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107230:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107233:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107236:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107239:	5b                   	pop    %ebx
8010723a:	5e                   	pop    %esi
8010723b:	5f                   	pop    %edi
8010723c:	5d                   	pop    %ebp
8010723d:	c3                   	ret    
8010723e:	66 90                	xchg   %ax,%ax
    return 0;
80107240:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107247:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010724a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010724d:	5b                   	pop    %ebx
8010724e:	5e                   	pop    %esi
8010724f:	5f                   	pop    %edi
80107250:	5d                   	pop    %ebp
80107251:	c3                   	ret    
80107252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107258:	83 ec 0c             	sub    $0xc,%esp
8010725b:	68 4d 81 10 80       	push   $0x8010814d
80107260:	e8 1b 94 ff ff       	call   80100680 <cprintf>
  if(newsz >= oldsz)
80107265:	8b 45 0c             	mov    0xc(%ebp),%eax
80107268:	83 c4 10             	add    $0x10,%esp
8010726b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010726e:	74 0c                	je     8010727c <allocuvm+0x10c>
80107270:	8b 55 10             	mov    0x10(%ebp),%edx
80107273:	89 c1                	mov    %eax,%ecx
80107275:	89 f8                	mov    %edi,%eax
80107277:	e8 34 fa ff ff       	call   80106cb0 <deallocuvm.part.0>
      kfree(mem);
8010727c:	83 ec 0c             	sub    $0xc,%esp
8010727f:	53                   	push   %ebx
80107280:	e8 5b b3 ff ff       	call   801025e0 <kfree>
      return 0;
80107285:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010728c:	83 c4 10             	add    $0x10,%esp
}
8010728f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107292:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107295:	5b                   	pop    %ebx
80107296:	5e                   	pop    %esi
80107297:	5f                   	pop    %edi
80107298:	5d                   	pop    %ebp
80107299:	c3                   	ret    
8010729a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801072a0 <deallocuvm>:
{
801072a0:	55                   	push   %ebp
801072a1:	89 e5                	mov    %esp,%ebp
801072a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801072a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801072a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801072ac:	39 d1                	cmp    %edx,%ecx
801072ae:	73 10                	jae    801072c0 <deallocuvm+0x20>
}
801072b0:	5d                   	pop    %ebp
801072b1:	e9 fa f9 ff ff       	jmp    80106cb0 <deallocuvm.part.0>
801072b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072bd:	8d 76 00             	lea    0x0(%esi),%esi
801072c0:	89 d0                	mov    %edx,%eax
801072c2:	5d                   	pop    %ebp
801072c3:	c3                   	ret    
801072c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801072cf:	90                   	nop

801072d0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801072d0:	55                   	push   %ebp
801072d1:	89 e5                	mov    %esp,%ebp
801072d3:	57                   	push   %edi
801072d4:	56                   	push   %esi
801072d5:	53                   	push   %ebx
801072d6:	83 ec 0c             	sub    $0xc,%esp
801072d9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801072dc:	85 f6                	test   %esi,%esi
801072de:	74 59                	je     80107339 <freevm+0x69>
  if(newsz >= oldsz)
801072e0:	31 c9                	xor    %ecx,%ecx
801072e2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801072e7:	89 f0                	mov    %esi,%eax
801072e9:	89 f3                	mov    %esi,%ebx
801072eb:	e8 c0 f9 ff ff       	call   80106cb0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801072f0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801072f6:	eb 0f                	jmp    80107307 <freevm+0x37>
801072f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072ff:	90                   	nop
80107300:	83 c3 04             	add    $0x4,%ebx
80107303:	39 df                	cmp    %ebx,%edi
80107305:	74 23                	je     8010732a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107307:	8b 03                	mov    (%ebx),%eax
80107309:	a8 01                	test   $0x1,%al
8010730b:	74 f3                	je     80107300 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010730d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107312:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107315:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107318:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010731d:	50                   	push   %eax
8010731e:	e8 bd b2 ff ff       	call   801025e0 <kfree>
80107323:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107326:	39 df                	cmp    %ebx,%edi
80107328:	75 dd                	jne    80107307 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010732a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010732d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107330:	5b                   	pop    %ebx
80107331:	5e                   	pop    %esi
80107332:	5f                   	pop    %edi
80107333:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107334:	e9 a7 b2 ff ff       	jmp    801025e0 <kfree>
    panic("freevm: no pgdir");
80107339:	83 ec 0c             	sub    $0xc,%esp
8010733c:	68 69 81 10 80       	push   $0x80108169
80107341:	e8 3a 90 ff ff       	call   80100380 <panic>
80107346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010734d:	8d 76 00             	lea    0x0(%esi),%esi

80107350 <setupkvm>:
{
80107350:	55                   	push   %ebp
80107351:	89 e5                	mov    %esp,%ebp
80107353:	56                   	push   %esi
80107354:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107355:	e8 46 b4 ff ff       	call   801027a0 <kalloc>
8010735a:	89 c6                	mov    %eax,%esi
8010735c:	85 c0                	test   %eax,%eax
8010735e:	74 42                	je     801073a2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107360:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107363:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107368:	68 00 10 00 00       	push   $0x1000
8010736d:	6a 00                	push   $0x0
8010736f:	50                   	push   %eax
80107370:	e8 7b d6 ff ff       	call   801049f0 <memset>
80107375:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107378:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010737b:	83 ec 08             	sub    $0x8,%esp
8010737e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107381:	ff 73 0c             	pushl  0xc(%ebx)
80107384:	8b 13                	mov    (%ebx),%edx
80107386:	50                   	push   %eax
80107387:	29 c1                	sub    %eax,%ecx
80107389:	89 f0                	mov    %esi,%eax
8010738b:	e8 d0 f9 ff ff       	call   80106d60 <mappages>
80107390:	83 c4 10             	add    $0x10,%esp
80107393:	85 c0                	test   %eax,%eax
80107395:	78 19                	js     801073b0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107397:	83 c3 10             	add    $0x10,%ebx
8010739a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801073a0:	75 d6                	jne    80107378 <setupkvm+0x28>
}
801073a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801073a5:	89 f0                	mov    %esi,%eax
801073a7:	5b                   	pop    %ebx
801073a8:	5e                   	pop    %esi
801073a9:	5d                   	pop    %ebp
801073aa:	c3                   	ret    
801073ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801073af:	90                   	nop
      freevm(pgdir);
801073b0:	83 ec 0c             	sub    $0xc,%esp
801073b3:	56                   	push   %esi
      return 0;
801073b4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801073b6:	e8 15 ff ff ff       	call   801072d0 <freevm>
      return 0;
801073bb:	83 c4 10             	add    $0x10,%esp
}
801073be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801073c1:	89 f0                	mov    %esi,%eax
801073c3:	5b                   	pop    %ebx
801073c4:	5e                   	pop    %esi
801073c5:	5d                   	pop    %ebp
801073c6:	c3                   	ret    
801073c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073ce:	66 90                	xchg   %ax,%ax

801073d0 <kvmalloc>:
{
801073d0:	55                   	push   %ebp
801073d1:	89 e5                	mov    %esp,%ebp
801073d3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801073d6:	e8 75 ff ff ff       	call   80107350 <setupkvm>
801073db:	a3 c4 55 11 80       	mov    %eax,0x801155c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801073e0:	05 00 00 00 80       	add    $0x80000000,%eax
801073e5:	0f 22 d8             	mov    %eax,%cr3
}
801073e8:	c9                   	leave  
801073e9:	c3                   	ret    
801073ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801073f0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801073f0:	55                   	push   %ebp
801073f1:	89 e5                	mov    %esp,%ebp
801073f3:	83 ec 08             	sub    $0x8,%esp
801073f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801073f9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801073fc:	89 c1                	mov    %eax,%ecx
801073fe:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107401:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107404:	f6 c2 01             	test   $0x1,%dl
80107407:	75 17                	jne    80107420 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107409:	83 ec 0c             	sub    $0xc,%esp
8010740c:	68 7a 81 10 80       	push   $0x8010817a
80107411:	e8 6a 8f ff ff       	call   80100380 <panic>
80107416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010741d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107420:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107423:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107429:	25 fc 0f 00 00       	and    $0xffc,%eax
8010742e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107435:	85 c0                	test   %eax,%eax
80107437:	74 d0                	je     80107409 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107439:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010743c:	c9                   	leave  
8010743d:	c3                   	ret    
8010743e:	66 90                	xchg   %ax,%ax

80107440 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107440:	55                   	push   %ebp
80107441:	89 e5                	mov    %esp,%ebp
80107443:	57                   	push   %edi
80107444:	56                   	push   %esi
80107445:	53                   	push   %ebx
80107446:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107449:	e8 02 ff ff ff       	call   80107350 <setupkvm>
8010744e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107451:	85 c0                	test   %eax,%eax
80107453:	0f 84 bd 00 00 00    	je     80107516 <copyuvm+0xd6>
    return 0;
  for(i = PGSIZE; i < sz; i += PGSIZE){
80107459:	81 7d 0c 00 10 00 00 	cmpl   $0x1000,0xc(%ebp)
80107460:	0f 86 b0 00 00 00    	jbe    80107516 <copyuvm+0xd6>
80107466:	be 00 10 00 00       	mov    $0x1000,%esi
8010746b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010746f:	90                   	nop
  if(*pde & PTE_P){
80107470:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107473:	89 f0                	mov    %esi,%eax
80107475:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107478:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010747b:	a8 01                	test   $0x1,%al
8010747d:	75 11                	jne    80107490 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010747f:	83 ec 0c             	sub    $0xc,%esp
80107482:	68 84 81 10 80       	push   $0x80108184
80107487:	e8 f4 8e ff ff       	call   80100380 <panic>
8010748c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107490:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107492:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107497:	c1 ea 0a             	shr    $0xa,%edx
8010749a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801074a0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801074a7:	85 c0                	test   %eax,%eax
801074a9:	74 d4                	je     8010747f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801074ab:	8b 00                	mov    (%eax),%eax
801074ad:	a8 01                	test   $0x1,%al
801074af:	0f 84 9f 00 00 00    	je     80107554 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801074b5:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
801074b7:	25 ff 0f 00 00       	and    $0xfff,%eax
801074bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801074bf:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801074c5:	e8 d6 b2 ff ff       	call   801027a0 <kalloc>
801074ca:	89 c3                	mov    %eax,%ebx
801074cc:	85 c0                	test   %eax,%eax
801074ce:	74 64                	je     80107534 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801074d0:	83 ec 04             	sub    $0x4,%esp
801074d3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801074d9:	68 00 10 00 00       	push   $0x1000
801074de:	57                   	push   %edi
801074df:	50                   	push   %eax
801074e0:	e8 ab d5 ff ff       	call   80104a90 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801074e5:	58                   	pop    %eax
801074e6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801074ec:	5a                   	pop    %edx
801074ed:	ff 75 e4             	pushl  -0x1c(%ebp)
801074f0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801074f5:	89 f2                	mov    %esi,%edx
801074f7:	50                   	push   %eax
801074f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801074fb:	e8 60 f8 ff ff       	call   80106d60 <mappages>
80107500:	83 c4 10             	add    $0x10,%esp
80107503:	85 c0                	test   %eax,%eax
80107505:	78 21                	js     80107528 <copyuvm+0xe8>
  for(i = PGSIZE; i < sz; i += PGSIZE){
80107507:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010750d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107510:	0f 87 5a ff ff ff    	ja     80107470 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107516:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107519:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010751c:	5b                   	pop    %ebx
8010751d:	5e                   	pop    %esi
8010751e:	5f                   	pop    %edi
8010751f:	5d                   	pop    %ebp
80107520:	c3                   	ret    
80107521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107528:	83 ec 0c             	sub    $0xc,%esp
8010752b:	53                   	push   %ebx
8010752c:	e8 af b0 ff ff       	call   801025e0 <kfree>
      goto bad;
80107531:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107534:	83 ec 0c             	sub    $0xc,%esp
80107537:	ff 75 e0             	pushl  -0x20(%ebp)
8010753a:	e8 91 fd ff ff       	call   801072d0 <freevm>
  return 0;
8010753f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107546:	83 c4 10             	add    $0x10,%esp
}
80107549:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010754c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010754f:	5b                   	pop    %ebx
80107550:	5e                   	pop    %esi
80107551:	5f                   	pop    %edi
80107552:	5d                   	pop    %ebp
80107553:	c3                   	ret    
      panic("copyuvm: page not present");
80107554:	83 ec 0c             	sub    $0xc,%esp
80107557:	68 9e 81 10 80       	push   $0x8010819e
8010755c:	e8 1f 8e ff ff       	call   80100380 <panic>
80107561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107568:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010756f:	90                   	nop

80107570 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107570:	55                   	push   %ebp
80107571:	89 e5                	mov    %esp,%ebp
80107573:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107576:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107579:	89 c1                	mov    %eax,%ecx
8010757b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010757e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107581:	f6 c2 01             	test   $0x1,%dl
80107584:	0f 84 5f 02 00 00    	je     801077e9 <uva2ka.cold>
  return &pgtab[PTX(va)];
8010758a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010758d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107593:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107594:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107599:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
801075a0:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801075a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801075a7:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801075aa:	05 00 00 00 80       	add    $0x80000000,%eax
801075af:	83 fa 05             	cmp    $0x5,%edx
801075b2:	ba 00 00 00 00       	mov    $0x0,%edx
801075b7:	0f 45 c2             	cmovne %edx,%eax
}
801075ba:	c3                   	ret    
801075bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075bf:	90                   	nop

801075c0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801075c0:	55                   	push   %ebp
801075c1:	89 e5                	mov    %esp,%ebp
801075c3:	57                   	push   %edi
801075c4:	56                   	push   %esi
801075c5:	53                   	push   %ebx
801075c6:	83 ec 0c             	sub    $0xc,%esp
801075c9:	8b 75 14             	mov    0x14(%ebp),%esi
801075cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801075cf:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801075d2:	85 f6                	test   %esi,%esi
801075d4:	75 51                	jne    80107627 <copyout+0x67>
801075d6:	e9 a5 00 00 00       	jmp    80107680 <copyout+0xc0>
801075db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075df:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
801075e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801075e6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801075ec:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801075f2:	74 75                	je     80107669 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
801075f4:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801075f6:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
801075f9:	29 c3                	sub    %eax,%ebx
801075fb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107601:	39 f3                	cmp    %esi,%ebx
80107603:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107606:	29 f8                	sub    %edi,%eax
80107608:	83 ec 04             	sub    $0x4,%esp
8010760b:	01 c8                	add    %ecx,%eax
8010760d:	53                   	push   %ebx
8010760e:	52                   	push   %edx
8010760f:	50                   	push   %eax
80107610:	e8 7b d4 ff ff       	call   80104a90 <memmove>
    len -= n;
    buf += n;
80107615:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107618:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010761e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107621:	01 da                	add    %ebx,%edx
  while(len > 0){
80107623:	29 de                	sub    %ebx,%esi
80107625:	74 59                	je     80107680 <copyout+0xc0>
  if(*pde & PTE_P){
80107627:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010762a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010762c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010762e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107631:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107637:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010763a:	f6 c1 01             	test   $0x1,%cl
8010763d:	0f 84 ad 01 00 00    	je     801077f0 <copyout.cold>
  return &pgtab[PTX(va)];
80107643:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107645:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010764b:	c1 eb 0c             	shr    $0xc,%ebx
8010764e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107654:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010765b:	89 d9                	mov    %ebx,%ecx
8010765d:	83 e1 05             	and    $0x5,%ecx
80107660:	83 f9 05             	cmp    $0x5,%ecx
80107663:	0f 84 77 ff ff ff    	je     801075e0 <copyout+0x20>
  }
  return 0;
}
80107669:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010766c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107671:	5b                   	pop    %ebx
80107672:	5e                   	pop    %esi
80107673:	5f                   	pop    %edi
80107674:	5d                   	pop    %ebp
80107675:	c3                   	ret    
80107676:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010767d:	8d 76 00             	lea    0x0(%esi),%esi
80107680:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107683:	31 c0                	xor    %eax,%eax
}
80107685:	5b                   	pop    %ebx
80107686:	5e                   	pop    %esi
80107687:	5f                   	pop    %edi
80107688:	5d                   	pop    %ebp
80107689:	c3                   	ret    
8010768a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107690 <mprotect>:
//PAGEBREAK!
// Blank page.

int
mprotect(void* addr, int len)
{
80107690:	55                   	push   %ebp
80107691:	89 e5                	mov    %esp,%ebp
80107693:	56                   	push   %esi
80107694:	53                   	push   %ebx
80107695:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107698:	89 de                	mov    %ebx,%esi
  struct proc *curproc = myproc();
8010769a:	e8 01 c4 ff ff       	call   80103aa0 <myproc>
  pde = &pgdir[PDX(va)];
8010769f:	c1 ee 16             	shr    $0x16,%esi
  struct proc *curproc = myproc();
801076a2:	89 c1                	mov    %eax,%ecx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)addr);
801076a4:	89 d8                	mov    %ebx,%eax
  if(*pde & PTE_P){
801076a6:	8b 51 04             	mov    0x4(%ecx),%edx
  a = (char*)PGROUNDDOWN((uint)addr);
801076a9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if(*pde & PTE_P){
801076ae:	8b 14 b2             	mov    (%edx,%esi,4),%edx
801076b1:	f6 c2 01             	test   $0x1,%dl
801076b4:	74 62                	je     80107718 <mprotect+0x88>
  return &pgtab[PTX(va)];
801076b6:	89 c6                	mov    %eax,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801076b8:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801076be:	c1 ee 0a             	shr    $0xa,%esi
801076c1:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
801076c7:	8d 94 32 00 00 00 80 	lea    -0x80000000(%edx,%esi,1),%edx
  last = (char*)PGROUNDDOWN(((uint)addr) + len - 1);
  for(;;){
    if((pte = walkpgdir(curproc->pgdir, a, 0)) == 0)
801076ce:	85 d2                	test   %edx,%edx
801076d0:	74 46                	je     80107718 <mprotect+0x88>
  last = (char*)PGROUNDDOWN(((uint)addr) + len - 1);
801076d2:	8b 75 0c             	mov    0xc(%ebp),%esi
801076d5:	8d 5c 33 ff          	lea    -0x1(%ebx,%esi,1),%ebx
801076d9:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801076df:	90                   	nop
      return -1;
    *pte &= ~PTE_W;
801076e0:	83 22 fd             	andl   $0xfffffffd,(%edx)
    if(a >= last)
801076e3:	39 c3                	cmp    %eax,%ebx
801076e5:	76 41                	jbe    80107728 <mprotect+0x98>
      break;
    a += PGSIZE;
801076e7:	05 00 10 00 00       	add    $0x1000,%eax
  if(*pde & PTE_P){
801076ec:	8b 51 04             	mov    0x4(%ecx),%edx
  pde = &pgdir[PDX(va)];
801076ef:	89 c6                	mov    %eax,%esi
801076f1:	c1 ee 16             	shr    $0x16,%esi
  if(*pde & PTE_P){
801076f4:	8b 14 b2             	mov    (%edx,%esi,4),%edx
801076f7:	f6 c2 01             	test   $0x1,%dl
801076fa:	74 1c                	je     80107718 <mprotect+0x88>
  return &pgtab[PTX(va)];
801076fc:	89 c6                	mov    %eax,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801076fe:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107704:	c1 ee 0a             	shr    $0xa,%esi
80107707:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
8010770d:	8d 94 32 00 00 00 80 	lea    -0x80000000(%edx,%esi,1),%edx
    if((pte = walkpgdir(curproc->pgdir, a, 0)) == 0)
80107714:	85 d2                	test   %edx,%edx
80107716:	75 c8                	jne    801076e0 <mprotect+0x50>
  }
  lcr3(V2P(curproc->pgdir));
  return 0;
}
80107718:	5b                   	pop    %ebx
      return -1;
80107719:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010771e:	5e                   	pop    %esi
8010771f:	5d                   	pop    %ebp
80107720:	c3                   	ret    
80107721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lcr3(V2P(curproc->pgdir));
80107728:	8b 41 04             	mov    0x4(%ecx),%eax
8010772b:	05 00 00 00 80       	add    $0x80000000,%eax
80107730:	0f 22 d8             	mov    %eax,%cr3
  return 0;
80107733:	31 c0                	xor    %eax,%eax
}
80107735:	5b                   	pop    %ebx
80107736:	5e                   	pop    %esi
80107737:	5d                   	pop    %ebp
80107738:	c3                   	ret    
80107739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107740 <munprotect>:


int
munprotect(void* addr, int len)
{
80107740:	55                   	push   %ebp
80107741:	89 e5                	mov    %esp,%ebp
80107743:	56                   	push   %esi
80107744:	53                   	push   %ebx
80107745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107748:	89 de                	mov    %ebx,%esi
  struct proc *curproc = myproc();
8010774a:	e8 51 c3 ff ff       	call   80103aa0 <myproc>
  pde = &pgdir[PDX(va)];
8010774f:	c1 ee 16             	shr    $0x16,%esi
  struct proc *curproc = myproc();
80107752:	89 c1                	mov    %eax,%ecx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)addr);
80107754:	89 d8                	mov    %ebx,%eax
  if(*pde & PTE_P){
80107756:	8b 51 04             	mov    0x4(%ecx),%edx
  a = (char*)PGROUNDDOWN((uint)addr);
80107759:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if(*pde & PTE_P){
8010775e:	8b 14 b2             	mov    (%edx,%esi,4),%edx
80107761:	f6 c2 01             	test   $0x1,%dl
80107764:	74 62                	je     801077c8 <munprotect+0x88>
  return &pgtab[PTX(va)];
80107766:	89 c6                	mov    %eax,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107768:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
8010776e:	c1 ee 0a             	shr    $0xa,%esi
80107771:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80107777:	8d 94 32 00 00 00 80 	lea    -0x80000000(%edx,%esi,1),%edx
  last = (char*)PGROUNDDOWN(((uint)addr) + len - 1);
  for(;;){
    if((pte = walkpgdir(curproc->pgdir, a, 0)) == 0)
8010777e:	85 d2                	test   %edx,%edx
80107780:	74 46                	je     801077c8 <munprotect+0x88>
  last = (char*)PGROUNDDOWN(((uint)addr) + len - 1);
80107782:	8b 75 0c             	mov    0xc(%ebp),%esi
80107785:	8d 5c 33 ff          	lea    -0x1(%ebx,%esi,1),%ebx
80107789:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010778f:	90                   	nop
      return -1;
    *pte |= PTE_W;
80107790:	83 0a 02             	orl    $0x2,(%edx)
    if(a >= last)
80107793:	39 c3                	cmp    %eax,%ebx
80107795:	76 41                	jbe    801077d8 <munprotect+0x98>
      break;
    a += PGSIZE;
80107797:	05 00 10 00 00       	add    $0x1000,%eax
  if(*pde & PTE_P){
8010779c:	8b 51 04             	mov    0x4(%ecx),%edx
  pde = &pgdir[PDX(va)];
8010779f:	89 c6                	mov    %eax,%esi
801077a1:	c1 ee 16             	shr    $0x16,%esi
  if(*pde & PTE_P){
801077a4:	8b 14 b2             	mov    (%edx,%esi,4),%edx
801077a7:	f6 c2 01             	test   $0x1,%dl
801077aa:	74 1c                	je     801077c8 <munprotect+0x88>
  return &pgtab[PTX(va)];
801077ac:	89 c6                	mov    %eax,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801077ae:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801077b4:	c1 ee 0a             	shr    $0xa,%esi
801077b7:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
801077bd:	8d 94 32 00 00 00 80 	lea    -0x80000000(%edx,%esi,1),%edx
    if((pte = walkpgdir(curproc->pgdir, a, 0)) == 0)
801077c4:	85 d2                	test   %edx,%edx
801077c6:	75 c8                	jne    80107790 <munprotect+0x50>
  }
  lcr3(V2P(curproc->pgdir));
  return 0;
}
801077c8:	5b                   	pop    %ebx
      return -1;
801077c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801077ce:	5e                   	pop    %esi
801077cf:	5d                   	pop    %ebp
801077d0:	c3                   	ret    
801077d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lcr3(V2P(curproc->pgdir));
801077d8:	8b 41 04             	mov    0x4(%ecx),%eax
801077db:	05 00 00 00 80       	add    $0x80000000,%eax
801077e0:	0f 22 d8             	mov    %eax,%cr3
  return 0;
801077e3:	31 c0                	xor    %eax,%eax
}
801077e5:	5b                   	pop    %ebx
801077e6:	5e                   	pop    %esi
801077e7:	5d                   	pop    %ebp
801077e8:	c3                   	ret    

801077e9 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801077e9:	a1 00 00 00 00       	mov    0x0,%eax
801077ee:	0f 0b                	ud2    

801077f0 <copyout.cold>:
801077f0:	a1 00 00 00 00       	mov    0x0,%eax
801077f5:	0f 0b                	ud2    
