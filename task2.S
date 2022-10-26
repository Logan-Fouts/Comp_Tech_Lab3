@ Done By Samuel Brandt and Logan Fouts Group F
    .EQU LED_PIN1, 0
    .EQU BUTTON1, 1
    .EQU BUTTON2, 2
    .EQU GPIO_IN, 0
    .EQU GPIO_OUT, 1

.thumb_func
.global main

main:
    MOV R0, #LED_PIN1
    BL gpio_init             @ Initalize the LED as output
    MOV R0, #LED_PIN1
    MOV R1, #GPIO_OUT
    BL link_gpio_set_dir

    MOV R0, #BUTTON1
    BL gpio_init
    MOV R0, #BUTTON1        @ Initalize the 2 buttons as input
    MOV R1, #GPIO_IN
    BL link_gpio_set_dir

    MOV R0, #BUTTON2
    BL gpio_init
    MOV R0, #BUTTON2
    MOV R1, #GPIO_IN
    BL link_gpio_set_dir

    MOV R0, #LED_PIN1       @ Start with the LED off
    MOV R1, #0
    BL link_gpio_put

loop:

    MOV R0, #BUTTON1
    BL gpio_get_in
    MOV R6, R0             
    CMP R6, #1
    BEQ led_on
                             @ Checks Buttons for state change and calls subroutines.
    MOV R0, #BUTTON2
    BL gpio_get_in
    MOV R7, R0
    CMP R7, #1
    BEQ led_off
B loop


led_on:
    PUSH {lr}
    MOV R0, #LED_PIN1
    MOV R1, #1               @ Turns the LED on.
    BL link_gpio_put
    POP {PC}
    B loop

led_off:
    PUSH {lr}
    MOV R0, #LED_PIN1        @ Turns the LED off.
    MOV R1, #0
    BL link_gpio_put
    POP {PC}
    B loop


.data
.align  4
test: .asciz "%d\n"
