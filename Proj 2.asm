IDEAL
MODEL small
STACK 100h

BMP_WIDTH = 320
BMP_HEIGHT = 200
FILE_NAME_IN  equ 'start.bmp'
FILE_NAME_IN2 equ 'GAMEOVER.bmp'
FILE_NAME_IN3  equ 'guide.bmp'
FILE_NAME_IN4 equ 'lvl1.bmp'
FILE_NAME_IN5  equ 'lvl2.bmp'
FILE_NAME_IN6 equ 'lvl3.bmp'
FILE_NAME_IN7 equ 'lvl4.bmp'
FILE_NAME_IN8 equ 'lvl5.bmp'
FILE_NAME_IN9 equ 'lvl6.bmp'
FILE_NAME_IN10 equ 'lvl7.bmp'
FILE_NAME_IN11 equ 'WIN.bmp'



DATASEG
; --------------------------
	RndCurrentPos dw start
	x dw 160d
	y dw 160d
	kind dw 0; 0=default, 1=del, 2=falling, 3=plat || 2&3 do not regard dudi only platforms
	round dw 0
	dir db ?;0=up,1=right,2=down, 3=left
	cont dw 0; 0=same Stage 1=next Stage 2=End Game
	xPlat1 dw 150d;for random plats
	xPlat2 dw 195d
	xPlat3 dw 125
	xPlat4 dw 165
	xPlat5 dw 210
	xPlat6 dw 135
	xPlat7 dw 190
	xPlat8 dw 170
	matrix dw ?
	dudi 	db  5,5,5,5,5,5,5,5,5,5,5
			db  5,5,5,5,5,5,5,5,5,5,5
			db  5,5,5,5,5,5,5,5,5,5,5
			db  5,5,5,5,5,5,5,5,5,5,5
			db  5,5,15,15,5,5,5,15,15,5,5
			db  5,5,15,15,5,5,5,15,15,5,5
			db  5,5,5,5,5,5,5,5,5,5,5
			db  5,5,5,5,5,5,5,5,5,5,5
			db  5,5,5,5,5,5,5,5,5,5,5
			db  5,5,5,5,5,5,5,5,5,5,5
			db  0,5,5,0,0,0,0,0,5,5,0
			db  0,5,5,0,0,0,0,0,5,5,0
			db  0,5,5,0,0,0,0,0,5,5,0
	
	delBelowDudi db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				 db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				 db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				 db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	
	save    db 11*13 dup(0)
	
	
	platform	db 30*4 dup(9)
					
	fallinplat  db  6,6,6,6,6,6,6,6,6,6,6,6,6,6,0,0,0,6,6,6,6,6,6,6,6,6,6,6,6,6
				db  6,6,6,6,6,6,6,6,6,6,6,6,6,0,0,0,6,6,6,6,6,6,6,6,6,6,6,6,6,6
				db  6,6,6,6,6,6,6,6,6,6,6,6,0,0,0,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
				db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	
	spike	    db  0,4,0,0,0,4,0,0,0,4,0,0,0,4,0,0,0,4,0,0,0,4,0,0,0,4,0,0,0,4
				db  4,4,4,0,4,4,4,0,4,4,4,0,4,4,4,0,4,4,4,0,4,4,4,0,4,4,4,0,4,4
				db  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
				db  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	
	delPlatform db 30*4 dup(0)

	heart 	db 0,8,8,8,0,0,0,8,8,8,0,0
			db 8,8,8,8,8,0,8,8,8,8,8,8
			db 8,8,8,8,8,8,8,8,8,8,8,8
			db 8,8,8,8,8,8,8,8,8,8,8,8
			db 8,8,8,8,8,8,8,8,8,8,8,8
			db 0,8,8,8,8,8,8,8,8,8,8,0
			db 0,0,8,8,8,8,8,8,8,8,0,0
			db 0,0,0,8,8,8,8,8,8,0,0,0
			db 0,0,0,0,0,8,8,0,0,0,0,0

	OneBmpLine 	db BMP_WIDTH dup (0)  ; One Color line read buffer

 ScrLine 	db BMP_WIDTH dup (0)  ; One Color line read buffer

	;BMP File data
	FileName1 	db FILE_NAME_IN ,0
	FileName2 	db FILE_NAME_IN2 ,0
	FileName3 	db FILE_NAME_IN3 ,0
	FileName4 	db FILE_NAME_IN4 ,0
	FileName5 	db FILE_NAME_IN5 ,0
	FileName6 	db FILE_NAME_IN6 ,0
	FileName7 	db FILE_NAME_IN7 ,0
	FileName8 	db FILE_NAME_IN8 ,0
	FileName9 	db FILE_NAME_IN9 ,0
	FileName10  db FILE_NAME_IN10 ,0
	FileName11  db FILE_NAME_IN11 ,0
	FileHandle	dw ?
	Header 	    db 54 dup(0)
	Palette 	db 400h dup (0)
	
	SmallPicName db 'o.bmp',0
	
	
	BmpFileErrorMsg    	db 'Error At Opening Bmp File ',FILE_NAME_IN, 0dh, 0ah,'$'
	ErrorFile           db 0
			  
	BmpLeft dw ?
	BmpTop dw ?
	BmpColSize dw ?
	BmpRowSize dw ?
;---------------------------

CODESEG
start:
	mov ax, @data
	mov ds, ax
; --------------------------
	call SetGraphic
	call startGame
nextRound:
	call newStage
	
	call waitForInput
	MainStart:
		call jump
		cmp [cont],1	
		je bye
		cmp [cont],2
		je nextRound
		;cmp [y],10d
		;je nextRound
		jmp MainStart
			
		bye:
		
		call openEndFile
	
; --------------------------

exit:
	mov ax, 4c00h
	int 21h

;------------------------------------------------
;------------------------------------------------
;-- End of Main Program ... Start of Procedures 
;------------------------------------------------

;------------------------------------------------
;-- Main Loop Procedures: -----------------------
; startGame ,EndGame
;jump, startJump, endJump, waitForInput, newStage
;------------------------------------------------
;------------------------------------------------

;================================================
; Description -  starts game by calling start&guide BMP's
; INPUT:  none
; OUTPUT: prints start BMP=>waits for enter press=>prints guide BMP
; Register Usage:  cx,dx,bx,ax,di,si
;================================================
proc startGame
	call openStartFile
	call toCont
	call openGuideFile
	ret 
endp startGame


proc EndGame
	cmp [round],8
		jne @@lost
	call openLevelFile
		jmp @@end
		@@lost:
		call openEndFile
		@@end:
	ret 
endp EndGame


proc jump	
	call startJump
	call endJump
	ret
endp jump

proc startJump
	push cx
	mov cx,40
		@@start:
			cmp cx,0
			jne @@startJump
			jmp @@end
			@@startJump:
				call checkWin
				cmp [cont],2
				je @@end
				call checkSituation
				cmp [cont],1
				je @@end
				mov [dir],0
				call movDudi
				dec cx
				call delay2
				call waitForInput
				jmp @@start
	@@end:
	
	pop cx
	ret
endp startJump

proc endJump
	push ax
@@start:
	call waitForInput
	call delay2
	mov [dir],2
	call movDudi
	call checkForRNDSTGChange
	call checkSituation
	cmp [cont],1
	je @@end
	cmp al,7
	jb @@start
@@end:
	pop ax
	ret
endp endJump

proc waitForInput	
	push ax
	mov ah,1h
	int 16h
	jz @@end
		
	mov ah,0
	int 16h
	cmp ah,4Dh
	je rightArrow
	cmp ah,4Bh
	je leftArrow
	cmp ah,39h
	je space
	
	rightArrow:
		mov [dir],1
		call movDudi
		jmp @@end
	leftArrow:
		mov [dir],3
		call movDudi
		jmp @@end
	space:
		mov cx,30
		superJump:
		mov [dir],0
		call movDudi
		loop superJump
		
	@@end:
	pop ax
	ret
endp waitForInput		

proc toCont
	push ax

@@start:
	mov ah,1h
	int 16h
	jz @@start
	
	cmp ah,1ch
	jne @@start
	
	pop ax
	ret 
endp toCont

proc newStage
	mov [cont],0
	inc [round]
	call openLevelFile
	call delScrn

	mov [x],160d
	mov [y],160d
	call saveBgDudi
	mov [kind],0
	call drawDudi
	call redrawPlat
	push 158
	push 3
	call drawHeart
	ret
endp newStage


;------------------------------------------------
;-- Check  Procedures: --------------------------
;checkWin, checkSituation, checkForPlats, checkForRNDSTGChange
;------------------------------------------------
;------------------------------------------------

proc checkWin	
	push ax	
	add [x],5
	push [x]
	push [y] 
	call PixelColor
	cmp al,8
	jne @@end
mov [cont],2
@@end:
	sub [x],5
	pop ax

	ret
endp checkWin

proc checkForRNDSTGChange
	cmp [round],5
	jb @@end
	mov bh,0
	mov bl,99
	xor ah,ah
	call RandomByCs
	mov bl,50
	div bl
	cmp ah,0
	jne @@end
	;call delay1
	cmp [round],5
	je @@stg5
	cmp [round],6
	je @@stg6
	jmp @@stg7
@@stg5:
	call stage5
	jmp @@end
@@stg6:
	call stage6
	jmp @@end
@@stg7:
	call stage7
	@@end:
		ret
endp checkForRNDSTGChange

	
proc checkSituation	
	call checkForPlats
	cmp al,4
	je @@isLose
	
	cmp al,6
	je @@isFallingPlat
	
	cmp [y],186
	jg @@isLose
	
	
	jmp @@end
	
@@isFallingPlat:
	add [y],13
	sub [x],30
	push [x]    
	push [y]
	call delBelow
	sub [y],13
	add [x],30
	jmp @@end

	
@@isLose:
	mov [cont],1
@@end:
	ret
endp checkSituation

proc checkForPlats
	add [y],15d
	push [x]
	push [y]
	call PixelColor
	cmp al,7
	jae @@end
	add [x],12
	push [x]
	push [y]
	call PixelColor
	sub [x],12	
	@@end:
	sub [y],15
	ret
endp checkForPlats


;------------------------------------------------
;---All draw/del/save/move Procedures: --------------- 
;------------------------------------------------
;------------------------------------------------

; Description  : Print a Matrix from memory into Screen.
; Input        : 1. DX = Line Length, CX = Amount of Lines, Variable matrix = Offset of the matrix you want to print, DI = Location to Print on screen(0 - 64,000)
; Output:        On screen
proc putMatrixInScreen
	push es
	push ax
	push si
	
	mov ax, 0A000h
	mov es, ax
	cld ; for movsb direction si --> di
	
	
	mov si,[matrix]
	
@@NextRow:	
	push cx
	mov cx, dx
	rep movsb ; Copy whole line to the screen, si and di advances in movsb
	sub di,dx ; returns back to the begining of the line 
	add di, 320 ; go down one line by adding 320
	
	
	pop cx
	loop @@NextRow
	
		
	pop si
	pop ax
	pop es
    ret
endp putMatrixInScreen

; Description  : Print a Matrix from Screen into memory.
; Input        : 1. DX = Line Length, CX = Amount of Lines, Variable matrix = Offset of the matrix you want to print, DI = Location to Print on screen(0 - 64,000)
; Output:        On screen
proc putMatrixInData
	push es
	push ax
	push si
	mov ax, 0A000h
	mov es, ax
	cld
	push dx
	mov ax,cx
	mul dx
	mov bp,ax
pop dx
	mov si,[matrix]
@@NextRow:	
	push cx
	mov cx, dx
@@copy: ; Copy line to the data
	mov al, [es:di]
	mov [ds:si], al
	inc si
	inc di
	loop @@copy
	sub di,dx
	add di, 320

	pop cx

	loop @@NextRow

@@endProc:		

	pop si
	pop ax
	pop es
    ret
endp putMatrixInData

proc delBelow
	push bp
	mov bp, sp
	push cx
	push dx
	push bx
	push ax
	push di
	
		mov cx,4
		mov dx,60d
		
		push dx

		mov ax, [bp+4]
		mov bx, 320
		mul bx
		mov di, ax
		add di, [bp+6]
		add di, 320
		
		pop dx
		
		mov bx, offset delBelowDudi
		mov [matrix], bx
		
		call putMatrixInScreen

	pop di
	pop ax
	pop bx
	pop dx
	pop cx
	pop bp
	ret 4
endp delBelow



proc redrawPlat
	cmp [round],1
	je dostg1
	cmp [round],2
	je dostg2
	cmp [round],3
	je dostg3
	cmp [round],4
	je dostg4
	cmp [round],5
	je dostg5
	cmp [round],6
	je dostg6
	cmp [round],7
	je dostg7
	;call deletesALLplats
	jmp @@end
	dostg1:
		call stage1
		jmp @@end
	dostg2:
		call stage2
		jmp @@end
	dostg3:
		call stage3
		jmp @@end
	dostg4:
		call stage4	
		jmp @@end
	dostg5:
		call stage5
		jmp @@end
	dostg6:
		call stage6	
		jmp @@end
	dostg7:
		call stage7
			
	@@end:
endp redrawPlat


;================================================
; Description -  moves dear dudi according to the dir
; INPUT:  dir 
; OUTPUT: redraw as "move"
; Register Usage:  cx,dx,bx,ax,di,si
;================================================
proc movDudi
	push cx
	push dx
	push bx
	push ax
	push di
	
	
		mov [kind],1
		call drawDudi
		
	cmp [dir],0
	je up
	cmp [dir],1
	je right
	cmp [dir],2
	je down
	cmp [dir],3
	je left
	up:
		dec [y]
		jmp @@reDraw
	right:
		inc [x]
		jmp @@reDraw
	left:
		dec [x]
		jmp @@reDraw	
	down:
		inc [y]
		jmp @@reDraw
	
	@@reDraw:
		call saveBgDudi
		mov [kind],0
		call drawDudi
	
	pop di
	pop ax
	pop bx
	pop dx
	pop cx
    ret
endp movDudi

;===========================
;description - saves background of dudi
;input - none
;output - none 
;variables - x,y
;===========================
proc saveBgDudi
	push cx
	push dx
	push bx
	push ax 
	push di
	
		mov cx,13
		mov dx,11
		
		push dx

		mov ax, [y]
		mov bx, 320
		mul bx
		mov di, ax
		add di, [x]
		add di, 320
		
		pop dx
		
		mov bx, offset save
		mov [matrix], bx
		call putMatrixInData

	pop di
	pop ax
	pop bx
	pop dx
	pop cx
	ret
endp saveBgDudi
;===========================
;description - draws dudi
;input - none
;output - screen 
;variables - x,y
;===========================
proc drawDudi
	push cx
	push dx
	push bx
	push ax
	push di
		
		mov cx,13
		mov dx,11
		
		push dx

		mov ax, [y]
		mov bx, 320
		mul bx
		mov di, ax
		add di, [x]
		add di, 320
		
		pop dx
		
		cmp [kind],0
		je @@reDraw
		jne @@delete
		@@reDraw:
			mov bx, offset dudi
			mov [matrix], bx
			jmp @@cont
		@@delete:
			mov bx, offset save
			mov [matrix], bx
			
		@@cont:
		call putMatrixInScreen

	pop di
	pop ax
	pop bx
	pop dx
	pop cx
	ret
endp drawDudi
;===========================
;description - draws the Heart
;input - x&y
;output - screen 
;===========================
proc drawHeart
	push bp
	mov bp, sp
	push cx
	push dx
	push bx
	push ax
	push di
	
		mov cx,9
		mov dx,12d
		
		push dx

		mov ax, [bp+4]
		mov bx, 320
		mul bx
		mov di, ax
		add di, [bp+6]
		add di, 320
		
		pop dx

		mov bx, offset heart
		mov [matrix], bx

		call putMatrixInScreen

	pop di
	pop ax
	pop bx
	pop dx
	pop cx
	pop bp
	ret 4
endp drawHeart



;===========================
;description - draws platforms
;input - push x,y 
;output - screen 
;===========================
proc drawPlat
	push bp
	mov bp, sp
	push cx
	push dx
	push bx
	push ax
	push di
	
		mov cx,4
		mov dx,30d
		
		push dx

		mov ax, [bp+4]
		mov bx, 320
		mul bx
		mov di, ax
		add di, [bp+6]
		add di, 320
		
		pop dx
		
		cmp [kind],0
		je @@reDraw
		cmp [kind],1
		je @@delete
		cmp [kind],2
		je @@fall
		cmp [kind],3
		je @@spike
		cmp [kind],4
		je @@random
		
		@@reDraw:
			mov bx, offset platform
			mov [matrix], bx
			jmp @@cont
		@@delete:
			mov bx, offset delPlatform
			mov [matrix], bx
			jmp @@cont
		@@fall: 
			mov bx, offset fallinplat
			mov [matrix], bx
			jmp @@cont
		@@spike: 
			mov bx, offset spike
			mov [matrix], bx
			jmp @@cont
		@@random: 
			

		@@cont:
		call putMatrixInScreen
	
	pop di
	pop ax
	pop bx
	pop dx
	pop cx
	pop bp
	ret 4
endp drawPlat


;------------------------------------------------
;---All BMP Procedures: -------------------------
;checkWin, checkSituation, checkForPlats, 
;------------------------------------------------
;------------------------------------------------

;================================================
; Description -  prints game opening
; INPUT:  none
; OUTPUT: print start screen
; Register Usage:  dx
;================================================
proc openStartFile
	push dx
	mov dx, offset FileName1
	mov [BmpLeft],0
	mov [BmpTop],0
	mov [BmpColSize], BMP_WIDTH
	mov [BmpRowSize] ,BMP_HEIGHT
	
	mov dx, offset FileName1
	call OpenShowBmp
	cmp [ErrorFile],1
		jne @@cont 
		jmp @@exitError
	@@cont:
		jmp @@end
		
	@@exitError:
		mov ax,2
		int 10h
		
		mov dx, offset BmpFileErrorMsg
		mov ah,9
		int 21h
		
	@@end:
		call delay1
		pop dx
	ret
endp openStartFile


;================================================
; Description -  prints game guide
; INPUT:  none
; OUTPUT: prints to screen
; Register Usage:  dx
;================================================
proc openGuideFile
	push dx
	mov dx, offset FileName3
	mov [BmpLeft],0
	mov [BmpTop],0
	mov [BmpColSize], BMP_WIDTH
	mov [BmpRowSize] ,BMP_HEIGHT
	
	mov dx, offset FileName3
	call OpenShowBmp
	cmp [ErrorFile],1
		jne @@cont 
		jmp @@exitError
	@@cont:
		jmp @@end
		
	@@exitError:
		mov ax,2
		int 10h
		
		mov dx, offset BmpFileErrorMsg
		mov ah,9
		int 21h
		
	@@end:
		call delay1
		pop dx
	ret
endp openGuideFile
;================================================
; Description -  prints game ending
; INPUT:  none
; OUTPUT: print to screen
; Register Usage:  dx
;================================================
proc openEndFile
	push dx
	mov dx, offset FileName2
	mov [BmpLeft],0
	mov [BmpTop],0
	mov [BmpColSize], BMP_WIDTH
	mov [BmpRowSize] ,BMP_HEIGHT
	
	mov dx, offset FileName2
	call OpenShowBmp
	cmp [ErrorFile],1
		jne @@cont
		jmp @@exitError
	@@cont:
		jmp @@end
		
	@@exitError:
		mov ax,2
		int 10h
		
		mov dx, offset BmpFileErrorMsg
		mov ah,9
		int 21h
	@@end:
	call delay1
	pop dx
	ret
endp openEndFile


proc openLevelFile
	push dx
@@start:
	cmp [round],1
	je @@stg1
	cmp [round],2
	je @@stg2
	cmp [round],3
	je @@stg3
	cmp [round],4
	je @@stg4
	cmp [round],5
	je @@stg5
	cmp [round],6
	je @@stg6
	cmp [round],7
	je @@stg7
	cmp [round],8
	je @@stg8
	@@stg1:
		mov dx, offset FileName4
		jmp @@cont1
	@@stg2:
		mov dx, offset FileName5
		jmp @@cont1
	@@stg3:
		mov dx, offset FileName6
		jmp @@cont1
	@@stg4:
		mov dx, offset FileName7
		jmp @@cont1
	@@stg5:
		mov dx, offset FileName8
		jmp @@cont1
	@@stg6:
		mov dx, offset FileName9
	@@stg7:
		mov dx, offset FileName10
	@@stg8:
		mov dx, offset FileName11

	@@cont1:
	mov [BmpLeft],0
	mov [BmpTop],0
	mov [BmpColSize], BMP_WIDTH
	mov [BmpRowSize] ,BMP_HEIGHT
	
	;mov dx, offset FileName3
	call OpenShowBmp
	cmp [ErrorFile],1
		jne @@cont2
		jmp @@exitError
	@@cont2:
		jmp @@end
		
	@@exitError:
		mov ax,2
		int 10h
		
		mov dx, offset BmpFileErrorMsg
		mov ah,9
		int 21h
		
	@@end:
		call delay1
		pop dx
	ret
endp openLevelFile

;------------------------------------------------
;---All present stage Procedures: --------------- 
;------------------------------------------------
;------------------------------------------------

;================================================
; Description -  calls stage1 to screen
; INPUT:  
; OUTPUT: draws stage's 1 platforms
; Register Usage:  none
;================================================
proc stage1
	mov [kind],0
	push 150
	push 175
	call drawPlat
	push 195
	push 150
	call drawPlat
	push 125
	push 140
	call drawPlat
	push 165
	push 115
	call drawPlat
	push 210
	push 90
	call drawPlat
	push 160
	push 65
	call drawPlat
	push 190
	push 50
	call drawPlat
	push 160
	push 35
	call drawPlat
	mov [kind],0
    ret
endp stage1

;================================================
; Description -  calls stage2 to screen
; INPUT:  
; OUTPUT: draws stage's 2 platforms
; Register Usage:  none
;================================================
proc stage2
	mov [kind],0
	push 150
	push 175
	call drawPlat
	push 175
	push 145
	call drawPlat
	push 125
	push 115
	call drawPlat
	push 185
	push 90
	call drawPlat
	push 145
	push 60
	call drawPlat
	push 170
	push 40
	call drawPlat
	mov [kind],2
	push 175
	push 110
	call drawPlat
	push 125
	push 140
	call drawPlat
	push 190
	push 70
	call drawPlat
	mov [kind],0
	ret
endp stage2
;================================================
; Description -  calls stage3 to screen
; INPUT:  
; OUTPUT: draws stage's 3 platforms
; Register Usage:  none
;================================================
proc stage3
	mov [kind],0
	push 150
	push 175
	call drawPlat
	push 145
	push 105
	call drawPlat
	push 155
	push 40
	call drawPlat
	push 115
	push 140
	call drawPlat
	push 120
	push 80
	call drawPlat

	mov [kind],3
	push 175
	push 135
	call drawPlat
	push 185
	push 90
	call drawPlat
	push 155
	push 60
	call drawPlat
	mov [kind],0
	ret
endp stage3
;================================================
; Description -  calls stage4 to screen
; INPUT:  
; OUTPUT: draws stage's 4 platforms
; Register Usage:  none
;================================================
proc stage4
	mov [kind],0
	push 150
	push 175
	call drawPlat
	push 170
	push 140
	call drawPlat
	push 150
	push 105
	call drawPlat
	push 155
	push 55
	call drawPlat
	push 120
	push 55
	call drawPlat
	
	mov [kind],3
	push 185
	push 70
	call drawPlat
	push 130
	push 65
	call drawPlat
	push 120
	push 135
	call drawPlat
	
	mov [kind],0
	ret
endp stage4

;================================================
; Description -  calls stage5 to screen
; INPUT:  
; OUTPUT: draws stage's 5 platforms
; Register Usage:  none
;================================================
proc stage5
	mov [kind],1
	push [xPlat2]
	push 150
	call drawPlat
	push [xPlat3]
	push 140
	call drawPlat
	push [xPlat4]
	push 115
	call drawPlat
	push [xPlat5]
	push 90
	call drawPlat
	push [xPlat6]
	push 60
	call drawPlat
	push [xPlat7]
	push 50
	call drawPlat
	push [xPlat8]
	push 20
	call drawPlat
	
	call assignToXPlat
	
	mov [kind],0
	push [xPlat1]
	push 175
	call drawPlat
	push [xPlat2]
	push 150
	call drawPlat
	push [xPlat3]
	push 140
	call drawPlat
	push [xPlat4]
	push 115
	call drawPlat
	push [xPlat5]
	push 90
	call drawPlat
	push [xPlat6]
	push 60
	call drawPlat
	push [xPlat7]
	push 50
	call drawPlat
	push [xPlat8]
	push 20
	call drawPlat
	
	

	mov [kind],0
	ret
endp stage5

;================================================
; Description -  calls stage6 to screen
; INPUT:  
; OUTPUT: draws stage's 6 platforms
; Register Usage:  none
;================================================
proc stage6
	mov [kind],1
	push [xPlat2]
	push 150
	call drawPlat
	push [xPlat3]
	push 140
	call drawPlat
	push [xPlat4]
	push 115
	call drawPlat
	push [xPlat5]
	push 90
	call drawPlat
	push [xPlat6]
	push 60
	call drawPlat
	push [xPlat7]
	push 50
	call drawPlat
	push [xPlat8]
	push 20
	call drawPlat
	
	call assignToXPlat
	
	mov [kind],0
	push [xPlat1]
	push 175
	call drawPlat
	push [xPlat2]
	push 150
	call drawPlat
	push [xPlat3]
	push 140
	call drawPlat
	push [xPlat4]
	push 115
	call drawPlat
	push [xPlat5]
	push 90
	call drawPlat
	push [xPlat8]
	push 20
	call drawPlat
	push [xPlat6]
	push 60
	call drawPlat
	mov [kind],2
	push [xPlat7]
	push 50
	call drawPlat
	push [xPlat4]
	push 115
	call drawPlat
	

	mov [kind],0
	ret
endp stage6
;================================================
; Description -  calls stage7 to screen
; INPUT:  
; OUTPUT: draws stage's 7 platforms
; Register Usage:  none
;================================================
proc stage7
	mov [kind],1
	push [xPlat2]
	push 150
	call drawPlat
	push [xPlat3]
	push 140
	call drawPlat
	push [xPlat4]
	push 115
	call drawPlat
	push [xPlat5]
	push 90
	call drawPlat
	push [xPlat6]
	push 60
	call drawPlat
	push [xPlat7]
	push 50
	call drawPlat
	push [xPlat8]
	push 20
	call drawPlat
	
	call assignToXPlat
	
	mov [kind],0
	push [xPlat1]
	push 175
	call drawPlat
	push [xPlat2]
	push 150
	call drawPlat
	push [xPlat3]
	push 115
	call drawPlat
	push [xPlat4]
	push 115
	call drawPlat
	push [xPlat5]
	push 90
	call drawPlat
	push [xPlat8]
	push 20
	call drawPlat
	push [xPlat6]
	push 50
	call drawPlat
	mov [kind],3
	push [xPlat7]
	push 60
	call drawPlat
	push [xPlat4]
	push 140
	call drawPlat
	

	mov [kind],0
	ret
endp stage7
;------------------------------------------------
;---All Help stage Procedures: ---------------
;checkWin, checkSituation, checkForPlats, 
;------------------------------------------------
;------------------------------------------------

;===========================
;description - return pixel color
;input - push x,y 
;output - al (pixel color)
;variables - none
;===========================
proc PixelColor
	push bp
	mov bp, sp
	push cx
	push dx
	
	mov bh, 0
	mov cx, [bp + 6]
	mov dx, [bp + 4]
	mov ah, 0dh
	int 10h
	pop dx
	pop cx
	pop bp
	ret 4
endp PixelColor

;===========================
;description - changes dosbox into Graphic mode
;input - none
;output - none
;variables - none
;===========================
proc  SetGraphic
	push ax
	mov ax,13h   ; 320 X 200 
				 ;Mode 13h is an IBM VGA BIOS mode. It is the specific standard 256-color mode 
	int 10h
	pop ax
	ret
endp 	SetGraphic

;===========================
;description - changes dosbox into text mode
;input - none
;output - none
;variables - none
;===========================
proc SetText
	push ax
	mov ax, 2
	int 10h
	pop ax
	ret
endp SetText

;===========================
;description - delays, draws seconds
;input - none
;output - none
;registers - cx
;===========================
proc delay1
	push cx
	mov cx,4000
	
	@@1:
		push cx
		mov cx,4000
	@@2:
		loop @@2
		pop cx
		loop @@1
		pop cx
		
    ret
endp delay1

proc delay2
	push cx
	mov cx,300
	
	@@1:
		push cx
		mov cx,250
	@@2:
		loop @@2
		pop cx
		loop @@1
		pop cx
		
    ret
endp delay2

;in dx new color
proc putColorInScreen
	push ds
	push es
	push ax
	push si
	
	mov ax, 0A000h
	mov es, ax
	mov ds, ax
	cld ; for movsb direction ds:si --> es:di
	mov cx, 64000	; full screen
	mov si, 0 ; starts from the first pixel
	mov [si], dx ; put color in [si]
	mov di, 1 ; copies prev pixel to the next one, [0]-->[1], [1]-->[2], 
	
	rep movsb ; Copy whole line to the screen, si and di advances in movsb
	
	pop si
	pop ax
	pop es
	pop ds
    ret
endp putColorInScreen

proc delScrn
	push dx
	mov dx, 0
	call putColorInScreen
	pop dx
ret
endp delScrn


;================================================
; Description - Write on screen the value of ax (decimal)
;               the practice :  
;				Divide AX by 10 and put the Mod on stack 
;               Repeat Until AX smaller than 10 then print AX (MSB) 
;           	then pop from the stack all what we kept there. 
; INPUT: AX
; OUTPUT: Screen 
; Register Usage: AX  
;================================================
	proc ShowAxDecimal
	   push ax
       push bx
	   push cx
	   push dx
	   
	   ; check if negative
	   test ax,08000h
	   jz PositiveAx
			
	   ;  put '-' on the screen
	   push ax
	   mov dl,'-'
	   mov ah,2
	   int 21h
	   pop ax

	   neg ax ; make it positive
PositiveAx:
       mov cx,0   ; will count how many time we did push 
       mov bx,10  ; the divider
   
put_mode_to_stack:
       xor dx,dx
       div bx
       add dl,30h
	   ; dl is the current LSB digit 
	   ; we cant push only dl so we push all dx
       push dx    
       inc cx
       cmp ax,9   ; check if it is the last time to div
       jg put_mode_to_stack

	   cmp ax,0
	   jz pop_next  ; jump if ax was totally 0
       add al,30h  
	   mov dl, al    
  	   mov ah, 2h
	   int 21h        ; show first digit MSB
	       
pop_next: 
       pop ax    ; remove all rest LIFO (reverse) (MSB to LSB)
	   mov dl, al
       mov ah, 2h
	   int 21h        ; show all rest digits
       loop pop_next
		
	   mov dl, ','
       mov ah, 2h
	   int 21h
   
	   pop dx
	   pop cx
	   pop bx
	   pop ax
	   
	   ret
endp ShowAxDecimal

;==========================
;==========================
;===GIVEN BMP PROCS Area===
;==========================
;==========================
	mov ah,7
	int 21h
	
	mov ax,2
	int 10h

	
	mov ax, 4c00h
	int 21h
	
proc OpenShowBmp near
	
	call OpenBmpFile
	cmp [ErrorFile],1
	je @@ExitProc
	
	call ReadBmpHeader
	
	call ReadBmpPalette
	
	call CopyBmpPalette
	
	call  ShowBmp
	
	 
	call CloseBmpFile

@@ExitProc:
	ret
endp OpenShowBmp

 

; input dx filename to open
proc OpenBmpFile	near						 
	mov ah, 3Dh
	xor al, al
	int 21h
	jc @@ErrorAtOpen
	mov [FileHandle], ax
	jmp @@ExitProc
	
@@ErrorAtOpen:
	mov [ErrorFile],1
@@ExitProc:	
	ret
endp OpenBmpFile

	
; output file dx filename to open
proc CreateBmpFile	near						 
	 
	
CreateNewFile:
	mov ah, 3Ch 
	mov cx, 0 
	int 21h
	
	jnc Success
@@ErrorAtOpen:
	mov [ErrorFile],1
	jmp @@ExitProc
	
Success:
	mov [ErrorFile],0
	mov [FileHandle], ax
@@ExitProc:
	ret
endp CreateBmpFile





proc CloseBmpFile near
	mov ah,3Eh
	mov bx, [FileHandle]
	int 21h
	ret
endp CloseBmpFile




; Read 54 bytes the Header
proc ReadBmpHeader	near					
	push cx
	push dx
	
	mov ah,3fh
	mov bx, [FileHandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	
	pop dx
	pop cx
	ret
endp ReadBmpHeader



proc ReadBmpPalette near ; Read BMP file color palette, 256 colors * 4 bytes (400h)
						 ; 4 bytes for each color BGR + null)			
	push cx
	push dx
	
	mov ah,3fh
	mov cx,400h
	mov dx,offset Palette
	int 21h
	
	pop dx
	pop cx
	
	ret
endp ReadBmpPalette


; Will move out to screen memory the colors
; video ports are 3C8h for number of first color
; and 3C9h for all rest
proc CopyBmpPalette		near					
										
	push cx
	push dx
	
	mov si,offset Palette
	mov cx,256
	mov dx,3C8h
	mov al,0  ; black first							
	out dx,al ;3C8h
	inc dx	  ;3C9h
CopyNextColor:
	mov al,[si+2] 		; Red				
	shr al,2 			; divide by 4 Max (cos max is 63 and we have here max 255 ) (loosing color resolution).				
	out dx,al 						
	mov al,[si+1] 		; Green.				
	shr al,2            
	out dx,al 							
	mov al,[si] 		; Blue.				
	shr al,2            
	out dx,al 							
	add si,4 			; Point to next color.  (4 bytes for each color BGR + null)				
								
	loop CopyNextColor
	
	pop dx
	pop cx
	
	ret
endp CopyBmpPalette

 
proc ShowBMP 
; BMP graphics are saved upside-down.
; Read the graphic line by line (BmpRowSize lines in VGA format),
; displaying the lines from bottom to top.
	push cx
	
	mov ax, 0A000h
	mov es, ax
	
	mov cx,[BmpRowSize]
	
 
	mov ax,[BmpColSize] ; row size must dived by 4 so if it less we must calculate the extra padding bytes
	xor dx,dx
	mov si,4
	div si
	cmp dx,0
	mov bp,0
	jz @@row_ok
	mov bp,4
	sub bp,dx

@@row_ok:	
	mov dx,[BmpLeft]
	
@@NextLine:
	push cx
	push dx
	
	mov di,cx  ; Current Row at the small bmp (each time -1)
	add di,[BmpTop] ; add the Y on entire screen
	
 
	; next 5 lines  di will be  = cx*320 + dx , point to the correct screen line
	mov cx,di
	shl cx,6
	shl di,8
	add di,cx
	add di,dx
	 
	; small Read one line
	mov ah,3fh
	mov cx,[BmpColSize]  
	add cx,bp  ; extra  bytes to each row must be divided by 4
	mov dx,offset ScrLine
	int 21h
	; Copy one line into video memory
	cld ; Clear direction flag, for movsb
	mov cx,[BmpColSize]  
	mov si,offset ScrLine
	rep movsb ; Copy line to the screen
	
	pop dx
	pop cx
	 
	loop @@NextLine
	
	pop cx
	ret
endp ShowBMP 

	

; Read 54 bytes the Header
proc PutBmpHeader	near					
	mov ah,40h
	mov bx, [FileHandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	ret
endp PutBmpHeader
 



proc PutBmpPalette near ; Read BMP file color palette, 256 colors * 4 bytes (400h)
						 ; 4 bytes for each color BGR + null)			
	mov ah,40h
	mov cx,400h
	mov dx,offset Palette
	int 21h
	ret
endp PutBmpPalette


 
proc PutBmpDataIntoFile near
			
    mov dx,offset OneBmpLine  ; read 320 bytes (line) from file to buffer
	
	mov ax, 0A000h ; graphic mode address for es
	mov es, ax
	
	mov cx,BMP_HEIGHT
	
	cld 		; forward direction for movsb
@@GetNextLine:
	push cx
	dec cx
										 
	mov si,cx    ; set si at the end of the cx line (cx * 320) 
	shl cx,6	 ; multiply line number twice by 64 and by 256 and add them (=320) 
	shl si,8
	add si,cx
	
	mov cx,BMP_WIDTH    ; line size
	mov di,dx
    
	 push ds 
     push es
	 pop ds
	 pop es
	 rep movsb
	 push ds 
     push es
	 pop ds
	 pop es
 
	
	
	 mov ah,40h
	 mov cx,BMP_WIDTH
	 int 21h
	
	 pop cx ; pop for next line
	 loop @@GetNextLine
	
	
	
	 ret 
endp PutBmpDataIntoFile




;==========================
;==========================
;====GIVEN Random PROCS====
;==========================
;==========================
proc getRandomX
	xor ah,ah
	mov bl,100d
	mov bh,230d
	call RandomByCs
		xor ah,ah
	ret
endp getRandomX

proc assignToXPlat
	push bx
	push ax
	call getRandomX
	mov [xPlat2],ax
	call getRandomX
	mov [xPlat3],ax
	call getRandomX
	mov [xPlat4],ax
	call getRandomX
	mov [xPlat5],ax
	call getRandomX
	mov [xPlat6],ax
	call getRandomX
	mov [xPlat7],ax
	call getRandomX
	mov [xPlat8],ax
	pop ax
	pop bx
		call delay2

	ret
endp assignToXPlat



; Description  : get RND between any bl and bh includs (max 0 -255)
; Input        : 1. Bl = min (from 0) , BH , Max (till 255)
; 			     2. RndCurrentPos a  word variable,   help to get good rnd number
; 				 	Declre it at DATASEG :  RndCurrentPos dw ,0
;				 3. EndOfCsLbl: is label at the end of the program one line above END start		
; Output:        Al - rnd num from bl to bh  (example 50 - 150)
; More Info:
; 	Bl must be less than Bh 
; 	in order to get good random value again and agin the Code segment size should be 
; 	at least the number of times the procedure called at the same second ... 
; 	for example - if you call to this proc 50 times at the same second  - 
; 	Make sure the cs size is 50 bytes or more 
; 	(if not, make it to be more) 
proc RandomByCs
    push es
	push si
	push di
	
	mov ax, 40h
	mov	es, ax
	
	sub bh,bl  ; we will make rnd number between 0 to the delta between bl and bh
			   ; Now bh holds only the delta
	cmp bh,0
	jz @@ExitP
 
	mov di, [word RndCurrentPos]
	call MakeMask ; will put in si the right mask according the delta (bh) (example for 28 will put 31)
	
RandLoop: ;  generate random number 
	mov ax, [es:06ch] ; read timer counter
	mov ah, [byte cs:di] ; read one byte from memory (from semi random byte at cs)
	xor al, ah ; xor memory and counter
	
	; Now inc di in order to get a different number next time
	inc di
	cmp di,(EndOfCsLbl - start - 1)
	jb @@Continue
	mov di, offset start
@@Continue:
	mov [word RndCurrentPos], di
	
	and ax, si ; filter result between 0 and si (the nask)
	cmp al,bh    ;do again if  above the delta
	ja RandLoop
	
	add al,bl  ; add the lower limit to the rnd num
		 
@@ExitP:	
	pop di
	pop si
	pop es
	ret
endp RandomByCs
; make mask acording to bh size 
; output Si = mask put 1 in all bh range
; example  if bh 4 or 5 or 6 or 7 si will be 7
; 		   if Bh 64 till 127 si will be 127
Proc MakeMask    
    push bx

	mov si,1
    
@@again:
	shr bh,1
	cmp bh,0
	jz @@EndProc
	
	shl si,1 ; add 1 to si at right
	inc si
	
	jmp @@again
	
@@EndProc:
    pop bx
	ret
endp  MakeMask


EndOfCsLbl:
END start


