.286
.MODEL TINY

.CODE

  org 100h  

start:

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

  	ret

a   dd  1.0
b   dd  1.0

end start
