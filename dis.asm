
kernel.elf:     file format pei-i386


Disassembly of section .text:

00001000 <_print_os_info-0x8>:
    1000:	e9 78 00 00 00       	jmp    107d <_kernel_main>
    1005:	66 90                	xchg   ax,ax
    1007:	90                   	nop

00001008 <_print_os_info>:
    1008:	55                   	push   ebp
    1009:	89 e5                	mov    ebp,esp
    100b:	83 ec 18             	sub    esp,0x18
    100e:	c7 04 24 00 40 00 00 	mov    DWORD PTR [esp],0x4000
    1015:	e8 16 14 00 00       	call   2430 <_kprint>
    101a:	0f b7 05 00 3e 00 00 	movzx  eax,WORD PTR ds:0x3e00
    1021:	0f b6 d0             	movzx  edx,al
    1024:	0f b7 05 00 3e 00 00 	movzx  eax,WORD PTR ds:0x3e00
    102b:	66 c1 e8 08          	shr    ax,0x8
    102f:	0f b6 c0             	movzx  eax,al
    1032:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1036:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    103a:	c7 04 24 10 40 00 00 	mov    DWORD PTR [esp],0x4010
    1041:	e8 ff 15 00 00       	call   2645 <_kprintf>
    1046:	c7 44 24 04 04 3e 00 	mov    DWORD PTR [esp+0x4],0x3e04
    104d:	00 
    104e:	c7 04 24 20 40 00 00 	mov    DWORD PTR [esp],0x4020
    1055:	e8 eb 15 00 00       	call   2645 <_kprintf>
    105a:	90                   	nop
    105b:	c9                   	leave  
    105c:	c3                   	ret    

0000105d <_test>:
    105d:	55                   	push   ebp
    105e:	89 e5                	mov    ebp,esp
    1060:	83 ec 10             	sub    esp,0x10
    1063:	c7 45 fc 10 00 00 00 	mov    DWORD PTR [ebp-0x4],0x10
    106a:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
    1071:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    1074:	99                   	cdq    
    1075:	f7 7d f8             	idiv   DWORD PTR [ebp-0x8]
    1078:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
    107b:	eb fe                	jmp    107b <_test+0x1e>

0000107d <_kernel_main>:
    107d:	55                   	push   ebp
    107e:	89 e5                	mov    ebp,esp
    1080:	83 ec 18             	sub    esp,0x18
    1083:	e8 70 19 00 00       	call   29f8 <_init_gdt>
    1088:	e8 2c 07 00 00       	call   17b9 <_init_tss>
    108d:	e8 62 06 00 00       	call   16f4 <_init_ldt>
    1092:	e8 89 0f 00 00       	call   2020 <_init_apm>
    1097:	e8 5b 22 00 00       	call   32f7 <_init_interrupts>
    109c:	e8 10 06 00 00       	call   16b1 <_init_sys_call>
    10a1:	e8 76 00 00 00       	call   111c <_init_memory>
    10a6:	e8 40 13 00 00       	call   23eb <_clear_screen>
    10ab:	e8 58 ff ff ff       	call   1008 <_print_os_info>
    10b0:	c7 44 24 04 04 00 00 	mov    DWORD PTR [esp+0x4],0x4
    10b7:	00 
    10b8:	c7 04 24 d0 39 00 00 	mov    DWORD PTR [esp],0x39d0
    10bf:	e8 59 07 00 00       	call   181d <_create_proc>
    10c4:	c7 44 24 04 02 00 00 	mov    DWORD PTR [esp+0x4],0x2
    10cb:	00 
    10cc:	c7 04 24 5d 10 00 00 	mov    DWORD PTR [esp],0x105d
    10d3:	e8 45 07 00 00       	call   181d <_create_proc>
    10d8:	c7 44 24 04 02 00 00 	mov    DWORD PTR [esp+0x4],0x2
    10df:	00 
    10e0:	c7 04 24 90 39 00 00 	mov    DWORD PTR [esp],0x3990
    10e7:	e8 31 07 00 00       	call   181d <_create_proc>
    10ec:	c7 44 24 04 08 00 00 	mov    DWORD PTR [esp+0x4],0x8
    10f3:	00 
    10f4:	c7 04 24 70 39 00 00 	mov    DWORD PTR [esp],0x3970
    10fb:	e8 1d 07 00 00       	call   181d <_create_proc>
    1100:	e8 dd 0b 00 00       	call   1ce2 <_schedule>
    1105:	90                   	nop
    1106:	c9                   	leave  
    1107:	c3                   	ret    

00001108 <_panic>:
    1108:	55                   	push   ebp
    1109:	89 e5                	mov    ebp,esp
    110b:	83 ec 18             	sub    esp,0x18
    110e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1111:	89 04 24             	mov    DWORD PTR [esp],eax
    1114:	e8 17 13 00 00       	call   2430 <_kprint>
    1119:	eb fe                	jmp    1119 <_panic+0x11>
    111b:	90                   	nop

0000111c <_init_memory>:
    111c:	55                   	push   ebp
    111d:	89 e5                	mov    ebp,esp
    111f:	53                   	push   ebx
    1120:	83 ec 34             	sub    esp,0x34
    1123:	c7 45 f0 00 06 00 00 	mov    DWORD PTR [ebp-0x10],0x600
    112a:	c7 44 24 08 00 00 02 	mov    DWORD PTR [esp+0x8],0x20000
    1131:	00 
    1132:	c7 44 24 04 ff 00 00 	mov    DWORD PTR [esp+0x4],0xff
    1139:	00 
    113a:	c7 04 24 00 a0 00 00 	mov    DWORD PTR [esp],0xa000
    1141:	e8 9a 27 00 00       	call   38e0 <_memset>
    1146:	c7 45 f4 2a 00 00 00 	mov    DWORD PTR [ebp-0xc],0x2a
    114d:	eb 17                	jmp    1166 <_init_memory+0x4a>
    114f:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    1156:	00 
    1157:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    115a:	89 04 24             	mov    DWORD PTR [esp],eax
    115d:	e8 67 04 00 00       	call   15c9 <_set_page>
    1162:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1166:	81 7d f4 9c 00 00 00 	cmp    DWORD PTR [ebp-0xc],0x9c
    116d:	76 e0                	jbe    114f <_init_memory+0x33>
    116f:	e9 03 01 00 00       	jmp    1277 <_init_memory+0x15b>
    1174:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1177:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    117a:	8b 00                	mov    eax,DWORD PTR [eax]
    117c:	bb ff ff 0f 00       	mov    ebx,0xfffff
    1181:	b9 00 00 00 00       	mov    ecx,0x0
    1186:	39 c3                	cmp    ebx,eax
    1188:	19 d1                	sbb    ecx,edx
    118a:	0f 83 df 00 00 00    	jae    126f <_init_memory+0x153>
    1190:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1193:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1196:	83 f8 01             	cmp    eax,0x1
    1199:	0f 85 d3 00 00 00    	jne    1272 <_init_memory+0x156>
    119f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    11a2:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    11a5:	8b 00                	mov    eax,DWORD PTR [eax]
    11a7:	c1 e8 0c             	shr    eax,0xc
    11aa:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    11ad:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    11b0:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    11b3:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    11b6:	89 c2                	mov    edx,eax
    11b8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11bb:	01 d0                	add    eax,edx
    11bd:	c1 e8 0c             	shr    eax,0xc
    11c0:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    11c3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11c6:	83 e0 07             	and    eax,0x7
    11c9:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    11cc:	c1 6d ec 03          	shr    DWORD PTR [ebp-0x14],0x3
    11d0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11d3:	83 e0 07             	and    eax,0x7
    11d6:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    11d9:	c1 6d f4 03          	shr    DWORD PTR [ebp-0xc],0x3
    11dd:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    11e1:	74 33                	je     1216 <_init_memory+0xfa>
    11e3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11e6:	05 00 a0 00 00       	add    eax,0xa000
    11eb:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    11ee:	89 c2                	mov    edx,eax
    11f0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    11f3:	0f b6 c0             	movzx  eax,al
    11f6:	bb 01 00 00 00       	mov    ebx,0x1
    11fb:	89 c1                	mov    ecx,eax
    11fd:	d3 e3                	shl    ebx,cl
    11ff:	89 d8                	mov    eax,ebx
    1201:	83 e8 01             	sub    eax,0x1
    1204:	21 d0                	and    eax,edx
    1206:	89 c2                	mov    edx,eax
    1208:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    120b:	05 00 a0 00 00       	add    eax,0xa000
    1210:	88 10                	mov    BYTE PTR [eax],dl
    1212:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1216:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    121a:	74 2e                	je     124a <_init_memory+0x12e>
    121c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    121f:	05 00 a0 00 00       	add    eax,0xa000
    1224:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1227:	89 c2                	mov    edx,eax
    1229:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    122c:	0f b6 c0             	movzx  eax,al
    122f:	bb 01 00 00 00       	mov    ebx,0x1
    1234:	89 c1                	mov    ecx,eax
    1236:	d3 e3                	shl    ebx,cl
    1238:	89 d8                	mov    eax,ebx
    123a:	f7 d8                	neg    eax
    123c:	21 d0                	and    eax,edx
    123e:	89 c2                	mov    edx,eax
    1240:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1243:	05 00 a0 00 00       	add    eax,0xa000
    1248:	88 10                	mov    BYTE PTR [eax],dl
    124a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    124d:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    1250:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1253:	81 c2 00 a0 00 00    	add    edx,0xa000
    1259:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    125d:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    1264:	00 
    1265:	89 14 24             	mov    DWORD PTR [esp],edx
    1268:	e8 73 26 00 00       	call   38e0 <_memset>
    126d:	eb 04                	jmp    1273 <_init_memory+0x157>
    126f:	90                   	nop
    1270:	eb 01                	jmp    1273 <_init_memory+0x157>
    1272:	90                   	nop
    1273:	83 45 f0 14          	add    DWORD PTR [ebp-0x10],0x14
    1277:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    127a:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    127d:	85 c0                	test   eax,eax
    127f:	0f 85 ef fe ff ff    	jne    1174 <_init_memory+0x58>
    1285:	c7 44 24 08 00 10 00 	mov    DWORD PTR [esp+0x8],0x1000
    128c:	00 
    128d:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    1294:	00 
    1295:	c7 04 24 00 80 00 00 	mov    DWORD PTR [esp],0x8000
    129c:	e8 3f 26 00 00       	call   38e0 <_memset>
    12a1:	b8 00 90 00 00       	mov    eax,0x9000
    12a6:	25 00 f0 ff ff       	and    eax,0xfffff000
    12ab:	83 c8 05             	or     eax,0x5
    12ae:	a3 00 80 00 00       	mov    ds:0x8000,eax
    12b3:	b8 00 80 00 00       	mov    eax,0x8000
    12b8:	25 00 f0 ff ff       	and    eax,0xfffff000
    12bd:	83 c8 05             	or     eax,0x5
    12c0:	a3 fc 8f 00 00       	mov    ds:0x8ffc,eax
    12c5:	c7 44 24 08 00 10 00 	mov    DWORD PTR [esp+0x8],0x1000
    12cc:	00 
    12cd:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    12d4:	00 
    12d5:	c7 04 24 00 90 00 00 	mov    DWORD PTR [esp],0x9000
    12dc:	e8 ff 25 00 00       	call   38e0 <_memset>
    12e1:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    12e8:	eb 19                	jmp    1303 <_init_memory+0x1e7>
    12ea:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12ed:	c1 e0 0c             	shl    eax,0xc
    12f0:	83 c8 01             	or     eax,0x1
    12f3:	89 c2                	mov    edx,eax
    12f5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12f8:	89 14 85 00 90 00 00 	mov    DWORD PTR [eax*4+0x9000],edx
    12ff:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1303:	83 7d f4 29          	cmp    DWORD PTR [ebp-0xc],0x29
    1307:	76 e1                	jbe    12ea <_init_memory+0x1ce>
    1309:	c7 45 f4 9d 00 00 00 	mov    DWORD PTR [ebp-0xc],0x9d
    1310:	eb 19                	jmp    132b <_init_memory+0x20f>
    1312:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1315:	c1 e0 0c             	shl    eax,0xc
    1318:	83 c8 01             	or     eax,0x1
    131b:	89 c2                	mov    edx,eax
    131d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1320:	89 14 85 00 90 00 00 	mov    DWORD PTR [eax*4+0x9000],edx
    1327:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    132b:	81 7d f4 ff 00 00 00 	cmp    DWORD PTR [ebp-0xc],0xff
    1332:	76 de                	jbe    1312 <_init_memory+0x1f6>
    1334:	c7 04 24 00 80 00 00 	mov    DWORD PTR [esp],0x8000
    133b:	e8 40 27 00 00       	call   3a80 <_set_cr3>
    1340:	e8 2b 27 00 00       	call   3a70 <_start_paging>
    1345:	90                   	nop
    1346:	83 c4 34             	add    esp,0x34
    1349:	5b                   	pop    ebx
    134a:	5d                   	pop    ebp
    134b:	c3                   	ret    

0000134c <_alloc_page>:
    134c:	55                   	push   ebp
    134d:	89 e5                	mov    ebp,esp
    134f:	83 ec 28             	sub    esp,0x28
    1352:	83 7d 08 04          	cmp    DWORD PTR [ebp+0x8],0x4
    1356:	75 10                	jne    1368 <_alloc_page+0x1c>
    1358:	c7 45 f4 80 00 00 00 	mov    DWORD PTR [ebp-0xc],0x80
    135f:	c7 45 e8 00 00 02 00 	mov    DWORD PTR [ebp-0x18],0x20000
    1366:	eb 6d                	jmp    13d5 <_alloc_page+0x89>
    1368:	c7 45 f4 05 00 00 00 	mov    DWORD PTR [ebp-0xc],0x5
    136f:	c7 45 e8 80 00 00 00 	mov    DWORD PTR [ebp-0x18],0x80
    1376:	eb 5d                	jmp    13d5 <_alloc_page+0x89>
    1378:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    137b:	05 00 a0 00 00       	add    eax,0xa000
    1380:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1383:	3c ff                	cmp    al,0xff
    1385:	74 4a                	je     13d1 <_alloc_page+0x85>
    1387:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    138a:	c1 e0 03             	shl    eax,0x3
    138d:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    1390:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1397:	eb 32                	jmp    13cb <_alloc_page+0x7f>
    1399:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    139c:	89 04 24             	mov    DWORD PTR [esp],eax
    139f:	e8 a1 02 00 00       	call   1645 <_is_page_free>
    13a4:	85 c0                	test   eax,eax
    13a6:	74 1b                	je     13c3 <_alloc_page+0x77>
    13a8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    13ab:	c7 44 24 04 01 00 00 	mov    DWORD PTR [esp+0x4],0x1
    13b2:	00 
    13b3:	89 04 24             	mov    DWORD PTR [esp],eax
    13b6:	e8 0e 02 00 00       	call   15c9 <_set_page>
    13bb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    13be:	c1 e0 0c             	shl    eax,0xc
    13c1:	eb 2b                	jmp    13ee <_alloc_page+0xa2>
    13c3:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    13c7:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    13cb:	83 7d f0 07          	cmp    DWORD PTR [ebp-0x10],0x7
    13cf:	7e c8                	jle    1399 <_alloc_page+0x4d>
    13d1:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    13d5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13d8:	3b 45 e8             	cmp    eax,DWORD PTR [ebp-0x18]
    13db:	7c 9b                	jl     1378 <_alloc_page+0x2c>
    13dd:	c7 04 24 30 40 00 00 	mov    DWORD PTR [esp],0x4030
    13e4:	e8 1f fd ff ff       	call   1108 <_panic>
    13e9:	b8 00 00 00 00       	mov    eax,0x0
    13ee:	c9                   	leave  
    13ef:	c3                   	ret    

000013f0 <_valloc_page>:
    13f0:	55                   	push   ebp
    13f1:	89 e5                	mov    ebp,esp
    13f3:	83 ec 38             	sub    esp,0x38
    13f6:	c7 45 f0 00 f0 ff ff 	mov    DWORD PTR [ebp-0x10],0xfffff000
    13fd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1400:	c1 e8 16             	shr    eax,0x16
    1403:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    1406:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1409:	c1 e8 0c             	shr    eax,0xc
    140c:	25 ff 03 00 00       	and    eax,0x3ff
    1411:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1414:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1417:	c1 e0 0c             	shl    eax,0xc
    141a:	2d 00 00 40 00       	sub    eax,0x400000
    141f:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    1422:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1425:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    142c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    142f:	01 d0                	add    eax,edx
    1431:	8b 00                	mov    eax,DWORD PTR [eax]
    1433:	85 c0                	test   eax,eax
    1435:	75 7f                	jne    14b6 <_valloc_page+0xc6>
    1437:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    143e:	e8 09 ff ff ff       	call   134c <_alloc_page>
    1443:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1446:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1449:	25 00 f0 ff ff       	and    eax,0xfffff000
    144e:	89 c2                	mov    edx,eax
    1450:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1453:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
    145a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    145d:	01 c8                	add    eax,ecx
    145f:	83 ca 07             	or     edx,0x7
    1462:	89 10                	mov    DWORD PTR [eax],edx
    1464:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1467:	89 04 24             	mov    DWORD PTR [esp],eax
    146a:	e8 22 26 00 00       	call   3a91 <_invalidate_page>
    146f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1472:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1475:	eb 2f                	jmp    14a6 <_valloc_page+0xb6>
    1477:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    147a:	c1 e0 0c             	shl    eax,0xc
    147d:	25 00 f0 3f 00       	and    eax,0x3ff000
    1482:	89 c2                	mov    edx,eax
    1484:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1487:	c1 e0 02             	shl    eax,0x2
    148a:	25 ff 0f 00 00       	and    eax,0xfff
    148f:	09 d0                	or     eax,edx
    1491:	0d 00 00 c0 ff       	or     eax,0xffc00000
    1496:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1499:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    149c:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    14a2:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    14a6:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    14a9:	8d 90 00 04 00 00    	lea    edx,[eax+0x400]
    14af:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    14b2:	39 c2                	cmp    edx,eax
    14b4:	77 c1                	ja     1477 <_valloc_page+0x87>
    14b6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    14b9:	c1 e0 0c             	shl    eax,0xc
    14bc:	25 00 f0 3f 00       	and    eax,0x3ff000
    14c1:	89 c2                	mov    edx,eax
    14c3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    14c6:	c1 e0 02             	shl    eax,0x2
    14c9:	25 ff 0f 00 00       	and    eax,0xfff
    14ce:	09 d0                	or     eax,edx
    14d0:	0d 00 00 c0 ff       	or     eax,0xffc00000
    14d5:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    14d8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    14db:	8b 00                	mov    eax,DWORD PTR [eax]
    14dd:	85 c0                	test   eax,eax
    14df:	74 07                	je     14e8 <_valloc_page+0xf8>
    14e1:	b8 00 00 00 00       	mov    eax,0x0
    14e6:	eb 27                	jmp    150f <_valloc_page+0x11f>
    14e8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    14eb:	25 00 f0 ff ff       	and    eax,0xfffff000
    14f0:	89 c2                	mov    edx,eax
    14f2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    14f5:	25 ff 0f 00 00       	and    eax,0xfff
    14fa:	09 c2                	or     edx,eax
    14fc:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    14ff:	89 10                	mov    DWORD PTR [eax],edx
    1501:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1504:	89 04 24             	mov    DWORD PTR [esp],eax
    1507:	e8 85 25 00 00       	call   3a91 <_invalidate_page>
    150c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    150f:	c9                   	leave  
    1510:	c3                   	ret    

00001511 <_free_page>:
    1511:	55                   	push   ebp
    1512:	89 e5                	mov    ebp,esp
    1514:	83 ec 18             	sub    esp,0x18
    1517:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    151a:	c1 e8 0c             	shr    eax,0xc
    151d:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    1524:	00 
    1525:	89 04 24             	mov    DWORD PTR [esp],eax
    1528:	e8 9c 00 00 00       	call   15c9 <_set_page>
    152d:	90                   	nop
    152e:	c9                   	leave  
    152f:	c3                   	ret    

00001530 <_vfree_page>:
    1530:	55                   	push   ebp
    1531:	89 e5                	mov    ebp,esp
    1533:	90                   	nop
    1534:	5d                   	pop    ebp
    1535:	c3                   	ret    

00001536 <_handle_gp>:
    1536:	55                   	push   ebp
    1537:	89 e5                	mov    ebp,esp
    1539:	83 ec 18             	sub    esp,0x18
    153c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    153f:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
    1542:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1545:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    1548:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    154c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1550:	c7 04 24 44 40 00 00 	mov    DWORD PTR [esp],0x4044
    1557:	e8 e9 10 00 00       	call   2645 <_kprintf>
    155c:	90                   	nop
    155d:	c9                   	leave  
    155e:	c3                   	ret    

0000155f <_handle_pf>:
    155f:	55                   	push   ebp
    1560:	89 e5                	mov    ebp,esp
    1562:	83 ec 18             	sub    esp,0x18
    1565:	c7 04 24 70 40 00 00 	mov    DWORD PTR [esp],0x4070
    156c:	e8 d4 10 00 00       	call   2645 <_kprintf>
    1571:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1574:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    1577:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    157b:	c7 04 24 7d 40 00 00 	mov    DWORD PTR [esp],0x407d
    1582:	e8 be 10 00 00       	call   2645 <_kprintf>
    1587:	e8 f0 24 00 00       	call   3a7c <_get_page_fault_addr>
    158c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1590:	c7 04 24 8e 40 00 00 	mov    DWORD PTR [esp],0x408e
    1597:	e8 a9 10 00 00       	call   2645 <_kprintf>
    159c:	e8 e7 24 00 00       	call   3a88 <_get_cr3>
    15a1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    15a5:	c7 04 24 9d 40 00 00 	mov    DWORD PTR [esp],0x409d
    15ac:	e8 94 10 00 00       	call   2645 <_kprintf>
    15b1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15b4:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    15b7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    15bb:	c7 04 24 a8 40 00 00 	mov    DWORD PTR [esp],0x40a8
    15c2:	e8 7e 10 00 00       	call   2645 <_kprintf>
    15c7:	eb fe                	jmp    15c7 <_handle_pf+0x68>

000015c9 <_set_page>:
    15c9:	55                   	push   ebp
    15ca:	89 e5                	mov    ebp,esp
    15cc:	53                   	push   ebx
    15cd:	83 ec 10             	sub    esp,0x10
    15d0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15d3:	c1 e8 03             	shr    eax,0x3
    15d6:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    15d9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15dc:	83 e0 07             	and    eax,0x7
    15df:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    15e2:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    15e6:	75 2d                	jne    1615 <_set_page+0x4c>
    15e8:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    15eb:	05 00 a0 00 00       	add    eax,0xa000
    15f0:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    15f3:	89 c2                	mov    edx,eax
    15f5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    15f8:	bb 01 00 00 00       	mov    ebx,0x1
    15fd:	89 c1                	mov    ecx,eax
    15ff:	d3 e3                	shl    ebx,cl
    1601:	89 d8                	mov    eax,ebx
    1603:	f7 d0                	not    eax
    1605:	21 d0                	and    eax,edx
    1607:	89 c2                	mov    edx,eax
    1609:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    160c:	05 00 a0 00 00       	add    eax,0xa000
    1611:	88 10                	mov    BYTE PTR [eax],dl
    1613:	eb 29                	jmp    163e <_set_page+0x75>
    1615:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    1618:	05 00 a0 00 00       	add    eax,0xa000
    161d:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1620:	89 c3                	mov    ebx,eax
    1622:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1625:	ba 01 00 00 00       	mov    edx,0x1
    162a:	89 c1                	mov    ecx,eax
    162c:	d3 e2                	shl    edx,cl
    162e:	89 d0                	mov    eax,edx
    1630:	09 d8                	or     eax,ebx
    1632:	89 c2                	mov    edx,eax
    1634:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    1637:	05 00 a0 00 00       	add    eax,0xa000
    163c:	88 10                	mov    BYTE PTR [eax],dl
    163e:	90                   	nop
    163f:	83 c4 10             	add    esp,0x10
    1642:	5b                   	pop    ebx
    1643:	5d                   	pop    ebp
    1644:	c3                   	ret    

00001645 <_is_page_free>:
    1645:	55                   	push   ebp
    1646:	89 e5                	mov    ebp,esp
    1648:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    164b:	c1 e8 03             	shr    eax,0x3
    164e:	0f b6 80 00 a0 00 00 	movzx  eax,BYTE PTR [eax+0xa000]
    1655:	0f b6 d0             	movzx  edx,al
    1658:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    165b:	83 e0 07             	and    eax,0x7
    165e:	89 c1                	mov    ecx,eax
    1660:	d3 fa                	sar    edx,cl
    1662:	89 d0                	mov    eax,edx
    1664:	83 e0 01             	and    eax,0x1
    1667:	85 c0                	test   eax,eax
    1669:	0f 94 c0             	sete   al
    166c:	0f b6 c0             	movzx  eax,al
    166f:	5d                   	pop    ebp
    1670:	c3                   	ret    
    1671:	90                   	nop
    1672:	90                   	nop
    1673:	90                   	nop

00001674 <_do_sys_call>:
    1674:	55                   	push   ebp
    1675:	89 e5                	mov    ebp,esp
    1677:	83 ec 28             	sub    esp,0x28
    167a:	a1 bc 65 00 00       	mov    eax,ds:0x65bc
    167f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1682:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1685:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1688:	83 f8 02             	cmp    eax,0x2
    168b:	77 21                	ja     16ae <_do_sys_call+0x3a>
    168d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1690:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1693:	8b 04 85 b4 40 00 00 	mov    eax,DWORD PTR [eax*4+0x40b4]
    169a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    169d:	8b 52 44             	mov    edx,DWORD PTR [edx+0x44]
    16a0:	83 c2 04             	add    edx,0x4
    16a3:	89 14 24             	mov    DWORD PTR [esp],edx
    16a6:	ff d0                	call   eax
    16a8:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    16ab:	89 42 2c             	mov    DWORD PTR [edx+0x2c],eax
    16ae:	90                   	nop
    16af:	c9                   	leave  
    16b0:	c3                   	ret    

000016b1 <_init_sys_call>:
    16b1:	55                   	push   ebp
    16b2:	89 e5                	mov    ebp,esp
    16b4:	83 ec 18             	sub    esp,0x18
    16b7:	b8 80 3c 00 00       	mov    eax,0x3c80
    16bc:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    16c0:	c7 04 24 80 00 00 00 	mov    DWORD PTR [esp],0x80
    16c7:	e8 6e 1b 00 00       	call   323a <_set_idt_gate>
    16cc:	0f b6 05 e5 69 00 00 	movzx  eax,BYTE PTR ds:0x69e5
    16d3:	83 c8 60             	or     eax,0x60
    16d6:	a2 e5 69 00 00       	mov    ds:0x69e5,al
    16db:	c7 44 24 04 74 16 00 	mov    DWORD PTR [esp+0x4],0x1674
    16e2:	00 
    16e3:	c7 04 24 80 00 00 00 	mov    DWORD PTR [esp],0x80
    16ea:	e8 3d 1c 00 00       	call   332c <_set_interrupt_handler>
    16ef:	90                   	nop
    16f0:	c9                   	leave  
    16f1:	c3                   	ret    
    16f2:	90                   	nop
    16f3:	90                   	nop

000016f4 <_init_ldt>:
    16f4:	55                   	push   ebp
    16f5:	89 e5                	mov    ebp,esp
    16f7:	83 ec 18             	sub    esp,0x18
    16fa:	66 c7 05 a8 65 00 00 	mov    WORD PTR ds:0x65a8,0xffff
    1701:	ff ff 
    1703:	0f b6 05 ae 65 00 00 	movzx  eax,BYTE PTR ds:0x65ae
    170a:	83 c8 0f             	or     eax,0xf
    170d:	a2 ae 65 00 00       	mov    ds:0x65ae,al
    1712:	66 c7 05 aa 65 00 00 	mov    WORD PTR ds:0x65aa,0x0
    1719:	00 00 
    171b:	c6 05 ac 65 00 00 00 	mov    BYTE PTR ds:0x65ac,0x0
    1722:	c6 05 af 65 00 00 00 	mov    BYTE PTR ds:0x65af,0x0
    1729:	c6 05 ad 65 00 00 fa 	mov    BYTE PTR ds:0x65ad,0xfa
    1730:	0f b6 05 ae 65 00 00 	movzx  eax,BYTE PTR ds:0x65ae
    1737:	83 e0 0f             	and    eax,0xf
    173a:	83 c8 c0             	or     eax,0xffffffc0
    173d:	a2 ae 65 00 00       	mov    ds:0x65ae,al
    1742:	66 c7 05 b0 65 00 00 	mov    WORD PTR ds:0x65b0,0xffff
    1749:	ff ff 
    174b:	0f b6 05 b6 65 00 00 	movzx  eax,BYTE PTR ds:0x65b6
    1752:	83 c8 0f             	or     eax,0xf
    1755:	a2 b6 65 00 00       	mov    ds:0x65b6,al
    175a:	66 c7 05 b2 65 00 00 	mov    WORD PTR ds:0x65b2,0x0
    1761:	00 00 
    1763:	c6 05 b4 65 00 00 00 	mov    BYTE PTR ds:0x65b4,0x0
    176a:	c6 05 b7 65 00 00 00 	mov    BYTE PTR ds:0x65b7,0x0
    1771:	c6 05 b5 65 00 00 f2 	mov    BYTE PTR ds:0x65b5,0xf2
    1778:	0f b6 05 b6 65 00 00 	movzx  eax,BYTE PTR ds:0x65b6
    177f:	83 e0 0f             	and    eax,0xf
    1782:	83 c8 c0             	or     eax,0xffffffc0
    1785:	a2 b6 65 00 00       	mov    ds:0x65b6,al
    178a:	c7 44 24 04 10 00 00 	mov    DWORD PTR [esp+0x4],0x10
    1791:	00 
    1792:	c7 04 24 a8 65 00 00 	mov    DWORD PTR [esp],0x65a8
    1799:	e8 b0 13 00 00       	call   2b4e <_add_ldt_descriptor>
    179e:	66 a3 c8 65 00 00    	mov    ds:0x65c8,ax
    17a4:	0f b7 05 c8 65 00 00 	movzx  eax,WORD PTR ds:0x65c8
    17ab:	0f b7 c0             	movzx  eax,ax
    17ae:	89 04 24             	mov    DWORD PTR [esp],eax
    17b1:	e8 aa 22 00 00       	call   3a60 <_load_ldtr>
    17b6:	90                   	nop
    17b7:	c9                   	leave  
    17b8:	c3                   	ret    

000017b9 <_init_tss>:
    17b9:	55                   	push   ebp
    17ba:	89 e5                	mov    ebp,esp
    17bc:	83 ec 18             	sub    esp,0x18
    17bf:	c7 44 24 08 68 00 00 	mov    DWORD PTR [esp+0x8],0x68
    17c6:	00 
    17c7:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    17ce:	00 
    17cf:	c7 04 24 40 65 00 00 	mov    DWORD PTR [esp],0x6540
    17d6:	e8 05 21 00 00       	call   38e0 <_memset>
    17db:	c7 05 48 65 00 00 10 	mov    DWORD PTR ds:0x6548,0x10
    17e2:	00 00 00 
    17e5:	66 c7 05 a6 65 00 00 	mov    WORD PTR ds:0x65a6,0x68
    17ec:	68 00 
    17ee:	c7 44 24 04 67 00 00 	mov    DWORD PTR [esp+0x4],0x67
    17f5:	00 
    17f6:	c7 04 24 40 65 00 00 	mov    DWORD PTR [esp],0x6540
    17fd:	e8 76 13 00 00       	call   2b78 <_add_tss_descriptor>
    1802:	66 a3 00 60 00 00    	mov    ds:0x6000,ax
    1808:	0f b7 05 00 60 00 00 	movzx  eax,WORD PTR ds:0x6000
    180f:	0f b7 c0             	movzx  eax,ax
    1812:	89 04 24             	mov    DWORD PTR [esp],eax
    1815:	e8 86 24 00 00       	call   3ca0 <_load_tr>
    181a:	90                   	nop
    181b:	c9                   	leave  
    181c:	c3                   	ret    

0000181d <_create_proc>:
    181d:	55                   	push   ebp
    181e:	89 e5                	mov    ebp,esp
    1820:	83 ec 28             	sub    esp,0x28
    1823:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    182a:	e8 1d fb ff ff       	call   134c <_alloc_page>
    182f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1832:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1835:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1838:	c7 44 24 08 03 00 00 	mov    DWORD PTR [esp+0x8],0x3
    183f:	00 
    1840:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1844:	89 04 24             	mov    DWORD PTR [esp],eax
    1847:	e8 a4 fb ff ff       	call   13f0 <_valloc_page>
    184c:	c7 44 24 08 00 10 00 	mov    DWORD PTR [esp+0x8],0x1000
    1853:	00 
    1854:	c7 44 24 04 00 80 00 	mov    DWORD PTR [esp+0x4],0x8000
    185b:	00 
    185c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    185f:	89 04 24             	mov    DWORD PTR [esp],eax
    1862:	e8 a9 20 00 00       	call   3910 <_memcpy>
    1867:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    186a:	25 00 f0 ff ff       	and    eax,0xfffff000
    186f:	89 c2                	mov    edx,eax
    1871:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1874:	05 fc 0f 00 00       	add    eax,0xffc
    1879:	83 ca 03             	or     edx,0x3
    187c:	89 10                	mov    DWORD PTR [eax],edx
    187e:	e8 05 22 00 00       	call   3a88 <_get_cr3>
    1883:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1886:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1889:	89 04 24             	mov    DWORD PTR [esp],eax
    188c:	e8 ef 21 00 00       	call   3a80 <_set_cr3>
    1891:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1898:	e8 af fa ff ff       	call   134c <_alloc_page>
    189d:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    18a0:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    18a3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    18a6:	c7 44 24 08 03 00 00 	mov    DWORD PTR [esp+0x8],0x3
    18ad:	00 
    18ae:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    18b2:	89 04 24             	mov    DWORD PTR [esp],eax
    18b5:	e8 36 fb ff ff       	call   13f0 <_valloc_page>
    18ba:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    18bd:	c7 44 24 08 00 10 00 	mov    DWORD PTR [esp+0x8],0x1000
    18c4:	00 
    18c5:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    18cc:	00 
    18cd:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    18d0:	89 04 24             	mov    DWORD PTR [esp],eax
    18d3:	e8 08 20 00 00       	call   38e0 <_memset>
    18d8:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    18db:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    18de:	89 10                	mov    DWORD PTR [eax],edx
    18e0:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    18e3:	c1 e8 0c             	shr    eax,0xc
    18e6:	89 c2                	mov    edx,eax
    18e8:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    18eb:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    18ee:	8b 15 04 60 00 00    	mov    edx,DWORD PTR ds:0x6004
    18f4:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    18f7:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    18fa:	8b 15 b8 65 00 00    	mov    edx,DWORD PTR ds:0x65b8
    1900:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1903:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
    1906:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1909:	a3 b8 65 00 00       	mov    ds:0x65b8,eax
    190e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1911:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1915:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1918:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    191c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    191f:	89 04 24             	mov    DWORD PTR [esp],eax
    1922:	e8 13 00 00 00       	call   193a <_create_thread>
    1927:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    192a:	89 04 24             	mov    DWORD PTR [esp],eax
    192d:	e8 4e 21 00 00       	call   3a80 <_set_cr3>
    1932:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1935:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1938:	c9                   	leave  
    1939:	c3                   	ret    

0000193a <_create_thread>:
    193a:	55                   	push   ebp
    193b:	89 e5                	mov    ebp,esp
    193d:	83 ec 28             	sub    esp,0x28
    1940:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1947:	e8 00 fa ff ff       	call   134c <_alloc_page>
    194c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    194f:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1952:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1955:	c7 44 24 08 03 00 00 	mov    DWORD PTR [esp+0x8],0x3
    195c:	00 
    195d:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1961:	89 04 24             	mov    DWORD PTR [esp],eax
    1964:	e8 87 fa ff ff       	call   13f0 <_valloc_page>
    1969:	c7 44 24 08 00 10 00 	mov    DWORD PTR [esp+0x8],0x1000
    1970:	00 
    1971:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    1978:	00 
    1979:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    197c:	89 04 24             	mov    DWORD PTR [esp],eax
    197f:	e8 5c 1f 00 00       	call   38e0 <_memset>
    1984:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1987:	05 84 0f 00 00       	add    eax,0xf84
    198c:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    198f:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1992:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1995:	89 50 50             	mov    DWORD PTR [eax+0x50],edx
    1998:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    199b:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    199e:	89 50 4c             	mov    DWORD PTR [eax+0x4c],edx
    19a1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19a4:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    19a7:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
    19aa:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19ad:	8b 50 64             	mov    edx,DWORD PTR [eax+0x64]
    19b0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19b3:	89 50 60             	mov    DWORD PTR [eax+0x60],edx
    19b6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    19b9:	c1 e8 0c             	shr    eax,0xc
    19bc:	89 c2                	mov    edx,eax
    19be:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19c1:	89 50 5c             	mov    DWORD PTR [eax+0x5c],edx
    19c4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    19c7:	8b 10                	mov    edx,DWORD PTR [eax]
    19c9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19cc:	89 50 54             	mov    DWORD PTR [eax+0x54],edx
    19cf:	8b 15 cc 65 00 00    	mov    edx,DWORD PTR ds:0x65cc
    19d5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19d8:	89 50 6c             	mov    DWORD PTR [eax+0x6c],edx
    19db:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19de:	a3 cc 65 00 00       	mov    ds:0x65cc,eax
    19e3:	8b 15 c0 65 00 00    	mov    edx,DWORD PTR ds:0x65c0
    19e9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19ec:	89 50 70             	mov    DWORD PTR [eax+0x70],edx
    19ef:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19f2:	a3 c0 65 00 00       	mov    ds:0x65c0,eax
    19f7:	c7 04 24 04 00 00 00 	mov    DWORD PTR [esp],0x4
    19fe:	e8 49 f9 ff ff       	call   134c <_alloc_page>
    1a03:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1a06:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1a09:	c7 44 24 08 07 00 00 	mov    DWORD PTR [esp+0x8],0x7
    1a10:	00 
    1a11:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a15:	c7 04 24 00 e0 ff 9f 	mov    DWORD PTR [esp],0x9fffe000
    1a1c:	e8 cf f9 ff ff       	call   13f0 <_valloc_page>
    1a21:	c7 04 24 04 00 00 00 	mov    DWORD PTR [esp],0x4
    1a28:	e8 1f f9 ff ff       	call   134c <_alloc_page>
    1a2d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1a30:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1a33:	c7 44 24 08 07 00 00 	mov    DWORD PTR [esp+0x8],0x7
    1a3a:	00 
    1a3b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a3f:	c7 04 24 00 f0 ff 9f 	mov    DWORD PTR [esp],0x9ffff000
    1a46:	e8 a5 f9 ff ff       	call   13f0 <_valloc_page>
    1a4b:	c7 04 24 04 00 00 00 	mov    DWORD PTR [esp],0x4
    1a52:	e8 f5 f8 ff ff       	call   134c <_alloc_page>
    1a57:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1a5a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1a5d:	c7 44 24 08 05 00 00 	mov    DWORD PTR [esp+0x8],0x5
    1a64:	00 
    1a65:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a69:	c7 04 24 00 00 40 00 	mov    DWORD PTR [esp],0x400000
    1a70:	e8 7b f9 ff ff       	call   13f0 <_valloc_page>
    1a75:	c7 44 24 08 00 10 00 	mov    DWORD PTR [esp+0x8],0x1000
    1a7c:	00 
    1a7d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1a80:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a84:	c7 04 24 00 00 40 00 	mov    DWORD PTR [esp],0x400000
    1a8b:	e8 80 1e 00 00       	call   3910 <_memcpy>
    1a90:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a93:	89 04 24             	mov    DWORD PTR [esp],eax
    1a96:	e8 0d 00 00 00       	call   1aa8 <_init_context>
    1a9b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a9e:	c7 40 58 00 00 00 00 	mov    DWORD PTR [eax+0x58],0x0
    1aa5:	90                   	nop
    1aa6:	c9                   	leave  
    1aa7:	c3                   	ret    

00001aa8 <_init_context>:
    1aa8:	55                   	push   ebp
    1aa9:	89 e5                	mov    ebp,esp
    1aab:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1aae:	83 e8 04             	sub    eax,0x4
    1ab1:	ba ac 3a 00 00       	mov    edx,0x3aac
    1ab6:	89 10                	mov    DWORD PTR [eax],edx
    1ab8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1abb:	8d 50 ec             	lea    edx,[eax-0x14]
    1abe:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ac1:	89 50 50             	mov    DWORD PTR [eax+0x50],edx
    1ac4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ac7:	c7 40 3c 07 00 00 00 	mov    DWORD PTR [eax+0x3c],0x7
    1ace:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ad1:	c7 40 48 0f 00 00 00 	mov    DWORD PTR [eax+0x48],0xf
    1ad8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1adb:	8b 50 48             	mov    edx,DWORD PTR [eax+0x48]
    1ade:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ae1:	89 10                	mov    DWORD PTR [eax],edx
    1ae3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ae6:	8b 10                	mov    edx,DWORD PTR [eax]
    1ae8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1aeb:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    1aee:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1af1:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1af4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1af7:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    1afa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1afd:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1b00:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b03:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
    1b06:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b09:	c7 40 38 00 00 40 00 	mov    DWORD PTR [eax+0x38],0x400000
    1b10:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b13:	c7 40 44 00 00 00 a0 	mov    DWORD PTR [eax+0x44],0xa0000000
    1b1a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b1d:	c7 40 40 02 02 00 00 	mov    DWORD PTR [eax+0x40],0x202
    1b24:	90                   	nop
    1b25:	5d                   	pop    ebp
    1b26:	c3                   	ret    

00001b27 <_suspend_thread>:
    1b27:	55                   	push   ebp
    1b28:	89 e5                	mov    ebp,esp
    1b2a:	83 ec 18             	sub    esp,0x18
    1b2d:	a1 c0 65 00 00       	mov    eax,ds:0x65c0
    1b32:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1b35:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1b3c:	a1 c0 65 00 00       	mov    eax,ds:0x65c0
    1b41:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    1b44:	eb 22                	jmp    1b68 <_suspend_thread+0x41>
    1b46:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1b49:	8b 40 5c             	mov    eax,DWORD PTR [eax+0x5c]
    1b4c:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
    1b4f:	75 08                	jne    1b59 <_suspend_thread+0x32>
    1b51:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1b54:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1b57:	eb 15                	jmp    1b6e <_suspend_thread+0x47>
    1b59:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1b5c:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    1b5f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1b62:	8b 40 6c             	mov    eax,DWORD PTR [eax+0x6c]
    1b65:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1b68:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1b6c:	75 d8                	jne    1b46 <_suspend_thread+0x1f>
    1b6e:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    1b72:	75 0a                	jne    1b7e <_suspend_thread+0x57>
    1b74:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1b79:	e9 85 00 00 00       	jmp    1c03 <_suspend_thread+0xdc>
    1b7e:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1b82:	75 07                	jne    1b8b <_suspend_thread+0x64>
    1b84:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1b89:	eb 78                	jmp    1c03 <_suspend_thread+0xdc>
    1b8b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b8e:	8b 50 70             	mov    edx,DWORD PTR [eax+0x70]
    1b91:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b94:	89 50 70             	mov    DWORD PTR [eax+0x70],edx
    1b97:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b9a:	c7 40 70 00 00 00 00 	mov    DWORD PTR [eax+0x70],0x0
    1ba1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ba4:	8b 10                	mov    edx,DWORD PTR [eax]
    1ba6:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1ba9:	89 50 70             	mov    DWORD PTR [eax+0x70],edx
    1bac:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1baf:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1bb2:	89 10                	mov    DWORD PTR [eax],edx
    1bb4:	83 7d 10 13          	cmp    DWORD PTR [ebp+0x10],0x13
    1bb8:	77 04                	ja     1bbe <_suspend_thread+0x97>
    1bba:	83 45 10 14          	add    DWORD PTR [ebp+0x10],0x14
    1bbe:	83 7d 10 ff          	cmp    DWORD PTR [ebp+0x10],0xffffffff
    1bc2:	74 16                	je     1bda <_suspend_thread+0xb3>
    1bc4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1bc7:	ba cd cc cc cc       	mov    edx,0xcccccccd
    1bcc:	f7 e2                	mul    edx
    1bce:	c1 ea 04             	shr    edx,0x4
    1bd1:	a1 04 60 00 00       	mov    eax,ds:0x6004
    1bd6:	01 c2                	add    edx,eax
    1bd8:	eb 05                	jmp    1bdf <_suspend_thread+0xb8>
    1bda:	ba ff ff ff ff       	mov    edx,0xffffffff
    1bdf:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1be2:	89 50 68             	mov    DWORD PTR [eax+0x68],edx
    1be5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1be8:	c7 40 58 01 00 00 00 	mov    DWORD PTR [eax+0x58],0x1
    1bef:	a1 bc 65 00 00       	mov    eax,ds:0x65bc
    1bf4:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    1bf7:	75 05                	jne    1bfe <_suspend_thread+0xd7>
    1bf9:	e8 e4 00 00 00       	call   1ce2 <_schedule>
    1bfe:	b8 00 00 00 00       	mov    eax,0x0
    1c03:	c9                   	leave  
    1c04:	c3                   	ret    

00001c05 <_resume_thread>:
    1c05:	55                   	push   ebp
    1c06:	89 e5                	mov    ebp,esp
    1c08:	83 ec 10             	sub    esp,0x10
    1c0b:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1c12:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1c16:	75 07                	jne    1c1f <_resume_thread+0x1a>
    1c18:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1c1d:	eb 79                	jmp    1c98 <_resume_thread+0x93>
    1c1f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c22:	8b 00                	mov    eax,DWORD PTR [eax]
    1c24:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    1c27:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    1c2a:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
    1c2d:	eb 22                	jmp    1c51 <_resume_thread+0x4c>
    1c2f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    1c32:	8b 40 5c             	mov    eax,DWORD PTR [eax+0x5c]
    1c35:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
    1c38:	75 08                	jne    1c42 <_resume_thread+0x3d>
    1c3a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    1c3d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1c40:	eb 15                	jmp    1c57 <_resume_thread+0x52>
    1c42:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    1c45:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    1c48:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    1c4b:	8b 40 74             	mov    eax,DWORD PTR [eax+0x74]
    1c4e:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
    1c51:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
    1c55:	75 d8                	jne    1c2f <_resume_thread+0x2a>
    1c57:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1c5b:	75 07                	jne    1c64 <_resume_thread+0x5f>
    1c5d:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1c62:	eb 34                	jmp    1c98 <_resume_thread+0x93>
    1c64:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1c67:	8b 50 74             	mov    edx,DWORD PTR [eax+0x74]
    1c6a:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    1c6d:	89 50 74             	mov    DWORD PTR [eax+0x74],edx
    1c70:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1c73:	c7 40 74 00 00 00 00 	mov    DWORD PTR [eax+0x74],0x0
    1c7a:	8b 15 c0 65 00 00    	mov    edx,DWORD PTR ds:0x65c0
    1c80:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1c83:	89 50 70             	mov    DWORD PTR [eax+0x70],edx
    1c86:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1c89:	a3 c0 65 00 00       	mov    ds:0x65c0,eax
    1c8e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1c91:	c7 40 58 00 00 00 00 	mov    DWORD PTR [eax+0x58],0x0
    1c98:	c9                   	leave  
    1c99:	c3                   	ret    

00001c9a <_do_wake_up>:
    1c9a:	55                   	push   ebp
    1c9b:	89 e5                	mov    ebp,esp
    1c9d:	83 ec 18             	sub    esp,0x18
    1ca0:	a1 c4 65 00 00       	mov    eax,ds:0x65c4
    1ca5:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
    1ca8:	eb 2e                	jmp    1cd8 <_do_wake_up+0x3e>
    1caa:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    1cad:	8b 50 68             	mov    edx,DWORD PTR [eax+0x68]
    1cb0:	a1 04 60 00 00       	mov    eax,ds:0x6004
    1cb5:	39 c2                	cmp    edx,eax
    1cb7:	75 16                	jne    1ccf <_do_wake_up+0x35>
    1cb9:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    1cbc:	8b 40 5c             	mov    eax,DWORD PTR [eax+0x5c]
    1cbf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1cc3:	c7 04 24 c4 65 00 00 	mov    DWORD PTR [esp],0x65c4
    1cca:	e8 36 ff ff ff       	call   1c05 <_resume_thread>
    1ccf:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    1cd2:	8b 40 74             	mov    eax,DWORD PTR [eax+0x74]
    1cd5:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
    1cd8:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
    1cdc:	75 cc                	jne    1caa <_do_wake_up+0x10>
    1cde:	90                   	nop
    1cdf:	90                   	nop
    1ce0:	c9                   	leave  
    1ce1:	c3                   	ret    

00001ce2 <_schedule>:
    1ce2:	55                   	push   ebp
    1ce3:	89 e5                	mov    ebp,esp
    1ce5:	83 ec 28             	sub    esp,0x28
    1ce8:	a1 bc 65 00 00       	mov    eax,ds:0x65bc
    1ced:	8b 40 58             	mov    eax,DWORD PTR [eax+0x58]
    1cf0:	85 c0                	test   eax,eax
    1cf2:	75 10                	jne    1d04 <_schedule+0x22>
    1cf4:	a1 bc 65 00 00       	mov    eax,ds:0x65bc
    1cf9:	8b 50 60             	mov    edx,DWORD PTR [eax+0x60]
    1cfc:	83 ea 01             	sub    edx,0x1
    1cff:	89 50 60             	mov    DWORD PTR [eax+0x60],edx
    1d02:	eb 01                	jmp    1d05 <_schedule+0x23>
    1d04:	90                   	nop
    1d05:	a1 c0 65 00 00       	mov    eax,ds:0x65c0
    1d0a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1d0d:	a1 c0 65 00 00       	mov    eax,ds:0x65c0
    1d12:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1d15:	eb 1f                	jmp    1d36 <_schedule+0x54>
    1d17:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d1a:	8b 50 60             	mov    edx,DWORD PTR [eax+0x60]
    1d1d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1d20:	8b 40 60             	mov    eax,DWORD PTR [eax+0x60]
    1d23:	39 c2                	cmp    edx,eax
    1d25:	72 06                	jb     1d2d <_schedule+0x4b>
    1d27:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d2a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1d2d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d30:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1d33:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1d36:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1d3a:	75 db                	jne    1d17 <_schedule+0x35>
    1d3c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1d3f:	8b 40 60             	mov    eax,DWORD PTR [eax+0x60]
    1d42:	85 c0                	test   eax,eax
    1d44:	75 4d                	jne    1d93 <_schedule+0xb1>
    1d46:	a1 cc 65 00 00       	mov    eax,ds:0x65cc
    1d4b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1d4e:	eb 38                	jmp    1d88 <_schedule+0xa6>
    1d50:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d53:	8b 40 58             	mov    eax,DWORD PTR [eax+0x58]
    1d56:	83 f8 01             	cmp    eax,0x1
    1d59:	75 10                	jne    1d6b <_schedule+0x89>
    1d5b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d5e:	8b 40 60             	mov    eax,DWORD PTR [eax+0x60]
    1d61:	d1 e8                	shr    eax,1
    1d63:	89 c2                	mov    edx,eax
    1d65:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d68:	89 50 60             	mov    DWORD PTR [eax+0x60],edx
    1d6b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d6e:	8b 50 60             	mov    edx,DWORD PTR [eax+0x60]
    1d71:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d74:	8b 40 64             	mov    eax,DWORD PTR [eax+0x64]
    1d77:	01 c2                	add    edx,eax
    1d79:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d7c:	89 50 60             	mov    DWORD PTR [eax+0x60],edx
    1d7f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d82:	8b 40 6c             	mov    eax,DWORD PTR [eax+0x6c]
    1d85:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1d88:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1d8c:	75 c2                	jne    1d50 <_schedule+0x6e>
    1d8e:	e9 72 ff ff ff       	jmp    1d05 <_schedule+0x23>
    1d93:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1d96:	89 04 24             	mov    DWORD PTR [esp],eax
    1d99:	e8 92 1b 00 00       	call   3930 <_switch_to>
    1d9e:	90                   	nop
    1d9f:	c9                   	leave  
    1da0:	c3                   	ret    
    1da1:	90                   	nop
    1da2:	90                   	nop
    1da3:	90                   	nop

00001da4 <_init_clock>:
    1da4:	55                   	push   ebp
    1da5:	89 e5                	mov    ebp,esp
    1da7:	83 ec 28             	sub    esp,0x28
    1daa:	b8 dc 34 12 00       	mov    eax,0x1234dc
    1daf:	ba 00 00 00 00       	mov    edx,0x0
    1db4:	f7 75 08             	div    DWORD PTR [ebp+0x8]
    1db7:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1dba:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1dbd:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
    1dc0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1dc3:	c1 e8 08             	shr    eax,0x8
    1dc6:	88 45 f2             	mov    BYTE PTR [ebp-0xe],al
    1dc9:	c7 44 24 04 4a 1e 00 	mov    DWORD PTR [esp+0x4],0x1e4a
    1dd0:	00 
    1dd1:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
    1dd8:	e8 4f 15 00 00       	call   332c <_set_interrupt_handler>
    1ddd:	c7 44 24 04 36 00 00 	mov    DWORD PTR [esp+0x4],0x36
    1de4:	00 
    1de5:	c7 04 24 43 00 00 00 	mov    DWORD PTR [esp],0x43
    1dec:	e8 c9 1e 00 00       	call   3cba <_port_byte_out>
    1df1:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
    1df5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1df9:	c7 04 24 40 00 00 00 	mov    DWORD PTR [esp],0x40
    1e00:	e8 b5 1e 00 00       	call   3cba <_port_byte_out>
    1e05:	0f b6 45 f2          	movzx  eax,BYTE PTR [ebp-0xe]
    1e09:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1e0d:	c7 04 24 40 00 00 00 	mov    DWORD PTR [esp],0x40
    1e14:	e8 a1 1e 00 00       	call   3cba <_port_byte_out>
    1e19:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
    1e20:	e8 8b 1e 00 00       	call   3cb0 <_port_byte_in>
    1e25:	0f b6 c0             	movzx  eax,al
    1e28:	25 fe 00 00 00       	and    eax,0xfe
    1e2d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1e31:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
    1e38:	e8 7d 1e 00 00       	call   3cba <_port_byte_out>
    1e3d:	90                   	nop
    1e3e:	c9                   	leave  
    1e3f:	c3                   	ret    

00001e40 <_sys_get_tick>:
    1e40:	55                   	push   ebp
    1e41:	89 e5                	mov    ebp,esp
    1e43:	a1 04 60 00 00       	mov    eax,ds:0x6004
    1e48:	5d                   	pop    ebp
    1e49:	c3                   	ret    

00001e4a <_do_timer>:
    1e4a:	55                   	push   ebp
    1e4b:	89 e5                	mov    ebp,esp
    1e4d:	83 ec 08             	sub    esp,0x8
    1e50:	a1 04 60 00 00       	mov    eax,ds:0x6004
    1e55:	83 c0 01             	add    eax,0x1
    1e58:	a3 04 60 00 00       	mov    ds:0x6004,eax
    1e5d:	e8 80 fe ff ff       	call   1ce2 <_schedule>
    1e62:	90                   	nop
    1e63:	c9                   	leave  
    1e64:	c3                   	ret    
    1e65:	90                   	nop
    1e66:	90                   	nop
    1e67:	90                   	nop

00001e68 <_get_system_time>:
    1e68:	55                   	push   ebp
    1e69:	89 e5                	mov    ebp,esp
    1e6b:	83 ec 18             	sub    esp,0x18
    1e6e:	c7 04 24 09 00 00 00 	mov    DWORD PTR [esp],0x9
    1e75:	e8 a4 00 00 00       	call   1f1e <_cmos_read>
    1e7a:	0f b6 c0             	movzx  eax,al
    1e7d:	89 04 24             	mov    DWORD PTR [esp],eax
    1e80:	e8 cd 00 00 00       	call   1f52 <_bcd_to_binary>
    1e85:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1e88:	88 02                	mov    BYTE PTR [edx],al
    1e8a:	c7 04 24 08 00 00 00 	mov    DWORD PTR [esp],0x8
    1e91:	e8 88 00 00 00       	call   1f1e <_cmos_read>
    1e96:	0f b6 c0             	movzx  eax,al
    1e99:	89 04 24             	mov    DWORD PTR [esp],eax
    1e9c:	e8 b1 00 00 00       	call   1f52 <_bcd_to_binary>
    1ea1:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1ea4:	88 42 01             	mov    BYTE PTR [edx+0x1],al
    1ea7:	c7 04 24 07 00 00 00 	mov    DWORD PTR [esp],0x7
    1eae:	e8 6b 00 00 00       	call   1f1e <_cmos_read>
    1eb3:	0f b6 c0             	movzx  eax,al
    1eb6:	89 04 24             	mov    DWORD PTR [esp],eax
    1eb9:	e8 94 00 00 00       	call   1f52 <_bcd_to_binary>
    1ebe:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1ec1:	88 42 02             	mov    BYTE PTR [edx+0x2],al
    1ec4:	c7 04 24 04 00 00 00 	mov    DWORD PTR [esp],0x4
    1ecb:	e8 4e 00 00 00       	call   1f1e <_cmos_read>
    1ed0:	0f b6 c0             	movzx  eax,al
    1ed3:	89 04 24             	mov    DWORD PTR [esp],eax
    1ed6:	e8 77 00 00 00       	call   1f52 <_bcd_to_binary>
    1edb:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1ede:	88 42 03             	mov    BYTE PTR [edx+0x3],al
    1ee1:	c7 04 24 02 00 00 00 	mov    DWORD PTR [esp],0x2
    1ee8:	e8 31 00 00 00       	call   1f1e <_cmos_read>
    1eed:	0f b6 c0             	movzx  eax,al
    1ef0:	89 04 24             	mov    DWORD PTR [esp],eax
    1ef3:	e8 5a 00 00 00       	call   1f52 <_bcd_to_binary>
    1ef8:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1efb:	88 42 04             	mov    BYTE PTR [edx+0x4],al
    1efe:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1f05:	e8 14 00 00 00       	call   1f1e <_cmos_read>
    1f0a:	0f b6 c0             	movzx  eax,al
    1f0d:	89 04 24             	mov    DWORD PTR [esp],eax
    1f10:	e8 3d 00 00 00       	call   1f52 <_bcd_to_binary>
    1f15:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1f18:	88 42 05             	mov    BYTE PTR [edx+0x5],al
    1f1b:	90                   	nop
    1f1c:	c9                   	leave  
    1f1d:	c3                   	ret    

00001f1e <_cmos_read>:
    1f1e:	55                   	push   ebp
    1f1f:	89 e5                	mov    ebp,esp
    1f21:	83 ec 28             	sub    esp,0x28
    1f24:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f27:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
    1f2a:	0f b6 45 f4          	movzx  eax,BYTE PTR [ebp-0xc]
    1f2e:	83 c8 80             	or     eax,0xffffff80
    1f31:	0f b6 c0             	movzx  eax,al
    1f34:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1f38:	c7 04 24 70 00 00 00 	mov    DWORD PTR [esp],0x70
    1f3f:	e8 76 1d 00 00       	call   3cba <_port_byte_out>
    1f44:	c7 04 24 71 00 00 00 	mov    DWORD PTR [esp],0x71
    1f4b:	e8 60 1d 00 00       	call   3cb0 <_port_byte_in>
    1f50:	c9                   	leave  
    1f51:	c3                   	ret    

00001f52 <_bcd_to_binary>:
    1f52:	55                   	push   ebp
    1f53:	89 e5                	mov    ebp,esp
    1f55:	83 ec 04             	sub    esp,0x4
    1f58:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f5b:	88 45 fc             	mov    BYTE PTR [ebp-0x4],al
    1f5e:	0f b6 45 fc          	movzx  eax,BYTE PTR [ebp-0x4]
    1f62:	c0 e8 04             	shr    al,0x4
    1f65:	89 c2                	mov    edx,eax
    1f67:	89 d0                	mov    eax,edx
    1f69:	c1 e0 02             	shl    eax,0x2
    1f6c:	01 d0                	add    eax,edx
    1f6e:	01 c0                	add    eax,eax
    1f70:	89 c2                	mov    edx,eax
    1f72:	0f b6 45 fc          	movzx  eax,BYTE PTR [ebp-0x4]
    1f76:	83 e0 0f             	and    eax,0xf
    1f79:	01 d0                	add    eax,edx
    1f7b:	c9                   	leave  
    1f7c:	c3                   	ret    
    1f7d:	90                   	nop
    1f7e:	90                   	nop
    1f7f:	90                   	nop

00001f80 <_keyboard_callback>:
    1f80:	55                   	push   ebp
    1f81:	89 e5                	mov    ebp,esp
    1f83:	83 ec 28             	sub    esp,0x28
    1f86:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
    1f8d:	e8 1e 1d 00 00       	call   3cb0 <_port_byte_in>
    1f92:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
    1f95:	80 7d f7 39          	cmp    BYTE PTR [ebp-0x9],0x39
    1f99:	77 40                	ja     1fdb <_keyboard_callback+0x5b>
    1f9b:	80 7d f7 0e          	cmp    BYTE PTR [ebp-0x9],0xe
    1f9f:	75 0e                	jne    1faf <_keyboard_callback+0x2f>
    1fa1:	c7 04 24 08 00 00 00 	mov    DWORD PTR [esp],0x8
    1fa8:	e8 e8 06 00 00       	call   2695 <_kputchar>
    1fad:	eb 2d                	jmp    1fdc <_keyboard_callback+0x5c>
    1faf:	80 7d f7 1c          	cmp    BYTE PTR [ebp-0x9],0x1c
    1fb3:	75 0e                	jne    1fc3 <_keyboard_callback+0x43>
    1fb5:	c7 04 24 ba 41 00 00 	mov    DWORD PTR [esp],0x41ba
    1fbc:	e8 6f 04 00 00       	call   2430 <_kprint>
    1fc1:	eb 19                	jmp    1fdc <_keyboard_callback+0x5c>
    1fc3:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    1fc7:	0f b6 80 80 41 00 00 	movzx  eax,BYTE PTR [eax+0x4180]
    1fce:	0f be c0             	movsx  eax,al
    1fd1:	89 04 24             	mov    DWORD PTR [esp],eax
    1fd4:	e8 bc 06 00 00       	call   2695 <_kputchar>
    1fd9:	eb 01                	jmp    1fdc <_keyboard_callback+0x5c>
    1fdb:	90                   	nop
    1fdc:	c9                   	leave  
    1fdd:	c3                   	ret    

00001fde <_init_keyboard>:
    1fde:	55                   	push   ebp
    1fdf:	89 e5                	mov    ebp,esp
    1fe1:	83 ec 18             	sub    esp,0x18
    1fe4:	c7 44 24 04 80 1f 00 	mov    DWORD PTR [esp+0x4],0x1f80
    1feb:	00 
    1fec:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
    1ff3:	e8 34 13 00 00       	call   332c <_set_interrupt_handler>
    1ff8:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
    1fff:	e8 ac 1c 00 00       	call   3cb0 <_port_byte_in>
    2004:	0f b6 c0             	movzx  eax,al
    2007:	25 fd 00 00 00       	and    eax,0xfd
    200c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2010:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
    2017:	e8 9e 1c 00 00       	call   3cba <_port_byte_out>
    201c:	90                   	nop
    201d:	c9                   	leave  
    201e:	c3                   	ret    
    201f:	90                   	nop

00002020 <_init_apm>:
    2020:	55                   	push   ebp
    2021:	89 e5                	mov    ebp,esp
    2023:	83 ec 18             	sub    esp,0x18
    2026:	0f b6 05 02 05 00 00 	movzx  eax,BYTE PTR ds:0x502
    202d:	84 c0                	test   al,al
    202f:	74 4f                	je     2080 <_init_apm+0x60>
    2031:	c7 04 24 8a 43 00 00 	mov    DWORD PTR [esp],0x438a
    2038:	e8 08 06 00 00       	call   2645 <_kprintf>
    203d:	0f b6 05 02 05 00 00 	movzx  eax,BYTE PTR ds:0x502
    2044:	0f b6 c0             	movzx  eax,al
    2047:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    204b:	c7 04 24 a5 43 00 00 	mov    DWORD PTR [esp],0x43a5
    2052:	e8 ee 05 00 00       	call   2645 <_kprintf>
    2057:	0f b6 05 02 05 00 00 	movzx  eax,BYTE PTR ds:0x502
    205e:	0f b6 c0             	movzx  eax,al
    2061:	83 e8 01             	sub    eax,0x1
    2064:	8b 04 85 20 3f 00 00 	mov    eax,DWORD PTR [eax*4+0x3f20]
    206b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    206f:	c7 04 24 b5 43 00 00 	mov    DWORD PTR [esp],0x43b5
    2076:	e8 ca 05 00 00       	call   2645 <_kprintf>
    207b:	e9 da 00 00 00       	jmp    215a <_init_apm+0x13a>
    2080:	0f b7 05 00 05 00 00 	movzx  eax,WORD PTR ds:0x500
    2087:	0f b7 c0             	movzx  eax,ax
    208a:	c1 e0 04             	shl    eax,0x4
    208d:	c7 44 24 0c 04 00 00 	mov    DWORD PTR [esp+0xc],0x4
    2094:	00 
    2095:	c7 44 24 08 9a 00 00 	mov    DWORD PTR [esp+0x8],0x9a
    209c:	00 
    209d:	c7 44 24 04 00 00 01 	mov    DWORD PTR [esp+0x4],0x10000
    20a4:	00 
    20a5:	89 04 24             	mov    DWORD PTR [esp],eax
    20a8:	e8 86 09 00 00       	call   2a33 <_add_global_descriptor>
    20ad:	66 a3 10 05 00 00    	mov    ds:0x510,ax
    20b3:	0f b7 05 08 05 00 00 	movzx  eax,WORD PTR ds:0x508
    20ba:	0f b7 c0             	movzx  eax,ax
    20bd:	c1 e0 04             	shl    eax,0x4
    20c0:	c7 44 24 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    20c7:	00 
    20c8:	c7 44 24 08 9a 00 00 	mov    DWORD PTR [esp+0x8],0x9a
    20cf:	00 
    20d0:	c7 44 24 04 00 00 01 	mov    DWORD PTR [esp+0x4],0x10000
    20d7:	00 
    20d8:	89 04 24             	mov    DWORD PTR [esp],eax
    20db:	e8 53 09 00 00       	call   2a33 <_add_global_descriptor>
    20e0:	66 a3 12 05 00 00    	mov    ds:0x512,ax
    20e6:	0f b7 05 0c 05 00 00 	movzx  eax,WORD PTR ds:0x50c
    20ed:	0f b7 c0             	movzx  eax,ax
    20f0:	c1 e0 04             	shl    eax,0x4
    20f3:	c7 44 24 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    20fa:	00 
    20fb:	c7 44 24 08 92 00 00 	mov    DWORD PTR [esp+0x8],0x92
    2102:	00 
    2103:	c7 44 24 04 00 00 01 	mov    DWORD PTR [esp+0x4],0x10000
    210a:	00 
    210b:	89 04 24             	mov    DWORD PTR [esp],eax
    210e:	e8 20 09 00 00       	call   2a33 <_add_global_descriptor>
    2113:	66 a3 14 05 00 00    	mov    ds:0x514,ax
    2119:	8b 15 04 05 00 00    	mov    edx,DWORD PTR ds:0x504
    211f:	0f b7 05 10 05 00 00 	movzx  eax,WORD PTR ds:0x510
    2126:	0f b7 c0             	movzx  eax,ax
    2129:	c7 44 24 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    2130:	00 
    2131:	c7 44 24 08 8c 00 00 	mov    DWORD PTR [esp+0x8],0x8c
    2138:	00 
    2139:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    213d:	89 04 24             	mov    DWORD PTR [esp],eax
    2140:	e8 60 0a 00 00       	call   2ba5 <_add_gate_descriptor>
    2145:	66 a3 16 05 00 00    	mov    ds:0x516,ax
    214b:	ba 85 3d 00 00       	mov    edx,0x3d85
    2150:	0f b7 05 16 05 00 00 	movzx  eax,WORD PTR ds:0x516
    2157:	66 89 02             	mov    WORD PTR [edx],ax
    215a:	c9                   	leave  
    215b:	c3                   	ret    

0000215c <_pciConfigReadWord>:
    215c:	55                   	push   ebp
    215d:	89 e5                	mov    ebp,esp
    215f:	53                   	push   ebx
    2160:	83 ec 44             	sub    esp,0x44
    2163:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
    2166:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
    2169:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    216c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    216f:	88 5d d4             	mov    BYTE PTR [ebp-0x2c],bl
    2172:	88 4d d0             	mov    BYTE PTR [ebp-0x30],cl
    2175:	88 55 cc             	mov    BYTE PTR [ebp-0x34],dl
    2178:	88 45 c8             	mov    BYTE PTR [ebp-0x38],al
    217b:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
    217f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    2182:	0f b6 45 d0          	movzx  eax,BYTE PTR [ebp-0x30]
    2186:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    2189:	0f b6 45 cc          	movzx  eax,BYTE PTR [ebp-0x34]
    218d:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    2190:	66 c7 45 ea 00 00    	mov    WORD PTR [ebp-0x16],0x0
    2196:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2199:	c1 e0 10             	shl    eax,0x10
    219c:	89 c2                	mov    edx,eax
    219e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    21a1:	c1 e0 0b             	shl    eax,0xb
    21a4:	09 c2                	or     edx,eax
    21a6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    21a9:	c1 e0 08             	shl    eax,0x8
    21ac:	09 c2                	or     edx,eax
    21ae:	0f b6 45 c8          	movzx  eax,BYTE PTR [ebp-0x38]
    21b2:	25 fc 00 00 00       	and    eax,0xfc
    21b7:	09 d0                	or     eax,edx
    21b9:	0d 00 00 00 80       	or     eax,0x80000000
    21be:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    21c1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    21c4:	0f b7 c0             	movzx  eax,ax
    21c7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    21cb:	c7 04 24 f8 0c 00 00 	mov    DWORD PTR [esp],0xcf8
    21d2:	e8 f9 1a 00 00       	call   3cd0 <_port_word_out>
    21d7:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    21de:	e8 e2 1a 00 00       	call   3cc5 <_port_word_in>
    21e3:	0f b7 d0             	movzx  edx,ax
    21e6:	0f b6 45 c8          	movzx  eax,BYTE PTR [ebp-0x38]
    21ea:	83 e0 02             	and    eax,0x2
    21ed:	c1 e0 03             	shl    eax,0x3
    21f0:	89 c1                	mov    ecx,eax
    21f2:	d3 fa                	sar    edx,cl
    21f4:	89 d0                	mov    eax,edx
    21f6:	66 89 45 ea          	mov    WORD PTR [ebp-0x16],ax
    21fa:	0f b7 45 ea          	movzx  eax,WORD PTR [ebp-0x16]
    21fe:	83 c4 44             	add    esp,0x44
    2201:	5b                   	pop    ebx
    2202:	5d                   	pop    ebp
    2203:	c3                   	ret    

00002204 <_checkAllBuses>:
    2204:	55                   	push   ebp
    2205:	89 e5                	mov    ebp,esp
    2207:	83 ec 28             	sub    esp,0x28
    220a:	66 c7 45 f6 00 00    	mov    WORD PTR [ebp-0xa],0x0
    2210:	e9 f3 00 00 00       	jmp    2308 <_checkAllBuses+0x104>
    2215:	c6 45 f5 00          	mov    BYTE PTR [ebp-0xb],0x0
    2219:	e9 d5 00 00 00       	jmp    22f3 <_checkAllBuses+0xef>
    221e:	0f b6 55 f5          	movzx  edx,BYTE PTR [ebp-0xb]
    2222:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    2226:	0f b6 c0             	movzx  eax,al
    2229:	c7 44 24 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    2230:	00 
    2231:	c7 44 24 08 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    2238:	00 
    2239:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    223d:	89 04 24             	mov    DWORD PTR [esp],eax
    2240:	e8 17 ff ff ff       	call   215c <_pciConfigReadWord>
    2245:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
    2248:	0f b6 55 f5          	movzx  edx,BYTE PTR [ebp-0xb]
    224c:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    2250:	0f b6 c0             	movzx  eax,al
    2253:	c7 44 24 0c 02 00 00 	mov    DWORD PTR [esp+0xc],0x2
    225a:	00 
    225b:	c7 44 24 08 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    2262:	00 
    2263:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2267:	89 04 24             	mov    DWORD PTR [esp],eax
    226a:	e8 ed fe ff ff       	call   215c <_pciConfigReadWord>
    226f:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
    2272:	0f b6 55 f5          	movzx  edx,BYTE PTR [ebp-0xb]
    2276:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    227a:	0f b6 c0             	movzx  eax,al
    227d:	c7 44 24 0c 0a 00 00 	mov    DWORD PTR [esp+0xc],0xa
    2284:	00 
    2285:	c7 44 24 08 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    228c:	00 
    228d:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2291:	89 04 24             	mov    DWORD PTR [esp],eax
    2294:	e8 c3 fe ff ff       	call   215c <_pciConfigReadWord>
    2299:	66 89 45 f0          	mov    WORD PTR [ebp-0x10],ax
    229d:	0f b6 45 f4          	movzx  eax,BYTE PTR [ebp-0xc]
    22a1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    22a5:	c7 04 24 cc 43 00 00 	mov    DWORD PTR [esp],0x43cc
    22ac:	e8 94 03 00 00       	call   2645 <_kprintf>
    22b1:	0f b6 4d f3          	movzx  ecx,BYTE PTR [ebp-0xd]
    22b5:	0f b6 55 f5          	movzx  edx,BYTE PTR [ebp-0xb]
    22b9:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    22bd:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    22c1:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    22c5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    22c9:	c7 04 24 dc 43 00 00 	mov    DWORD PTR [esp],0x43dc
    22d0:	e8 70 03 00 00       	call   2645 <_kprintf>
    22d5:	0f b7 45 f0          	movzx  eax,WORD PTR [ebp-0x10]
    22d9:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    22dd:	c7 04 24 fd 43 00 00 	mov    DWORD PTR [esp],0x43fd
    22e4:	e8 5c 03 00 00       	call   2645 <_kprintf>
    22e9:	0f b6 45 f5          	movzx  eax,BYTE PTR [ebp-0xb]
    22ed:	83 c0 01             	add    eax,0x1
    22f0:	88 45 f5             	mov    BYTE PTR [ebp-0xb],al
    22f3:	80 7d f5 1f          	cmp    BYTE PTR [ebp-0xb],0x1f
    22f7:	0f 86 21 ff ff ff    	jbe    221e <_checkAllBuses+0x1a>
    22fd:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    2301:	83 c0 01             	add    eax,0x1
    2304:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
    2308:	66 81 7d f6 ff 00    	cmp    WORD PTR [ebp-0xa],0xff
    230e:	0f 86 01 ff ff ff    	jbe    2215 <_checkAllBuses+0x11>
    2314:	90                   	nop
    2315:	90                   	nop
    2316:	c9                   	leave  
    2317:	c3                   	ret    

00002318 <_init_screen>:
    2318:	55                   	push   ebp
    2319:	89 e5                	mov    ebp,esp
    231b:	90                   	nop
    231c:	5d                   	pop    ebp
    231d:	c3                   	ret    

0000231e <_get_cursor_offset>:
    231e:	55                   	push   ebp
    231f:	89 e5                	mov    ebp,esp
    2321:	83 ec 28             	sub    esp,0x28
    2324:	c7 44 24 04 0e 00 00 	mov    DWORD PTR [esp+0x4],0xe
    232b:	00 
    232c:	c7 04 24 d4 03 00 00 	mov    DWORD PTR [esp],0x3d4
    2333:	e8 82 19 00 00       	call   3cba <_port_byte_out>
    2338:	c7 04 24 d5 03 00 00 	mov    DWORD PTR [esp],0x3d5
    233f:	e8 6c 19 00 00       	call   3cb0 <_port_byte_in>
    2344:	0f b6 c0             	movzx  eax,al
    2347:	c1 e0 08             	shl    eax,0x8
    234a:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
    234e:	c7 44 24 04 0f 00 00 	mov    DWORD PTR [esp+0x4],0xf
    2355:	00 
    2356:	c7 04 24 d4 03 00 00 	mov    DWORD PTR [esp],0x3d4
    235d:	e8 58 19 00 00       	call   3cba <_port_byte_out>
    2362:	c7 04 24 d5 03 00 00 	mov    DWORD PTR [esp],0x3d5
    2369:	e8 42 19 00 00       	call   3cb0 <_port_byte_in>
    236e:	0f b6 c0             	movzx  eax,al
    2371:	66 09 45 f6          	or     WORD PTR [ebp-0xa],ax
    2375:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    2379:	01 c0                	add    eax,eax
    237b:	c9                   	leave  
    237c:	c3                   	ret    

0000237d <_set_cursor_offset>:
    237d:	55                   	push   ebp
    237e:	89 e5                	mov    ebp,esp
    2380:	83 ec 28             	sub    esp,0x28
    2383:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2386:	66 89 45 f4          	mov    WORD PTR [ebp-0xc],ax
    238a:	66 d1 6d f4          	shr    WORD PTR [ebp-0xc],1
    238e:	c7 44 24 04 0e 00 00 	mov    DWORD PTR [esp+0x4],0xe
    2395:	00 
    2396:	c7 04 24 d4 03 00 00 	mov    DWORD PTR [esp],0x3d4
    239d:	e8 18 19 00 00       	call   3cba <_port_byte_out>
    23a2:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    23a6:	66 c1 e8 08          	shr    ax,0x8
    23aa:	0f b6 c0             	movzx  eax,al
    23ad:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    23b1:	c7 04 24 d5 03 00 00 	mov    DWORD PTR [esp],0x3d5
    23b8:	e8 fd 18 00 00       	call   3cba <_port_byte_out>
    23bd:	c7 44 24 04 0f 00 00 	mov    DWORD PTR [esp+0x4],0xf
    23c4:	00 
    23c5:	c7 04 24 d4 03 00 00 	mov    DWORD PTR [esp],0x3d4
    23cc:	e8 e9 18 00 00       	call   3cba <_port_byte_out>
    23d1:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    23d5:	0f b6 c0             	movzx  eax,al
    23d8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    23dc:	c7 04 24 d5 03 00 00 	mov    DWORD PTR [esp],0x3d5
    23e3:	e8 d2 18 00 00       	call   3cba <_port_byte_out>
    23e8:	90                   	nop
    23e9:	c9                   	leave  
    23ea:	c3                   	ret    

000023eb <_clear_screen>:
    23eb:	55                   	push   ebp
    23ec:	89 e5                	mov    ebp,esp
    23ee:	83 ec 28             	sub    esp,0x28
    23f1:	c7 45 ec a0 0f 00 00 	mov    DWORD PTR [ebp-0x14],0xfa0
    23f8:	c7 45 f0 00 80 0b 00 	mov    DWORD PTR [ebp-0x10],0xb8000
    23ff:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    2406:	eb 11                	jmp    2419 <_clear_screen+0x2e>
    2408:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    240b:	c7 00 00 07 00 07    	mov    DWORD PTR [eax],0x7000700
    2411:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    2415:	83 45 f0 04          	add    DWORD PTR [ebp-0x10],0x4
    2419:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    241c:	3b 45 ec             	cmp    eax,DWORD PTR [ebp-0x14]
    241f:	7c e7                	jl     2408 <_clear_screen+0x1d>
    2421:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2428:	e8 50 ff ff ff       	call   237d <_set_cursor_offset>
    242d:	90                   	nop
    242e:	c9                   	leave  
    242f:	c3                   	ret    

00002430 <_kprint>:
    2430:	55                   	push   ebp
    2431:	89 e5                	mov    ebp,esp
    2433:	83 ec 38             	sub    esp,0x38
    2436:	e8 e3 fe ff ff       	call   231e <_get_cursor_offset>
    243b:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
    243f:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    2443:	05 00 80 0b 00       	add    eax,0xb8000
    2448:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    244b:	c6 45 ef 00          	mov    BYTE PTR [ebp-0x11],0x0
    244f:	e9 7f 01 00 00       	jmp    25d3 <_kprint+0x1a3>
    2454:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2457:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    245a:	3c 0a                	cmp    al,0xa
    245c:	75 41                	jne    249f <_kprint+0x6f>
    245e:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    2462:	0f b7 c0             	movzx  eax,ax
    2465:	69 c0 cd cc 00 00    	imul   eax,eax,0xcccd
    246b:	c1 e8 10             	shr    eax,0x10
    246e:	66 c1 e8 07          	shr    ax,0x7
    2472:	88 45 ee             	mov    BYTE PTR [ebp-0x12],al
    2475:	0f b6 45 ee          	movzx  eax,BYTE PTR [ebp-0x12]
    2479:	83 c0 01             	add    eax,0x1
    247c:	89 c2                	mov    edx,eax
    247e:	89 d0                	mov    eax,edx
    2480:	c1 e0 02             	shl    eax,0x2
    2483:	01 d0                	add    eax,edx
    2485:	c1 e0 04             	shl    eax,0x4
    2488:	01 c0                	add    eax,eax
    248a:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
    248e:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    2492:	83 e8 02             	sub    eax,0x2
    2495:	05 00 80 0b 00       	add    eax,0xb8000
    249a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    249d:	eb 6e                	jmp    250d <_kprint+0xdd>
    249f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    24a2:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    24a5:	3c 08                	cmp    al,0x8
    24a7:	75 5b                	jne    2504 <_kprint+0xd4>
    24a9:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    24ad:	0f b7 c0             	movzx  eax,ax
    24b0:	69 c0 cd cc 00 00    	imul   eax,eax,0xcccd
    24b6:	c1 e8 10             	shr    eax,0x10
    24b9:	66 c1 e8 07          	shr    ax,0x7
    24bd:	88 45 ee             	mov    BYTE PTR [ebp-0x12],al
    24c0:	83 6d f0 02          	sub    DWORD PTR [ebp-0x10],0x2
    24c4:	66 83 6d f6 02       	sub    WORD PTR [ebp-0xa],0x2
    24c9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    24cc:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    24cf:	84 c0                	test   al,al
    24d1:	75 09                	jne    24dc <_kprint+0xac>
    24d3:	81 7d f0 00 80 0b 00 	cmp    DWORD PTR [ebp-0x10],0xb8000
    24da:	77 e4                	ja     24c0 <_kprint+0x90>
    24dc:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    24e0:	0f b7 c0             	movzx  eax,ax
    24e3:	69 c0 cd cc 00 00    	imul   eax,eax,0xcccd
    24e9:	c1 e8 10             	shr    eax,0x10
    24ec:	66 c1 e8 07          	shr    ax,0x7
    24f0:	38 45 ee             	cmp    BYTE PTR [ebp-0x12],al
    24f3:	75 08                	jne    24fd <_kprint+0xcd>
    24f5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    24f8:	c6 00 00             	mov    BYTE PTR [eax],0x0
    24fb:	eb 10                	jmp    250d <_kprint+0xdd>
    24fd:	66 83 45 f6 02       	add    WORD PTR [ebp-0xa],0x2
    2502:	eb 09                	jmp    250d <_kprint+0xdd>
    2504:	66 83 45 f6 02       	add    WORD PTR [ebp-0xa],0x2
    2509:	c6 45 ef 01          	mov    BYTE PTR [ebp-0x11],0x1
    250d:	66 81 7d f6 9f 0f    	cmp    WORD PTR [ebp-0xa],0xf9f
    2513:	0f 86 92 00 00 00    	jbe    25ab <_kprint+0x17b>
    2519:	c7 45 e8 a0 8f 0b 00 	mov    DWORD PTR [ebp-0x18],0xb8fa0
    2520:	c7 44 24 08 50 00 00 	mov    DWORD PTR [esp+0x8],0x50
    2527:	00 
    2528:	c7 44 24 04 00 07 00 	mov    DWORD PTR [esp+0x4],0x700
    252f:	00 
    2530:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2533:	89 04 24             	mov    DWORD PTR [esp],eax
    2536:	e8 75 14 00 00       	call   39b0 <_memset_w>
    253b:	66 81 7d f6 a0 0f    	cmp    WORD PTR [ebp-0xa],0xfa0
    2541:	74 0c                	je     254f <_kprint+0x11f>
    2543:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    2547:	83 c0 60             	add    eax,0x60
    254a:	0f b6 c0             	movzx  eax,al
    254d:	eb 05                	jmp    2554 <_kprint+0x124>
    254f:	b8 01 00 00 00       	mov    eax,0x1
    2554:	89 04 24             	mov    DWORD PTR [esp],eax
    2557:	e8 94 00 00 00       	call   25f0 <_scroll_screen>
    255c:	0f b7 4d f6          	movzx  ecx,WORD PTR [ebp-0xa]
    2560:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    2564:	0f b7 c0             	movzx  eax,ax
    2567:	69 c0 cd cc 00 00    	imul   eax,eax,0xcccd
    256d:	c1 e8 10             	shr    eax,0x10
    2570:	66 c1 e8 07          	shr    ax,0x7
    2574:	0f b6 d0             	movzx  edx,al
    2577:	89 d0                	mov    eax,edx
    2579:	c1 e0 02             	shl    eax,0x2
    257c:	01 d0                	add    eax,edx
    257e:	c1 e0 04             	shl    eax,0x4
    2581:	01 c0                	add    eax,eax
    2583:	29 c1                	sub    ecx,eax
    2585:	89 c8                	mov    eax,ecx
    2587:	d1 f8                	sar    eax,1
    2589:	88 45 e7             	mov    BYTE PTR [ebp-0x19],al
    258c:	0f b6 45 e7          	movzx  eax,BYTE PTR [ebp-0x19]
    2590:	66 05 7f 07          	add    ax,0x77f
    2594:	01 c0                	add    eax,eax
    2596:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
    259a:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    259e:	05 00 80 0b 00       	add    eax,0xb8000
    25a3:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    25a6:	66 83 45 f6 02       	add    WORD PTR [ebp-0xa],0x2
    25ab:	80 7d ef 00          	cmp    BYTE PTR [ebp-0x11],0x0
    25af:	74 1a                	je     25cb <_kprint+0x19b>
    25b1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25b4:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    25b7:	89 c2                	mov    edx,eax
    25b9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    25bc:	88 10                	mov    BYTE PTR [eax],dl
    25be:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    25c1:	83 c0 01             	add    eax,0x1
    25c4:	c6 00 07             	mov    BYTE PTR [eax],0x7
    25c7:	c6 45 ef 00          	mov    BYTE PTR [ebp-0x11],0x0
    25cb:	83 45 f0 02          	add    DWORD PTR [ebp-0x10],0x2
    25cf:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
    25d3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25d6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    25d9:	84 c0                	test   al,al
    25db:	0f 85 73 fe ff ff    	jne    2454 <_kprint+0x24>
    25e1:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    25e5:	89 04 24             	mov    DWORD PTR [esp],eax
    25e8:	e8 90 fd ff ff       	call   237d <_set_cursor_offset>
    25ed:	90                   	nop
    25ee:	c9                   	leave  
    25ef:	c3                   	ret    

000025f0 <_scroll_screen>:
    25f0:	55                   	push   ebp
    25f1:	89 e5                	mov    ebp,esp
    25f3:	83 ec 38             	sub    esp,0x38
    25f6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25f9:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
    25fc:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
    2600:	3c a0                	cmp    al,0xa0
    2602:	0f 93 c0             	setae  al
    2605:	83 c0 01             	add    eax,0x1
    2608:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
    260b:	c7 45 f0 00 80 0b 00 	mov    DWORD PTR [ebp-0x10],0xb8000
    2612:	0f b6 55 f7          	movzx  edx,BYTE PTR [ebp-0x9]
    2616:	89 d0                	mov    eax,edx
    2618:	c1 e0 02             	shl    eax,0x2
    261b:	01 d0                	add    eax,edx
    261d:	c1 e0 05             	shl    eax,0x5
    2620:	05 00 80 0b 00       	add    eax,0xb8000
    2625:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    2628:	c7 44 24 08 a0 0f 00 	mov    DWORD PTR [esp+0x8],0xfa0
    262f:	00 
    2630:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2633:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2637:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    263a:	89 04 24             	mov    DWORD PTR [esp],eax
    263d:	e8 ce 12 00 00       	call   3910 <_memcpy>
    2642:	90                   	nop
    2643:	c9                   	leave  
    2644:	c3                   	ret    

00002645 <_kprintf>:
    2645:	55                   	push   ebp
    2646:	89 e5                	mov    ebp,esp
    2648:	81 ec a8 00 00 00    	sub    esp,0xa8
    264e:	8d 45 0c             	lea    eax,[ebp+0xc]
    2651:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    2654:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2657:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    265a:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    265e:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2662:	c7 44 24 04 80 00 00 	mov    DWORD PTR [esp+0x4],0x80
    2669:	00 
    266a:	8d 85 70 ff ff ff    	lea    eax,[ebp-0x90]
    2670:	89 04 24             	mov    DWORD PTR [esp],eax
    2673:	e8 01 0f 00 00       	call   3579 <_vsnprintf>
    2678:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    267b:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    2682:	8d 85 70 ff ff ff    	lea    eax,[ebp-0x90]
    2688:	89 04 24             	mov    DWORD PTR [esp],eax
    268b:	e8 a0 fd ff ff       	call   2430 <_kprint>
    2690:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2693:	c9                   	leave  
    2694:	c3                   	ret    

00002695 <_kputchar>:
    2695:	55                   	push   ebp
    2696:	89 e5                	mov    ebp,esp
    2698:	83 ec 28             	sub    esp,0x28
    269b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    269e:	88 45 f6             	mov    BYTE PTR [ebp-0xa],al
    26a1:	c6 45 f7 00          	mov    BYTE PTR [ebp-0x9],0x0
    26a5:	8d 45 f6             	lea    eax,[ebp-0xa]
    26a8:	89 04 24             	mov    DWORD PTR [esp],eax
    26ab:	e8 80 fd ff ff       	call   2430 <_kprint>
    26b0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    26b3:	c9                   	leave  
    26b4:	c3                   	ret    
    26b5:	90                   	nop
    26b6:	90                   	nop
    26b7:	90                   	nop

000026b8 <_init_hd>:
    26b8:	55                   	push   ebp
    26b9:	89 e5                	mov    ebp,esp
    26bb:	83 ec 18             	sub    esp,0x18
    26be:	c7 05 08 60 00 00 00 	mov    DWORD PTR ds:0x6008,0x0
    26c5:	00 00 00 
    26c8:	c7 44 24 04 c8 29 00 	mov    DWORD PTR [esp+0x4],0x29c8
    26cf:	00 
    26d0:	c7 04 24 2e 00 00 00 	mov    DWORD PTR [esp],0x2e
    26d7:	e8 50 0c 00 00       	call   332c <_set_interrupt_handler>
    26dc:	c7 04 24 a1 00 00 00 	mov    DWORD PTR [esp],0xa1
    26e3:	e8 c8 15 00 00       	call   3cb0 <_port_byte_in>
    26e8:	0f b6 c0             	movzx  eax,al
    26eb:	25 bf 00 00 00       	and    eax,0xbf
    26f0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    26f4:	c7 04 24 a1 00 00 00 	mov    DWORD PTR [esp],0xa1
    26fb:	e8 ba 15 00 00       	call   3cba <_port_byte_out>
    2700:	90                   	nop
    2701:	c9                   	leave  
    2702:	c3                   	ret    

00002703 <_pio_hd_read_sector>:
    2703:	55                   	push   ebp
    2704:	89 e5                	mov    ebp,esp
    2706:	57                   	push   edi
    2707:	56                   	push   esi
    2708:	53                   	push   ebx
    2709:	83 ec 4c             	sub    esp,0x4c
    270c:	8b 75 0c             	mov    esi,DWORD PTR [ebp+0xc]
    270f:	8b 5d 10             	mov    ebx,DWORD PTR [ebp+0x10]
    2712:	8b 4d 14             	mov    ecx,DWORD PTR [ebp+0x14]
    2715:	8b 7d 18             	mov    edi,DWORD PTR [ebp+0x18]
    2718:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    271b:	89 f0                	mov    eax,esi
    271d:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
    2720:	88 5d d0             	mov    BYTE PTR [ebp-0x30],bl
    2723:	88 4d cc             	mov    BYTE PTR [ebp-0x34],cl
    2726:	89 f8                	mov    eax,edi
    2728:	66 89 45 c8          	mov    WORD PTR [ebp-0x38],ax
    272c:	89 d0                	mov    eax,edx
    272e:	88 45 c4             	mov    BYTE PTR [ebp-0x3c],al
    2731:	80 7d d4 00          	cmp    BYTE PTR [ebp-0x2c],0x0
    2735:	0f 84 27 01 00 00    	je     2862 <_pio_hd_read_sector+0x15f>
    273b:	c7 44 24 04 04 00 00 	mov    DWORD PTR [esp+0x4],0x4
    2742:	00 
    2743:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    274a:	e8 6b 15 00 00       	call   3cba <_port_byte_out>
    274f:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    2756:	00 
    2757:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    275e:	e8 57 15 00 00       	call   3cba <_port_byte_out>
    2763:	c7 04 24 f7 01 00 00 	mov    DWORD PTR [esp],0x1f7
    276a:	e8 41 15 00 00       	call   3cb0 <_port_byte_in>
    276f:	88 45 e3             	mov    BYTE PTR [ebp-0x1d],al
    2772:	0f b6 45 e3          	movzx  eax,BYTE PTR [ebp-0x1d]
    2776:	84 c0                	test   al,al
    2778:	78 e9                	js     2763 <_pio_hd_read_sector+0x60>
    277a:	0f b6 45 e3          	movzx  eax,BYTE PTR [ebp-0x1d]
    277e:	83 e0 08             	and    eax,0x8
    2781:	85 c0                	test   eax,eax
    2783:	75 de                	jne    2763 <_pio_hd_read_sector+0x60>
    2785:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    278c:	00 
    278d:	c7 04 24 f1 01 00 00 	mov    DWORD PTR [esp],0x1f1
    2794:	e8 21 15 00 00       	call   3cba <_port_byte_out>
    2799:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
    279d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    27a1:	c7 04 24 f2 01 00 00 	mov    DWORD PTR [esp],0x1f2
    27a8:	e8 0d 15 00 00       	call   3cba <_port_byte_out>
    27ad:	0f b6 45 cc          	movzx  eax,BYTE PTR [ebp-0x34]
    27b1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    27b5:	c7 04 24 f3 01 00 00 	mov    DWORD PTR [esp],0x1f3
    27bc:	e8 f9 14 00 00       	call   3cba <_port_byte_out>
    27c1:	0f b7 45 c8          	movzx  eax,WORD PTR [ebp-0x38]
    27c5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    27c9:	c7 04 24 f4 01 00 00 	mov    DWORD PTR [esp],0x1f4
    27d0:	e8 fb 14 00 00       	call   3cd0 <_port_word_out>
    27d5:	0f b6 45 d0          	movzx  eax,BYTE PTR [ebp-0x30]
    27d9:	c1 e0 05             	shl    eax,0x5
    27dc:	83 e0 20             	and    eax,0x20
    27df:	89 c2                	mov    edx,eax
    27e1:	0f b6 45 c4          	movzx  eax,BYTE PTR [ebp-0x3c]
    27e5:	83 e0 0f             	and    eax,0xf
    27e8:	09 d0                	or     eax,edx
    27ea:	0f b6 c0             	movzx  eax,al
    27ed:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    27f1:	c7 04 24 f6 01 00 00 	mov    DWORD PTR [esp],0x1f6
    27f8:	e8 bd 14 00 00       	call   3cba <_port_byte_out>
    27fd:	c7 44 24 04 20 00 00 	mov    DWORD PTR [esp+0x4],0x20
    2804:	00 
    2805:	c7 04 24 f7 01 00 00 	mov    DWORD PTR [esp],0x1f7
    280c:	e8 a9 14 00 00       	call   3cba <_port_byte_out>
    2811:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    2818:	eb 3d                	jmp    2857 <_pio_hd_read_sector+0x154>
    281a:	a1 08 60 00 00       	mov    eax,ds:0x6008
    281f:	85 c0                	test   eax,eax
    2821:	74 f7                	je     281a <_pio_hd_read_sector+0x117>
    2823:	c7 44 24 08 00 02 00 	mov    DWORD PTR [esp+0x8],0x200
    282a:	00 
    282b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    282e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2832:	c7 04 24 f0 01 00 00 	mov    DWORD PTR [esp],0x1f0
    2839:	e8 b2 14 00 00       	call   3cf0 <_port_buffer_in>
    283e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2841:	05 00 02 00 00       	add    eax,0x200
    2846:	89 45 08             	mov    DWORD PTR [ebp+0x8],eax
    2849:	c7 05 08 60 00 00 00 	mov    DWORD PTR ds:0x6008,0x0
    2850:	00 00 00 
    2853:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
    2857:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
    285b:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
    285e:	7c ba                	jl     281a <_pio_hd_read_sector+0x117>
    2860:	eb 01                	jmp    2863 <_pio_hd_read_sector+0x160>
    2862:	90                   	nop
    2863:	83 c4 4c             	add    esp,0x4c
    2866:	5b                   	pop    ebx
    2867:	5e                   	pop    esi
    2868:	5f                   	pop    edi
    2869:	5d                   	pop    ebp
    286a:	c3                   	ret    

0000286b <_pio_hd_write_sector>:
    286b:	55                   	push   ebp
    286c:	89 e5                	mov    ebp,esp
    286e:	57                   	push   edi
    286f:	56                   	push   esi
    2870:	53                   	push   ebx
    2871:	83 ec 4c             	sub    esp,0x4c
    2874:	8b 75 0c             	mov    esi,DWORD PTR [ebp+0xc]
    2877:	8b 5d 10             	mov    ebx,DWORD PTR [ebp+0x10]
    287a:	8b 4d 14             	mov    ecx,DWORD PTR [ebp+0x14]
    287d:	8b 7d 18             	mov    edi,DWORD PTR [ebp+0x18]
    2880:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    2883:	89 f0                	mov    eax,esi
    2885:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
    2888:	88 5d d0             	mov    BYTE PTR [ebp-0x30],bl
    288b:	88 4d cc             	mov    BYTE PTR [ebp-0x34],cl
    288e:	89 f8                	mov    eax,edi
    2890:	66 89 45 c8          	mov    WORD PTR [ebp-0x38],ax
    2894:	89 d0                	mov    eax,edx
    2896:	88 45 c4             	mov    BYTE PTR [ebp-0x3c],al
    2899:	c7 44 24 04 04 00 00 	mov    DWORD PTR [esp+0x4],0x4
    28a0:	00 
    28a1:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    28a8:	e8 0d 14 00 00       	call   3cba <_port_byte_out>
    28ad:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    28b4:	00 
    28b5:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    28bc:	e8 f9 13 00 00       	call   3cba <_port_byte_out>
    28c1:	c7 04 24 f7 01 00 00 	mov    DWORD PTR [esp],0x1f7
    28c8:	e8 e3 13 00 00       	call   3cb0 <_port_byte_in>
    28cd:	88 45 e3             	mov    BYTE PTR [ebp-0x1d],al
    28d0:	0f b6 45 e3          	movzx  eax,BYTE PTR [ebp-0x1d]
    28d4:	84 c0                	test   al,al
    28d6:	78 e9                	js     28c1 <_pio_hd_write_sector+0x56>
    28d8:	0f b6 45 e3          	movzx  eax,BYTE PTR [ebp-0x1d]
    28dc:	83 e0 08             	and    eax,0x8
    28df:	85 c0                	test   eax,eax
    28e1:	75 de                	jne    28c1 <_pio_hd_write_sector+0x56>
    28e3:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    28ea:	00 
    28eb:	c7 04 24 f1 01 00 00 	mov    DWORD PTR [esp],0x1f1
    28f2:	e8 c3 13 00 00       	call   3cba <_port_byte_out>
    28f7:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
    28fb:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    28ff:	c7 04 24 f2 01 00 00 	mov    DWORD PTR [esp],0x1f2
    2906:	e8 af 13 00 00       	call   3cba <_port_byte_out>
    290b:	0f b6 45 cc          	movzx  eax,BYTE PTR [ebp-0x34]
    290f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2913:	c7 04 24 f3 01 00 00 	mov    DWORD PTR [esp],0x1f3
    291a:	e8 9b 13 00 00       	call   3cba <_port_byte_out>
    291f:	0f b7 45 c8          	movzx  eax,WORD PTR [ebp-0x38]
    2923:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2927:	c7 04 24 f4 01 00 00 	mov    DWORD PTR [esp],0x1f4
    292e:	e8 9d 13 00 00       	call   3cd0 <_port_word_out>
    2933:	0f b6 45 d0          	movzx  eax,BYTE PTR [ebp-0x30]
    2937:	c1 e0 05             	shl    eax,0x5
    293a:	83 e0 20             	and    eax,0x20
    293d:	89 c2                	mov    edx,eax
    293f:	0f b6 45 c4          	movzx  eax,BYTE PTR [ebp-0x3c]
    2943:	83 e0 0f             	and    eax,0xf
    2946:	09 d0                	or     eax,edx
    2948:	0f b6 c0             	movzx  eax,al
    294b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    294f:	c7 04 24 f6 01 00 00 	mov    DWORD PTR [esp],0x1f6
    2956:	e8 5f 13 00 00       	call   3cba <_port_byte_out>
    295b:	c7 44 24 04 30 00 00 	mov    DWORD PTR [esp+0x4],0x30
    2962:	00 
    2963:	c7 04 24 f7 01 00 00 	mov    DWORD PTR [esp],0x1f7
    296a:	e8 4b 13 00 00       	call   3cba <_port_byte_out>
    296f:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    2976:	eb 3d                	jmp    29b5 <_pio_hd_write_sector+0x14a>
    2978:	c7 44 24 08 00 02 00 	mov    DWORD PTR [esp+0x8],0x200
    297f:	00 
    2980:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2983:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2987:	c7 04 24 f0 01 00 00 	mov    DWORD PTR [esp],0x1f0
    298e:	e8 72 13 00 00       	call   3d05 <_port_buffer_out>
    2993:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2996:	05 00 02 00 00       	add    eax,0x200
    299b:	89 45 08             	mov    DWORD PTR [ebp+0x8],eax
    299e:	c7 05 08 60 00 00 00 	mov    DWORD PTR ds:0x6008,0x0
    29a5:	00 00 00 
    29a8:	a1 08 60 00 00       	mov    eax,ds:0x6008
    29ad:	85 c0                	test   eax,eax
    29af:	74 f7                	je     29a8 <_pio_hd_write_sector+0x13d>
    29b1:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
    29b5:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
    29b9:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
    29bc:	7c ba                	jl     2978 <_pio_hd_write_sector+0x10d>
    29be:	90                   	nop
    29bf:	90                   	nop
    29c0:	83 c4 4c             	add    esp,0x4c
    29c3:	5b                   	pop    ebx
    29c4:	5e                   	pop    esi
    29c5:	5f                   	pop    edi
    29c6:	5d                   	pop    ebp
    29c7:	c3                   	ret    

000029c8 <_hd_request>:
    29c8:	55                   	push   ebp
    29c9:	89 e5                	mov    ebp,esp
    29cb:	83 ec 28             	sub    esp,0x28
    29ce:	c7 04 24 f7 01 00 00 	mov    DWORD PTR [esp],0x1f7
    29d5:	e8 d6 12 00 00       	call   3cb0 <_port_byte_in>
    29da:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
    29dd:	c7 04 24 10 44 00 00 	mov    DWORD PTR [esp],0x4410
    29e4:	e8 47 fa ff ff       	call   2430 <_kprint>
    29e9:	c7 05 08 60 00 00 01 	mov    DWORD PTR ds:0x6008,0x1
    29f0:	00 00 00 
    29f3:	90                   	nop
    29f4:	c9                   	leave  
    29f5:	c3                   	ret    
    29f6:	90                   	nop
    29f7:	90                   	nop

000029f8 <_init_gdt>:
    29f8:	55                   	push   ebp
    29f9:	89 e5                	mov    ebp,esp
    29fb:	83 ec 18             	sub    esp,0x18
    29fe:	66 c7 05 2a 61 00 00 	mov    WORD PTR ds:0x612a,0x3
    2a05:	03 00 
    2a07:	b8 20 60 00 00       	mov    eax,0x6020
    2a0c:	a3 26 61 00 00       	mov    ds:0x6126,eax
    2a11:	66 c7 05 24 61 00 00 	mov    WORD PTR ds:0x6124,0xff
    2a18:	ff 00 
    2a1a:	c7 04 24 24 61 00 00 	mov    DWORD PTR [esp],0x6124
    2a21:	e8 fa 0f 00 00       	call   3a20 <_reload_gdtr>
    2a26:	c7 05 20 61 00 00 20 	mov    DWORD PTR ds:0x6120,0x6020
    2a2d:	60 00 00 
    2a30:	90                   	nop
    2a31:	c9                   	leave  
    2a32:	c3                   	ret    

00002a33 <_add_global_descriptor>:
    2a33:	55                   	push   ebp
    2a34:	89 e5                	mov    ebp,esp
    2a36:	83 ec 08             	sub    esp,0x8
    2a39:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    2a3c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    2a3f:	88 55 fc             	mov    BYTE PTR [ebp-0x4],dl
    2a42:	88 45 f8             	mov    BYTE PTR [ebp-0x8],al
    2a45:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2a4c:	66 83 f8 20          	cmp    ax,0x20
    2a50:	76 0a                	jbe    2a5c <_add_global_descriptor+0x29>
    2a52:	b8 00 00 00 00       	mov    eax,0x0
    2a57:	e9 f0 00 00 00       	jmp    2b4c <_add_global_descriptor+0x119>
    2a5c:	83 6d 0c 01          	sub    DWORD PTR [ebp+0xc],0x1
    2a60:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2a67:	0f b7 c0             	movzx  eax,ax
    2a6a:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2a6d:	66 89 14 c5 20 60 00 	mov    WORD PTR [eax*8+0x6020],dx
    2a74:	00 
    2a75:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2a78:	c1 e8 10             	shr    eax,0x10
    2a7b:	89 c1                	mov    ecx,eax
    2a7d:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2a84:	0f b7 d0             	movzx  edx,ax
    2a87:	89 c8                	mov    eax,ecx
    2a89:	83 e0 0f             	and    eax,0xf
    2a8c:	83 e0 0f             	and    eax,0xf
    2a8f:	89 c1                	mov    ecx,eax
    2a91:	0f b6 04 d5 26 60 00 	movzx  eax,BYTE PTR [edx*8+0x6026]
    2a98:	00 
    2a99:	83 e0 f0             	and    eax,0xfffffff0
    2a9c:	09 c8                	or     eax,ecx
    2a9e:	88 04 d5 26 60 00 00 	mov    BYTE PTR [edx*8+0x6026],al
    2aa5:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    2aa8:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2aaf:	0f b7 c0             	movzx  eax,ax
    2ab2:	66 89 14 c5 22 60 00 	mov    WORD PTR [eax*8+0x6022],dx
    2ab9:	00 
    2aba:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2abd:	c1 e8 10             	shr    eax,0x10
    2ac0:	89 c2                	mov    edx,eax
    2ac2:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2ac9:	0f b7 c0             	movzx  eax,ax
    2acc:	88 14 c5 24 60 00 00 	mov    BYTE PTR [eax*8+0x6024],dl
    2ad3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2ad6:	c1 e8 10             	shr    eax,0x10
    2ad9:	66 c1 e8 08          	shr    ax,0x8
    2add:	89 c2                	mov    edx,eax
    2adf:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2ae6:	0f b7 c0             	movzx  eax,ax
    2ae9:	88 14 c5 27 60 00 00 	mov    BYTE PTR [eax*8+0x6027],dl
    2af0:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2af7:	0f b7 c0             	movzx  eax,ax
    2afa:	0f b6 55 fc          	movzx  edx,BYTE PTR [ebp-0x4]
    2afe:	88 14 c5 25 60 00 00 	mov    BYTE PTR [eax*8+0x6025],dl
    2b05:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2b0c:	0f b7 c0             	movzx  eax,ax
    2b0f:	0f b6 55 f8          	movzx  edx,BYTE PTR [ebp-0x8]
    2b13:	83 e2 0f             	and    edx,0xf
    2b16:	89 d1                	mov    ecx,edx
    2b18:	c1 e1 04             	shl    ecx,0x4
    2b1b:	0f b6 14 c5 26 60 00 	movzx  edx,BYTE PTR [eax*8+0x6026]
    2b22:	00 
    2b23:	83 e2 0f             	and    edx,0xf
    2b26:	09 ca                	or     edx,ecx
    2b28:	88 14 c5 26 60 00 00 	mov    BYTE PTR [eax*8+0x6026],dl
    2b2f:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2b36:	83 c0 01             	add    eax,0x1
    2b39:	66 a3 2a 61 00 00    	mov    ds:0x612a,ax
    2b3f:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2b46:	83 e8 01             	sub    eax,0x1
    2b49:	c1 e0 03             	shl    eax,0x3
    2b4c:	c9                   	leave  
    2b4d:	c3                   	ret    

00002b4e <_add_ldt_descriptor>:
    2b4e:	55                   	push   ebp
    2b4f:	89 e5                	mov    ebp,esp
    2b51:	83 ec 10             	sub    esp,0x10
    2b54:	c7 44 24 0c 04 00 00 	mov    DWORD PTR [esp+0xc],0x4
    2b5b:	00 
    2b5c:	c7 44 24 08 82 00 00 	mov    DWORD PTR [esp+0x8],0x82
    2b63:	00 
    2b64:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b67:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2b6b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2b6e:	89 04 24             	mov    DWORD PTR [esp],eax
    2b71:	e8 bd fe ff ff       	call   2a33 <_add_global_descriptor>
    2b76:	c9                   	leave  
    2b77:	c3                   	ret    

00002b78 <_add_tss_descriptor>:
    2b78:	55                   	push   ebp
    2b79:	89 e5                	mov    ebp,esp
    2b7b:	83 ec 10             	sub    esp,0x10
    2b7e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b81:	83 e8 01             	sub    eax,0x1
    2b84:	c7 44 24 0c 04 00 00 	mov    DWORD PTR [esp+0xc],0x4
    2b8b:	00 
    2b8c:	c7 44 24 08 89 00 00 	mov    DWORD PTR [esp+0x8],0x89
    2b93:	00 
    2b94:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2b98:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2b9b:	89 04 24             	mov    DWORD PTR [esp],eax
    2b9e:	e8 90 fe ff ff       	call   2a33 <_add_global_descriptor>
    2ba3:	c9                   	leave  
    2ba4:	c3                   	ret    

00002ba5 <_add_gate_descriptor>:
    2ba5:	55                   	push   ebp
    2ba6:	89 e5                	mov    ebp,esp
    2ba8:	83 ec 0c             	sub    esp,0xc
    2bab:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2bae:	8b 4d 10             	mov    ecx,DWORD PTR [ebp+0x10]
    2bb1:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
    2bb4:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
    2bb8:	89 c8                	mov    eax,ecx
    2bba:	88 45 f8             	mov    BYTE PTR [ebp-0x8],al
    2bbd:	89 d0                	mov    eax,edx
    2bbf:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
    2bc2:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2bc9:	66 83 f8 20          	cmp    ax,0x20
    2bcd:	76 0a                	jbe    2bd9 <_add_gate_descriptor+0x34>
    2bcf:	b8 00 00 00 00       	mov    eax,0x0
    2bd4:	e9 da 00 00 00       	jmp    2cb3 <_add_gate_descriptor+0x10e>
    2bd9:	a1 20 61 00 00       	mov    eax,ds:0x6120
    2bde:	0f b7 15 2a 61 00 00 	movzx  edx,WORD PTR ds:0x612a
    2be5:	0f b7 d2             	movzx  edx,dx
    2be8:	c1 e2 03             	shl    edx,0x3
    2beb:	01 c2                	add    edx,eax
    2bed:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
    2bf1:	66 89 42 02          	mov    WORD PTR [edx+0x2],ax
    2bf5:	a1 20 61 00 00       	mov    eax,ds:0x6120
    2bfa:	0f b7 15 2a 61 00 00 	movzx  edx,WORD PTR ds:0x612a
    2c01:	0f b7 d2             	movzx  edx,dx
    2c04:	c1 e2 03             	shl    edx,0x3
    2c07:	01 d0                	add    eax,edx
    2c09:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2c0c:	66 89 10             	mov    WORD PTR [eax],dx
    2c0f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2c12:	c1 e8 10             	shr    eax,0x10
    2c15:	89 c1                	mov    ecx,eax
    2c17:	a1 20 61 00 00       	mov    eax,ds:0x6120
    2c1c:	0f b7 15 2a 61 00 00 	movzx  edx,WORD PTR ds:0x612a
    2c23:	0f b7 d2             	movzx  edx,dx
    2c26:	c1 e2 03             	shl    edx,0x3
    2c29:	01 d0                	add    eax,edx
    2c2b:	89 ca                	mov    edx,ecx
    2c2d:	66 89 50 06          	mov    WORD PTR [eax+0x6],dx
    2c31:	a1 20 61 00 00       	mov    eax,ds:0x6120
    2c36:	0f b7 15 2a 61 00 00 	movzx  edx,WORD PTR ds:0x612a
    2c3d:	0f b7 d2             	movzx  edx,dx
    2c40:	c1 e2 03             	shl    edx,0x3
    2c43:	01 d0                	add    eax,edx
    2c45:	0f b6 55 f4          	movzx  edx,BYTE PTR [ebp-0xc]
    2c49:	83 e2 1f             	and    edx,0x1f
    2c4c:	89 d1                	mov    ecx,edx
    2c4e:	83 e1 1f             	and    ecx,0x1f
    2c51:	0f b6 50 04          	movzx  edx,BYTE PTR [eax+0x4]
    2c55:	83 e2 e0             	and    edx,0xffffffe0
    2c58:	09 ca                	or     edx,ecx
    2c5a:	88 50 04             	mov    BYTE PTR [eax+0x4],dl
    2c5d:	a1 20 61 00 00       	mov    eax,ds:0x6120
    2c62:	0f b7 15 2a 61 00 00 	movzx  edx,WORD PTR ds:0x612a
    2c69:	0f b7 d2             	movzx  edx,dx
    2c6c:	c1 e2 03             	shl    edx,0x3
    2c6f:	01 c2                	add    edx,eax
    2c71:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
    2c75:	88 42 05             	mov    BYTE PTR [edx+0x5],al
    2c78:	a1 20 61 00 00       	mov    eax,ds:0x6120
    2c7d:	0f b7 15 2a 61 00 00 	movzx  edx,WORD PTR ds:0x612a
    2c84:	0f b7 d2             	movzx  edx,dx
    2c87:	c1 e2 03             	shl    edx,0x3
    2c8a:	01 d0                	add    eax,edx
    2c8c:	0f b6 50 04          	movzx  edx,BYTE PTR [eax+0x4]
    2c90:	83 e2 1f             	and    edx,0x1f
    2c93:	88 50 04             	mov    BYTE PTR [eax+0x4],dl
    2c96:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2c9d:	83 c0 01             	add    eax,0x1
    2ca0:	66 a3 2a 61 00 00    	mov    ds:0x612a,ax
    2ca6:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2cad:	83 e8 01             	sub    eax,0x1
    2cb0:	c1 e0 03             	shl    eax,0x3
    2cb3:	c9                   	leave  
    2cb4:	c3                   	ret    

00002cb5 <_get_desc_base_addr>:
    2cb5:	55                   	push   ebp
    2cb6:	89 e5                	mov    ebp,esp
    2cb8:	83 ec 14             	sub    esp,0x14
    2cbb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2cbe:	66 89 45 ec          	mov    WORD PTR [ebp-0x14],ax
    2cc2:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
    2cc6:	66 c1 e8 03          	shr    ax,0x3
    2cca:	66 89 45 fe          	mov    WORD PTR [ebp-0x2],ax
    2cce:	0f b7 45 fe          	movzx  eax,WORD PTR [ebp-0x2]
    2cd2:	0f b6 04 c5 27 60 00 	movzx  eax,BYTE PTR [eax*8+0x6027]
    2cd9:	00 
    2cda:	0f b6 c0             	movzx  eax,al
    2cdd:	c1 e0 18             	shl    eax,0x18
    2ce0:	89 c2                	mov    edx,eax
    2ce2:	0f b7 45 fe          	movzx  eax,WORD PTR [ebp-0x2]
    2ce6:	0f b6 04 c5 24 60 00 	movzx  eax,BYTE PTR [eax*8+0x6024]
    2ced:	00 
    2cee:	0f b6 c0             	movzx  eax,al
    2cf1:	c1 e0 10             	shl    eax,0x10
    2cf4:	09 c2                	or     edx,eax
    2cf6:	0f b7 45 fe          	movzx  eax,WORD PTR [ebp-0x2]
    2cfa:	0f b7 04 c5 22 60 00 	movzx  eax,WORD PTR [eax*8+0x6022]
    2d01:	00 
    2d02:	0f b7 c0             	movzx  eax,ax
    2d05:	09 d0                	or     eax,edx
    2d07:	c9                   	leave  
    2d08:	c3                   	ret    

00002d09 <_set_desc_base_addr>:
    2d09:	55                   	push   ebp
    2d0a:	89 e5                	mov    ebp,esp
    2d0c:	83 ec 14             	sub    esp,0x14
    2d0f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2d12:	66 89 45 ec          	mov    WORD PTR [ebp-0x14],ax
    2d16:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
    2d1a:	66 c1 e8 03          	shr    ax,0x3
    2d1e:	66 89 45 fe          	mov    WORD PTR [ebp-0x2],ax
    2d22:	0f b7 05 2a 61 00 00 	movzx  eax,WORD PTR ds:0x612a
    2d29:	66 39 45 fe          	cmp    WORD PTR [ebp-0x2],ax
    2d2d:	73 3b                	jae    2d6a <_set_desc_base_addr+0x61>
    2d2f:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2d32:	0f b7 45 fe          	movzx  eax,WORD PTR [ebp-0x2]
    2d36:	66 89 14 c5 22 60 00 	mov    WORD PTR [eax*8+0x6022],dx
    2d3d:	00 
    2d3e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d41:	c1 e8 10             	shr    eax,0x10
    2d44:	89 c2                	mov    edx,eax
    2d46:	0f b7 45 fe          	movzx  eax,WORD PTR [ebp-0x2]
    2d4a:	88 14 c5 24 60 00 00 	mov    BYTE PTR [eax*8+0x6024],dl
    2d51:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d54:	c1 e8 10             	shr    eax,0x10
    2d57:	66 c1 e8 08          	shr    ax,0x8
    2d5b:	89 c2                	mov    edx,eax
    2d5d:	0f b7 45 fe          	movzx  eax,WORD PTR [ebp-0x2]
    2d61:	88 14 c5 27 60 00 00 	mov    BYTE PTR [eax*8+0x6027],dl
    2d68:	eb 01                	jmp    2d6b <_set_desc_base_addr+0x62>
    2d6a:	90                   	nop
    2d6b:	c9                   	leave  
    2d6c:	c3                   	ret    
    2d6d:	90                   	nop
    2d6e:	90                   	nop
    2d6f:	90                   	nop

00002d70 <_init_idt>:
    2d70:	55                   	push   ebp
    2d71:	89 e5                	mov    ebp,esp
    2d73:	83 ec 18             	sub    esp,0x18
    2d76:	b8 d0 3a 00 00       	mov    eax,0x3ad0
    2d7b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2d7f:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2d86:	e8 af 04 00 00       	call   323a <_set_idt_gate>
    2d8b:	b8 d7 3a 00 00       	mov    eax,0x3ad7
    2d90:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2d94:	c7 04 24 01 00 00 00 	mov    DWORD PTR [esp],0x1
    2d9b:	e8 9a 04 00 00       	call   323a <_set_idt_gate>
    2da0:	b8 de 3a 00 00       	mov    eax,0x3ade
    2da5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2da9:	c7 04 24 02 00 00 00 	mov    DWORD PTR [esp],0x2
    2db0:	e8 85 04 00 00       	call   323a <_set_idt_gate>
    2db5:	b8 e5 3a 00 00       	mov    eax,0x3ae5
    2dba:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2dbe:	c7 04 24 03 00 00 00 	mov    DWORD PTR [esp],0x3
    2dc5:	e8 70 04 00 00       	call   323a <_set_idt_gate>
    2dca:	b8 ec 3a 00 00       	mov    eax,0x3aec
    2dcf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2dd3:	c7 04 24 04 00 00 00 	mov    DWORD PTR [esp],0x4
    2dda:	e8 5b 04 00 00       	call   323a <_set_idt_gate>
    2ddf:	b8 f3 3a 00 00       	mov    eax,0x3af3
    2de4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2de8:	c7 04 24 05 00 00 00 	mov    DWORD PTR [esp],0x5
    2def:	e8 46 04 00 00       	call   323a <_set_idt_gate>
    2df4:	b8 fa 3a 00 00       	mov    eax,0x3afa
    2df9:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2dfd:	c7 04 24 06 00 00 00 	mov    DWORD PTR [esp],0x6
    2e04:	e8 31 04 00 00       	call   323a <_set_idt_gate>
    2e09:	b8 01 3b 00 00       	mov    eax,0x3b01
    2e0e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e12:	c7 04 24 07 00 00 00 	mov    DWORD PTR [esp],0x7
    2e19:	e8 1c 04 00 00       	call   323a <_set_idt_gate>
    2e1e:	b8 08 3b 00 00       	mov    eax,0x3b08
    2e23:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e27:	c7 04 24 08 00 00 00 	mov    DWORD PTR [esp],0x8
    2e2e:	e8 07 04 00 00       	call   323a <_set_idt_gate>
    2e33:	b8 0d 3b 00 00       	mov    eax,0x3b0d
    2e38:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e3c:	c7 04 24 09 00 00 00 	mov    DWORD PTR [esp],0x9
    2e43:	e8 f2 03 00 00       	call   323a <_set_idt_gate>
    2e48:	b8 14 3b 00 00       	mov    eax,0x3b14
    2e4d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e51:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    2e58:	e8 dd 03 00 00       	call   323a <_set_idt_gate>
    2e5d:	b8 19 3b 00 00       	mov    eax,0x3b19
    2e62:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e66:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    2e6d:	e8 c8 03 00 00       	call   323a <_set_idt_gate>
    2e72:	b8 1e 3b 00 00       	mov    eax,0x3b1e
    2e77:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e7b:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2e82:	e8 b3 03 00 00       	call   323a <_set_idt_gate>
    2e87:	b8 26 3b 00 00       	mov    eax,0x3b26
    2e8c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e90:	c7 04 24 0d 00 00 00 	mov    DWORD PTR [esp],0xd
    2e97:	e8 9e 03 00 00       	call   323a <_set_idt_gate>
    2e9c:	b8 2e 3b 00 00       	mov    eax,0x3b2e
    2ea1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2ea5:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    2eac:	e8 89 03 00 00       	call   323a <_set_idt_gate>
    2eb1:	b8 36 3b 00 00       	mov    eax,0x3b36
    2eb6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2eba:	c7 04 24 0f 00 00 00 	mov    DWORD PTR [esp],0xf
    2ec1:	e8 74 03 00 00       	call   323a <_set_idt_gate>
    2ec6:	b8 40 3b 00 00       	mov    eax,0x3b40
    2ecb:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2ecf:	c7 04 24 10 00 00 00 	mov    DWORD PTR [esp],0x10
    2ed6:	e8 5f 03 00 00       	call   323a <_set_idt_gate>
    2edb:	b8 4a 3b 00 00       	mov    eax,0x3b4a
    2ee0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2ee4:	c7 04 24 11 00 00 00 	mov    DWORD PTR [esp],0x11
    2eeb:	e8 4a 03 00 00       	call   323a <_set_idt_gate>
    2ef0:	b8 54 3b 00 00       	mov    eax,0x3b54
    2ef5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2ef9:	c7 04 24 12 00 00 00 	mov    DWORD PTR [esp],0x12
    2f00:	e8 35 03 00 00       	call   323a <_set_idt_gate>
    2f05:	b8 5e 3b 00 00       	mov    eax,0x3b5e
    2f0a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2f0e:	c7 04 24 13 00 00 00 	mov    DWORD PTR [esp],0x13
    2f15:	e8 20 03 00 00       	call   323a <_set_idt_gate>
    2f1a:	b8 68 3b 00 00       	mov    eax,0x3b68
    2f1f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2f23:	c7 04 24 14 00 00 00 	mov    DWORD PTR [esp],0x14
    2f2a:	e8 0b 03 00 00       	call   323a <_set_idt_gate>
    2f2f:	b8 72 3b 00 00       	mov    eax,0x3b72
    2f34:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2f38:	c7 04 24 15 00 00 00 	mov    DWORD PTR [esp],0x15
    2f3f:	e8 f6 02 00 00       	call   323a <_set_idt_gate>
    2f44:	b8 7c 3b 00 00       	mov    eax,0x3b7c
    2f49:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2f4d:	c7 04 24 16 00 00 00 	mov    DWORD PTR [esp],0x16
    2f54:	e8 e1 02 00 00       	call   323a <_set_idt_gate>
    2f59:	b8 86 3b 00 00       	mov    eax,0x3b86
    2f5e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2f62:	c7 04 24 17 00 00 00 	mov    DWORD PTR [esp],0x17
    2f69:	e8 cc 02 00 00       	call   323a <_set_idt_gate>
    2f6e:	b8 90 3b 00 00       	mov    eax,0x3b90
    2f73:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2f77:	c7 04 24 18 00 00 00 	mov    DWORD PTR [esp],0x18
    2f7e:	e8 b7 02 00 00       	call   323a <_set_idt_gate>
    2f83:	b8 9a 3b 00 00       	mov    eax,0x3b9a
    2f88:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2f8c:	c7 04 24 19 00 00 00 	mov    DWORD PTR [esp],0x19
    2f93:	e8 a2 02 00 00       	call   323a <_set_idt_gate>
    2f98:	b8 a4 3b 00 00       	mov    eax,0x3ba4
    2f9d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2fa1:	c7 04 24 1a 00 00 00 	mov    DWORD PTR [esp],0x1a
    2fa8:	e8 8d 02 00 00       	call   323a <_set_idt_gate>
    2fad:	b8 ae 3b 00 00       	mov    eax,0x3bae
    2fb2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2fb6:	c7 04 24 1b 00 00 00 	mov    DWORD PTR [esp],0x1b
    2fbd:	e8 78 02 00 00       	call   323a <_set_idt_gate>
    2fc2:	b8 b8 3b 00 00       	mov    eax,0x3bb8
    2fc7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2fcb:	c7 04 24 1c 00 00 00 	mov    DWORD PTR [esp],0x1c
    2fd2:	e8 63 02 00 00       	call   323a <_set_idt_gate>
    2fd7:	b8 c2 3b 00 00       	mov    eax,0x3bc2
    2fdc:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2fe0:	c7 04 24 1d 00 00 00 	mov    DWORD PTR [esp],0x1d
    2fe7:	e8 4e 02 00 00       	call   323a <_set_idt_gate>
    2fec:	b8 cc 3b 00 00       	mov    eax,0x3bcc
    2ff1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2ff5:	c7 04 24 1e 00 00 00 	mov    DWORD PTR [esp],0x1e
    2ffc:	e8 39 02 00 00       	call   323a <_set_idt_gate>
    3001:	b8 d6 3b 00 00       	mov    eax,0x3bd6
    3006:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    300a:	c7 04 24 1f 00 00 00 	mov    DWORD PTR [esp],0x1f
    3011:	e8 24 02 00 00       	call   323a <_set_idt_gate>
    3016:	b8 e0 3b 00 00       	mov    eax,0x3be0
    301b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    301f:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
    3026:	e8 0f 02 00 00       	call   323a <_set_idt_gate>
    302b:	b8 ea 3b 00 00       	mov    eax,0x3bea
    3030:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3034:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
    303b:	e8 fa 01 00 00       	call   323a <_set_idt_gate>
    3040:	b8 f4 3b 00 00       	mov    eax,0x3bf4
    3045:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3049:	c7 04 24 22 00 00 00 	mov    DWORD PTR [esp],0x22
    3050:	e8 e5 01 00 00       	call   323a <_set_idt_gate>
    3055:	b8 fe 3b 00 00       	mov    eax,0x3bfe
    305a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    305e:	c7 04 24 23 00 00 00 	mov    DWORD PTR [esp],0x23
    3065:	e8 d0 01 00 00       	call   323a <_set_idt_gate>
    306a:	b8 08 3c 00 00       	mov    eax,0x3c08
    306f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3073:	c7 04 24 24 00 00 00 	mov    DWORD PTR [esp],0x24
    307a:	e8 bb 01 00 00       	call   323a <_set_idt_gate>
    307f:	b8 12 3c 00 00       	mov    eax,0x3c12
    3084:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3088:	c7 04 24 25 00 00 00 	mov    DWORD PTR [esp],0x25
    308f:	e8 a6 01 00 00       	call   323a <_set_idt_gate>
    3094:	b8 1c 3c 00 00       	mov    eax,0x3c1c
    3099:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    309d:	c7 04 24 26 00 00 00 	mov    DWORD PTR [esp],0x26
    30a4:	e8 91 01 00 00       	call   323a <_set_idt_gate>
    30a9:	b8 26 3c 00 00       	mov    eax,0x3c26
    30ae:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    30b2:	c7 04 24 27 00 00 00 	mov    DWORD PTR [esp],0x27
    30b9:	e8 7c 01 00 00       	call   323a <_set_idt_gate>
    30be:	b8 30 3c 00 00       	mov    eax,0x3c30
    30c3:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    30c7:	c7 04 24 28 00 00 00 	mov    DWORD PTR [esp],0x28
    30ce:	e8 67 01 00 00       	call   323a <_set_idt_gate>
    30d3:	b8 3a 3c 00 00       	mov    eax,0x3c3a
    30d8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    30dc:	c7 04 24 29 00 00 00 	mov    DWORD PTR [esp],0x29
    30e3:	e8 52 01 00 00       	call   323a <_set_idt_gate>
    30e8:	b8 44 3c 00 00       	mov    eax,0x3c44
    30ed:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    30f1:	c7 04 24 2a 00 00 00 	mov    DWORD PTR [esp],0x2a
    30f8:	e8 3d 01 00 00       	call   323a <_set_idt_gate>
    30fd:	b8 4e 3c 00 00       	mov    eax,0x3c4e
    3102:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3106:	c7 04 24 2b 00 00 00 	mov    DWORD PTR [esp],0x2b
    310d:	e8 28 01 00 00       	call   323a <_set_idt_gate>
    3112:	b8 58 3c 00 00       	mov    eax,0x3c58
    3117:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    311b:	c7 04 24 2c 00 00 00 	mov    DWORD PTR [esp],0x2c
    3122:	e8 13 01 00 00       	call   323a <_set_idt_gate>
    3127:	b8 62 3c 00 00       	mov    eax,0x3c62
    312c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3130:	c7 04 24 2d 00 00 00 	mov    DWORD PTR [esp],0x2d
    3137:	e8 fe 00 00 00       	call   323a <_set_idt_gate>
    313c:	b8 6c 3c 00 00       	mov    eax,0x3c6c
    3141:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3145:	c7 04 24 2e 00 00 00 	mov    DWORD PTR [esp],0x2e
    314c:	e8 e9 00 00 00       	call   323a <_set_idt_gate>
    3151:	b8 76 3c 00 00       	mov    eax,0x3c76
    3156:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    315a:	c7 04 24 2f 00 00 00 	mov    DWORD PTR [esp],0x2f
    3161:	e8 d4 00 00 00       	call   323a <_set_idt_gate>
    3166:	90                   	nop
    3167:	c9                   	leave  
    3168:	c3                   	ret    

00003169 <_init_irq>:
    3169:	55                   	push   ebp
    316a:	89 e5                	mov    ebp,esp
    316c:	83 ec 18             	sub    esp,0x18
    316f:	c7 44 24 04 11 00 00 	mov    DWORD PTR [esp+0x4],0x11
    3176:	00 
    3177:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
    317e:	e8 37 0b 00 00       	call   3cba <_port_byte_out>
    3183:	c7 44 24 04 11 00 00 	mov    DWORD PTR [esp+0x4],0x11
    318a:	00 
    318b:	c7 04 24 a0 00 00 00 	mov    DWORD PTR [esp],0xa0
    3192:	e8 23 0b 00 00       	call   3cba <_port_byte_out>
    3197:	c7 44 24 04 20 00 00 	mov    DWORD PTR [esp+0x4],0x20
    319e:	00 
    319f:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
    31a6:	e8 0f 0b 00 00       	call   3cba <_port_byte_out>
    31ab:	c7 44 24 04 28 00 00 	mov    DWORD PTR [esp+0x4],0x28
    31b2:	00 
    31b3:	c7 04 24 a1 00 00 00 	mov    DWORD PTR [esp],0xa1
    31ba:	e8 fb 0a 00 00       	call   3cba <_port_byte_out>
    31bf:	c7 44 24 04 04 00 00 	mov    DWORD PTR [esp+0x4],0x4
    31c6:	00 
    31c7:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
    31ce:	e8 e7 0a 00 00       	call   3cba <_port_byte_out>
    31d3:	c7 44 24 04 02 00 00 	mov    DWORD PTR [esp+0x4],0x2
    31da:	00 
    31db:	c7 04 24 a1 00 00 00 	mov    DWORD PTR [esp],0xa1
    31e2:	e8 d3 0a 00 00       	call   3cba <_port_byte_out>
    31e7:	c7 44 24 04 01 00 00 	mov    DWORD PTR [esp+0x4],0x1
    31ee:	00 
    31ef:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
    31f6:	e8 bf 0a 00 00       	call   3cba <_port_byte_out>
    31fb:	c7 44 24 04 01 00 00 	mov    DWORD PTR [esp+0x4],0x1
    3202:	00 
    3203:	c7 04 24 a1 00 00 00 	mov    DWORD PTR [esp],0xa1
    320a:	e8 ab 0a 00 00       	call   3cba <_port_byte_out>
    320f:	c7 44 24 04 fb 00 00 	mov    DWORD PTR [esp+0x4],0xfb
    3216:	00 
    3217:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
    321e:	e8 97 0a 00 00       	call   3cba <_port_byte_out>
    3223:	c7 44 24 04 ff 00 00 	mov    DWORD PTR [esp+0x4],0xff
    322a:	00 
    322b:	c7 04 24 a1 00 00 00 	mov    DWORD PTR [esp],0xa1
    3232:	e8 83 0a 00 00       	call   3cba <_port_byte_out>
    3237:	90                   	nop
    3238:	c9                   	leave  
    3239:	c3                   	ret    

0000323a <_set_idt_gate>:
    323a:	55                   	push   ebp
    323b:	89 e5                	mov    ebp,esp
    323d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3240:	89 c2                	mov    edx,eax
    3242:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3245:	66 89 14 c5 e0 65 00 	mov    WORD PTR [eax*8+0x65e0],dx
    324c:	00 
    324d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3250:	66 c7 04 c5 e2 65 00 	mov    WORD PTR [eax*8+0x65e2],0x8
    3257:	00 08 00 
    325a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    325d:	0f b6 14 c5 e4 65 00 	movzx  edx,BYTE PTR [eax*8+0x65e4]
    3264:	00 
    3265:	83 e2 e0             	and    edx,0xffffffe0
    3268:	88 14 c5 e4 65 00 00 	mov    BYTE PTR [eax*8+0x65e4],dl
    326f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3272:	0f b6 14 c5 e4 65 00 	movzx  edx,BYTE PTR [eax*8+0x65e4]
    3279:	00 
    327a:	83 e2 1f             	and    edx,0x1f
    327d:	88 14 c5 e4 65 00 00 	mov    BYTE PTR [eax*8+0x65e4],dl
    3284:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3287:	c6 04 c5 e5 65 00 00 	mov    BYTE PTR [eax*8+0x65e5],0x8e
    328e:	8e 
    328f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3292:	c1 e8 10             	shr    eax,0x10
    3295:	89 c2                	mov    edx,eax
    3297:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    329a:	66 89 14 c5 e6 65 00 	mov    WORD PTR [eax*8+0x65e6],dx
    32a1:	00 
    32a2:	90                   	nop
    32a3:	5d                   	pop    ebp
    32a4:	c3                   	ret    

000032a5 <_set_idtr>:
    32a5:	55                   	push   ebp
    32a6:	89 e5                	mov    ebp,esp
    32a8:	83 ec 08             	sub    esp,0x8
    32ab:	b8 e0 65 00 00       	mov    eax,0x65e0
    32b0:	a3 e2 6d 00 00       	mov    ds:0x6de2,eax
    32b5:	66 c7 05 e0 6d 00 00 	mov    WORD PTR ds:0x6de0,0x7ff
    32bc:	ff 07 
    32be:	e8 cd 09 00 00       	call   3c90 <_load_idtr>
    32c3:	90                   	nop
    32c4:	c9                   	leave  
    32c5:	c3                   	ret    

000032c6 <_init_exceptions>:
    32c6:	55                   	push   ebp
    32c7:	89 e5                	mov    ebp,esp
    32c9:	83 ec 18             	sub    esp,0x18
    32cc:	c7 44 24 04 36 15 00 	mov    DWORD PTR [esp+0x4],0x1536
    32d3:	00 
    32d4:	c7 04 24 0d 00 00 00 	mov    DWORD PTR [esp],0xd
    32db:	e8 4c 00 00 00       	call   332c <_set_interrupt_handler>
    32e0:	c7 44 24 04 5f 15 00 	mov    DWORD PTR [esp+0x4],0x155f
    32e7:	00 
    32e8:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    32ef:	e8 38 00 00 00       	call   332c <_set_interrupt_handler>
    32f4:	90                   	nop
    32f5:	c9                   	leave  
    32f6:	c3                   	ret    

000032f7 <_init_interrupts>:
    32f7:	55                   	push   ebp
    32f8:	89 e5                	mov    ebp,esp
    32fa:	83 ec 18             	sub    esp,0x18
    32fd:	e8 6e fa ff ff       	call   2d70 <_init_idt>
    3302:	e8 bf ff ff ff       	call   32c6 <_init_exceptions>
    3307:	e8 99 ff ff ff       	call   32a5 <_set_idtr>
    330c:	e8 58 fe ff ff       	call   3169 <_init_irq>
    3311:	c7 04 24 32 00 00 00 	mov    DWORD PTR [esp],0x32
    3318:	e8 87 ea ff ff       	call   1da4 <_init_clock>
    331d:	e8 bc ec ff ff       	call   1fde <_init_keyboard>
    3322:	e8 91 f3 ff ff       	call   26b8 <_init_hd>
    3327:	90                   	nop
    3328:	c9                   	leave  
    3329:	c3                   	ret    
    332a:	90                   	nop
    332b:	90                   	nop

0000332c <_set_interrupt_handler>:
    332c:	55                   	push   ebp
    332d:	89 e5                	mov    ebp,esp
    332f:	83 ec 04             	sub    esp,0x4
    3332:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3335:	88 45 fc             	mov    BYTE PTR [ebp-0x4],al
    3338:	0f b6 45 fc          	movzx  eax,BYTE PTR [ebp-0x4]
    333c:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    333f:	89 14 85 40 61 00 00 	mov    DWORD PTR [eax*4+0x6140],edx
    3346:	90                   	nop
    3347:	c9                   	leave  
    3348:	c3                   	ret    

00003349 <_isr_handler>:
    3349:	55                   	push   ebp
    334a:	89 e5                	mov    ebp,esp
    334c:	83 ec 28             	sub    esp,0x28
    334f:	a1 bc 65 00 00       	mov    eax,ds:0x65bc
    3354:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    3357:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    335a:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    335d:	8b 04 85 40 61 00 00 	mov    eax,DWORD PTR [eax*4+0x6140]
    3364:	85 c0                	test   eax,eax
    3366:	74 17                	je     337f <_isr_handler+0x36>
    3368:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    336b:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    336e:	8b 04 85 40 61 00 00 	mov    eax,DWORD PTR [eax*4+0x6140]
    3375:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    3378:	89 14 24             	mov    DWORD PTR [esp],edx
    337b:	ff d0                	call   eax
    337d:	eb 39                	jmp    33b8 <_isr_handler+0x6f>
    337f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3382:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    3385:	83 f8 2f             	cmp    eax,0x2f
    3388:	76 2e                	jbe    33b8 <_isr_handler+0x6f>
    338a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    338d:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    3390:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3394:	c7 04 24 18 44 00 00 	mov    DWORD PTR [esp],0x4418
    339b:	e8 a5 f2 ff ff       	call   2645 <_kprintf>
    33a0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    33a3:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    33a6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    33aa:	c7 04 24 32 44 00 00 	mov    DWORD PTR [esp],0x4432
    33b1:	e8 8f f2 ff ff       	call   2645 <_kprintf>
    33b6:	eb fe                	jmp    33b6 <_isr_handler+0x6d>
    33b8:	90                   	nop
    33b9:	c9                   	leave  
    33ba:	c3                   	ret    
    33bb:	90                   	nop

000033bc <_itoa>:
    33bc:	55                   	push   ebp
    33bd:	89 e5                	mov    ebp,esp
    33bf:	83 ec 38             	sub    esp,0x38
    33c2:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    33c9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    33cc:	8b 00                	mov    eax,DWORD PTR [eax]
    33ce:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    33d1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    33d4:	0f b6 40 08          	movzx  eax,BYTE PTR [eax+0x8]
    33d8:	83 e0 1f             	and    eax,0x1f
    33db:	0f b6 c0             	movzx  eax,al
    33de:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    33e1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    33e4:	0f b6 40 09          	movzx  eax,BYTE PTR [eax+0x9]
    33e8:	3c 01                	cmp    al,0x1
    33ea:	77 0b                	ja     33f7 <_itoa+0x3b>
    33ec:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    33ef:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    33f2:	e9 5c 01 00 00       	jmp    3553 <_itoa+0x197>
    33f7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    33fa:	0f b6 40 08          	movzx  eax,BYTE PTR [eax+0x8]
    33fe:	83 e0 1f             	and    eax,0x1f
    3401:	3c 10                	cmp    al,0x10
    3403:	76 07                	jbe    340c <_itoa+0x50>
    3405:	c7 45 e4 10 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x10
    340c:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    3410:	75 20                	jne    3432 <_itoa+0x76>
    3412:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3415:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3418:	c6 00 30             	mov    BYTE PTR [eax],0x30
    341b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    341e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3421:	83 c0 01             	add    eax,0x1
    3424:	c6 00 00             	mov    BYTE PTR [eax],0x0
    3427:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    342a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    342d:	e9 21 01 00 00       	jmp    3553 <_itoa+0x197>
    3432:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3435:	0f b6 40 09          	movzx  eax,BYTE PTR [eax+0x9]
    3439:	0f b6 d0             	movzx  edx,al
    343c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    343f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3442:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    3446:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    344d:	00 
    344e:	89 04 24             	mov    DWORD PTR [esp],eax
    3451:	e8 8a 04 00 00       	call   38e0 <_memset>
    3456:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3459:	0f b6 40 08          	movzx  eax,BYTE PTR [eax+0x8]
    345d:	83 e0 20             	and    eax,0x20
    3460:	84 c0                	test   al,al
    3462:	74 19                	je     347d <_itoa+0xc1>
    3464:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    3468:	79 13                	jns    347d <_itoa+0xc1>
    346a:	f7 5d e8             	neg    DWORD PTR [ebp-0x18]
    346d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3470:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3473:	c6 00 2d             	mov    BYTE PTR [eax],0x2d
    3476:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
    347d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3480:	0f b6 40 09          	movzx  eax,BYTE PTR [eax+0x9]
    3484:	0f b6 c0             	movzx  eax,al
    3487:	83 e8 02             	sub    eax,0x2
    348a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    348d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    3490:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    3493:	eb 6b                	jmp    3500 <_itoa+0x144>
    3495:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    3498:	ba 00 00 00 00       	mov    edx,0x0
    349d:	f7 75 e4             	div    DWORD PTR [ebp-0x1c]
    34a0:	89 d0                	mov    eax,edx
    34a2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    34a5:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    34a8:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    34ab:	ba 00 00 00 00       	mov    edx,0x0
    34b0:	f7 75 e4             	div    DWORD PTR [ebp-0x1c]
    34b3:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    34b6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    34b9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    34bc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    34bf:	01 c2                	add    edx,eax
    34c1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    34c4:	05 9c 44 00 00       	add    eax,0x449c
    34c9:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    34cc:	88 02                	mov    BYTE PTR [edx],al
    34ce:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    34d1:	0f b6 40 08          	movzx  eax,BYTE PTR [eax+0x8]
    34d5:	83 e0 40             	and    eax,0x40
    34d8:	84 c0                	test   al,al
    34da:	75 20                	jne    34fc <_itoa+0x140>
    34dc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    34df:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    34e2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    34e5:	01 d0                	add    eax,edx
    34e7:	0f b6 08             	movzx  ecx,BYTE PTR [eax]
    34ea:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    34ed:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    34f0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    34f3:	01 d0                	add    eax,edx
    34f5:	83 c9 20             	or     ecx,0x20
    34f8:	89 ca                	mov    edx,ecx
    34fa:	88 10                	mov    BYTE PTR [eax],dl
    34fc:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
    3500:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3503:	3b 45 ec             	cmp    eax,DWORD PTR [ebp-0x14]
    3506:	7c 06                	jl     350e <_itoa+0x152>
    3508:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    350c:	75 87                	jne    3495 <_itoa+0xd9>
    350e:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    3512:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    3515:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    3518:	eb 24                	jmp    353e <_itoa+0x182>
    351a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    351d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3520:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3523:	8d 0c 02             	lea    ecx,[edx+eax*1]
    3526:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3529:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    352c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    352f:	01 c2                	add    edx,eax
    3531:	0f b6 01             	movzx  eax,BYTE PTR [ecx]
    3534:	88 02                	mov    BYTE PTR [edx],al
    3536:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    353a:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    353e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3541:	0f b6 40 09          	movzx  eax,BYTE PTR [eax+0x9]
    3545:	0f b6 c0             	movzx  eax,al
    3548:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    354b:	7c cd                	jl     351a <_itoa+0x15e>
    354d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3550:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3553:	c9                   	leave  
    3554:	c3                   	ret    

00003555 <_strlen>:
    3555:	55                   	push   ebp
    3556:	89 e5                	mov    ebp,esp
    3558:	83 ec 10             	sub    esp,0x10
    355b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    355e:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
    3561:	eb 04                	jmp    3567 <_strlen+0x12>
    3563:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
    3567:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    356a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    356d:	84 c0                	test   al,al
    356f:	75 f2                	jne    3563 <_strlen+0xe>
    3571:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    3574:	2b 45 08             	sub    eax,DWORD PTR [ebp+0x8]
    3577:	c9                   	leave  
    3578:	c3                   	ret    

00003579 <_vsnprintf>:
    3579:	55                   	push   ebp
    357a:	89 e5                	mov    ebp,esp
    357c:	83 ec 58             	sub    esp,0x58
    357f:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    3586:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    358d:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [ebp-0x3c],0x0
    3594:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
    359b:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    35a2:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    35a9:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
    35b0:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    35b7:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    35be:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    35c5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    35c8:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    35cc:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    35d3:	00 
    35d4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    35d7:	89 04 24             	mov    DWORD PTR [esp],eax
    35da:	e8 01 03 00 00       	call   38e0 <_memset>
    35df:	83 7d 0c 01          	cmp    DWORD PTR [ebp+0xc],0x1
    35e3:	77 0a                	ja     35ef <_vsnprintf+0x76>
    35e5:	b8 00 00 00 00       	mov    eax,0x0
    35ea:	e9 17 02 00 00       	jmp    3806 <_vsnprintf+0x28d>
    35ef:	83 6d 0c 01          	sub    DWORD PTR [ebp+0xc],0x1
    35f3:	8d 45 c4             	lea    eax,[ebp-0x3c]
    35f6:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
    35f9:	c6 45 c1 20          	mov    BYTE PTR [ebp-0x3f],0x20
    35fd:	e9 e2 01 00 00       	jmp    37e4 <_vsnprintf+0x26b>
    3602:	0f b6 45 c0          	movzx  eax,BYTE PTR [ebp-0x40]
    3606:	83 c8 40             	or     eax,0x40
    3609:	88 45 c0             	mov    BYTE PTR [ebp-0x40],al
    360c:	0f b6 45 c0          	movzx  eax,BYTE PTR [ebp-0x40]
    3610:	83 c8 20             	or     eax,0x20
    3613:	88 45 c0             	mov    BYTE PTR [ebp-0x40],al
    3616:	0f b6 45 c0          	movzx  eax,BYTE PTR [ebp-0x40]
    361a:	83 e0 e0             	and    eax,0xffffffe0
    361d:	83 c8 0a             	or     eax,0xa
    3620:	88 45 c0             	mov    BYTE PTR [ebp-0x40],al
    3623:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    362a:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    3631:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    3634:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    3637:	3c 25                	cmp    al,0x25
    3639:	0f 85 86 01 00 00    	jne    37c5 <_vsnprintf+0x24c>
    363f:	90                   	nop
    3640:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    3643:	83 c0 01             	add    eax,0x1
    3646:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    3649:	83 c8 20             	or     eax,0x20
    364c:	0f be c0             	movsx  eax,al
    364f:	83 f8 25             	cmp    eax,0x25
    3652:	74 30                	je     3684 <_vsnprintf+0x10b>
    3654:	83 f8 25             	cmp    eax,0x25
    3657:	0f 8c 6b 01 00 00    	jl     37c8 <_vsnprintf+0x24f>
    365d:	83 f8 78             	cmp    eax,0x78
    3660:	0f 8f 62 01 00 00    	jg     37c8 <_vsnprintf+0x24f>
    3666:	83 f8 62             	cmp    eax,0x62
    3669:	0f 8c 59 01 00 00    	jl     37c8 <_vsnprintf+0x24f>
    366f:	83 e8 62             	sub    eax,0x62
    3672:	83 f8 16             	cmp    eax,0x16
    3675:	0f 87 4d 01 00 00    	ja     37c8 <_vsnprintf+0x24f>
    367b:	8b 04 85 40 44 00 00 	mov    eax,DWORD PTR [eax*4+0x4440]
    3682:	ff e0                	jmp    eax
    3684:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3687:	8d 50 01             	lea    edx,[eax+0x1]
    368a:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
    368d:	c6 00 25             	mov    BYTE PTR [eax],0x25
    3690:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    3694:	83 45 10 02          	add    DWORD PTR [ebp+0x10],0x2
    3698:	e9 26 01 00 00       	jmp    37c3 <_vsnprintf+0x24a>
    369d:	83 45 14 04          	add    DWORD PTR [ebp+0x14],0x4
    36a1:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    36a4:	83 e8 04             	sub    eax,0x4
    36a7:	8b 08                	mov    ecx,DWORD PTR [eax]
    36a9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    36ac:	8d 50 01             	lea    edx,[eax+0x1]
    36af:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
    36b2:	89 ca                	mov    edx,ecx
    36b4:	88 10                	mov    BYTE PTR [eax],dl
    36b6:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    36ba:	83 45 10 02          	add    DWORD PTR [ebp+0x10],0x2
    36be:	e9 00 01 00 00       	jmp    37c3 <_vsnprintf+0x24a>
    36c3:	0f b6 45 c0          	movzx  eax,BYTE PTR [ebp-0x40]
    36c7:	83 e0 e0             	and    eax,0xffffffe0
    36ca:	83 c8 02             	or     eax,0x2
    36cd:	88 45 c0             	mov    BYTE PTR [ebp-0x40],al
    36d0:	eb 36                	jmp    3708 <_vsnprintf+0x18f>
    36d2:	0f b6 45 c0          	movzx  eax,BYTE PTR [ebp-0x40]
    36d6:	83 e0 e0             	and    eax,0xffffffe0
    36d9:	83 c8 08             	or     eax,0x8
    36dc:	88 45 c0             	mov    BYTE PTR [ebp-0x40],al
    36df:	eb 27                	jmp    3708 <_vsnprintf+0x18f>
    36e1:	0f b6 45 c0          	movzx  eax,BYTE PTR [ebp-0x40]
    36e5:	83 e0 e0             	and    eax,0xffffffe0
    36e8:	83 c8 10             	or     eax,0x10
    36eb:	88 45 c0             	mov    BYTE PTR [ebp-0x40],al
    36ee:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    36f1:	83 c0 01             	add    eax,0x1
    36f4:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    36f7:	3c 78                	cmp    al,0x78
    36f9:	75 0c                	jne    3707 <_vsnprintf+0x18e>
    36fb:	0f b6 45 c0          	movzx  eax,BYTE PTR [ebp-0x40]
    36ff:	83 e0 bf             	and    eax,0xffffffbf
    3702:	88 45 c0             	mov    BYTE PTR [ebp-0x40],al
    3705:	eb 01                	jmp    3708 <_vsnprintf+0x18f>
    3707:	90                   	nop
    3708:	0f b6 45 c0          	movzx  eax,BYTE PTR [ebp-0x40]
    370c:	83 e0 df             	and    eax,0xffffffdf
    370f:	88 45 c0             	mov    BYTE PTR [ebp-0x40],al
    3712:	83 45 14 04          	add    DWORD PTR [ebp+0x14],0x4
    3716:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    3719:	8b 40 fc             	mov    eax,DWORD PTR [eax-0x4]
    371c:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    371f:	8d 45 b8             	lea    eax,[ebp-0x48]
    3722:	89 04 24             	mov    DWORD PTR [esp],eax
    3725:	e8 92 fc ff ff       	call   33bc <_itoa>
    372a:	89 04 24             	mov    DWORD PTR [esp],eax
    372d:	e8 23 fe ff ff       	call   3555 <_strlen>
    3732:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    3735:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    3738:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    373b:	01 d0                	add    eax,edx
    373d:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
    3740:	0f 86 b6 00 00 00    	jbe    37fc <_vsnprintf+0x283>
    3746:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3749:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    374d:	8d 45 c4             	lea    eax,[ebp-0x3c]
    3750:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3754:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3757:	89 04 24             	mov    DWORD PTR [esp],eax
    375a:	e8 b1 01 00 00       	call   3910 <_memcpy>
    375f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3762:	01 45 08             	add    DWORD PTR [ebp+0x8],eax
    3765:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3768:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
    376b:	83 45 10 02          	add    DWORD PTR [ebp+0x10],0x2
    376f:	eb 52                	jmp    37c3 <_vsnprintf+0x24a>
    3771:	83 45 14 04          	add    DWORD PTR [ebp+0x14],0x4
    3775:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    3778:	8b 40 fc             	mov    eax,DWORD PTR [eax-0x4]
    377b:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    377e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3781:	89 04 24             	mov    DWORD PTR [esp],eax
    3784:	e8 cc fd ff ff       	call   3555 <_strlen>
    3789:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    378c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    378f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3792:	01 d0                	add    eax,edx
    3794:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
    3797:	76 66                	jbe    37ff <_vsnprintf+0x286>
    3799:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    379c:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    37a0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    37a3:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    37a7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    37aa:	89 04 24             	mov    DWORD PTR [esp],eax
    37ad:	e8 5e 01 00 00       	call   3910 <_memcpy>
    37b2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    37b5:	01 45 08             	add    DWORD PTR [ebp+0x8],eax
    37b8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    37bb:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
    37be:	83 45 10 02          	add    DWORD PTR [ebp+0x10],0x2
    37c2:	90                   	nop
    37c3:	eb 1f                	jmp    37e4 <_vsnprintf+0x26b>
    37c5:	90                   	nop
    37c6:	eb 01                	jmp    37c9 <_vsnprintf+0x250>
    37c8:	90                   	nop
    37c9:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    37cd:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    37d0:	8d 42 01             	lea    eax,[edx+0x1]
    37d3:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
    37d6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    37d9:	8d 48 01             	lea    ecx,[eax+0x1]
    37dc:	89 4d 08             	mov    DWORD PTR [ebp+0x8],ecx
    37df:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    37e2:	88 10                	mov    BYTE PTR [eax],dl
    37e4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    37e7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    37ea:	84 c0                	test   al,al
    37ec:	74 14                	je     3802 <_vsnprintf+0x289>
    37ee:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    37f1:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    37f4:	0f 82 08 fe ff ff    	jb     3602 <_vsnprintf+0x89>
    37fa:	eb 06                	jmp    3802 <_vsnprintf+0x289>
    37fc:	90                   	nop
    37fd:	eb 04                	jmp    3803 <_vsnprintf+0x28a>
    37ff:	90                   	nop
    3800:	eb 01                	jmp    3803 <_vsnprintf+0x28a>
    3802:	90                   	nop
    3803:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3806:	c9                   	leave  
    3807:	c3                   	ret    

00003808 <_snprintf>:
    3808:	55                   	push   ebp
    3809:	89 e5                	mov    ebp,esp
    380b:	83 ec 28             	sub    esp,0x28
    380e:	8d 45 10             	lea    eax,[ebp+0x10]
    3811:	83 c0 04             	add    eax,0x4
    3814:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    3817:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    381a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    381d:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    3821:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    3825:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3828:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    382c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    382f:	89 04 24             	mov    DWORD PTR [esp],eax
    3832:	e8 42 fd ff ff       	call   3579 <_vsnprintf>
    3837:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    383a:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    3841:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3844:	c9                   	leave  
    3845:	c3                   	ret    

00003846 <_strcmp>:
    3846:	55                   	push   ebp
    3847:	89 e5                	mov    ebp,esp
    3849:	eb 30                	jmp    387b <_strcmp+0x35>
    384b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    384e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3851:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3854:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    3857:	38 c2                	cmp    dl,al
    3859:	74 18                	je     3873 <_strcmp+0x2d>
    385b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    385e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    3861:	0f be d0             	movsx  edx,al
    3864:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3867:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    386a:	0f be c0             	movsx  eax,al
    386d:	29 c2                	sub    edx,eax
    386f:	89 d0                	mov    eax,edx
    3871:	eb 21                	jmp    3894 <_strcmp+0x4e>
    3873:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
    3877:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    387b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    387e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    3881:	84 c0                	test   al,al
    3883:	74 0a                	je     388f <_strcmp+0x49>
    3885:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3888:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    388b:	84 c0                	test   al,al
    388d:	75 bc                	jne    384b <_strcmp+0x5>
    388f:	b8 00 00 00 00       	mov    eax,0x0
    3894:	5d                   	pop    ebp
    3895:	c3                   	ret    
    3896:	90                   	nop
    3897:	90                   	nop

00003898 <_isalpha>:
    3898:	55                   	push   ebp
    3899:	89 e5                	mov    ebp,esp
    389b:	83 7d 08 60          	cmp    DWORD PTR [ebp+0x8],0x60
    389f:	7e 06                	jle    38a7 <_isalpha+0xf>
    38a1:	83 7d 08 7a          	cmp    DWORD PTR [ebp+0x8],0x7a
    38a5:	7e 0c                	jle    38b3 <_isalpha+0x1b>
    38a7:	83 7d 08 40          	cmp    DWORD PTR [ebp+0x8],0x40
    38ab:	7e 0d                	jle    38ba <_isalpha+0x22>
    38ad:	83 7d 08 5a          	cmp    DWORD PTR [ebp+0x8],0x5a
    38b1:	7f 07                	jg     38ba <_isalpha+0x22>
    38b3:	b8 01 00 00 00       	mov    eax,0x1
    38b8:	eb 05                	jmp    38bf <_isalpha+0x27>
    38ba:	b8 00 00 00 00       	mov    eax,0x0
    38bf:	5d                   	pop    ebp
    38c0:	c3                   	ret    

000038c1 <_isdigit>:
    38c1:	55                   	push   ebp
    38c2:	89 e5                	mov    ebp,esp
    38c4:	83 7d 08 2f          	cmp    DWORD PTR [ebp+0x8],0x2f
    38c8:	7e 0d                	jle    38d7 <_isdigit+0x16>
    38ca:	83 7d 08 39          	cmp    DWORD PTR [ebp+0x8],0x39
    38ce:	7f 07                	jg     38d7 <_isdigit+0x16>
    38d0:	b8 01 00 00 00       	mov    eax,0x1
    38d5:	eb 05                	jmp    38dc <_isdigit+0x1b>
    38d7:	b8 00 00 00 00       	mov    eax,0x0
    38dc:	5d                   	pop    ebp
    38dd:	c3                   	ret    
    38de:	90                   	nop
    38df:	90                   	nop

000038e0 <_memset>:
    38e0:	8b 4c 24 0c          	mov    ecx,DWORD PTR [esp+0xc]
    38e4:	c1 e9 02             	shr    ecx,0x2
    38e7:	8b 7c 24 04          	mov    edi,DWORD PTR [esp+0x4]
    38eb:	31 c0                	xor    eax,eax
    38ed:	8a 44 24 08          	mov    al,BYTE PTR [esp+0x8]
    38f1:	88 c4                	mov    ah,al
    38f3:	50                   	push   eax
    38f4:	c1 e0 10             	shl    eax,0x10
    38f7:	0b 04 24             	or     eax,DWORD PTR [esp]
    38fa:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    38fc:	8b 4c 24 10          	mov    ecx,DWORD PTR [esp+0x10]
    3900:	83 e1 03             	and    ecx,0x3
    3903:	f3 aa                	rep stos BYTE PTR es:[edi],al
    3905:	83 c4 04             	add    esp,0x4
    3908:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    390c:	c3                   	ret    
    390d:	66 90                	xchg   ax,ax
    390f:	90                   	nop

00003910 <_memcpy>:
    3910:	55                   	push   ebp
    3911:	89 e5                	mov    ebp,esp
    3913:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3916:	8b 5d 10             	mov    ebx,DWORD PTR [ebp+0x10]
    3919:	83 e3 03             	and    ebx,0x3
    391c:	8b 4d 10             	mov    ecx,DWORD PTR [ebp+0x10]
    391f:	c1 e9 02             	shr    ecx,0x2
    3922:	8b 75 0c             	mov    esi,DWORD PTR [ebp+0xc]
    3925:	89 c7                	mov    edi,eax
    3927:	f3 a5                	rep movs DWORD PTR es:[edi],DWORD PTR ds:[esi]
    3929:	89 d9                	mov    ecx,ebx
    392b:	f3 a4                	rep movs BYTE PTR es:[edi],BYTE PTR ds:[esi]
    392d:	c9                   	leave  
    392e:	c3                   	ret    
    392f:	90                   	nop

00003930 <_switch_to>:
    3930:	8b 4c 24 04          	mov    ecx,DWORD PTR [esp+0x4]
    3934:	55                   	push   ebp
    3935:	53                   	push   ebx
    3936:	56                   	push   esi
    3937:	57                   	push   edi
    3938:	a1 bc 65 00 00       	mov    eax,ds:0x65bc
    393d:	89 60 50             	mov    DWORD PTR [eax+0x50],esp
    3940:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    3943:	89 41 30             	mov    DWORD PTR [ecx+0x30],eax
    3946:	8b 41 54             	mov    eax,DWORD PTR [ecx+0x54]
    3949:	0f 22 d8             	mov    cr3,eax
    394c:	8b 61 50             	mov    esp,DWORD PTR [ecx+0x50]
    394f:	8d 41 4c             	lea    eax,[ecx+0x4c]
    3952:	a3 44 65 00 00       	mov    ds:0x6544,eax
    3957:	89 0d bc 65 00 00    	mov    DWORD PTR ds:0x65bc,ecx
    395d:	5f                   	pop    edi
    395e:	5e                   	pop    esi
    395f:	5b                   	pop    ebx
    3960:	5d                   	pop    ebp
    3961:	c3                   	ret    
    3962:	66 90                	xchg   ax,ax
    3964:	66 90                	xchg   ax,ax
    3966:	66 90                	xchg   ax,ax
    3968:	66 90                	xchg   ax,ax
    396a:	66 90                	xchg   ax,ax
    396c:	66 90                	xchg   ax,ax
    396e:	66 90                	xchg   ax,ax

00003970 <_test_C>:
    3970:	55                   	push   ebp
    3971:	89 e5                	mov    ebp,esp
    3973:	68 8e 39 00 00       	push   0x398e

00003978 <@1>:
    3978:	b8 01 00 00 00       	mov    eax,0x1
    397d:	cd 80                	int    0x80
    397f:	e8 02 00 00 00       	call   3986 <_print_screen>
    3984:	eb f2                	jmp    3978 <@1>

00003986 <_print_screen>:
    3986:	b8 00 00 00 00       	mov    eax,0x0
    398b:	cd 80                	int    0x80
    398d:	c3                   	ret    

0000398e <_string>:
    398e:	43                   	inc    ebx
	...

00003990 <_test_B>:
    3990:	55                   	push   ebp
    3991:	89 e5                	mov    ebp,esp
    3993:	68 ae 39 00 00       	push   0x39ae

00003998 <@1>:
    3998:	b8 01 00 00 00       	mov    eax,0x1
    399d:	cd 80                	int    0x80
    399f:	e8 02 00 00 00       	call   39a6 <_print_screen>
    39a4:	eb f2                	jmp    3998 <@1>

000039a6 <_print_screen>:
    39a6:	b8 00 00 00 00       	mov    eax,0x0
    39ab:	cd 80                	int    0x80
    39ad:	c3                   	ret    

000039ae <_string>:
    39ae:	42                   	inc    edx
	...

000039b0 <_memset_w>:
    39b0:	55                   	push   ebp
    39b1:	89 e5                	mov    ebp,esp
    39b3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    39b6:	8b 4d 10             	mov    ecx,DWORD PTR [ebp+0x10]
    39b9:	8b 7d 08             	mov    edi,DWORD PTR [ebp+0x8]
    39bc:	fc                   	cld    
    39bd:	f3 66 ab             	rep stos WORD PTR es:[edi],ax
    39c0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    39c3:	c9                   	leave  
    39c4:	c3                   	ret    
    39c5:	66 90                	xchg   ax,ax
    39c7:	66 90                	xchg   ax,ax
    39c9:	66 90                	xchg   ax,ax
    39cb:	66 90                	xchg   ax,ax
    39cd:	66 90                	xchg   ax,ax
    39cf:	90                   	nop

000039d0 <_test_A>:
    39d0:	55                   	push   ebp
    39d1:	89 e5                	mov    ebp,esp
    39d3:	68 ee 39 00 00       	push   0x39ee

000039d8 <@1>:
    39d8:	b8 01 00 00 00       	mov    eax,0x1
    39dd:	cd 80                	int    0x80
    39df:	e8 02 00 00 00       	call   39e6 <_print_screen>
    39e4:	eb f2                	jmp    39d8 <@1>

000039e6 <_print_screen>:
    39e6:	b8 00 00 00 00       	mov    eax,0x0
    39eb:	cd 80                	int    0x80
    39ed:	c3                   	ret    

000039ee <string>:
    39ee:	41                   	inc    ecx
	...

000039f0 <_get_tick>:
    39f0:	b8 01 00 00 00       	mov    eax,0x1
    39f5:	cd 80                	int    0x80
    39f7:	c3                   	ret    
    39f8:	66 90                	xchg   ax,ax
    39fa:	66 90                	xchg   ax,ax
    39fc:	66 90                	xchg   ax,ax
    39fe:	66 90                	xchg   ax,ax

00003a00 <_print_screen>:
    3a00:	b8 00 00 00 00       	mov    eax,0x0
    3a05:	cd 80                	int    0x80
    3a07:	c3                   	ret    

00003a08 <_sys_print_screen>:
    3a08:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    3a0c:	8b 00                	mov    eax,DWORD PTR [eax]
    3a0e:	50                   	push   eax
    3a0f:	e8 1c ea ff ff       	call   2430 <_kprint>
    3a14:	83 c4 04             	add    esp,0x4
    3a17:	c3                   	ret    
    3a18:	66 90                	xchg   ax,ax
    3a1a:	66 90                	xchg   ax,ax
    3a1c:	66 90                	xchg   ax,ax
    3a1e:	66 90                	xchg   ax,ax

00003a20 <_reload_gdtr>:
    3a20:	55                   	push   ebp
    3a21:	89 e5                	mov    ebp,esp
    3a23:	83 ec 08             	sub    esp,0x8
    3a26:	0f 01 04 24          	sgdtd  [esp]
    3a2a:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
    3a2d:	31 c9                	xor    ecx,ecx
    3a2f:	66 8b 0c 24          	mov    cx,WORD PTR [esp]
    3a33:	41                   	inc    ecx
    3a34:	c1 e9 02             	shr    ecx,0x2
    3a37:	8b 74 24 02          	mov    esi,DWORD PTR [esp+0x2]
    3a3b:	8b 7b 02             	mov    edi,DWORD PTR [ebx+0x2]
    3a3e:	89 7c 24 02          	mov    DWORD PTR [esp+0x2],edi
    3a42:	66 8b 13             	mov    dx,WORD PTR [ebx]
    3a45:	66 89 14 24          	mov    WORD PTR [esp],dx
    3a49:	0f 01 14 24          	lgdtd  [esp]
    3a4d:	fc                   	cld    
    3a4e:	f3 a5                	rep movs DWORD PTR es:[edi],DWORD PTR ds:[esi]
    3a50:	c9                   	leave  
    3a51:	c3                   	ret    
    3a52:	66 90                	xchg   ax,ax
    3a54:	66 90                	xchg   ax,ax
    3a56:	66 90                	xchg   ax,ax
    3a58:	66 90                	xchg   ax,ax
    3a5a:	66 90                	xchg   ax,ax
    3a5c:	66 90                	xchg   ax,ax
    3a5e:	66 90                	xchg   ax,ax

00003a60 <_load_ldtr>:
    3a60:	0f 00 54 24 04       	lldt   WORD PTR [esp+0x4]
    3a65:	c3                   	ret    
    3a66:	66 90                	xchg   ax,ax
    3a68:	66 90                	xchg   ax,ax
    3a6a:	66 90                	xchg   ax,ax
    3a6c:	66 90                	xchg   ax,ax
    3a6e:	66 90                	xchg   ax,ax

00003a70 <_start_paging>:
    3a70:	0f 20 c0             	mov    eax,cr0
    3a73:	0d 00 00 00 80       	or     eax,0x80000000
    3a78:	0f 22 c0             	mov    cr0,eax
    3a7b:	c3                   	ret    

00003a7c <_get_page_fault_addr>:
    3a7c:	0f 20 d0             	mov    eax,cr2
    3a7f:	c3                   	ret    

00003a80 <_set_cr3>:
    3a80:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    3a84:	0f 22 d8             	mov    cr3,eax
    3a87:	c3                   	ret    

00003a88 <_get_cr3>:
    3a88:	0f 20 d8             	mov    eax,cr3
    3a8b:	25 00 f0 ff ff       	and    eax,0xfffff000
    3a90:	c3                   	ret    

00003a91 <_invalidate_page>:
    3a91:	0f 01 7c 24 04       	invlpg BYTE PTR [esp+0x4]
    3a96:	c3                   	ret    
    3a97:	66 90                	xchg   ax,ax
    3a99:	66 90                	xchg   ax,ax
    3a9b:	66 90                	xchg   ax,ax
    3a9d:	66 90                	xchg   ax,ax
    3a9f:	90                   	nop

00003aa0 <_isr_common_stub>:
    3aa0:	60                   	pusha  
    3aa1:	1e                   	push   ds
    3aa2:	06                   	push   es
    3aa3:	0f a0                	push   fs
    3aa5:	0f a8                	push   gs
    3aa7:	e8 9d f8 ff ff       	call   3349 <_isr_handler>

00003aac <_return_to_user>:
    3aac:	8b 4c 24 30          	mov    ecx,DWORD PTR [esp+0x30]
    3ab0:	83 f9 20             	cmp    ecx,0x20
    3ab3:	72 10                	jb     3ac5 <not_irq>
    3ab5:	83 f9 2f             	cmp    ecx,0x2f
    3ab8:	77 0b                	ja     3ac5 <not_irq>
    3aba:	b0 20                	mov    al,0x20
    3abc:	83 f9 28             	cmp    ecx,0x28
    3abf:	72 02                	jb     3ac3 <not_slave>
    3ac1:	e6 a0                	out    0xa0,al

00003ac3 <not_slave>:
    3ac3:	e6 20                	out    0x20,al

00003ac5 <not_irq>:
    3ac5:	0f a9                	pop    gs
    3ac7:	0f a1                	pop    fs
    3ac9:	07                   	pop    es
    3aca:	1f                   	pop    ds
    3acb:	61                   	popa   
    3acc:	83 c4 08             	add    esp,0x8
    3acf:	cf                   	iret   

00003ad0 <_isr0>:
    3ad0:	fa                   	cli    
    3ad1:	6a 00                	push   0x0
    3ad3:	6a 00                	push   0x0
    3ad5:	eb c9                	jmp    3aa0 <_isr_common_stub>

00003ad7 <_isr1>:
    3ad7:	fa                   	cli    
    3ad8:	6a 00                	push   0x0
    3ada:	6a 01                	push   0x1
    3adc:	eb c2                	jmp    3aa0 <_isr_common_stub>

00003ade <_isr2>:
    3ade:	fa                   	cli    
    3adf:	6a 00                	push   0x0
    3ae1:	6a 02                	push   0x2
    3ae3:	eb bb                	jmp    3aa0 <_isr_common_stub>

00003ae5 <_isr3>:
    3ae5:	fa                   	cli    
    3ae6:	6a 00                	push   0x0
    3ae8:	6a 03                	push   0x3
    3aea:	eb b4                	jmp    3aa0 <_isr_common_stub>

00003aec <_isr4>:
    3aec:	fa                   	cli    
    3aed:	6a 00                	push   0x0
    3aef:	6a 04                	push   0x4
    3af1:	eb ad                	jmp    3aa0 <_isr_common_stub>

00003af3 <_isr5>:
    3af3:	fa                   	cli    
    3af4:	6a 00                	push   0x0
    3af6:	6a 05                	push   0x5
    3af8:	eb a6                	jmp    3aa0 <_isr_common_stub>

00003afa <_isr6>:
    3afa:	fa                   	cli    
    3afb:	6a 00                	push   0x0
    3afd:	6a 06                	push   0x6
    3aff:	eb 9f                	jmp    3aa0 <_isr_common_stub>

00003b01 <_isr7>:
    3b01:	fa                   	cli    
    3b02:	6a 00                	push   0x0
    3b04:	6a 07                	push   0x7
    3b06:	eb 98                	jmp    3aa0 <_isr_common_stub>

00003b08 <_isr8>:
    3b08:	fa                   	cli    
    3b09:	6a 08                	push   0x8
    3b0b:	eb 93                	jmp    3aa0 <_isr_common_stub>

00003b0d <_isr9>:
    3b0d:	fa                   	cli    
    3b0e:	6a 00                	push   0x0
    3b10:	6a 09                	push   0x9
    3b12:	eb 8c                	jmp    3aa0 <_isr_common_stub>

00003b14 <_isr10>:
    3b14:	fa                   	cli    
    3b15:	6a 0a                	push   0xa
    3b17:	eb 87                	jmp    3aa0 <_isr_common_stub>

00003b19 <_isr11>:
    3b19:	fa                   	cli    
    3b1a:	6a 0b                	push   0xb
    3b1c:	eb 82                	jmp    3aa0 <_isr_common_stub>

00003b1e <_isr12>:
    3b1e:	fa                   	cli    
    3b1f:	6a 0c                	push   0xc
    3b21:	e9 7a ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b26 <_isr13>:
    3b26:	fa                   	cli    
    3b27:	6a 0d                	push   0xd
    3b29:	e9 72 ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b2e <_isr14>:
    3b2e:	fa                   	cli    
    3b2f:	6a 0e                	push   0xe
    3b31:	e9 6a ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b36 <_isr15>:
    3b36:	fa                   	cli    
    3b37:	6a 00                	push   0x0
    3b39:	6a 0f                	push   0xf
    3b3b:	e9 60 ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b40 <_isr16>:
    3b40:	fa                   	cli    
    3b41:	6a 00                	push   0x0
    3b43:	6a 10                	push   0x10
    3b45:	e9 56 ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b4a <_isr17>:
    3b4a:	fa                   	cli    
    3b4b:	6a 00                	push   0x0
    3b4d:	6a 11                	push   0x11
    3b4f:	e9 4c ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b54 <_isr18>:
    3b54:	fa                   	cli    
    3b55:	6a 00                	push   0x0
    3b57:	6a 12                	push   0x12
    3b59:	e9 42 ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b5e <_isr19>:
    3b5e:	fa                   	cli    
    3b5f:	6a 00                	push   0x0
    3b61:	6a 13                	push   0x13
    3b63:	e9 38 ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b68 <_isr20>:
    3b68:	fa                   	cli    
    3b69:	6a 00                	push   0x0
    3b6b:	6a 14                	push   0x14
    3b6d:	e9 2e ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b72 <_isr21>:
    3b72:	fa                   	cli    
    3b73:	6a 00                	push   0x0
    3b75:	6a 15                	push   0x15
    3b77:	e9 24 ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b7c <_isr22>:
    3b7c:	fa                   	cli    
    3b7d:	6a 00                	push   0x0
    3b7f:	6a 16                	push   0x16
    3b81:	e9 1a ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b86 <_isr23>:
    3b86:	fa                   	cli    
    3b87:	6a 00                	push   0x0
    3b89:	6a 17                	push   0x17
    3b8b:	e9 10 ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b90 <_isr24>:
    3b90:	fa                   	cli    
    3b91:	6a 00                	push   0x0
    3b93:	6a 18                	push   0x18
    3b95:	e9 06 ff ff ff       	jmp    3aa0 <_isr_common_stub>

00003b9a <_isr25>:
    3b9a:	fa                   	cli    
    3b9b:	6a 00                	push   0x0
    3b9d:	6a 19                	push   0x19
    3b9f:	e9 fc fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003ba4 <_isr26>:
    3ba4:	fa                   	cli    
    3ba5:	6a 00                	push   0x0
    3ba7:	6a 1a                	push   0x1a
    3ba9:	e9 f2 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003bae <_isr27>:
    3bae:	fa                   	cli    
    3baf:	6a 00                	push   0x0
    3bb1:	6a 1b                	push   0x1b
    3bb3:	e9 e8 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003bb8 <_isr28>:
    3bb8:	fa                   	cli    
    3bb9:	6a 00                	push   0x0
    3bbb:	6a 1c                	push   0x1c
    3bbd:	e9 de fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003bc2 <_isr29>:
    3bc2:	fa                   	cli    
    3bc3:	6a 00                	push   0x0
    3bc5:	6a 1d                	push   0x1d
    3bc7:	e9 d4 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003bcc <_isr30>:
    3bcc:	fa                   	cli    
    3bcd:	6a 00                	push   0x0
    3bcf:	6a 1e                	push   0x1e
    3bd1:	e9 ca fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003bd6 <_isr31>:
    3bd6:	fa                   	cli    
    3bd7:	6a 00                	push   0x0
    3bd9:	6a 1f                	push   0x1f
    3bdb:	e9 c0 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003be0 <_irq0>:
    3be0:	fa                   	cli    
    3be1:	6a 00                	push   0x0
    3be3:	6a 20                	push   0x20
    3be5:	e9 b6 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003bea <_irq1>:
    3bea:	fa                   	cli    
    3beb:	6a 01                	push   0x1
    3bed:	6a 21                	push   0x21
    3bef:	e9 ac fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003bf4 <_irq2>:
    3bf4:	fa                   	cli    
    3bf5:	6a 02                	push   0x2
    3bf7:	6a 22                	push   0x22
    3bf9:	e9 a2 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003bfe <_irq3>:
    3bfe:	fa                   	cli    
    3bff:	6a 03                	push   0x3
    3c01:	6a 23                	push   0x23
    3c03:	e9 98 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c08 <_irq4>:
    3c08:	fa                   	cli    
    3c09:	6a 04                	push   0x4
    3c0b:	6a 24                	push   0x24
    3c0d:	e9 8e fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c12 <_irq5>:
    3c12:	fa                   	cli    
    3c13:	6a 05                	push   0x5
    3c15:	6a 25                	push   0x25
    3c17:	e9 84 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c1c <_irq6>:
    3c1c:	fa                   	cli    
    3c1d:	6a 06                	push   0x6
    3c1f:	6a 26                	push   0x26
    3c21:	e9 7a fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c26 <_irq7>:
    3c26:	fa                   	cli    
    3c27:	6a 07                	push   0x7
    3c29:	6a 27                	push   0x27
    3c2b:	e9 70 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c30 <_irq8>:
    3c30:	fa                   	cli    
    3c31:	6a 08                	push   0x8
    3c33:	6a 28                	push   0x28
    3c35:	e9 66 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c3a <_irq9>:
    3c3a:	fa                   	cli    
    3c3b:	6a 09                	push   0x9
    3c3d:	6a 29                	push   0x29
    3c3f:	e9 5c fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c44 <_irq10>:
    3c44:	fa                   	cli    
    3c45:	6a 0a                	push   0xa
    3c47:	6a 2a                	push   0x2a
    3c49:	e9 52 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c4e <_irq11>:
    3c4e:	fa                   	cli    
    3c4f:	6a 0b                	push   0xb
    3c51:	6a 2b                	push   0x2b
    3c53:	e9 48 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c58 <_irq12>:
    3c58:	fa                   	cli    
    3c59:	6a 0c                	push   0xc
    3c5b:	6a 2c                	push   0x2c
    3c5d:	e9 3e fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c62 <_irq13>:
    3c62:	fa                   	cli    
    3c63:	6a 0d                	push   0xd
    3c65:	6a 2d                	push   0x2d
    3c67:	e9 34 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c6c <_irq14>:
    3c6c:	fa                   	cli    
    3c6d:	6a 0e                	push   0xe
    3c6f:	6a 2e                	push   0x2e
    3c71:	e9 2a fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c76 <_irq15>:
    3c76:	fa                   	cli    
    3c77:	6a 0f                	push   0xf
    3c79:	6a 2f                	push   0x2f
    3c7b:	e9 20 fe ff ff       	jmp    3aa0 <_isr_common_stub>

00003c80 <_isr128>:
    3c80:	fa                   	cli    
    3c81:	6a 00                	push   0x0
    3c83:	68 80 00 00 00       	push   0x80
    3c88:	e9 13 fe ff ff       	jmp    3aa0 <_isr_common_stub>
    3c8d:	66 90                	xchg   ax,ax
    3c8f:	90                   	nop

00003c90 <_load_idtr>:
    3c90:	0f 01 1d e0 6d 00 00 	lidtd  ds:0x6de0
    3c97:	c3                   	ret    
    3c98:	66 90                	xchg   ax,ax
    3c9a:	66 90                	xchg   ax,ax
    3c9c:	66 90                	xchg   ax,ax
    3c9e:	66 90                	xchg   ax,ax

00003ca0 <_load_tr>:
    3ca0:	0f 00 5c 24 04       	ltr    WORD PTR [esp+0x4]
    3ca5:	c3                   	ret    
    3ca6:	66 90                	xchg   ax,ax
    3ca8:	66 90                	xchg   ax,ax
    3caa:	66 90                	xchg   ax,ax
    3cac:	66 90                	xchg   ax,ax
    3cae:	66 90                	xchg   ax,ax

00003cb0 <_port_byte_in>:
    3cb0:	66 8b 54 24 04       	mov    dx,WORD PTR [esp+0x4]
    3cb5:	ec                   	in     al,dx
    3cb6:	0f b6 c0             	movzx  eax,al
    3cb9:	c3                   	ret    

00003cba <_port_byte_out>:
    3cba:	66 8b 54 24 04       	mov    dx,WORD PTR [esp+0x4]
    3cbf:	8a 44 24 08          	mov    al,BYTE PTR [esp+0x8]
    3cc3:	ee                   	out    dx,al
    3cc4:	c3                   	ret    

00003cc5 <_port_word_in>:
    3cc5:	66 8b 54 24 04       	mov    dx,WORD PTR [esp+0x4]
    3cca:	66 ed                	in     ax,dx
    3ccc:	0f b7 c0             	movzx  eax,ax
    3ccf:	c3                   	ret    

00003cd0 <_port_word_out>:
    3cd0:	66 8b 54 24 04       	mov    dx,WORD PTR [esp+0x4]
    3cd5:	66 8b 44 24 08       	mov    ax,WORD PTR [esp+0x8]
    3cda:	66 ef                	out    dx,ax
    3cdc:	c3                   	ret    

00003cdd <_port_dword_in>:
    3cdd:	66 8b 54 24 04       	mov    dx,WORD PTR [esp+0x4]
    3ce2:	ed                   	in     eax,dx
    3ce3:	c3                   	ret    

00003ce4 <_port_dword_out>:
    3ce4:	66 8b 54 24 04       	mov    dx,WORD PTR [esp+0x4]
    3ce9:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    3ced:	66 ef                	out    dx,ax
    3cef:	c3                   	ret    

00003cf0 <_port_buffer_in>:
    3cf0:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    3cf4:	66 8b 54 24 04       	mov    dx,WORD PTR [esp+0x4]
    3cf9:	89 c7                	mov    edi,eax
    3cfb:	8b 4c 24 0c          	mov    ecx,DWORD PTR [esp+0xc]
    3cff:	c1 e9 02             	shr    ecx,0x2
    3d02:	f3 6d                	rep ins DWORD PTR es:[edi],dx
    3d04:	c3                   	ret    

00003d05 <_port_buffer_out>:
    3d05:	66 8b 54 24 04       	mov    dx,WORD PTR [esp+0x4]
    3d0a:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    3d0e:	8b 4c 24 0c          	mov    ecx,DWORD PTR [esp+0xc]
    3d12:	c1 e9 02             	shr    ecx,0x2
    3d15:	f3 6f                	rep outs dx,DWORD PTR ds:[esi]
    3d17:	c3                   	ret    
    3d18:	66 90                	xchg   ax,ax
    3d1a:	66 90                	xchg   ax,ax
    3d1c:	66 90                	xchg   ax,ax
    3d1e:	66 90                	xchg   ax,ax

00003d20 <_suspend>:
    3d20:	55                   	push   ebp
    3d21:	89 e5                	mov    ebp,esp
    3d23:	b8 07 53 00 00       	mov    eax,0x5307
    3d28:	bb 01 00 00 00       	mov    ebx,0x1
    3d2d:	b9 02 00 00 00       	mov    ecx,0x2
    3d32:	9a 80 3d 00 00 08 00 	call   0x8:0x3d80
    3d39:	c9                   	leave  
    3d3a:	c3                   	ret    

00003d3b <_stand_by>:
    3d3b:	55                   	push   ebp
    3d3c:	89 e5                	mov    ebp,esp
    3d3e:	b8 07 53 00 00       	mov    eax,0x5307
    3d43:	bb 01 00 00 00       	mov    ebx,0x1
    3d48:	b9 01 00 00 00       	mov    ecx,0x1
    3d4d:	9a 80 3d 00 00 08 00 	call   0x8:0x3d80
    3d54:	c9                   	leave  
    3d55:	c3                   	ret    

00003d56 <_shutdown>:
    3d56:	55                   	push   ebp
    3d57:	89 e5                	mov    ebp,esp
    3d59:	b8 07 53 00 00       	mov    eax,0x5307
    3d5e:	bb 01 00 00 00       	mov    ebx,0x1
    3d63:	b9 03 00 00 00       	mov    ecx,0x3
    3d68:	9a 80 3d 00 00 08 00 	call   0x8:0x3d80
    3d6f:	c9                   	leave  
    3d70:	c3                   	ret    

00003d71 <_reset>:
    3d71:	55                   	push   ebp
    3d72:	89 e5                	mov    ebp,esp

00003d74 <WaitRdy>:
    3d74:	e4 64                	in     al,0x64
    3d76:	a8 02                	test   al,0x2
    3d78:	75 fa                	jne    3d74 <WaitRdy>
    3d7a:	b0 fe                	mov    al,0xfe
    3d7c:	e6 64                	out    0x64,al
    3d7e:	c9                   	leave  
    3d7f:	c3                   	ret    

00003d80 <_apm_jump_stub>:
    3d80:	ea 00 00 00 00 00 00 	jmp    0x0:0x0

00003d87 <__CTOR_LIST__>:
    3d87:	ff                   	(bad)  
    3d88:	ff                   	(bad)  
    3d89:	ff                   	(bad)  
    3d8a:	ff 00                	inc    DWORD PTR [eax]
    3d8c:	00 00                	add    BYTE PTR [eax],al
	...

00003d8f <__DTOR_LIST__>:
    3d8f:	ff                   	(bad)  
    3d90:	ff                   	(bad)  
    3d91:	ff                   	(bad)  
    3d92:	ff 00                	inc    DWORD PTR [eax]
    3d94:	00 00                	add    BYTE PTR [eax],al
	...
