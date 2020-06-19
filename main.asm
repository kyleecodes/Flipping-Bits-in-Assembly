;; Author: Kylee Fields
;; Description: A table that changes colors based on user input (Assembly language.)

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data

; strings for labeling bits
sevenString db "  7  ", 0
sixString   db "  6  ", 0
fiveString  db "  5  ", 0
fourString  db "  4  ", 0
threeString db "  3  ", 0
twoString   db "  2  ", 0
oneString   db "  1  ", 0
zeroString  db "  0  ", 0

bitString db "  0  ", 0
bitOneString db "  1  ", 0

; table lines & spaces
splitLine      db 186d , 0 
midT			db 206d, 0
splitDash      db 205d, 0
topT			db 203d, 0
bottomT        db 202d, 0


; phrasing
positionString  db " BIT POSITION ", 0
codeString      db "   BIT CODE   ", 0
directionString db "Please press a corresponding key for the bit that you would like to cycle...", 0dh, 0ah, 0
press0          db "Press the '0' key to shift the bit in position 0.", 0dh, 0ah, 0
press1          db "Press the '1' key to shift the bit in position 1.", 0dh, 0ah, 0
press2          db "Press the '2' key to shift the bit in position 2.", 0dh, 0ah, 0
press3          db "Press the '3' key to shift the bit in position 3.", 0dh, 0ah, 0
press4          db "Press the '4' key to shift the bit in position 4.", 0dh, 0ah, 0
press5          db "Press the '5' key to shift the bit in position 5.", 0dh, 0ah, 0
press6          db "Press the '6' key to shift the bit in position 6.", 0dh, 0ah, 0
press7          db "Press the '7' key to shift the bit in position 7.", 0dh, 0ah, 0
wrongInput      db "Sorry, you entered invalid input.", 0dh, 0ah, 0

; array for printing bit labels on top row
positionArray		DWORD OFFSET splitLine, OFFSET positionString, OFFSET splitLine, OFFSET sevenString, OFFSET splitLine, OFFSET sixString, OFFSET splitLine, OFFSET fiveString, OFFSET splitLine, OFFSET fourString, OFFSET splitLine, OFFSET threeString, OFFSET splitLine, OFFSET twoString, OFFSET splitLine, OFFSET oneString, OFFSET splitLine, OFFSET zeroString, OFFSET splitLine

; colors 
lightcyan		= 00001011b
green	     = 00000010b
lightred   	= 00001100b
magenta		= 00001101b
white		= 00001111b
arrayColors BYTE lightcyan, lightcyan, magenta, magenta, green, green, lightred, lightred, white, white

; counters for individual bits
zeroCounter   BYTE 0
oneCounter    BYTE 0
twoCounter    BYTE 0
threeCounter  BYTE 0
fourCounter   BYTE 0
fiveCounter   BYTE 0
sixCounter    BYTE 0
sevenCounter  BYTE 0

.code
main PROC
     
     ; clear screen fast
     call reScr

     ; draw table
     call drawTable

     ; print directions
     call directions

     ; get input & update table
     call getInput
        
     INVOKE ExitProcess, 0

main ENDP

; main functions
reScr PROC

     push edx 

     mov dh, 0 
	mov dl, 0
	call GotoXY ;faster clear screen by resetting cursor

     pop edx
     ret

reScr ENDP
directions PROC

     push edx

     call crlf
     mov edx, OFFSET directionString
     call WriteString
     mov edx, OFFSET press0
     call WriteString
     mov edx, OFFSET press1
     call WriteString
     mov edx, OFFSET press2
     call WriteString
     mov edx, OFFSET press3
     call WriteString
     mov edx, OFFSET press4
     call WriteString
     mov edx, OFFSET press5
     call WriteString
     mov edx, OFFSET press6
     call WriteString
     mov edx, OFFSET press7
     call WriteString

     pop edx
     ret

directions ENDP 
getInput PROC
     
     call ReadChar ; read as chars to avoid echo

     cmp al, '0' ; delegates inc to appropriate bit based on input
     jz incZero
     cmp al, '1'
     jz incOne
     cmp al, '2'
     jz incTwo
     cmp al, '3'
     jz incThree
     cmp al, '4'
     jz incFour
     cmp al, '5'
     jz incFive
     cmp al, '6'
     jz incSix
     cmp al, '7'
     jz incSeven
     
     jmp invalid ; user validation

     invalid: 
          mov edx, OFFSET wrongInput
          call WriteString
          call getInput
     
getInput ENDP
drawTable PROC

	call drawTop 
	call bytePosition
	call drawMiddle
     call byteCode
     call drawBottom

     ret

drawTable ENDP

; functions for handling bit counters
; called by getInput 
; inc or reset based on color index
; dec cx main prevents memory limits when calling to main
incZero PROC 

      inc zeroCounter
      cmp zeroCounter, 10
      jz reset0
      dec cx
      call main

     reset0:
      mov zeroCounter, 0
      dec cx
      call main

incZero ENDP
incOne PROC
     
      inc oneCounter
      cmp oneCounter, 10
      jz reset1
      dec cx
      call main

     reset1:
      mov oneCounter, 0
      dec cx
      call main

incOne ENDP
incTwo PROC

      inc twoCounter
      cmp twoCounter, 10
      jz reset2
      dec cx
      call main

     reset2:
      mov twoCounter, 0
      dec cx
      call main

incTwo ENDP
incThree PROC

      inc threeCounter
      cmp threeCounter, 10
      jz reset3
      dec cx
      call main

     reset3:
      mov threeCounter, 0
      dec cx
      call main

incThree ENDP
incFour PROC

      inc fourCounter
      cmp fourCounter, 10
      jz reset4
      dec cx
      call main

     reset4:
      mov fourCounter, 0
      dec cx
      call main

incFour ENDP
incFive PROC

      inc fiveCounter
      cmp fiveCounter, 10
      jz reset5
      dec cx
      call main

     reset5:
      mov fiveCounter, 0
      dec cx
      call main

incFive ENDP
incSix PROC

      inc sixCounter
      cmp sixCounter, 10
      jz reset6
      dec cx
      call main

     reset6:
      mov sixCounter, 0
      dec cx
      call main

incSix ENDP
incSeven PROC

      inc sevenCounter
      cmp sevenCounter, 10
      jz reset7
      dec cx
      call main

     reset7:
      mov sevenCounter, 0
      dec cx
      call main

incSeven ENDP

; helper functions for formatting
printSplitLine PROC
; prints vertical formatting lines 

   push edx

   mov edx, offset splitLine
   call WriteString

   pop edx

   ret

printSplitLine ENDP                    
printSplitDashRow PROC
; prints row of horizontal lines 

     push ecx
     push edx

     mov cx,5   
     do5:   
             mov edx, OFFSET splitDash
             call WriteString   
             dec cx
             jnz do5

     pop ecx 
     pop edx
     ret

printSplitDashRow ENDP
printTopT PROC
; prints vertical lines to divide top row

     push edx

     mov edx, OFFSET topT
     call WriteString

     pop edx

     ret

printTopT ENDP
printmidT PROC
; prints cross-shaped lines to format middle row
     push edx

     mov edx, OFFSET midT
     call WriteString

     pop edx

     ret

printmidT ENDP
printBottomT PROC
; prints vertical lines to format bottom row

     push edx

     mov edx, OFFSET bottomT
     call WriteString

     pop edx

     ret

printBottomT ENDP

; functions for formatting
drawTop PROC
; prints top row lines

     push ecx 
     push edx

	call printTopT

     mov cx, 14   
     topLabel:   
             mov edx, OFFSET splitDash
             call WriteString          
             dec cx
             jnz topLabel

	call printTopT

     call printSplitDashRow

	call printTopT

	call printSplitDashRow

	call printTopT

     call printSplitDashRow

	call printTopT

     call printSplitDashRow

	call printTopT

     call printSplitDashRow

	call printTopT

     call printSplitDashRow

	call printTopT

     call printSplitDashRow

	call printTopT

     call printSplitDashRow

	call printTopT

     call crlf

     pop ecx 
     pop edx

	ret	

drawTop ENDP
drawMiddle PROC
; prints middle row lines
	
     push ecx 
     push edx 

	call printmidT

	     mov cx, 14   
     midLabel:   
             mov edx, OFFSET splitDash
             call WriteString         
             dec cx
             jnz midLabel

	call printmidT

     call printSplitDashRow

	call printmidT

     call printSplitDashRow

	call printmidT

     call printSplitDashRow

	call printmidT

     call printSplitDashRow

	call printmidT

     call printSplitDashRow

	call printmidT

     call printSplitDashRow

	call printmidT

     call printSplitDashRow

	call printmidT

     call printSplitDashRow

	call printmidT

     call crlf 

     pop ecx
     pop edx 

    ret

drawMiddle ENDP
drawBottom PROC 
; prints bottom row lines

     push ecx 
     push edx

	call printBottomT
 
     mov cx, 14   
     bottomLabel:   
             mov edx, OFFSET splitDash
             call WriteString    
             dec cx
             jnz bottomLabel

     call printBottomT

     call printSplitDashRow

	call printBottomT

     call printSplitDashRow

	call printBottomT

     call printSplitDashRow

	call printBottomT

     call printSplitDashRow

	call printBottomT

     call printSplitDashRow

	call printBottomT

	call printSplitDashRow

	call printBottomT

     call printSplitDashRow

	call printBottomT
	
     call printSplitDashRow

	call printBottomT

     call crlf

     pop ecx 
     pop edx

	ret	

drawBottom ENDP

; functions for printing bit labels 
; and values into table
bytePosition PROC
; prints bit labels on top row 
; via indexing through positionArray

     push ecx 
     push edx 

	mov ecx, 0                   
     lea edx, [positionArray + ecx * 4]     
     mov edx, [edx]                      
     call WriteString

	mov ecx, 1                   
     lea edx, [positionArray + ecx * 4]      
     mov edx, [edx]                      
     call WriteString

	mov ecx, 2                   
     lea edx, [positionArray + ecx * 4]      
     mov edx, [edx]                      
     call WriteString

	mov ecx, 3                   
     lea edx, [positionArray + ecx * 4]   
     mov edx, [edx]                      
     call WriteString

	mov ecx, 4                   
     lea edx, [positionArray + ecx * 4]  
     mov edx, [edx]                      
     call WriteString

	mov ecx, 5                   
     lea edx, [positionArray + ecx * 4]       
     mov edx, [edx]                      
     call WriteString

	mov ecx, 6                   
     lea edx, [positionArray + ecx * 4]    
     mov edx, [edx]                      
     call WriteString

	mov ecx, 7                   
     lea edx, [positionArray + ecx * 4]     
     mov edx, [edx]                      
     call WriteString

     mov ecx, 8                   
     lea edx, [positionArray + ecx * 4]       
     mov edx, [edx]                      
     call WriteString

     mov ecx, 9                   
     lea edx, [positionArray + ecx * 4]      
     mov edx, [edx]                      
     call WriteString

     mov ecx, 10                  
     lea edx, [positionArray + ecx * 4]     
     mov edx, [edx]                      
     call WriteString

     mov ecx, 11                   
     lea edx, [positionArray + ecx * 4]    
     mov edx, [edx]                      
     call WriteString

     mov ecx, 12                   
     lea edx, [positionArray + ecx * 4]      
     mov edx, [edx]                      
     call WriteString

     mov ecx, 13                   
     lea edx, [positionArray + ecx * 4]  
     mov edx, [edx]                      
     call WriteString

     mov ecx, 14                   
     lea edx, [positionArray + ecx * 4]    
     mov edx, [edx]                      
     call WriteString

     mov ecx, 15                   
     lea edx, [positionArray + ecx * 4]       
     mov edx, [edx]                      
     call WriteString

     mov ecx, 16                   
     lea edx, [positionArray + ecx * 4]      
     mov edx, [edx]                      
     call WriteString

     mov ecx, 17                   
     lea edx, [positionArray + ecx * 4]    
     mov edx, [edx]                      
     call WriteString

     mov ecx, 18                  
     lea edx, [positionArray + ecx * 4]     
     mov edx, [edx]                      
     call WriteString


	call Crlf
	    
     pop ecx 
     pop edx 

	ret

bytePosition ENDP
byteCode PROC
; prints bits on bottom row

     push edx

	call printSplitLine

     mov edx, OFFSET codeString 
     call WriteString

	call printSplitLine
     call sevenBit
     call printSplitLine
	call sixBit
	call printSplitLine
	call fifthBit 
     call printSplitLine
     call fourthBit
     call printSplitLine
     call thirdBit
     call printSplitLine
     call secondBit 
     call printSplitLine
     call firstBit
     call printSplitLine    
     call zeroBit
     call printSplitLine
     
     call crlf 

     pop edx 

     ret

byteCode ENDP

; functions for altering specific bits
; changes 0<->1 & color
; more comments found under zeroBit
zeroBit PROC
     
     push eax 
     push esi
     push ebx
     push edx

     mov eax, 0
     movzx esi, zeroCounter ;applies color based on count
	mov al, arrayColors[ESI]
	call SetTextColor

     mov bx,2  
     movzx ax, zeroCounter
     mov dx, 0
     div bx
     cmp dx,0 ;determines if even or odd
     JE even0 ;if even, print 0
     JNE odd0 ;if odd, print 1

     even0:
	     mov edx, OFFSET bitString
	     call WriteString
          mov al, white ;return to default color
	     call SetTextColor
          pop eax 
          pop esi
          pop ebx
          pop edx

          ret

     odd0: 
          mov edx, offset bitOneString
          call writeString
          mov al, white
	     call SetTextColor
          pop eax 
          pop esi
          pop ebx
          pop edx

          ret

zeroBit ENDP
firstBit PROC
 
     push eax 
     push esi
     push ebx
     push edx

     mov eax, 0
     movzx esi, oneCounter 
	mov al, arrayColors[ESI]
	call SetTextColor

     mov bx,2  
     movzx ax, oneCounter
     mov dx, 0
     div bx
     cmp dx, 0
     JE even1
     JNE odd1

     even1:
	     mov edx, OFFSET bitString
	     call WriteString
          mov al, white 
	     call SetTextColor
          pop eax 
          pop esi
          pop ebx
          pop edx

          ret

     odd1: 
          mov edx, offset bitOneString
          call writeString
          mov al, white
	     call SetTextColor
          pop eax 
          pop esi
          pop ebx
          pop edx

          ret

firstBit ENDP
secondBit PROC

     push eax 
     push esi
     push ebx
     push edx

     mov eax, 0
     movzx esi, twoCounter 
	mov al, arrayColors[ESI]
	call SetTextColor

     mov bx,2  
     movzx ax, twoCounter
     mov dx, 0
     div bx
     cmp dx, 0
     JE even2
     JNE odd2

     even2:
	     mov edx, OFFSET bitString
	     call WriteString
          mov al, white 
	     call SetTextColor
          pop eax 
          pop esi
          pop ebx
          pop edx

          ret

     odd2: 
          mov edx, offset bitOneString
          call writeString
          mov al, white
	     call SetTextColor
          pop eax 
          pop esi
          pop ebx
          pop edx

          ret

secondBit ENDP
thirdBit PROC

     push eax 
     push esi
     push ebx
     push edx

     mov eax, 0
     movzx esi, threeCounter 
	mov al, arrayColors[ESI]
	call SetTextColor

     mov bx,2  
     movzx ax, threeCounter
     mov dx, 0
     div bx
     cmp dx, 0
     JE even3
     JNE odd3

     even3:
	     mov edx, OFFSET bitString
	     call WriteString
          mov al, white 
	     call SetTextColor
          pop eax 
          pop esi
          pop ebx
          pop edx

          ret

     odd3: 
          mov edx, offset bitOneString
          call writeString
          mov al, white
	     call SetTextColor
          pop eax 
          pop esi
          pop ebx
          pop edx

          ret

thirdBit ENDP
fourthBit PROC

     push eax 
     push esi
     push ebx
     push edx

     mov eax, 0
     movzx esi, fourCounter 
	mov al, arrayColors[ESI]
	call SetTextColor

     mov bx,2  
     movzx ax, fourCounter
     mov dx, 0
     div bx
     cmp dx, 0
     JE even4
     JNE odd4

     even4:
	     mov edx, OFFSET bitString
	     call WriteString
          mov al, white 
	     call SetTextColor
          pop eax 
          pop esi
          pop ebx
          pop edx

          ret

     odd4: 
          mov edx, offset bitOneString
          call writeString
          mov al, white
	     call SetTextColor
          pop eax 
          pop esi
          pop ebx
          pop edx

          ret

fourthBit ENDP
fifthBit PROC

     push eax 
     push edx
     push esi

     mov eax, 0
     movzx esi, fiveCounter
	mov al, arrayColors[ESI]
	call SetTextColor
	mov edx, OFFSET bitString
	call WriteString

     mov al, white
	call SetTextColor

     pop eax 
     pop ecx 
     pop esi

     ret

fifthBit ENDP
sixBit PROC

     push eax 
     push edx
     push esi

     mov eax, 0
     movzx esi, sixCounter
	mov al, arrayColors[ESI]
	call SetTextColor
	mov edx, OFFSET bitString
	call WriteString

     mov al, white
	call SetTextColor

     pop eax 
     pop ecx 
     pop esi

     ret

sixBit ENDP
sevenBit PROC

     push eax 
     push edx
     push esi

     mov eax, 0
     movzx esi, sevenCounter
	mov al, arrayColors[ESI]
	call SetTextColor
	mov edx, OFFSET bitString
	call WriteString

     mov al, white
	call SetTextColor

     pop eax 
     pop ecx 
     pop esi

     ret

sevenBit ENDP


END main								