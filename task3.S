@ Done By Samuel Brandt and Logan Fouts Group F  
    .EQU LED_PIN1, 0
    .EQU BUTTON1, 1
    .EQU BUTTON2, 2
    .EQU BUTTON3, 3
    .EQU BUTTON4, 4
    .EQU GPIO_IN, 0
    .EQU GPIO_OUT, 1
    .EQU sleep_time, 1000

.thumb_func
.global main

main:
    LDR R5, =sleep_time           @ Load the sleep time into a register so we can change it.

    MOV R0, #LED_PIN1
    BL gpio_init
    MOV R0, #LED_PIN1             @ Initalize the LED as an output.
    MOV R1, #GPIO_OUT
    BL link_gpio_set_dir

    MOV R0, #BUTTON1              @ Initalize the 4 buttons as inputs.
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

    MOV R0, #LED_PIN1           @ Start with the led off.
    MOV R1, #0
    BL link_gpio_put

loop:
    MOV R0, #BUTTON1
    BL gpio_get_in              @ Check if button 1 has been pressed, and if so blink the LED.
    MOV R6, R0
    CMP R6, #1
    BEQ after
    B loop

after:                          @ Blinks the LED and checks for button2, button3, and button4 presses.
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

    MOV R0, #BUTTON3           @ If button3 is pressed increase the sleep time subroutine is called.
    BL gpio_get_in
    MOV R7, R0
    CMP R7, #1
    BEQ increase

    MOV R0, #BUTTON4           @ If button4 is pressed decrease the sleep time subroutine is called.
    BL gpio_get_in
    MOV R7, R0
    CMP R7, #1
    BEQ decrease

    MOV R0, #BUTTON2           @ If button2 is pressed call the led off subroutine.
    BL gpio_get_in
    MOV R7, R0
    CMP R7, #1
    BEQ led_off
B after


led_on:
    PUSH {lr}
    MOV R0, #LED_PIN1          @ Turns LED on.
    MOV R1, #1
    BL link_gpio_put
    POP {PC}
    B loop

led_off:
    MOV R0, #LED_PIN1          @ Turns LED off.
    MOV R1, #0
    BL link_gpio_put
    B loop

decrease:                      @ Decreases sleep time by subtracting 100ms from R5.
    SUB R5, R5, #100
    B after

increase:                      @ Increases sleep time by adding 100ms to R5.
    ADD R5, R5, #100
    B after 


.data
.align  4
test: .asciz "%d!\n"
