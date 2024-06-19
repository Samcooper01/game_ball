org 0x100

section .data
    ticks_per_second: equ 1
    paddle_x_pos: db 151

section .bss
    ball_x_pos: resb    2
    ball_y_pos: resb    2
    ball_direction: resb    1
    blank:  resb    60
    rect_1_hit: resb    1
    rect_1_NW_hit:  resb    1
    rect_2_hit: resb    1
    rect_3_hit: resb    1
    rect_4_hit: resb    1
    rect_5_hit: resb    1
    rect_6_hit: resb    1
    rect_7_hit: resb    1
    rect_8_hit: resb    1
    rect_9_hit: resb    1
    rect_10_hit:    resb    1
    game_row_2_state:   resb    1

section .text
    global _start


_start:
    mov ax, 0x13
    int 0x10

    ;Init gameboard
    call init_game
    init_done:

    jmp hit_a_to_begin
    init:
    
    jmp erase_a_to_begin
    done_erasing:

    ;Application Loop
    main_loop:
    ; Check for key press
        jmp move_ball
        done_moving_ball:
        call delay_1_second
        mov ah, 0x01    ; BIOS function: Check for keystroke
        int 0x16
        jz main_loop    ; No key press, continue looping

    ; Get the key press
    mov ah, 0x00    ; BIOS function: Read keystroke
    int 0x16

    ; Check if the key is the left arrow key
    cmp ah, 0x4B    ; Compare scan code
    je left_arrow_pressed

    ;check if the key is the right arrow key
    cmp ah, 0x4D
    je right_arrow_pressed
    jmp main_loop

    ; Wait for key press
    mov ah, 0
    int 0x16

    ; Return to text mode
    mov ax, 0x03      ; Set video mode 03h (text mode)
    int 0x10

    ; Exit program
    ret


delay_1_second:
    ; Get the current tick count
    mov ah, 0
    int 0x1A
    mov bx, dx          ; Store current tick count in bx

wait_loop:
    ; Get the current tick count again
    mov ah, 0
    int 0x1A
    sub dx, bx          ; Calculate the difference in ticks
    cmp dx, ticks_per_second ; Compare with ticks_per_second
    jb wait_loop        ; If less than ticks_per_second, loop
    ret

hit_a_to_begin:
    mov ah, 0x0E     
    mov bl, 2  
    mov al, 0x0A
    int 0x10  
    mov al, 0x0A
    int 0x10  
    mov al, 0x0A
    int 0x10  
    mov al, 0x0A
    int 0x10 
    mov al, 0x0A
    int 0x10  
    mov al, 0x0A
    int 0x10
    mov al, 0x0A
    int 0x10  
    mov al, 0x0A
    int 0x10
    mov al, 0x09
    int 0x10
    mov al, ' '
    int 0x10
    mov al, ' '
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 'H'
    int 0x10
    mov al, 'I'
    int 0x10 
    mov al, 'T'
    int 0x10
    mov al, ' '
    int 0x10 
    mov al, 'A'
    int 0x10
    mov al, ' '
    int 0x10 
    mov al, 'T'
    int 0x10
    mov al, 'O'
    int 0x10 
    mov al, ' '
    int 0x10
    mov al, 'B'
    int 0x10 
    mov al, 'E'
    int 0x10
    mov al, 'G'
    int 0x10 
    mov al, 'I'
    int 0x10
    mov al, 'N'
    int 0x10 

    wait_for_go:
        call delay_1_second
        mov ah, 0x01    ; BIOS function: Check for keystroke
        int 0x16
        jz wait_for_go
        ; Get the key press
    mov ah, 0x00    ; BIOS function: Read keystroke
    int 0x16

    cmp al, 'a'
    je init
    cmp al, 'A'
    je init

    jmp wait_for_go

erase_a_to_begin:
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 0         ; Color (in mode 13h, 4 is red)
    mov dx, 50
    erase:
        mov cx, 65
        erase_horz:
            inc cx            
            int 0x10
            cmp cx, 250
            jne erase_horz
        xor cx, cx
        inc dx
        cmp dx, 100
        jne erase
    jmp done_erasing


;#############################
; SECTION - GAME END
;#############################
game_over:
    mov ah, 0x0E     
    mov bl, 4  
    mov al, 0x0A
    int 0x10 
    mov al, 0x0A
    int 0x10     
    mov al, 0x0A
    int 0x10 
    mov al, 0x0A
    int 0x10 
    mov al, 0x0A
    int 0x10 
    mov al, 0x0A
    int 0x10   
    mov al, 0x09
    int 0x10  
    mov al, 0x09
    int 0x10  
    mov al, 0x09
    int 0x10   
    mov al, 'G'
    int 0x10 
    mov al, 'A'             
    int 0x10 
    mov al, 'M'             
    int 0x10 
    mov al, 'E'             
    int 0x10 
    mov al, ' '             
    int 0x10 
    mov al, 'O'             
    int 0x10 
    mov al, 'V'             
    int 0x10 
    mov al, 'E'             
    int 0x10 
    mov al, 'R'             
    int 0x10
    mov al, ' '             
    int 0x10
    mov al, ' '             
    int 0x10
    mov al, 'r'             
    int 0x10
    mov al, ' '             
    int 0x10
    mov al, 'T'             
    int 0x10
    mov al, 'O'             
    int 0x10
    mov al, ' '             
    int 0x10
    mov al, 'T'             
    int 0x10
    mov al, 'R'             
    int 0x10
    mov al, 'Y'             
    int 0x10
    mov al, ' '             
    int 0x10
    mov al, 'A'             
    int 0x10
    mov al, 'G'             
    int 0x10
    mov al, 'A'             
    int 0x10
    mov al, 'I'             
    int 0x10
    mov al, 'N'             
    int 0x10

    wait_for_new_try:
        call delay_1_second
        mov ah, 0x01    ; BIOS function: Check for keystroke
        int 0x16
        jz wait_for_new_try

        ; Get the key press
    mov ah, 0x00    ; BIOS function: Read keystroke
    int 0x16

    cmp al, 'r'
    je _start
    cmp al, 'R'
    je _start

    jmp wait_for_new_try

game_WON:
    mov ah, 0x0E     
    mov bl, 2  
    mov al, 0x0A
    int 0x10 
    mov al, 0x0A
    int 0x10 
    mov al, 0x0A
    int 0x10 
    mov al, 0x0A
    int 0x10     
    mov al, 0x0A
    int 0x10 
    mov al, 0x0A
    int 0x10 
    mov al, 0x0A
    int 0x10 
    mov al, 0x0A
    int 0x10   
    mov al, 0x09
    int 0x10  
    mov al, 0x09
    int 0x10  
    mov al, 0x09
    int 0x10  
    mov al, 'G'
    int 0x10 
    mov al, 'A'             
    int 0x10 
    mov al, 'M'             
    int 0x10 
    mov al, 'E'             
    int 0x10 
    mov al, ' '             
    int 0x10 
    mov al, 'W'             
    int 0x10 
    mov al, 'O'             
    int 0x10 
    mov al, 'N'             
    int 0x10 
    mov al, ' '             
    int 0x10
    mov al, ' '             
    int 0x10
    mov al, 'r'             
    int 0x10
    mov al, ' '             
    int 0x10
    mov al, 'T'             
    int 0x10
    mov al, 'O'             
    int 0x10
    mov al, ' '             
    int 0x10
    mov al, 'P'             
    int 0x10
    mov al, 'L'             
    int 0x10
    mov al, 'A'             
    int 0x10
    mov al, 'Y'             
    int 0x10
    mov al, ' '             
    int 0x10
    mov al, 'A'             
    int 0x10
    mov al, 'G'             
    int 0x10
    mov al, 'A'             
    int 0x10
    mov al, 'I'             
    int 0x10
    mov al, 'N'             
    int 0x10

    jmp wait_for_new_try



;#############################
; SECTION - MOVE BALL
;#############################

;   N
; W   E
;   S
; 

;Essentially a state machine
; ball_direction 
;   0 - NE
;   1 - SE
;   2 - SW
;   3 - NW

move_ball:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov bx, [ball_direction]

    mov esi, 180
    cmp edx, esi
    jg game_over
    mov esi, 10 ; x1bound
    mov edi, 310 ; x2bound


    cmp bx, 0 ;NE
    je moving_NE
    cmp bx, 1
    je moving_SE
    cmp bx, 2
    je moving_SW
    cmp bx, 3
    je moving_NW

    moving_NE:
        ;Right wall
        cmp edi, ecx
        jg in_bounds_NE
            mov bx, 3
            mov [ball_direction], bx
            jmp done_move
        in_bounds_NE:
        
        ;top blocks
        mov esi, 1
        cmp [game_row_2_state], esi
        je state_2_NE
        mov esi, 50
        cmp edx, esi
        jg in_bounds_y_NE
            jmp change_block_state_NE
            done_changing_block_state_NE:
            mov bx, 1
            mov [ball_direction], bx
            jmp done_move
        state_2_NE:
        mov esi, 24
        cmp edx, esi
        jg in_bounds_y_NE
            jmp change_block_state_2_NE
            done_changing_block_state_2_NE:
            mov bx, 1
            mov [ball_direction], bx
            jmp done_move
        in_bounds_y_NE:
        jmp move_ball_NE
        done_moving_ball_NE:
        jmp done_move
    moving_SE:
        ;right wall
        cmp edi, ecx
        jg in_bounds_SE
            mov bx, 2
            mov [ball_direction], bx
            jmp done_move
        in_bounds_SE:

        ;paddle
        mov edi, [paddle_x_pos]
        mov esi, edi
        add esi, 50
        cmp ecx, edi
        jl not_in_SE_Range
            cmp ecx, esi
            jg not_in_SE_Range
                cmp edx, 170
                jl not_in_SE_Range
                    mov bx, 0
                    mov [ball_direction], bx
                    jmp done_move
        not_in_SE_Range:
        jmp move_ball_SE
        done_moving_ball_SE:
        jmp done_move
    moving_SW:
        ;left wall
        cmp esi, ecx
        jl not_on_x_border_SW
            mov bx, 1
            mov [ball_direction], bx
            jmp done_move
        not_on_x_border_SW:
        
        ;paddle
        mov edi, [paddle_x_pos]
        mov esi, edi
        add esi, 50
        cmp ecx, edi
        jl not_in_SW_Range
            cmp ecx, esi
            jg not_in_SW_Range
                cmp edx, 170
                jl not_in_SW_Range
                    mov bx, 3
                    mov [ball_direction], bx
                    jmp done_move
        not_in_SW_Range:
        jmp move_ball_SW
        done_moving_ball_SW:
        jmp done_move
    moving_NW:
        ;left wall
        cmp ecx, esi
        jg in_bounds_NW
            mov bx, 0
            mov [ball_direction], bx
            jmp done_move
        in_bounds_NW:

        ;top blocks
        mov esi, 1
        cmp [game_row_2_state], esi
        je state_2_NW
        mov esi, 50
        cmp edx, esi
        jg in_bounds_y_NW
            jmp change_block_state_NW
            done_changing_block_state_NW:
            mov bx, 2
            mov [ball_direction], bx
            jmp done_move
        state_2_NW:
        mov esi, 24
        cmp edx, esi
        jg in_bounds_y_NW
            jmp change_block_state_2_NW
            done_changing_block_state_2_NW:
            mov bx, 2
            mov [ball_direction], bx
            jmp done_move            
        in_bounds_y_NW:
        jmp move_ball_NW
        done_moving_ball_NW:
        jmp done_move
    done_move:
    jmp done_moving_ball

change_block_state_NE:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 59
    cmp ecx, esi
    jg not_rect_6
        jmp change_rectangle_6
        done_changing_rectangle_6:
        jmp done_changing
    not_rect_6:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 125
    cmp ecx, esi
    jg not_rect_7
        jmp change_rectangle_7
        done_changing_rectangle_7:
        jmp done_changing
    not_rect_7:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 190
    cmp ecx, esi
    jg not_rect_8
        jmp change_rectangle_8
        done_changing_rectangle_8:
        jmp done_changing
    not_rect_8:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 255
    cmp ecx, esi
    jg not_rect_9
        jmp change_rectangle_9
        done_changing_rectangle_9:
        jmp done_changing
    not_rect_9:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 319
    cmp ecx, esi
    jg not_rect_10
        jmp change_rectangle_10
        done_changing_rectangle_10:
        jmp done_changing
    not_rect_10:
    done_changing:
    mov esi, [rect_10_hit]
    mov edi, [rect_9_hit]
    AND edi, esi
    mov esi, [rect_8_hit]
    and edi, esi
    mov esi, [rect_7_hit]
    and edi, esi
    mov esi, [rect_6_hit]
    and edi, esi
    cmp edi, 1
    jne game_state_1
        jmp erase_row_1
        done_erasing_row_1:
        mov bl, 1
        mov [game_row_2_state], bl
    game_state_1:
jmp done_changing_block_state_NE

change_block_state_2_NE:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 59
    cmp ecx, esi
    jg not_rect_1_NE
        jmp change_rectangle_1_NE
        done_changing_rectangle_1_NE:
        jmp done_changing_2_NE
    not_rect_1_NE:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 125
    cmp ecx, esi
    jg not_rect_2_NE
        jmp change_rectangle_2_NE
        done_changing_rectangle_2_NE:
        jmp done_changing_2_NE
    not_rect_2_NE:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 190
    cmp ecx, esi
    jg not_rect_3_NE
        jmp change_rectangle_3_NE
        done_changing_rectangle_3_NE:
        jmp done_changing_2_NE
    not_rect_3_NE:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 255
    cmp ecx, esi
    jg not_rect_4_NE
        jmp change_rectangle_4_NE
        done_changing_rectangle_4_NE:
        jmp done_changing_2_NE
    not_rect_4_NE:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 318
    cmp ecx, esi
    jg not_rect_5_NE
        jmp change_rectangle_5_NE
        done_changing_rectangle_5_NE:
        jmp done_changing_2_NE
    not_rect_5_NE:
    done_changing_2_NE:
    xor eax, eax
    xor ecx, ecx
    mov cl, [rect_1_hit]
    mov al, [rect_2_hit]
    and cl, al
    mov al, [rect_3_hit]
    and cl, al
    mov al, [rect_4_hit]
    and cl, al
    mov al, [rect_5_hit]
    and cl, al
    cmp cl, 1
    jl game_not_won_NE
        jmp game_WON
    game_not_won_NE:        
    jmp done_changing_block_state_2_NE

change_block_state_2_NW:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 59
    cmp ecx, esi
    jg not_rect_1_NW
        jmp change_rectangle_1_NW
        done_changing_rectangle_1_NW:
        jmp done_changing_2_NW
    not_rect_1_NW:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 125
    cmp ecx, esi
    jg not_rect_2_NW
        jmp change_rectangle_2_NW
        done_changing_rectangle_2_NW:
        jmp done_changing_2_NW
    not_rect_2_NW:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 190
    cmp ecx, esi
    jg not_rect_3_NW
        jmp change_rectangle_3_NW
        done_changing_rectangle_3_NW:
        jmp done_changing_2_NW
    not_rect_3_NW:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 255
    cmp ecx, esi
    jg not_rect_4_NW
        jmp change_rectangle_4_NW
        done_changing_rectangle_4_NW:
        jmp done_changing_2_NW
    not_rect_4_NW:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 318
    cmp ecx, esi
    jg not_rect_5_NW
        jmp change_rectangle_5_NW
        done_changing_rectangle_5_NW:
        jmp done_changing_2_NW
    not_rect_5_NW:
    done_changing_2_NW:
    xor ecx, ecx
    xor eax, eax
    mov cl, [rect_1_hit]
    mov al, [rect_2_hit]
    and cl, al
    mov al, [rect_3_hit]
    and cl, al
    mov al, [rect_4_hit]
    and cl, al
    mov al, [rect_5_hit]
    and cl, al
    cmp cl, 1
    jl game_not_won_NW
        jmp game_WON
    game_not_won_NW:        
    jmp done_changing_block_state_2_NW

change_block_state_NW:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 59
    cmp ecx, esi
    jg not_rect_6_NW
        jmp change_rectangle_6_NW
        done_changing_rectangle_6_NW:
        jmp done_changing_NW
    not_rect_6_NW:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 125
    cmp ecx, esi
    jg not_rect_7_NW
        jmp change_rectangle_7_NW
        done_changing_rectangle_7_NW:
        jmp done_changing_NW
    not_rect_7_NW:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 190
    cmp ecx, esi
    jg not_rect_8_NW
        jmp change_rectangle_8_NW
        done_changing_rectangle_8_NW:
        jmp done_changing_NW
    not_rect_8_NW:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 255
    cmp ecx, esi
    jg not_rect_9_NW
        jmp change_rectangle_9_NW
        done_changing_rectangle_9_NW:
        jmp done_changing_NW
    not_rect_9_NW:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov esi, 319
    cmp ecx, esi
    jg not_rect_10_NW
        jmp change_rectangle_10_NW
        done_changing_rectangle_10_NW:
        jmp done_changing_NW
    not_rect_10_NW:
    done_changing_NW:
    mov esi, [rect_10_hit]
    mov edi, [rect_9_hit]
    AND edi, esi
    mov esi, [rect_8_hit]
    and edi, esi
    mov esi, [rect_7_hit]
    and edi, esi
    mov esi, [rect_6_hit]
    and edi, esi
    cmp edi, 1
    jne game_state_1_NW
        jmp erase_row_1
        done_erasing_row_1_NW:
        mov bl, 1
        mov [game_row_2_state], bl
    game_state_1_NW:
jmp done_changing_block_state_NW

move_ball_SE:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 0         ; Color (in mode 13h, 4 is red)          
    int 0x10
    inc cx
    int 0x10
    inc dx
    dec cx
    dec cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc dx
    inc cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    inc cx
    inc dx
    int 0x10
    inc cx 
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    dec cx
    inc dx
    int 0x10
    dec cx
    int 0x10
    add cx, 5
    add dx, 5
    mov [ball_x_pos], cx
    mov [ball_y_pos], dx
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 14         ; Color (in mode 13h, 4 is red)          
    int 0x10
    inc cx
    int 0x10
    inc dx
    dec cx
    dec cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc dx
    inc cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    inc cx
    inc dx
    int 0x10
    inc cx 
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    dec cx
    inc dx
    int 0x10
    dec cx
    int 0x10
    jmp done_moving_ball_SE

move_ball_NE:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 0         ; Color (in mode 13h, 4 is red)          
    int 0x10
    inc cx
    int 0x10
    inc dx
    dec cx
    dec cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc dx
    inc cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    inc cx
    inc dx
    int 0x10
    inc cx 
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    dec cx
    inc dx
    int 0x10
    dec cx
    int 0x10
    add cx, 5
    sub dx, 5
    mov [ball_x_pos], cx
    mov [ball_y_pos], dx
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 14         ; Color (in mode 13h, 4 is red)          
    int 0x10
    inc cx
    int 0x10
    inc dx
    dec cx
    dec cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc dx
    inc cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    inc cx
    inc dx
    int 0x10
    inc cx 
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    dec cx
    inc dx
    int 0x10
    dec cx
    int 0x10
    jmp done_moving_ball_NE

move_ball_NW:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 0         ; Color (in mode 13h, 4 is red)          
    int 0x10
    inc cx
    int 0x10
    inc dx
    dec cx
    dec cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc dx
    inc cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    inc cx
    inc dx
    int 0x10
    inc cx 
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    dec cx
    inc dx
    int 0x10
    dec cx
    int 0x10
    sub cx, 5
    sub dx, 5
    mov [ball_x_pos], cx
    mov [ball_y_pos], dx
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 14         ; Color (in mode 13h, 4 is red)          
    int 0x10
    inc cx
    int 0x10
    inc dx
    dec cx
    dec cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc dx
    inc cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    inc cx
    inc dx
    int 0x10
    inc cx 
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    dec cx
    inc dx
    int 0x10
    dec cx
    int 0x10
    jmp done_moving_ball_NW

move_ball_SW:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 0         ; Color (in mode 13h, 4 is red)          
    int 0x10
    inc cx
    int 0x10
    inc dx
    dec cx
    dec cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc dx
    inc cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    inc cx
    inc dx
    int 0x10
    inc cx 
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    dec cx
    inc dx
    int 0x10
    dec cx
    int 0x10
    sub cx, 5
    add dx, 5
    mov [ball_x_pos], cx
    mov [ball_y_pos], dx
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 14         ; Color (in mode 13h, 4 is red)          
    int 0x10
    inc cx
    int 0x10
    inc dx
    dec cx
    dec cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc dx
    inc cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    inc cx
    inc dx
    int 0x10
    inc cx 
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    dec cx
    inc dx
    int 0x10
    dec cx
    int 0x10
    jmp done_moving_ball_SW

;#############################
; SECTION - MOVE PADDLE
;#############################

left_arrow_pressed:
    mov esi, [paddle_x_pos]
    mov edi, 50
    cmp edi, esi
    jg main_loop
    jmp erase_paddle_loop
    done_erasing_paddle_loop:
    jmp draw_paddle_loop
    done_drawing_paddle_loop:

    ; Go back to main loop after handling the key press
    jmp main_loop

right_arrow_pressed:
    mov esi, [paddle_x_pos]
    mov edi, 270
    cmp edi, esi
    jl main_loop
    jmp erase_paddle_loop_right
    done_erasing_paddle_loop_right:
    jmp draw_paddle_loop_right
    done_drawing_paddle_loop_right:

    ; Go back to main loop after handling the key press
    jmp main_loop

init_game:
    xor eax, eax
    mov [rect_1_hit], ah
    mov [rect_1_NW_hit], ah
    mov [rect_2_hit], ah
    mov [rect_3_hit], ah
    mov [rect_4_hit], ah
    mov [rect_5_hit], ah
    mov [rect_6_hit], ah
    mov [rect_7_hit], ah
    mov [rect_8_hit], ah
    mov [rect_9_hit], ah
    mov [rect_10_hit], ah
    mov [game_row_2_state], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 12         ; Color (in mode 13h, 4 is red)
    jmp draw_rectangles
    done_drawing_rectangles:
    jmp draw_paddle
    done_drawing_paddle:
    mov cx, 100 ;158
    mov dx, 165 ;164
    mov [ball_x_pos], cx
    mov [ball_y_pos], dx
    xor ecx, ecx
    xor edx, edx
    jmp draw_ball
    done_drawing_ball:
    mov cx, 0 ;3
    mov [ball_direction], cx
    jmp init_done

draw_paddle_loop:
    xor edx, edx
    xor ebx, ebx
    xor ecx, ecx
    mov dx, 184
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 15         ; Color (in mode 13h, 4 is red)
    mov bx, [paddle_x_pos]
    sub bx, 50
    draw_loop:
        mov cx, bx
        horizontal_draw_loop:
            inc cx            
            int 0x10
            cmp cx, [paddle_x_pos]
            jne horizontal_draw_loop
        xor cx, cx
        inc dx
        cmp dx, 194
        jne draw_loop
    mov [paddle_x_pos], bx
    jmp done_drawing_paddle_loop

draw_paddle_loop_right:
    xor dx, dx
    xor bx, bx
    xor cx, cx
    mov dx, 184
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 15         ; Color (in mode 13h, 4 is red)
    mov bx, [paddle_x_pos]
    add bx, 50
    draw_loop_right:
        mov cx, [paddle_x_pos]
        horizontal_draw_loop_right:
            inc cx            
            int 0x10
            cmp cx, bx
            jne horizontal_draw_loop_right
        xor cx, cx
        inc dx
        cmp dx, 194
        jne draw_loop_right
    jmp done_drawing_paddle_loop_right
erase_paddle_loop:
    xor edx, edx
    xor ebx, ebx
    xor ecx, ecx
    mov dx, 184
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 0        ; Color (in mode 13h, 4 is red)
    mov bx, [paddle_x_pos]
    add bx, 51
    erase_loop:
        mov cx, [paddle_x_pos]
        horizontal_erase_loop:
            inc cx            
            int 0x10
            cmp cx, bx
            jne horizontal_erase_loop
        xor cx, cx
        inc dx
        cmp dx, 194
        jne erase_loop
    jmp done_erasing_paddle_loop

erase_paddle_loop_right:
    xor dx, dx
    xor bx, bx
    xor cx, cx
    mov dx, 184
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 0        ; Color (in mode 13h, 4 is red)
    mov bx, [paddle_x_pos]
    add bx, 51
    erase_loop_right:
        mov cx, [paddle_x_pos]
        horizontal_erase_loop_right:
            inc cx            
            int 0x10
            cmp cx, bx
            jne horizontal_erase_loop_right
        xor cx, cx
        inc dx
        cmp dx, 194
        jne erase_loop_right
    mov bx, [paddle_x_pos]
    add bx, 50
    mov [paddle_x_pos], bx
    jmp done_erasing_paddle_loop_right


;#############################
; SECTION - DRAW INITIAL SETUP
;#############################

draw_ball:
    mov cx, [ball_x_pos]
    mov dx, [ball_y_pos]
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 14         ; Color (in mode 13h, 4 is red)          
    int 0x10
    inc cx
    int 0x10
    inc dx
    dec cx
    dec cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    inc dx
    inc cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    dec cx
    int 0x10
    inc cx
    inc dx
    int 0x10
    inc cx 
    int 0x10
    inc cx
    int 0x10
    inc cx
    int 0x10
    dec cx
    inc dx
    int 0x10
    dec cx
    int 0x10
    jmp done_drawing_ball

draw_paddle:
    mov cx, [paddle_x_pos]
    inc cx
    mov dx, 184
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 15         ; Color (in mode 13h, 4 is red)
    int 0x10          ; Call BIOS video services
    mov bx, [paddle_x_pos]
    add bx, 50
    draw:
        mov cx, [paddle_x_pos]
        horizontal_draw:
            inc cx            
            int 0x10
            cmp cx, bx
            jne horizontal_draw
        xor cx, cx
        inc dx
        cmp dx, 194
        jne draw
    jmp done_drawing_paddle

;NOTE: the reason this isnt functions is unconditional jumps are much faster than storing
;args on the stack and restoring stack pointer
draw_rectangles:
    jmp draw_row_1
    done_drawing_row_1:
    
    mov dx, 28
    mov cx, 4
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 2         ; Color (in mode 13h, 4 is red)
    int 0x10          ; Call BIOS video services

    jmp draw_row_2
    done_drawing_row_2:

    jmp done_drawing_rectangles

draw_row_1:
    jmp draw_rectangle_1
    done_drawing_rectangle_1:
    jmp draw_rectangle_2
    done_drawing_rectangle_2:
    jmp draw_rectangle_3
    done_drawing_rectangle_3:
    jmp draw_rectangle_4
    done_drawing_rectangle_4:
    jmp draw_rectangle_5
    done_drawing_rectangle_5:
    jmp done_drawing_row_1

draw_row_2:
    jmp draw_rectangle_6
    done_drawing_rectangle_6:
    jmp draw_rectangle_7
    done_drawing_rectangle_7:
    jmp draw_rectangle_8
    done_drawing_rectangle_8:
    jmp draw_rectangle_9
    done_drawing_rectangle_9:
    jmp draw_rectangle_10
    done_drawing_rectangle_10:
    jmp done_drawing_row_2

;take starting y coordinate and starting x coordinate as parameters
;cx is X coord, dx is Y coord
draw_rectangle_1:
    mov dx, 2
    draw_1:
        mov cx, 0
        horizontal_draw_1:
            inc cx            
            int 0x10
            cmp cx, 59
            jne horizontal_draw_1
        xor cx, cx
        inc dx
        cmp dx, 22
        jne draw_1
    jmp done_drawing_rectangle_1

draw_rectangle_6:
    mov dx, 27
    draw_6:
        mov cx, 0
        horizontal_draw_6:
            inc cx            
            int 0x10
            cmp cx, 59
            jne horizontal_draw_6
        xor cx, cx
        inc dx
        cmp dx, 47
        jne draw_6
    jmp done_drawing_rectangle_6

draw_rectangle_2:
    mov dx, 2
    draw_2:
        mov cx, 65
        horizontal_draw_2:
            inc cx            
            int 0x10
            cmp cx, 125
            jne horizontal_draw_2
        xor cx, cx
        inc dx
        cmp dx, 22
        jne draw_2
    jmp done_drawing_rectangle_2

draw_rectangle_7:
    mov dx, 27
    draw_7:
        mov cx, 65
        horizontal_draw_7:
            inc cx            
            int 0x10
            cmp cx, 125
            jne horizontal_draw_7
        xor cx, cx
        inc dx
        cmp dx, 47
        jne draw_7
    jmp done_drawing_rectangle_7

draw_rectangle_3:
    mov dx, 2
    draw_3:
        mov cx, 130
        horizontal_draw_3:
            inc cx            
            int 0x10
            cmp cx, 190
            jne horizontal_draw_3
        xor cx, cx
        inc dx
        cmp dx, 22
        jne draw_3
    jmp done_drawing_rectangle_3

draw_rectangle_8:
    mov dx, 27
    draw_8:
        mov cx, 130
        horizontal_draw_8:
            inc cx            
            int 0x10
            cmp cx, 190
            jne horizontal_draw_8
        xor cx, cx
        inc dx
        cmp dx, 47
        jne draw_8
    jmp done_drawing_rectangle_8

draw_rectangle_4:
    mov dx, 2
    draw_4:
        mov cx, 195
        horizontal_draw_4:
            inc cx            
            int 0x10
            cmp cx, 255
            jne horizontal_draw_4
        xor cx, cx
        inc dx
        cmp dx, 22
        jne draw_4
    jmp done_drawing_rectangle_4

draw_rectangle_9:
    mov dx, 27
    draw_9:
        mov cx, 195
        horizontal_draw_9:
            inc cx            
            int 0x10
            cmp cx, 255
            jne horizontal_draw_9
        xor cx, cx
        inc dx
        cmp dx, 47
        jne draw_9
    jmp done_drawing_rectangle_9

draw_rectangle_5:
    mov dx, 2
    draw_5:
        mov cx, 260
        horizontal_draw_5:
            inc cx            
            int 0x10
            cmp cx, 318
            jne horizontal_draw_5
        xor cx, cx
        inc dx
        cmp dx, 22
        jne draw_5
    jmp done_drawing_rectangle_5

draw_rectangle_10:
    mov dx, 27
    draw_10:
        mov cx, 260
        horizontal_draw_10:
            inc cx            
            int 0x10
            cmp cx, 318
            jne horizontal_draw_10
        xor cx, cx
        inc dx
        cmp dx, 47
        jne draw_10
    jmp done_drawing_rectangle_10

change_rectangle_6:
    mov ah, 1
    mov [rect_6_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_6:
        mov cx, 0
        change_horizontal_draw_6:
            inc cx            
            int 0x10
            cmp cx, 59
            jne change_horizontal_draw_6
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_6
    jmp done_changing_rectangle_6

change_rectangle_6_NW:
    mov ah, 1
    mov [rect_6_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_6_NW:
        mov cx, 0
        change_horizontal_draw_6_NW:
            inc cx            
            int 0x10
            cmp cx, 59
            jne change_horizontal_draw_6_NW
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_6_NW
    jmp done_changing_rectangle_6_NW

change_rectangle_7:
    mov ah, 1
    mov [rect_7_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_7:
        mov cx, 65
        change_horizontal_draw_7:
            inc cx            
            int 0x10
            cmp cx, 125
            jne change_horizontal_draw_7
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_7
    jmp done_changing_rectangle_7

change_rectangle_7_NW:
    mov ah, 1
    mov [rect_7_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_7_NW:
        mov cx, 65
        change_horizontal_draw_7_NW:
            inc cx            
            int 0x10
            cmp cx, 125
            jne change_horizontal_draw_7_NW
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_7_NW
    jmp done_changing_rectangle_7_NW    

change_rectangle_8:
    mov ah, 1
    mov [rect_8_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_8:
        mov cx, 130
        change_horizontal_draw_8:
            inc cx            
            int 0x10
            cmp cx, 190
            jne change_horizontal_draw_8
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_8
    jmp done_changing_rectangle_8

change_rectangle_8_NW:
    mov ah, 1
    mov [rect_8_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_8_NW:
        mov cx, 130
        change_horizontal_draw_8_NW:
            inc cx            
            int 0x10
            cmp cx, 190
            jne change_horizontal_draw_8_NW
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_8_NW
    jmp done_changing_rectangle_8_NW   

change_rectangle_9:
    mov ah, 1
    mov [rect_9_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_9:
        mov cx, 195
        change_horizontal_draw_9:
            inc cx            
            int 0x10
            cmp cx, 255
            jne change_horizontal_draw_9
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_9
    jmp done_changing_rectangle_9

change_rectangle_9_NW:
    mov ah, 1
    mov [rect_9_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_9_NW:
        mov cx, 195
        change_horizontal_draw_9_NW:
            inc cx            
            int 0x10
            cmp cx, 255
            jne change_horizontal_draw_9_NW
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_9_NW
    jmp done_changing_rectangle_9_NW

change_rectangle_10:
    mov ah, 1
    mov [rect_10_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_10:
        mov cx, 260
        change_horizontal_draw_10:
            inc cx            
            int 0x10
            cmp cx, 318
            jne change_horizontal_draw_10
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_10
    jmp done_changing_rectangle_10

change_rectangle_10_NW:
    mov ah, 1
    mov [rect_10_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_10_NW:
        mov cx, 260
        change_horizontal_draw_10_NW:
            inc cx            
            int 0x10
            cmp cx, 318
            jne change_horizontal_draw_10_NW
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_10_NW
    jmp done_changing_rectangle_10_NW

erase_row_1:
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 0         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_6_erase:
        mov cx, 0
        change_horizontal_draw_6_erase:
            inc cx            
            int 0x10
            cmp cx, 59
            jne change_horizontal_draw_6_erase
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_6_erase
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 0         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_7_erase:
        mov cx, 65
        change_horizontal_draw_7_erase:
            inc cx            
            int 0x10
            cmp cx, 125
            jne change_horizontal_draw_7_erase
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_7_erase
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 0         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_8_erase:
        mov cx, 130
        change_horizontal_draw_8_erase:
            inc cx            
            int 0x10
            cmp cx, 190
            jne change_horizontal_draw_8_erase
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_8_erase
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 0         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_9_erase:
        mov cx, 195
        change_horizontal_draw_9_erase:
            inc cx            
            int 0x10
            cmp cx, 255
            jne change_horizontal_draw_9_erase
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_9_erase
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 0         ; Color (in mode 13h, 4 is red)
    mov dx, 27
    change_10_erase:
        mov cx, 260
        change_horizontal_draw_10_erase:
            inc cx            
            int 0x10
            cmp cx, 318
            jne change_horizontal_draw_10_erase
        xor cx, cx
        inc dx
        cmp dx, 47
        jne change_10_erase

jmp done_erasing_row_1

change_rectangle_1_NE:
    mov ah, 1
    mov [rect_1_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 2
    change_1:
        mov cx, 0
        change_horizontal_draw_1:
            inc cx            
            int 0x10
            cmp cx, 59
            jne change_horizontal_draw_1
        xor cx, cx
        inc dx
        cmp dx, 22
        jne change_1
    jmp done_changing_rectangle_1_NE

change_rectangle_1_NW:
    mov ah, 1
    mov [rect_1_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 2
    change_1_NW:
        mov cx, 0
        change_horizontal_draw_1_NW:
            inc cx            
            int 0x10
            cmp cx, 59
            jne change_horizontal_draw_1_NW
        xor cx, cx
        inc dx
        cmp dx, 22
        jne change_1_NW
    jmp done_changing_rectangle_1_NW

change_rectangle_2_NE:
    mov ah, 1
    mov [rect_2_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 2
    change_2:
        mov cx, 65
        change_horizontal_draw_2:
            inc cx            
            int 0x10
            cmp cx, 125
            jne change_horizontal_draw_2
        xor cx, cx
        inc dx
        cmp dx, 22
        jne change_2    
    jmp done_changing_rectangle_2_NE

change_rectangle_2_NW:
    mov ah, 1
    mov [rect_2_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 2
    change_2_NW:
        mov cx, 65
        change_horizontal_draw_2_NW:
            inc cx            
            int 0x10
            cmp cx, 125
            jne change_horizontal_draw_2_NW
        xor cx, cx
        inc dx
        cmp dx, 22
        jne change_2_NW    
    jmp done_changing_rectangle_2_NW

change_rectangle_3_NE:
    mov ah, 1
    mov [rect_3_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 2
    change_3_NE:
        mov cx, 130
        change_horizontal_draw_3_NE:
            inc cx            
            int 0x10
            cmp cx, 190
            jne change_horizontal_draw_3_NE
        xor cx, cx
        inc dx
        cmp dx, 22
        jne change_3_NE 
    jmp done_changing_rectangle_3_NE   

change_rectangle_3_NW:
    mov ah, 1
    mov [rect_3_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 2
    change_3_NW:
        mov cx, 130
        change_horizontal_draw_3_NW:
            inc cx            
            int 0x10
            cmp cx, 190
            jne change_horizontal_draw_3_NW
        xor cx, cx
        inc dx
        cmp dx, 22
        jne change_3_NW    
    jmp done_changing_rectangle_3_NW

change_rectangle_4_NE:
    mov ah, 1
    mov [rect_4_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 2
    change_4_NE:
        mov cx, 195
        change_horizontal_draw_4_NE:
            inc cx            
            int 0x10
            cmp cx, 255
            jne change_horizontal_draw_4_NE
        xor cx, cx
        inc dx
        cmp dx, 22
        jne change_4_NE
    jmp done_changing_rectangle_4_NE

change_rectangle_4_NW:
    mov ah, 1
    mov [rect_4_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 2
    change_4_NW:
        mov cx, 195
        change_horizontal_draw_4_NW:
            inc cx            
            int 0x10
            cmp cx, 255
            jne change_horizontal_draw_4_NW
        xor cx, cx
        inc dx
        cmp dx, 22
        jne change_4_NW
    jmp done_changing_rectangle_4_NW

change_rectangle_5_NE:
    mov ah, 1
    mov [rect_5_hit], ah
    mov ah, 0x0C      ; BIOS function to set pixel color
    mov al, 1         ; Color (in mode 13h, 4 is red)
    mov dx, 2
    change_5_NE:
        mov cx, 260
        change_horizontal_draw_5_NE:
            inc cx            
            int 0x10
            cmp cx, 318
            jne change_horizontal_draw_5_NE
        xor cx, cx
        inc dx
        cmp dx, 22
        jne change_5_NE
    jmp done_changing_rectangle_5_NE

change_rectangle_5_NW:
    mov ah, 1
    mov [rect_5_hit], ah
    mov ah, 0x0C     
    mov al, 1         
    mov dx, 2
    change_5_NW:
        mov cx, 260
        change_horizontal_draw_5_NW:
            inc cx            
            int 0x10
            cmp cx, 318
            jne change_horizontal_draw_5_NW
        xor cx, cx
        inc dx
        cmp dx, 22
        jne change_5_NW
    jmp done_changing_rectangle_5_NW