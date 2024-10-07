JMP start

var1: DB 30
var2: DB 35
var3: DB 0

start:  
 
   MOV A, [var1]
   MOV B, [var2]
   ADD A, B
   MOV [var3], A
   MOV C, [var3]
   MOV [232], C

;------------------------------------------------------------------------

; Simple example
; Writes Hello World to the output

    JMP start

var1: DB 23
var2: DB 12

start:
    MOV A, var1
    INC A
    MOV B, var2
    INC B
    ADD A, B

;------------------------------------------------------------------------    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; INSTRUCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Déclarer une variable numérique
; Copier la variabe dans le registre A
; Incrémenter le registre A

; Déclarer une deuxième variable numérique
; Récupérer la premiere variable dans A
; Récupérer la deuxième dans B
; Additionner A et B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; JMP initial pour "sauter" les déclaration de variables qui ne sont pas des instructions
    JMP start

; Label var1 pour retrouver ensuite l'adresse où se situe la valeur "23" enregistrée par l'instruction DB. Attention, 23 est du décimal, il apparaitera en hexadécimal dans le tableau à droite (donc 17)
var1: DB 23
; Pareil avec 12 que l'on référence par "var2"
var2: DB 12

start:
    ; rappatrier dans le registre A la valeur à l'adresse 'var1'
    MOV A, var1
    ; incrémenter la valeur contenue dans le registre A
    INC A
    
    ; Faire maintenant la même chose en rapatriant var2 dans le registre B et en additionnant A et B
    ; ADD -> additionne deux registres

;------------------------------------------------------------------------

JMP start
    var: DB 10

start:  
     MOV C, 0

loop:
    INC C
    CMP C, [var]
    JNZ loop

;------------------------------------------------------------------------

JMP start
    result: DB 0
    limit: db 0
    
start:
    MOV D,SP
    PUSH 1
    PUSH 2
    PUSH 3
    
loop: 
    POP C
    ADD A, C 
    INC B
    CMP SP, 231
    JNZ loop
    DIV B

;------------------------------------------------------------------------

;; Calcule de la moyenne en utilisant la pile
JMP start:
resultat: DB 0

start:
  MOV D, SP  ; Enregistre la position initiale de la pile vide

  PUSH 1
  PUSH 5
  PUSH 4
  PUSH 4
  PUSH 2

  MOV A, 0 ; A cumul toutes les valeurs lues (somme)
  MOV B, 0 : B compte le nombre de valeurs
  MOV C, 0 ; C registre temporaire pour lire le contenu de la pile

loop:
  ; Récupérer l'élément sur la pile
  POP C

  ; Ajoute l'élément à A
  ADD A, C

  ; Incrémente B pour compter le nombre d'éléments
  INC B

  ; Boucle tant que la pile n'est pas vide
  CMP SP, D
  JNZ loop

; Calculer la moyenne
DIV B

; Enregistrer le résultat
MOV [resultat], A

;------------------------------------------------------------------------

JMP start
    result: DB 0
    somme: DB 0
    limit: db 0
    
start:
    PUSH 1
    PUSH 2
    PUSH 3
    MOV A, 0
    MOV B, 0
    MOV C, 0
    MOV D, 231
    
loop: 
    POP C
    ADD A, C 
    INC B
    CMP SP, D
    JNZ loop
    MOV [somme], A
    DIV B
    MOV [result], A
    MOV A, [somme]

;; Calcule de la moyenne sans utiliser la pile mais en déclarant un tableau d'entier ainsi que le nombre d'éléments du tableau
JMP start:
resultat: DB 0

nb: DB 5
tab:
  DB 1
  DB 5
  DB 4
  DB 4
  DB 2

;------------------------------------------------------------------------

start:
  MOV D, tab  ; Enregistre la position initiale de la pile vide

  MOV A, 0 ; A cumul toutes les valeurs lues (somme)
  MOV B, 0 : B compte le nombre de valeurs
  MOV C, 
; C registre temporaire pour lire le contenu de la pile

loop:
  ; Récupérer l'élément sur la pile
  MOV C, [D]
   INC D

  ; Ajoute l'élément à A
  ADD A, C

  ; Incrémente B pour compter le nombre d'éléments
  INC B

  ; Boucle tant que la pile n'est pas vide
  MOV C, D
  ADD C, [nb]
  CMP D, C
  JNZ loop

; Calculer la moyenne
DIV B

; Enregistrer le résultat
MOV [resultat], A  

;------------------------------------------------------------------------

;; Cryptage de César

JMP start

cesar:
  ; Cette variable stocke le décalage à appliquer à
  ; la chaine de caractères
  DB 3
message:
  DB "Hello World!"
  DB 0  ; ce 0 est super important pour délimiter la fin du message

start:
  ; Le output commence à l'adresse 232

  ; Deux méthodes :
  ;    1/ On stocke l'indice de la lettre, on lit à message+indice, on écrit à 232+indice => avantage: un seul registre pour stocker l'indice
  ;    2/ On stocke l'adresse de lecture et l'adresse d'écriture. => avantage : c'est plus simple. Inconvénient : il faut deux registres

  ; Pointer D sur la première lettre du message
  MOV D, [message]

  ; Lire la première lettre dans C
  MOV C, [D]

  ; Application du cryptage de César
  ADD C, [cesar]

  ; Ecrire la lettre lue dans le output
  MOV [232], C

;------------------------------------------------------------------------

JMP start

cesar: 
    DB 4
message:    
    DB "Mur"
    DB 0 
start:
    MOV D, message
    MOV A, 232
loop:
    MOV C, [D]
    ADD C, [cesar]
    MOV [A], C
    INC D
    INC A
    CMP C, [cesar]
    JNZ loop

;------------------------------------------------------------------------

JMP start    
cesar: DB 3
message: DB "Test"
DB 0
start:
    MOV D, message    ; D pointe vers le début du message
    MOV A, 232        ; A pointe vers l'adresse 232 pour stocker le résultat
    
loop: 
    MOV C, [D]        ; Charge le caractère pointé par D dans C
    CMP C, 0          ; Compare C à 0 (pour vérifier la fin de la chaîne)
    JZ end_loop       ; Si C est 0, saute à end_loop (fin du message)
    ADD C, [cesar]    ; Ajoute la valeur de César (3 ici) au caractère
    MOV [A], C        ; Stocke le caractère chiffré à l'adresse A
    INC D             ; Avance D au caractère suivant du message
    INC A             ; Avance A à la prochaine adresse pour stocker le résultat
    JMP loop          ; Recommence la boucle
    
end_loop:
    ; Ici, le programme peut se terminer ou faire autre chose

