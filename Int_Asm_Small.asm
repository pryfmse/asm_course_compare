.MODEL SMALL

.STACK 100H

.DATA
   	
 
.CODE
    mov cx, 65535
    mov ax, 1
    mov bx, 1

    adding:
        add ax, bx

        loop adding

    mov cx, 65535
    mov ax, 1

    muling:
        imul bx
        
        loop muling

    mov cx, 65535

    diving:
        idiv bx

        loop diving

    mov cx, 65535

    gibson:
        add ax, bx
        add ax, bx
        add ax, bx
        add ax, bx
        add ax, bx

        imul bx
        imul bx

        idiv bx

        loop gibson

    mov ah, 4Ch
    mov al, 00
    int 21h

end