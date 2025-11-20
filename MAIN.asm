.MODEL SMALL

.STACK 200H

.DATA
    env_seg         dw      0            ; сегмент окружения (0 = унаследовать от родителя)
    cmd_line        db      0, 0Dh       ; командная строка для дочерней программы

    params          label   word
        env         dw      0            ; сегмент окружения
        cmd_ptr     dd      cmd_line     ; указатель на командную строку
        fcb1_ptr    dd      0
        fcb2_ptr    dd      0

    path1           db      "I_A_T.com", 0
    path2           db      "I_A_S.exe", 0
    path3           db      "I_P.exe", 0
    path4           db      "F_A_T.com", 0
    path5           db      "F_A_S.exe", 0
    path6           db      "F_P.exe", 0

    start_time_low  dw      0
    start_time_high dw      0
    end_time_low    dw      0
    end_time_high   dw      0

    result          dw 0

    mess1           db      "Полученные результаты:", 0Dh, 0Ah, "    Целые числа:", 0Dh, 0Ah, "        *.com: ", "$"
    mess2           db      "        *.exe (asm): ", "$"
    mess3           db      "        *.exe (pascal): ", "$"
    mess4           db      "    Вещественные числа:", 0Dh, 0Ah, "        *.com: ", "$"
    mess5           db      "        *.exe (asm): ", "$"
    mess6           db      "        *.exe (pascal): ", "$"
    new_line        db      0Dh, 0Ah, "$"

 
.CODE

    main PROC
    ;----блок выделения памяти-------
        mov bx, ss                       ; Получаем сегмент стека
        mov ax, es
        sub bx, ax                       ; Вычитаем сегмент начала программы (PSP), который лежит в ES
        add bx, 20h                      ; Добавляем размер стека в параграфах (для .STACK 200h)
    
        mov ah, 4Ah                      ; Функция: изменить размер блока памяти
        int 21h                          
   
    ;----инициализация сегмента данных
        mov ax, @DATA
        mov ds, ax

    ;---анализ первого файла---------
        mov ah, 09h                      ; Вывод сообщения о начале анализа
        mov dx, offset mess1
        int 21h

        mov ah, 00h                      ; Получение начального времени анализа
        int 1Ah
        mov start_time_high, cx          ; Запись старшей и младшей части текущего времени
        mov start_time_low, dx

        mov dx, offset path1             ; Передача имени анализируемого файла
        CALL analiz                      ; Запустить файл, выполнить и зафиксировать время выполнения
        CALL translate                   ; Перевести время исполнения в символы

    ;---анализ второго файла---------
        mov ah, 09h
        mov dx, offset mess2
        int 21h

        mov ah, 00h
        int 1Ah
        mov start_time_high, cx
        mov start_time_low, dx

        mov dx, offset path2
        CALL analiz
        CALL translate

    ;---анализ третьего файла---------
        mov ah, 09h
        mov dx, offset mess3
        int 21h

        mov ah, 00h
        int 1Ah
        mov start_time_high, cx
        mov start_time_low, dx

        mov dx, offset path3
        CALL analiz
        CALL translate

    ;---анализ четвертого файла---------
        mov ah, 09h
        mov dx, offset mess4
        int 21h

        mov ah, 00h
        int 1Ah
        mov start_time_high, cx
        mov start_time_low, dx

        mov dx, offset path4
        CALL analiz
        CALL translate

    ;---анализ пятого файла---------
        mov ah, 09h
        mov dx, offset mess5
        int 21h

        mov ah, 00h
        int 1Ah
        mov start_time_high, cx
        mov start_time_low, dx

        mov dx, offset path5
        CALL analiz
        CALL translate

    ;---анализ шестого файла---------

        mov ah, 09h
        mov dx, offset mess6
        int 21h

        mov ah, 00h
        int 1Ah
        mov start_time_high, cx
        mov start_time_low, dx

        mov dx, offset path6
        CALL analiz
        CALL translate

    ;---конец выполнения программы----
        mov ah, 4Ch
        mov al, 00h
        int 21h

    main ENDP

;---процедура запуска исполняемого файла
;---и фиксация конечного времени работы-
    analiz PROC
        mov ah, 4Bh                      ; Функция запуска исполняемого файла
        mov al, 0
        mov bx, offset params
        int 21h
        jc exec_error                    ; В случае ошибки перейти к обработчику

        mov ah, 00h                      ; Получить время завершения работы файла
        int 1Ah
        mov end_time_high, cx
        mov end_time_low, dx

        mov ax, end_time_low             ; Высчитать время выполнения и записать в переменную
        sub ax, start_time_low
        mov [result], ax

        ret

    ;---обработка ошибки при запуске файла
    exec_error:
        mov [result], ax                 ; Вывести код ошибки

        CALL translate

        mov ah, 02h                      ; Вывести восклицательный знак-показатель ошибки
        mov dx, "!"
        int 21h

        mov ah, 4Ch                      ; Завершить выполнение программы
        int 21h

    analiz ENDP

;---процедура перевода чисел в символы----
    translate PROC
        mov ax, [result]                 ; Записать число в регистр ax для работы с ним
        mov bx, 10                       ; bx - делитель
        xor cx, cx
        xor dx, dx

        step:
            inc cx                       ; Считаем количество цифр в числе
            div bx                       ; Делим число на 10 для получения последней цифры
            push dx                      ; Завидываем в стек остаток
            xor dx, dx                   ; Обнуляем dx для корректных вычислений

            cmp ax, 0                    ; Если число больше нуля, то продолжаем деление
            ja step

        output:
            pop dx                       ; Вытаскиваем цифры из стека в обратном порядке
            add dx, "0"                  ; Преобразуем в символы
            mov ah, 02h                  ; Выводим
            int 21h

            loop output

        mov ah, 09h                      ; Выполняем переход на новую строку
        mov dx, offset new_line
        int 21h

        ret

    translate ENDP

end