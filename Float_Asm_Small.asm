.286
.MODEL SMALL

.STACK 100H

.DATA
    a   dd  1.0
    b   dd  1.0
   	
.CODE

    mov ax, @DATA
    mov ds, ax

    finit

    mov cx, 65535
    fld a

    adding:
        fadd b

        loop adding
        fstp a

    fld1
    fstp a

    mov cx, 65535
    fld a

    muling:
        fmul b
        
        loop muling
        fstp a

    mov cx, 65535
    fld a

    diving:
        fdiv b

        loop diving
        fstp a

    mov cx, 65535
    fld a

    gibson:
        fadd b
        fadd b
        fadd b
        fadd b
        fadd b

        fmul b
        fmul b

        fdiv b

        loop gibson
        fstp a

    mov ah, 4Ch
    mov al, 00
    int 21h

end