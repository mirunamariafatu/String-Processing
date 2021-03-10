%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher

    mov ebx, edi                        ; mutarea cheii in ebx
cycle:
    mov al , byte [esi + ecx -1]        ; extragerea elementului din plaintext

    cmp al, 0x7A
    jbe possibleChar

    cmp al, 0x5A
    jbe possibleChar
    
back:
    mov byte [edx + ecx - 1] , al       ; adaugarea caracterului criptat
    loop cycle
    jmp end

possibleChar:
    cmp al, 0x61        ; verificare daca elementul este un caracter
    jae isChar

    cmp al, 0x41        ; verificare daca elementul este un caracter
    jae isBigChar

    jmp back

isChar:
    cmp al, 0x7A
    ja back

    add al, bl          ; adaugare cheie
    cmp al, 0x7A        ; verificare daca valoarea literei este valida
    ja backToChar
    jmp back

isBigChar:
    cmp al, 0x5A
    ja back

    add al, bl          ; adaugare cheie
    cmp al, 0x5A        ; verificare daca valoarea literei este valida
    ja backBigChar
    jmp back

backBigChar:
    sub al, 0x5A        ; obtin restul scazand limita superioara a intervalului
    add al, 0x40        ; restabilirea valorii valide a elementului
    jmp back

backToChar:
    sub al, 0x7A        ; scadere limita superioara a intervalului
    cmp al, 26          
    ja resizeIndex
resume:
    add al, 0x60        ; restabilirea valorii valide a elementului
    jmp back

resizeIndex:
    sub al,26
    cmp al,26
    ja resizeIndex
    jmp resume


end:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY