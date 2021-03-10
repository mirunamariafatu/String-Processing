%include "io.mac"

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex

    mov ebx, ecx					; salvez length in ebx
    mov bh, 0						; dimensiune hexa_value

    test cl, 01H					; verificarea paritatii lungimii secventei
    je evenNumber

    jmp oddNumber

evenNumber:							; numar par
	inc bh
	sub bl, 4
	cmp bl, 4
	jge evenNumber
	jmp back

oddNumber:							; numar impar
	inc bh
	sub bl, 4
	cmp bl, 4
	jge oddNumber
	inc bh
	jmp back

back:
	xor bl ,bl
	xchg bh, bl						; salvez dimensiunea lui hexa_value in registrul bl

	inc bl
	mov byte [edx + ebx - 1], 0xA 	; adaugare '\n' pe ultima pozitie din hexa_value
	dec bl

	push ebx						; salvez valoarea lui ebx pe stiva pentru a folosi 
									; registrii acestuia

	mov ah, 0 						; variabila rezultat temporar
	mov bl, 0 						; contor biti extrasi
	mov bh, 1						; variabia in care stochez puterile lui 2 prin   
									; shiftari

cycle:
	mov al, byte [esi + ecx - 1]

	cmp bl, 4						; verificare nr biti extrasi = 4
	je createNrHex
nrCreated:

	cmp bl, 0
	je firstBit

	inc bl							; incrementare contor biti extrasi
	shl bh, 1						

	cmp al, 0x31					; verificare daca bitul este 1
	je addNumber
numberAdded:

	loop cycle
	jmp createNrHex					; creeaza numarul format din ultimii biti ramasi

finalJump:
	pop ebx
	jmp end

addNumber:
	add ah, bh
	jmp numberAdded

firstBit:
	inc bl
	cmp al, 0x31					; verificare daca bitul este 1
	je isSet
	jmp numberAdded

isSet:
	add ah, 1
	jmp numberAdded

createNrHex:
	pop ebx 		
	cmp ah, 9						; verificare daca rezultatul obtinut este 	
									;reprezentat in baza 16 ca numar/caracter
	jbe isNumber
	jmp isChar

isNumber:
	add ah, 0x30					; 0x30 - limita inferioara a intervalului ce
									; corespunde cifrelor
	jmp ready

isChar:
	sub ah, 0xa
	add ah, 0x41   					; 0x41 - limita inferioara a intervalului pentru 
									; literele mari
	jmp ready

ready:
	mov byte [edx + ebx - 1], ah
	mov ah, 0
	dec ebx
	push ebx
	mov bl, 0
	mov bh, 1

	cmp cl, 0						; verificare daca a fost parcursa intreaga 											; secventa de biti
	je finalJump

	jmp nrCreated

end:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY