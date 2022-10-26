@ Done By Samuel Brandt and Logan Fouts Group F
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


sum:
    MOV R3, #0         @ Stores sum.

    LDR R2, [R0, #0]   @ num1.
    ADD R3, R3, R2
    LDR R2, [R0, #4]   @ num2.
    ADD R3, R3, R2
    LDR R2, [R0, #8]   @ num3.
    ADD R3, R3, R2
    LDR R2, [R0, #12]  @ num4.
    ADD R3, R3, R2
    LDR R2, [R0, #16]  @ num5.
    ADD R3, R3, R2
    LDR R2, [R0, #20]  @ num6.
    ADD R3, R3, R2
    LDR R2, [R0, #24]  @ num7.
    ADD R3, R3, R2
    LDR R2, [R0, #28]  @ num8.
    ADD R3, R3, R2

    MOV R0, R3         @ Move the sum into R0.
    BX lr

average:
    PUSH {lr}
    BL sum
    LSR R0, #3         @ Divide by 8.
    POP {pc}
    BX lr

.data
    .align 4
    my_array: .word 10, 20, 30, 40, 50, 60, 70, 80
    message_str: .asciz "Average value %d\n"
   
