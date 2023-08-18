org 0x7C00 ; Memory Offset for the OS
bits 16 ;Setting the code to 16 bit code

main: 
    htl
; The bios expects that the last two bytes of the first sector are 88 55
; We can emit bytes directly with the DB directive
; Times repeats a given instruction or a piece of data a number of times (loop)
; The $ sign give us memory offset of the current line.
; The $$ give us the position of the start of the current section
; So the $-$$ give us the size of the program so far

.halt:
    jmp .halt

times 510-($-$$) db 0
dw 0AA55h
;dw declares a 2 bytes as words

