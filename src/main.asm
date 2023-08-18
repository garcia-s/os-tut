org 0x7C00 ; Memory Offset for the OS
bits 16 ;Setting the code to 16 bit code


%define ENDL 0x0D, 0x0A

start: 
    jmp main

puts:
    ;Add the register we are going to modify to the stack
    push si
    push ax

.loop:
    lodsb ; Loads next character into al
    or al, al  ;Verify is character is null
    jz .done ; Jump to the done lable if zero flag is set

    mov ah, 0x0e ; call bios interrupt
    mov bh, 0 ; setting page number to 0
    int 0x10

    jmp .loop

.done:
    ;Remove registers in reverse order
    pop ax
    pop si
    ret

main: 
    ; Setting up the data segments: We cannot copy directly to ds/es so we use ax to copy into it
    mov ax, 0
    mov ds, ax
    mov es, ax

    ; Setting up the stack pointer to the end of our operating system
    mov ss, ax
    mov sp, 0x7C00

    ; PRINTING THE STRING
    mov si, msg_hello
    call puts

    hlt

msg_hello: db 'Hello World!', ENDL, 0

.halt:
    jmp .halt

; The bios expects that the last two bytes of the first sector are 87 55
; We can emit bytes directly with the DB directive
; Times repeats a given instruction or a piece of data a number of times (loop)
; The $ sign give us memory offset of the current line.
; The $$ give us the position of the start of the current section
; So the $-$$ give us the size of the program so far
times 510-($-$$) db 0
dw 0AA55h
;dw declares a 2 bytes as words

