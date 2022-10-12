.thumb_func
.global main

main:
    BL stdio_init_all

loop:
    LDR R0, =my_array
    MOV R1, #8
    BL average

    MOV R1, R0
    LDR R0, =message_str
    BL printf
    B loop

average:



.data
    .align 4
    message_str: .asciz "Average value %d\n"
    my_array: .word 10, 20, 30, 40, 50, 60, 70, 80