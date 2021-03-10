%include "io.mac"

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher

	mov bh, 0 ; contor accesare cheie

cycle:
    mov al , byte [esi]         ; extragerea elementului din plaintext
    inc esi

    cmp al, 0x7A                
    jbe possibleChar

    cmp al, 0x5A                
    jbe possibleChar

back:
    mov byte [edx] , al         ; plasarea elementului criptat in key
    inc edx
    loop cycle
    jmp end

possibleChar:
    cmp al, 0x61            
    jae isChar                  ; verificare daca elementul este un caracter

    cmp al, 0x41        
    jae isBigChar               ; verificare daca elementul este un caracter

    jmp back

isChar:
    cmp al, 0x7A
    ja back

   	jmp getKey

isBigChar:
    cmp al, 0x5A
    ja back

    jmp getKeyBig

getKey:
	mov ah, byte [edi]     ; extragere cheie
	inc bh                 ; incrementarea contorului accesarii cheii
	inc edi

	cmp bh, bl             ; verificare daca contor <= key_len
	je keyAdapt

	jmp gotKey

getKeyBig:
	mov ah, byte [edi]     ; extragere cheie
	inc bh                 ; incrementarea contorului accesarii cheii
	inc edi

	cmp bh, bl             ; verificare daca contor <= key_len
	je keyAdaptB

	jmp gotKeyBig

keyAdapt:                   ; resetarea contorului si a lui key la valorile initiale
	dec bh
	dec edi
	cmp bh, 0
	jne keyAdapt
	jmp gotKey

keyAdaptB:                  ; resetarea contorului si a lui key la valorile initiale
	dec bh
	dec edi
	cmp bh, 0
	jne keyAdaptB
	jmp gotKeyBig

gotKey:
	sub ah, 0x41           ; calcularea indexului
    add al, ah             ; adaugarea indexului la element 

    cmp al, 0x7A           ; verificare daca valoarea literei este valida
    ja backToChar
    jmp back

gotKeyBig:
	sub ah, 0x41           ; calcularea indexului
    add al, ah             ; adaugarea indexului la element 

    cmp al, 0x5A           ; verificare daca valoarea literei este valida
    ja backBigChar
    jmp back

backToChar:
    sub al, 0x7A            ; scadere limita superioara a intervalului
    cmp al, 26
    ja resizeIndex
resume:
    add al, 0x60            ; restabilirea valorii valide a elementului
    jmp back

resizeIndex:
    sub al,26
    cmp al,26
    ja resizeIndex
    jmp resume

backBigChar:
    sub al, 0x5A             ; obtin restul scazand limita superioara a intervalului
    add al, 0x40             ; restabilirea valorii valide a elementului
    jmp back

end:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY