%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr

  	mov ch, 0                ; contor

cycle:
back:
	mov ah , byte [esi]
    inc esi
    jmp check

resized:
    inc byte[edi]               ; se incrementeaza indexul
	loop cycle

    inc byte [edi]              ; daca substring-ul nu a fost gasit,
                                ; se incrementeaza [edi] pentru a returna 
                                ; haystack_len + 1
	jmp end

check:
    mov al, byte [ebx]          ; se extrage un caracter din needle
    inc ebx
    inc ch                      ; incrementare contor pozitie curenta in needle
    cmp al, ah                  ; verificare daca caracterele corespund 
    je possibleMatch

    jmp resizeCnt

resizeCnt:
    dec ebx
    dec esi                     ; revenim la pozitia unde am identificat un    
                                ; "possible match"
    dec ch
    cmp ch, 0
    jne resizeCnt
    inc esi                     
    jmp resized

possibleMatch:
	cmp ch, dl                 ; verificare contor = needle_len
	je end

	jmp back

end:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
