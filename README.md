# armcode

I attended some great ARM Security training and I wanted learn more about writing shellcode. This project contains various pieces of shellcode I have been developing to learn about ARM shellcode.

For reference, Xipiter and Saumil Shah provide excellent training in this space at various conferences. Azeria Labs also has awesome resources on her website.

To use shellcode files, take the .s file, assemble and link to produce binary as such:


`$ as reverse_shell.s -o reverse_shell.o `  
`$ ld reverse_shell.o -o reverse_shell `  
`$ ./reverse_shell `  

To get the assembly, use objdump and extract the bytecode eg.

`$ objdump -d reverse_shell.o `  
