byte 0x03; 0
byte 0x9F; 1
byte 0x25; 2
byte 0x0D; 3
byte 0x99; 4
byte 0x49; 5
byte 0x41; 6
byte 0x1F; 7
byte 0x01; 8
byte 0x19; 9
byte 0x10; A.
byte 0x30; P.
byte 0x48; S.
byte 0xF4; R
byte 0x7C; U
byte 0x1F; leftT
byte 0x8C; rightT

mvi a,0x03 ; resetting displays
out 00001111b,a

;RAM 0 - index of entered number 
mvi a,0 ; initialize current number index in RAM
mvi b,0
str a,b ; init in ram

mvi a,2 ; init guesing in ram
mvi b,0
str a,b

mvi a,11 ; P
mmr b,a
out 11101111b,b
mvi a,10 ; A
mmr b,a
out 11011111b,b
mvi a,12 ; SS
mmr b,a
out 00111111b,b


main:
	mvi a,2
	ldr a,a
	cmi a,0
	jzr firstEnterPassword
	cmi a,1
	jzr startGuessing
jmp main

firstEnterPassword:
	mvi a,0
	ldr a,a
	cmi a,4
	jzr firstEnterPasswordEnd
	
	mvi b,0 ; reset 
	str a,b
jmp enterPassword

firstEnterPasswordEnd:
	mvi a,2
	mvi b,1
	str a,b
	
	mvi a,0
	mvi b,0
	str a,b
	

startGuessing:
	

	mvi a,0
	ldr a,a
	cmi a,4
	jzr compare
jmp enterPassword


compare:

enterPassword:

	inn a, 1110b	; first row
	ani a, 1111b
	cmi a, 0111b
	jzr buttonZero
	cmi a, 1011b
	jzr buttonOne
	cmi a, 1101b
	jzr buttonTwo
	cmi a, 1110b
	jzr buttonThree
	
	inn a, 1101b	; second row
	ani a, 1111b
	cmi a, 0111b
	jzr buttonFour
	cmi a, 1011b
	jzr buttonFive
	cmi a, 1101b
	jzr buttonSix
	cmi a, 1110b
	jzr buttonSeven
	
	inn a, 1011b	; third row
	ani a, 1111b
	cmi a, 0111b
	jzr buttonEight
	cmi a, 1011b
	jzr buttonNine
	
jmp enterPassword


buttonZero:
	mvi a,1
	mvi b,0
	str a,b
jmp displayNumber

buttonOne:
	mvi a,1
	mvi b,1
	str a,b
jmp displayNumber

buttonTwo:
	mvi a,1
	mvi b,2
	str a,b
jmp displayNumber

buttonThree:
	mvi a,1
	mvi b,3
	str a,b
jmp displayNumber

buttonFour:
	mvi a,1
	mvi b,4
	str a,b
jmp displayNumber

buttonFive:
	mvi a,1
	mvi b,5
	str a,b
jmp displayNumber

buttonSix:
	mvi a,1
	mvi b,6
	str a,b
jmp displayNumber

buttonSeven:
	mvi a,1
	mvi b,7
	str a,b
jmp displayNumber

buttonEight:
	mvi a,1
	mvi b,8
	str a,b
jmp displayNumber

buttonNine:
	mvi a,1
	mvi b,9
	str a,b
jmp displayNumber


displayNumber:

	mvi a,2
	ldr a,a
	cmi a,1
	jzr displayNumber2

	mvi a,1 ; new number to add
	ldr a,a
	
	mvi b,0 ; index offset in RAM
	ldr b,b
	
	mvi c,10 ; start of user saved number
	add b,c
	str b,a

	
	mvi a,0 ; increase index of new num
	ldr a,a
	inc a
	mvi b,0
	str b,a
	
	
	mvi a,10
	ldr a,a
	mmr b,a
	out 11101111b,b
	
	mvi a,11
	ldr a,a
	mmr b,a
	out 11011111b,b
	
	mvi a,12
	ldr a,a
	mmr b,a
	out 10111111b,b
	
	mvi a,13
	ldr a,a
	mmr b,a
	out 01111111b,b
	
jmp waitReleaseButton

displayNumber2:
	mvi a,1 ; new number to add
	ldr a,a
	
	mvi b,0 ; index offset in RAM
	ldr b,b
	
	mvi c,16 ; start of user saved number
	add b,c
	str b,a

	
	mvi a,0 ; increase index of new num
	ldr a,a
	inc a
	mvi b,0
	str b,a
	
	
	mvi a,16
	ldr a,a
	mmr b,a
	out 11101111b,b
	
	mvi a,17
	ldr a,a
	mmr b,a
	out 11011111b,b
	
	mvi a,18
	ldr a,a
	mmr b,a
	out 10111111b,b
	
	mvi a,19
	ldr a,a
	mmr b,a
	out 01111111b,b
jmp waitReleaseButton


waitReleaseButton: 
	inn A,1110b
	ani A,1111b
	cmi A,1111b
	jzr waitReleaseRow2
jmp waitReleaseButton
waitReleaseRow2:
	inn A,1101b 
	ani A,1111b
	cmi A,1111b
	jzr waitReleaseRow3
jmp waitReleaseButton
waitReleaseRow3:
	inn A,1011b 
	ani A,1111b
	cmi A,1111b
	jzr waitReleaseRow4
jmp waitReleaseButton
waitReleaseRow4:
	inn A,0111b 
	ani A,1111b
	cmi A,1111b
	jzr main	
jmp waitReleaseButton	



















