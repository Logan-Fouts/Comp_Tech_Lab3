    .EQU LED_PIN1, 0
    .EQU BUTTON1, 1
    .EQU BUTTON2, 2
    .EQU GPIO_IN, 0
    .EQU GPIO_OUT, 1
    .EQU BUTTON3, 3
    .EQU BUTTON4, 4
    .EQU sleep_time, 1000

.thumb_func
.global main

main:
    LDR R5, =sleep_time

    MOV R0, #LED_PIN1
    BL gpio_init
    MOV R0, #LED_PIN1
    MOV R1, #GPIO_OUT
    BL link_gpio_set_dir

    MOV R0, #BUTTON1
    BL gpio_init
    MOV R0, #BUTTON1
    MOV R1, #GPIO_IN
    BL link_gpio_set_dir

    MOV R0, #BUTTON2
    BL gpio_init
    MOV R0, #BUTTON2
    MOV R1, #GPIO_IN
    BL link_gpio_set_dir

    MOV R0, #BUTTON3
    BL gpio_init
    MOV R0, #BUTTON3
    MOV R1, #GPIO_IN
    BL link_gpio_set_dir

    MOV R0, #BUTTON4
    BL gpio_init
    MOV R0, #BUTTON4
    MOV R1, #GPIO_IN
    BL link_gpio_set_dir

    MOV R0, #LED_PIN1
    MOV R1, #0
    BL link_gpio_put

loop:

    MOV R0, #BUTTON1
    BL gpio_get_in
    MOV R6, R0
    CMP R6, #1
    BEQ after
    B loop
after:

    MOV R0, #LED_PIN1
    MOV R1, #1
    BL link_gpio_put

    MOV R0, R5
    BL sleep_ms

    MOV R0, #LED_PIN1
    MOV R1, #0
    BL link_gpio_put

    MOV R0, R5
    BL sleep_ms

    MOV R0, #BUTTON3
    BL gpio_get_in
    MOV R7, R0
    CMP R7, #1
    BEQ increase

    MOV R0, #BUTTON4
    BL gpio_get_in
    MOV R7, R0
    CMP R7, #1
    BEQ decrease

    MOV R0, #BUTTON2
    BL gpio_get_in
    MOV R7, R0
    CMP R7, #1
    BEQ led_off
B after


led_on:
    PUSH {lr}
    MOV R0, #LED_PIN1
    MOV R1, #1
    BL link_gpio_put
    POP {PC}
    B loop

led_off:
    MOV R0, #LED_PIN1
    MOV R1, #0
    BL link_gpio_put
    B loop

decrease:
    SUB R5, R5, #100
    B after

increase:
    ADD R5, R5, #100
    B after 


.data
.align  4
test: .asciz "%d!\n"
