.model small
.stack 100h 
.data 
;Passswoed Property
a db 10,13,"Enter Your Password:$" 
b db 10,13,"Invalid Password$" 
pass db "shabrina$" 
pass1 dw 8

;Option Property
wel db 10,13,"                   Welcome to Your Account $"
bal db 10,13,10,13,"1. Balance Inquiry $" 
with db 10,13,"2. Money Withdraw $" 
trans db 10,13,"3. Transfer Money $"
cur_con db 10,13,"4. Currency Convert $" 
ex db 10,13,"5. Exit $"
bac db 10,13,"1. Back$" 
ext db 10,13,"2. Exit$"

;Message Property 
thank db 10,13,10,13,"                   Thank You For Banking With Us. $"
inval db 10,13,"Invalid Input$"
new db 10,13,"$"


; Balance show property
totalbal db 10,13,"Your Total Balance is: 25,000 USD $" 
availablebal db 10,13,"Your Available Balance is: 24,900 USD $"  
interest db 10,13,"You got Interest rate 5% of your amount 25,000 and the 5% amount is = 1250 USD $"
in_totbal db 10,13,"With Interest Your Total Balance is: 26,250 USD $"
in_availbal db 10,13,"Your Available Balance is: 26,150 USD $" 


;Money Withdrow Option
fivehun db 10,13,"1. 500 USD$" 
one db 10,13,"2. 1,000 USD$"
three db 10,13,"3. 3,000 USD$"
five db 10,13,"4. 5,000 USD$"
ten db 10,13,"5. 10,000 USD$"
fiften db 10,13,"6. 15,000 USD$"
tweenty db 10,13,"7. 20,000 USD$"

;Balance info
t1 db 10,13,"Your Total Balance is: 25,750 USD $" 
av1 db 10,13,"Your Available Balance is: 25,650 USD $"

t2 db 10,13,"Your Total Balance is: 25,250 USD $" 
av2 db 10,13,"Your Available Balance is: 25,150 USD $"

t3 db 10,13,"Your Total Balance is: 23,250 USD $" 
av3 db 10,13,"Your Available Balance is: 23,150 USD $"

t4 db 10,13,"Your Total Balance is: 21,250 USD $" 
av4 db 10,13,"Your Available Balance is: 21,150 USD $"

t5 db 10,13,"Your Total Balance is: 16,250 USD $" 
av5 db 10,13,"Your Available Balance is: 16,150 USD $"

t6 db 10,13,"Your Total Balance is: 11,250 USD $" 
av6 db 10,13,"Your Available Balance is: 11,150 USD $"

t7 db 10,13,"Your Total Balance is: 6,250 USD $" 
av7 db 10,13,"Your Available Balance is: 6,150 USD $" 


;Amount Property
wdamount db 10,13,"Enter Your Withdrow Amount$" 
tranamount db 10,13,"Enter Your Transaction Amount$"  
success db 10,13,"Your Transaction is Successfull...$" 
accountnum db 10,13,"Enter Account Number: $"

;Converting Property
cur_t db 10,13,,"Enter which currency type you wanted to convert $" 
pd db 10,13,10,13,"1. Pound $" 
bd db 10,13,"2. BDT $" 
con_amount db 10,13,"Enter the serial number of Converting Amount $"
con_sucs db 10,13,"Your Currency converting is Successfull...$"

;Pound
pd1 db 10,13,"Your amount 500 USD converted into Pound $" 
pd11 db 10,13,"Your converted amount is: 361.27 POUND $"

pd2 db 10,13,"Your amount 1000 USD converted into Pound $" 
pd22 db 10,13,"Your converted amount is: 722.55 POUND $"

pd3 db 10,13,"Your amount 3000 USD converted into Pound $" 
pd33 db 10,13,"Your converted amount is: 2167.65 POUND $"

pd4 db 10,13,"Your amount 5000 USD converted into Pound $" 
pd44 db 10,13,"Your converted amount is: 3612.75 POUND $" 

;BDT
bd1 db 10,13,"Your amount 500 USD converted into BDT $" 
bd11 db 10,13,"Your converted amount is: 42489.28 bdt $"

bd2 db 10,13,"Your amount 1000 USD converted into BDT $" 
bd22 db 10,13,"Your converted amount is: 84978.56 bdt $"

bd3 db 10,13,"Your amount 3000 USD converted into BDT $" 
bd33 db 10,13,"Your converted amount is: 254935.68 bdt $"

bd4 db 10,13,"Your amount 5000 USD converted into BDT $" 
bd44 db 10,13,"Your converted amount is: 424892.80 bdt $"

.code
main proc
    mov ax,@data
    mov ds,ax 
    
    
    ;Password Cheek Level
    mov cx,pass1                ;; enters the length of pass
    mov bx,offset pass          
    
    mov ah,9                   ;9=WRITE STRING TO STANDARD OUTPUT
    lea dx,a                   ;print enter pass
    int 21h
    
    cheekpass:
    mov ah,8     ; enters first char of the pass & 8=CHARACTER INPUT WITHOUT ECHO
    int 21h
    
    cmp al,[bx] 
    jne worng
   
   
    inc bx
    loop cheekpass
    
    mov ah,0x00
    mov al,0x03              ;set video mode to TextMode
    int 0x10                 ; INT 0x10 is used for screen manipulation
    jmp mainpross            ; after correct password goes to next step "Account option"
    
    
    ;Worng Password Level
    worng:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    mov ah,9
    lea dx,b      ;  Used to load the address of operand into the provided register.
    int 21h
    mov ah,4ch    ;EXIT - TERMINATE WITH RETURN CODE
    int 21h
    
    
    
    ;Account Option
    mainpross:
    mov ah,9
    lea dx,wel
    int 21h 
    mov ah,9
    lea dx,bal
    int 21h
    mov ah,9
    lea dx,with
    int 21h
    mov ah,9
    lea dx,trans
    int 21h
    mov ah,9
    lea dx,cur_con
    int 21h 
    mov ah,9
    lea dx,ex
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    mov ah,1        ;1=READ CHARACTER FROM STANDARD INPUT, WITH ECHO
    int 21h
    mov bl,al
    
    
    ;Input Cheek 
    cheek:
    cmp bl,49 
    je blance
    cmp bl,50 
    je withdraw
    cmp bl,51 
    je Transfer
    cmp bl,52 
    je converting
    cmp bl,53 
    je exit
    jmp err
    
    
    ;Account Balance Cheek Level
    blance:
    mov ah,0x00
    mov al,0x03
    int 0x10
     
    mov ah,9
    lea dx,totalbal
    int 21h 
    mov ah,9
    lea dx,availablebal
    int 21h
    
    lea dx,new
    int 21h   ;new line
    
    mov ah,9
    lea dx,interest
    int 21h
    
    lea dx,new
    int 21h   ;new line
     
    mov ah,9
    lea dx,in_totbal
    int 21h 
    mov ah,9
    lea dx,in_availbal
    int 21h                           ; shows the balnce of the account
    jmp option
    
     
    ;currency converting level
    
    converting:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    mov ah,9
    lea dx,cur_t
    int 21h
    mov ah,9
    lea dx,pd
    int 21h
    mov ah,9
    lea dx,bd
    int 21h
    mov ah,9
    lea dx,new
    int 21h
    mov ah,1        ;1=READ CHARACTER FROM STANDARD INPUT, WITH ECHO
    int 21h
    mov bl,al
    
    cmp bl,49 
    je cur_pd
    cmp bl,50 
    je cur_bd
    
    cur_pd:
    mov ah,0x00
    mov al,0x03
    int 0x10
    mov ah,9
    lea dx,new
    int 21h
    mov ah,9
    lea dx,con_amount
    int 21h
    
    mov ah,9
    lea dx,fivehun
    int 21h
    
    mov ah,9
    lea dx,one
    int 21h 
    
    mov ah,9
    lea dx,three
    int 21h
    
    mov ah,9
    lea dx,five
    int 21h
    
    
    mov ah,9
    lea dx,new
    int 21h
    mov ah,1
    int 21h
    mov bl,al
     
    cmp bl,49 
    je pdpross1 
    
    cmp bl,50 
    je pdpross2
    
    cmp bl,51 
    je pdpross3
    
    cmp bl,52
    je pdpross4   
    
    pdpross1:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    
    mov ah,9
    lea dx,con_sucs
    int 21h
    mov ah,9
    lea dx,new
    int 21h 
    mov ah,9
    lea dx,pd1
    int 21h
    mov ah,9
    lea dx,pd11
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
    
    pdpross2:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    
    mov ah,9
    lea dx,con_sucs
    int 21h
    mov ah,9
    lea dx,new
    int 21h 
    mov ah,9
    lea dx,pd2
    int 21h
    mov ah,9
    lea dx,pd22
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
    
    pdpross3:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    
    mov ah,9
    lea dx,con_sucs
    int 21h
    mov ah,9
    lea dx,new
    int 21h 
    mov ah,9
    lea dx,pd3
    int 21h
    mov ah,9
    lea dx,pd33
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
    
    pdpross4:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    
    mov ah,9
    lea dx,con_sucs
    int 21h
    mov ah,9
    lea dx,new
    int 21h 
    mov ah,9
    lea dx,pd4
    int 21h
    mov ah,9
    lea dx,pd4
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
                
                
    cur_bd:
    mov ah,0x00
    mov al,0x03
    int 0x10
    mov ah,9
    lea dx,new
    int 21h
    mov ah,9
    lea dx,con_amount
    int 21h
    
    mov ah,9
    lea dx,fivehun
    int 21h
    
    mov ah,9
    lea dx,one
    int 21h 
    
    mov ah,9
    lea dx,three
    int 21h
    
    mov ah,9
    lea dx,five
    int 21h
    
    
    mov ah,9
    lea dx,new
    int 21h
    mov ah,1
    int 21h
    mov bl,al
     
    cmp bl,49 
    je bdpross1 
    
    cmp bl,50 
    je bdpross2
    
    cmp bl,51 
    je bdpross3
    
    cmp bl,52
    je bdpross4   
    
    bdpross1:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    
    mov ah,9
    lea dx,con_sucs
    int 21h
    mov ah,9
    lea dx,new
    int 21h 
    mov ah,9
    lea dx,bd1
    int 21h
    mov ah,9
    lea dx,bd11
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
    
    bdpross2:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    
    mov ah,9
    lea dx,con_sucs
    int 21h
    mov ah,9
    lea dx,new
    int 21h 
    mov ah,9
    lea dx,bd2
    int 21h
    mov ah,9
    lea dx,bd22
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
    
    bdpross3:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    
    mov ah,9
    lea dx,con_sucs
    int 21h
    mov ah,9
    lea dx,new
    int 21h 
    mov ah,9
    lea dx,bd3
    int 21h
    mov ah,9
    lea dx,bd33
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
    
    bdpross4:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    
    mov ah,9
    lea dx,con_sucs
    int 21h
    mov ah,9
    lea dx,new
    int 21h 
    mov ah,9
    lea dx,bd4
    int 21h
    mov ah,9
    lea dx,bd44
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option            
                
                
                
                
    ;Money Withdrow Level
    withdraw:
    mov ah,0x00
    mov al,0x03
    int 0x10
    mov ah,9
    lea dx,new
    int 21h
    mov ah,9
    lea dx,wdamount
    int 21h  
    
    ;Money Withdrow Option Display
    mov ah,9
    lea dx,fivehun
    int 21h
    
    mov ah,9
    lea dx,one
    int 21h 
    
    mov ah,9
    lea dx,three
    int 21h
    
    mov ah,9
    lea dx,five
    int 21h
    
    mov ah,9
    lea dx,ten
    int 21h
    
    mov ah,9
    lea dx,fiften
    int 21h
    
    mov ah,9
    lea dx,tweenty
    int 21h
    
    mov ah,9
    lea dx,new
    int 21h
    mov ah,1
    int 21h
    mov bl,al 
    
    ;Input Condition Cheek
    cmp bl,49 
    je pross1 
    
    cmp bl,50 
    je pross2
    
    cmp bl,51 
    je pross3
    
    cmp bl,52
    je pross4  
    
    cmp bl,53
    je pross5
    
    cmp bl,54
    je pross6
    
    cmp bl,55
    je pross7
    jmp err
    
    
    ;Option 1
    pross1:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    mov ah,9
    lea dx,success
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    mov ah,9
    lea dx,new
    int 21h
    
    mov ah,9
    lea dx,t1
    int 21h 
    mov ah,9
    lea dx,av1
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
    
    ;Option 2
    pross2:
    mov ah,0x00
    mov al,0x03
    int 0x10
    mov ah,9
    lea dx,success
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    mov ah,9
    lea dx,new
    int 21h 
    
    mov ah,9
    lea dx,t2
    int 21h 
    mov ah,9
    lea dx,av2
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
    
    ;Option 3
    pross3:
    mov ah,0x00
    mov al,0x03
    int 0x10
    mov ah,9
    lea dx,success
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    mov ah,9
    lea dx,new
    int 21h 
    
    mov ah,9
    lea dx,t3
    int 21h 
    mov ah,9
    lea dx,av3
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
    
    ;Option 4
    pross4:
    mov ah,0x00
    mov al,0x03
    int 0x10
    mov ah,9
    lea dx,success
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    mov ah,9
    lea dx,new
    int 21h 
    
    mov ah,9
    lea dx,t4
    int 21h 
    mov ah,9
    lea dx,av4
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
    
    ;Option 5
    pross5:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    mov ah,9
    lea dx,success
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    mov ah,9
    lea dx,new
    int 21h 
    
    mov ah,9
    lea dx,t5
    int 21h 
    mov ah,9
    lea dx,av5
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
    
    ;Option 6
    pross6:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    mov ah,9
    lea dx,success
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    mov ah,9
    lea dx,new
    int 21h  
    
    mov ah,9
    lea dx,t6
    int 21h 
    mov ah,9
    lea dx,av6
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option 
    
    ;Option 7
    pross7:
    mov ah,0x00
    mov al,0x03
    int 0x10
    mov ah,9
    lea dx,success
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    mov ah,9
    lea dx,new
    int 21h
    
    mov ah,9
    lea dx,t7
    int 21h 
    mov ah,9
    lea dx,av7
    int 21h 
    mov ah,9
    lea dx,new
    int 21h
    jmp option
    
    
    
 
    
    
    ;Balance Transfer Level
    Transfer:
    mov ah,0x00
    mov al,0x03
    int 0x10
    mov ah,9
    lea dx,accountnum
    int 21h
    
    mov ah,1
    acco:  
    int 21h 
    cmp al,13
    jne acco   
    
    mov ah,9
    lea dx,new
    int 21h 
    
    
    ;Again Password Cheek
    mov ah,9
    lea dx,a
    int 21h   
    
    mov cx,pass1
    mov bx,offset pass
    
    again:
    mov ah,8
    int 21h
    
    cmp al,[bx] 
    jne worng
    mov ah,2
    mov dl,42
    int 21h
    inc bx
    loop again
    mov ah,0x00
    mov al,0x03
    int 0x10 
    jmp transferpross
    
    
    ;Money Transfer Proccess
    transferpross:
    mov ah,9
    lea dx,tranamount
    int 21h  
    ;Transfer Amount Display
    mov ah,9
    lea dx,fivehun
    int 21h
    
    mov ah,9
    lea dx,one
    int 21h 
    
    mov ah,9
    lea dx,three
    int 21h
    
    mov ah,9
    lea dx,five
    int 21h
    
    mov ah,9
    lea dx,ten
    int 21h
    
    mov ah,9
    lea dx,fiften
    int 21h
    
    mov ah,9
    lea dx,tweenty
    int 21h
    
    mov ah,9
    lea dx,new
    int 21h
    mov ah,1
    int 21h
    mov bl,al 
    
    ;Input Condition Cheek
    cmp bl,49 
    je pross1 
    
    cmp bl,50 
    je pross2
    
    cmp bl,51 
    je pross3
    
    cmp bl,52
    je pross4  
    
    cmp bl,53
    je pross5
    
    cmp bl,54
    je pross6
    
    cmp bl,55
    je pross7
    jmp err
     
    
    
    
    
    ;Back And Exit Option Level
    option: 
    mov ah,9
    lea dx,new
    int 21h
    mov ah,9
    lea dx,bac
    int 21h
    mov ah,9
    lea dx,ext
    int 21h
    mov ah,9
    lea dx,new
    int 21h
    mov ah,1
    int 21h
    cmp al,49
    je back
    cmp al,50
    je exit
    jmp err
    
      
    
    ;back Option Level
    back:
    mov ah,0x00
    mov al,0x03
    int 0x10
    call mainpross
    
    
    ;Input Error Level
    err:
    mov ah,0x00
    mov al,0x03
    int 0x10 
    mov ah,9
    lea dx,inval
    int 21h 
    mov ah,9
    lea dx,new
    int 21h  
    call mainpross
  
    
    ;DOS Exit Level
    exit:
    mov ah,0x00
    mov al,0x03
    int 0x10
    mov ah,9
    lea dx,thank
    int 21h 
    mov ah,4ch
    int 21h
    main endp
end main 


