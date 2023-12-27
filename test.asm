.model small
.data
    ms db 10,'invalid,please Enter number','$' 
    prompt_msg db 10,10,'Do you want to continue? (Y/N): $'
    msg db 10,'                Use the Color Wheel to Pick the Right Palette              ' , '$'
    mssymbol db 10,10, '            ====================================================','$'
    msComplementary db 10,'Complementary : Two colors that are on opposite sides of the color wheel','$'
    msAnalogous db 10,'Analogous : Three colors that are side by side on the color wheel','$'
    msTriadic db 10,'Triadic : Three colors that are evenly spaced on the color wheel','$'
    arr db 'red $','purple-red $','purple $','blue $','blue-green $','green $','yellow-green $','yellow $','orange $','orange-red$','$'
    msg_scheme db 10,10,'Choose a color scheme (1=Complementary, 2=Analogous, 3=Triadic): $'
    msg_color db 10,10, 'Choose a color' ,10, '0=Red ',10,'1=purple-red',10,'2=purple',10,'3=Blue',10,'4=blue-green',10,'5=green',10,'6=yellow-green',10,'7=yellow',10,'8=orange',10,'9=red-orange ): $'
    result_msg db 10,10,'The color: $'
.code
main proc far 
.startup
    lea dx,msg
    call print 
    lea dx ,mssymbol
    call print
start:
    lea dx, msg_scheme
    call print
    
    ; Set the color palette based on the chosen color scheme
    mov ah, 01h
    int 21h
    
    sub al, '0'   ; Convert ASCII to integer
    mov bl, al    ; Save the chosen color
    
    lea dx ,mssymbol
    call print
    
    cmp bl ,1
    je Complementary
    cmp bl ,2
    je Analogous
    cmp bl ,3
    je Triadic
    jne invalid 
Complementary:    
    call com 
Analogous:
    call ana    
 Triadic:
    call tri
 invalid :
    mov dx,0
    lea dx,ms
    call print
   jmp stop    
stop:
        mov dx,0 
    mov ah, 09h 
    lea dx, prompt_msg 
    int 21h 

    
    mov ah, 01h 
    int 21h 
    ; Check if the user wants to exit
    cmp al, 'n'
    je exit
    ; Check if the user wants to continue
    cmp al, 'y'
    jmp start

    
exit:          
.exit
main endp    
print proc near
            mov ah, 09h
            int 21h
            ret 
        print endp 
     
     
com proc near 

    mov dx,0
    lea dx,msComplementary
    call print
    lea dx, msg_color
    call print 
    mov ah, 01h
    int 21h
    sub al, '0'   ; Convert ASCII to integer
    mov bl, al    ; Save the chosen color
     lea si,arr
        cmp bl ,0
        ; Display matching colors based on user input
        lea dx, result_msg
        call print
        je c_red
        cmp bl ,1
        je ppred
        cmp bl,2
        je pyellow
        cmp bl,3
        je borange
        cmp bl,4
        je bgor
        cmp bl,5
        je gred
        cmp bl,6
        je ygpr
        cmp bl,7
        je purple
        cmp bl,8
        je blue
        cmp bl,9
        je blueGreen  
    c_red:
        mov ah, 09h      
        lea dx, [si]+36   
        int 21h
        jmp stop
    ppred :
        mov dx,0
        mov ah, 09h      
        lea dx, [si]+50
        int 21h
        jmp stop 
    pyellow:
        mov dx,0
        mov ah, 09h     
        lea dx, [si]+64
        int 21h
        jmp stop 
    borange:
        mov dx,0
        mov ah, 09h     
        lea dx, [si]+72
        int 21h
        jmp stop 
    bgor:
        mov dx,0
        mov ah, 09h      
        lea dx, [si]+80
        int 21h
        jmp stop 
    gred:
        mov dx,0
        mov ah, 09h      
        lea dx, [si]
        int 21h
        jmp stop 
    ygpr:
        mov dx,0
        mov ah, 09h    
        lea dx, [si]+5
        int 21h
        jmp stop 
    purple:
        mov dx,0
        mov ah, 09h     
        lea dx, [si]+17
        int 21h
        jmp stop 
    blue:
        mov dx,0
        mov ah, 09h      ; DOS function to print a string
        lea dx, [si]+25
        ; Load the address of the current string into DX
        int 21h
        jmp stop 
    blueGreen: 
        mov dx,0
        mov ah, 09h      ; DOS function to print a string
        lea dx, [si]+31
        int 21h
        jmp stop
com endp 

ana proc near
mov dx,0
    lea dx,msAnalogous
    call print
    lea dx, msg_color
    call print
    mov ah, 01h
    int 21h
    lea si,arr
    sub al, '0'   ; Convert ASCII to integer
    mov bl, al   
    lea dx, result_msg
    call print
        cmp bl,0
        je ared
        cmp bl ,1
        je appred
        cmp bl,2
        je apyellow
        cmp bl,3
        je aborange
        cmp bl,4
        je abgor
        cmp bl,5
        jmp agred
        cmp bl,6
        jmp aygpr
        cmp bl,7
        jmp apurple
        cmp bl,8
        jmp ablue
        cmp bl,9
        jmp ablueGreen
    ared:
        mov dx,0
        mov ah, 09h      ; DOS function to print a string
        lea dx, [si]
        ; Load the address of the current string into DX
        int 21h
        lea dx,[si]+72
        int 21h
        lea dx,[si]+80
        int 21h
        jmp stop
    appred:
        mov dx,0
        mov ah, 09h      
        lea dx, [si]+5
        int 21h
        lea dx,[si]+17
        int 21h
        lea dx,[si]+25
        int 21h
        jmp stop
    apyellow:
        mov dx,0
        mov ah, 09h      
        lea dx, [si]+17
        int 21h
        lea dx,[si]+25
        int 21h
        lea dx,[si]+31
        int 21h
        jmp stop
    aborange:  
        mov dx,0
        mov ah, 09h      
        lea dx, [si]+25
        int 21h
        lea dx,[si]+31
        int 21h
        lea dx,[si]+36
        int 21h
        jmp stop  
    abgor:    
         mov dx,0
        mov ah, 09h    
        lea dx, [si]+31
        int 21h
        lea dx,[si]+36
        int 21h
        lea dx,[si]+50
        int 21h
        jmp stop  
    agred: 
        mov dx,0
        mov ah, 09h      
        lea dx, [si]+36
        int 21h
        lea dx,[si]+50
        int 21h
        lea dx,[si]+64
        int 21h
        jmp stop     
    aygpr :  
        mov dx,0
        mov ah, 09h     
        lea dx, [si]+50
        int 21h
        lea dx,[si]+64
        int 21h
        lea dx,[si]+72
        int 21h
        jmp stop 
        
    apurple: 
       mov dx,0
        mov ah, 09h   
        lea dx, [si]+64
        int 21h
        lea dx,[si]+72
        int 21h
        lea dx,[si]+80
        int 21h
        jmp stop   
    ablue: 
         mov dx,0
        mov ah, 09h      
        lea dx, [si]+72
        int 21h
        lea dx,[si]+80
        int 21h
        lea dx,[si]
        int 21h
        jmp stop    
    ablueGreen: 
         mov dx,0
        mov ah, 09h      
        lea dx, [si]+80
        int 21h
        lea dx,[si]
        int 21h
        lea dx,[si]+5
        int 21h
        jmp stop 
ana endp     
tri proc near 
  mov dx,0
    lea dx,msTriadic
    call print
    lea dx, msg_color
    call print
    mov ah, 01h
    int 21h
    lea si,arr
    sub al, '0'   ; Convert ASCII to integer
    mov bl, al  
    lea dx, result_msg
    call print
        cmp bl,0
        je tred
        cmp bl ,1
        je tppred
        cmp bl,2
        je tpyellow
        cmp bl,3
        je tborange
        cmp bl,4
        je tbgor
        cmp bl,5
        jmp tgred
        cmp bl,6
        jmp tygpr
        cmp bl,7
        jmp tpurple
        cmp bl,8
        jmp tblue
        cmp bl,9
        jmp tblueGreen
    tred:
        mov dx,0
        mov ah, 09h      
        lea dx, [si]+10 
        int 21h
        lea dx,[si]+64
        int 21h
        lea dx,[si]+72
        int 21h
        jmp stop
    tppred:
         mov dx,0
        mov ah, 09h      ; DOS function to print a string
        lea dx, [si]+5
        ; Load the address of the current string into DX
        int 21h
        lea dx,[si]+36
        int 21h
        lea dx,[si]+64
        int 21h
        jmp stop    
    tpyellow: 
        mov dx,0
        mov ah, 09h      ; DOS function to print a string
        lea dx, [si]+17
        ; Load the address of the current string into DX
        int 21h
        lea dx,[si]+50
        int 21h
        lea dx,[si]+72
        int 21h
        jmp stop   
    tborange:  
        mov dx,0
        mov ah, 09h      ; DOS function to print a string
        lea dx, [si]+25
        ; Load the address of the current string into DX
        int 21h
        lea dx,[si]+64
        int 21h
        lea dx,[si]+80
        int 21h
        jmp stop    
    tbgor:  
        mov dx,0
        mov ah, 09h      ; DOS function to print a string
        lea dx, [si]+31
        ; Load the address of the current string into DX
        int 21h
        lea dx,[si]+72
        int 21h
        lea dx,[si]
        int 21h
        jmp stop  
    tgred: 
        mov dx,0
        mov ah, 09h      ; DOS function to print a string
        lea dx, [si]+36
        ; Load the address of the current string into DX
        int 21h
        lea dx,[si]+80
        int 21h
        lea dx,[si]+5
        int 21h
        jmp stop     
    tygpr:  
        mov dx,0
        mov ah, 09h      ; DOS function to print a string
        lea dx, [si]+50
        ; Load the address of the current string into DX
        int 21h
        lea dx,[si]
        int 21h
        lea dx,[si]+17
        int 21h
        jmp stop    
    tpurple: 
        mov dx,0
        mov ah, 09h      ; DOS function to print a string
        lea dx, [si]+64
        ; Load the address of the current string into DX
        int 21h
        lea dx,[si]+25
        int 21h
        lea dx,[si]+5
        int 21h
        jmp stop     
    tblue:
       mov dx,0
        mov ah, 09h      ; DOS function to print a string
        lea dx, [si]+72
        ; Load the address of the current string into DX
        int 21h
        lea dx,[si]+31
        int 21h
        lea dx,[si]+17
        int 21h
        jmp stop 
    tblueGreen: 
        mov dx,0
        mov ah, 09h      ; DOS function to print a string
        lea dx, [si]+80
        ; Load the address of the current string into DX
        int 21h
        lea dx,[si]+36
        int 21h
        lea dx,[si]+2
        int 21h
        jmp stop  
tri endp  
end main     