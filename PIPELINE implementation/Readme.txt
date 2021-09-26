1)here i implemented the pipeline mips processor
2)it can handle hazards and has forward unit
3)i put machine code of:

addi $4,$0,27			//4 has 27
xori $5,$4,5			//5 has 30
lw $7, 4($5)			// lw from memory to reg 7 load 3


2004001b
38850005
8ca70004

4)first output is after 4 cycles
5)you can find test resualts in report	