;*******************************************************************************
;                                                                              *
;    Microchip licenses this software to you solely for use with Microchip     *
;    products. The software is owned by Microchip and/or its licensors, and is *
;    protected under applicable copyright laws.  All rights reserved.          *
;                                                                              *
;    This software and any accompanying information is for suggestion only.    *
;    It shall not be deemed to modify Microchip?s standard warranty for its    *
;    products.  It is your responsibility to ensure that this software meets   *
;    your requirements.                                                        *
;                                                                              *
;    SOFTWARE IS PROVIDED "AS IS".  MICROCHIP AND ITS LICENSORS EXPRESSLY      *
;    DISCLAIM ANY WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING  *
;    BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS    *
;    FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL          *
;    MICROCHIP OR ITS LICENSORS BE LIABLE FOR ANY INCIDENTAL, SPECIAL,         *
;    INDIRECT OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, HARM TO     *
;    YOUR EQUIPMENT, COST OF PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR    *
;    SERVICES, ANY CLAIMS BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY   *
;    DEFENSE THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER      *
;    SIMILAR COSTS.                                                            *
;                                                                              *
;    To the fullest extend allowed by law, Microchip and its licensors         *
;    liability shall not exceed the amount of fee, if any, that you have paid  *
;    directly to Microchip to use this software.                               *
;                                                                              *
;    MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOUR ACCEPTANCE OF    *
;    THESE TERMS.                                                              *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Filename:                                                                 *
;    Date:                                                                     *
;    File Version:                                                             *
;    Author:                                                                   *
;    Company:                                                                  *
;    Description:                                                              *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Notes: In the MPLAB X Help, refer to the MPASM Assembler documentation    *
;    for information on assembly instructions.                                 *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Known Issues: This template is designed for relocatable code.  As such,   *
;    build errors such as "Directive only allowed when generating an object    *
;    file" will result when the 'Build in Absolute Mode' checkbox is selected  *
;    in the project properties.  Designing code in absolute mode is            *
;    antiquated - use relocatable mode.                                        *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Revision History:                                                         *
;                                                                              *
;*******************************************************************************



;*******************************************************************************
; Processor Inclusion
;
; TODO Step #1 Open the task list under Window > Tasks.  Include your
; device .inc file - e.g. #include <device_name>.inc.  Available
; include files are in C:\Program Files\Microchip\MPLABX\mpasmx
; assuming the default installation path for MPLAB X.  You may manually find
; the appropriate include file for your device here and include it, or
; simply copy the include generated by the configuration bits
; generator (see Step #2).
;
;*******************************************************************************

; TODO INSERT INCLUDE CODE HERE
#include "p18F45K20.inc"

;*******************************************************************************
;
; TODO Step #2 - Configuration Word Setup
;
; The 'CONFIG' directive is used to embed the configuration word within the
; .asm file. MPLAB X requires users to embed their configuration words
; into source code.  See the device datasheet for additional information
; on configuration word settings.  Device configuration bits descriptions
; are in C:\Program Files\Microchip\MPLABX\mpasmx\P<device_name>.inc
; (may change depending on your MPLAB X installation directory).
;
; MPLAB X has a feature which generates configuration bits source code.  Go to
; Window > PIC Memory Views > Configuration Bits.  Configure each field as
; needed and select 'Generate Source Code to Output'.  The resulting code which
; appears in the 'Output Window' > 'Config Bits Source' tab may be copied
; below.
;
;*******************************************************************************

; TODO INSERT CONFIG HERE

;*******************************************************************************
;
; TODO Step #3 - Variable Definitions
;
; Refer to datasheet for available data memory (RAM) organization assuming
; relocatible code organization (which is an option in project
; properties > mpasm (Global Options)).  Absolute mode generally should
; be used sparingly.
;
; Example of using GPR Uninitialized Data
;
;   GPR_VAR        UDATA
;   MYVAR1         RES        1      ; User variable linker places
;   MYVAR2         RES        1      ; User variable linker places
;   MYVAR3         RES        1      ; User variable linker places
;
;   ; Example of using Access Uninitialized Data Section (when available)
;   ; The variables for the context saving in the device datasheet may need
;   ; memory reserved here.
;   INT_VAR        UDATA_ACS
;   W_TEMP         RES        1      ; w register for context saving (ACCESS)
;   STATUS_TEMP    RES        1      ; status used for context saving
;   BSR_TEMP       RES        1      ; bank select used for ISR context saving
;
;*******************************************************************************

; TODO PLACE VARIABLE DEFINITIONS GO HERE

varAccess   UDATA_ACS
   lenght		RES	1	    ; 9
    
varBank1	UDATA   0x100
   password	RES	10		    ; 813nv3nu3
	
varBank2	UDATA   0x200		    
   lenght_crypt	RES	1		    ; 9
   pwd_crypt	RES	11		    ; mdf;#f; f
	
varBank3	UDATA   0x300	
lenght_crypt_inv    RES	1		    ; 9
pwd_crypt_inv	RES	11		    ; f ;f#;f dm

;*******************************************************************************
; Reset Vector
;*******************************************************************************

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    DEBUT                   ; go to beginning of program

;*******************************************************************************
; TODO Step #4 - Interrupt Service Routines
;
; There are a few different ways to structure interrupt routines in the 8
; bit device families.  On PIC18's the high priority and low priority
; interrupts are located at 0x0008 and 0x0018, respectively.  On PIC16's and
; lower the interrupt is at 0x0004.  Between device families there is subtle
; variation in the both the hardware supporting the ISR (for restoring
; interrupt context) as well as the software used to restore the context
; (without corrupting the STATUS bits).
;
; General formats are shown below in relocatible format.
;
;------------------------------PIC16's and below--------------------------------
;
; ISR       CODE    0x0004           ; interrupt vector location
;
;     <Search the device datasheet for 'context' and copy interrupt
;     context saving code here.  Older devices need context saving code,
;     but newer devices like the 16F#### don't need context saving code.>
;
;     RETFIE
;
;----------------------------------PIC18's--------------------------------------
;
; ISRHV     CODE    0x0008
;     GOTO    HIGH_ISR
; ISRLV     CODE    0x0018
;     GOTO    LOW_ISR
;
; ISRH      CODE                     ; let linker place high ISR routine
; HIGH_ISR
;     <Insert High Priority ISR Here - no SW context saving>
;     RETFIE  FAST
;
; ISRL      CODE                     ; let linker place low ISR routine
; LOW_ISR
;       <Search the device datasheet for 'context' and copy interrupt
;       context saving code here>
;     RETFIE
;
;*******************************************************************************

; TODO INSERT ISR HERE

;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************

MAIN_PROG CODE                      ; let linker place main program
 
; Routine de calcul de la longueur de pwd
calcul_longueur
    movlw   0x01		    ; Charger littéralement 1 dans le registre de travail
    movwf   FSR0H, ACCESS	    ; Charger WREG dans FSR0H pour l'innitialisé sur la banque 1
    clrf    FSR0L, ACCESS	    ; Reset FSR0L à 0 pour sélectionner la case 0
    
    clrf    lenght, ACCESS	    ; Reset lenght à 0
loop_calcul_longueur
    movf    POSTINC0, W		    ; Charger l'adresse de POSTINC0 dans WREG puis incrémenter le FSR0
    bz	    fin_calcul_longueur	    ; Si ZERO dans le registre STATUS = 1 alors jump sur ""
    incf    lenght, F, ACCESS	    ; lenght = lenght + 1
    goto    loop_calcul_longueur    ; jump to ""
fin_calcul_longueur
    return			    ; retourne à l'adresse de fin de routine

    
; Routine de calcul de la longueur de pwd chiffré
calcul_longueur_crypt
    movlw   0x02			; Charger littéralement 2 dans le registre de travail
    movwf   FSR1H, ACCESS		; Charger WREG dans FSR1H pour l'innitialisé sur la banque 2
    movlw   0x01			; Charger littéralement 1 dans le registre de travail
    movwf   FSR1L, ACCESS		; Charger WREG dans FSR1L pour sélectionner la case 1
    
    clrf    lenght_crypt, 1		; Reset lenght_crypt à 0
loop_calcul_longueur_crypt
    movf    POSTINC1, W			; Charger l'adresse de POSTINC1 dans WREG puis incrémenter l'adresse du FSR1
    bz	    fin_calcul_longueur_crypt	; Si ZERO dans le registre STATUS = 1 alors jump sur ""
    incf    lenght_crypt, F, 1		; lenght_crypt = lenght_crypt + 1
    goto    loop_calcul_longueur_crypt	; jump to ""
fin_calcul_longueur_crypt
    return				; retourne à l'adresse de fin de routine
    
    
; Boucle de chiffrement de pwd dans la banque 2
change_crypt
    movf    POSTINC0, W		    ; Charger l'adresse de POSTINC0 dans WREG puis incrémenter l'adresse du FSR0
    movwf   INDF1, ACCESS	    ; Charger WREG dans l'adresse du FRS1
    btg	    INDF1, 6, ACCESS	    ; inverser le bit 6 de l'adresse du FRS1
    btg	    INDF1, 4, ACCESS	    ; inverser le bit 4 de l'adresse du FRS1
    btg	    INDF1, 2, ACCESS	    ; inverser le bit 2 de l'adresse du FRS1
    btg	    POSTINC1, 0, ACCESS	    ; inverser le bit 0 de l'adresse du FRS1 puis incrémenter l'adresse du FRS1
    
    decf    lenght_crypt, f, 1	    ; lenght_crypt = lenght_crypt - 1 
    
    goto    loop_crypt		    ; jump to ""
; Routine de chiffrement 
chiffrement
    movlw   0x01		    ; Charger littéralement 1 dans le registre de travail
    movwf   FSR0H, ACCESS	    ; Charger WREG dans FSR0H pour l'innitialisé sur la banque 1
    clrf    FSR0L, ACCESS	    ; Reset FSR0L à 0 pour sélectionner la case 0
    
    movlw   0x02		    ; Charger littéralement 2 dans le registre de travail
    movwf   FSR1H, ACCESS	    ; Charger WREG dans FSR1H pour l'innitialisé sur la banque 2
    movlw   0x01		    ; Charger littéralement 1 dans le registre de travail
    movwf   FSR1L, ACCESS	    ; Charger WREG dans FSR1L pour sélectionner la case 1
    
    movf    lenght, W		    ; Charger lenght dans le registre de travail
    MOVLB   0x02		    ; Changer le BSR pour sélectionner la banque 2
    movwf    lenght_crypt, 1	    ; Charger WREG dans lenght_crypt
loop_crypt   
    movlw   0x00		    ; Charger littéralement 0 dans le registre de travail
    CPFSEQ  lenght_crypt, 1	    ; Si lenght_crypt = 0 alors skip la prochaine instruction
    goto    change_crypt	    ; jump to ""
    movlw   0x00		    ; Charger littéralement 0 dans le registre de travail
    movwf   INDF1, ACCESS	    ; Charger WREG dans l'adresse de INDF1 pour ajouter le caractère de fin de chaîne
fin_cryptage
    return			    ; retourner vers l'adresse de fin de routine

    
; Boucle d'inversion des caractère   
inv_crypt
    movf    POSTDEC1, W, ACCESS	    ; Charger FRS1 dans WREG puis décrémenter l'adresse de FSR1
    movwf   POSTINC0, ACCESS	    ; Charger WREG dans FSR0 puis incrémenter l'adresse de FSR0
    
    decf    lenght_crypt_inv, F, 1  ; lenght_crypt_inv = lenght_crypt_inv - 1
    
    goto    loop_inv_pwd	    ; jump to ""  
; Routine d'inversion de sens du pwd
inv_pwd_crypt
    movlw   0x02		    ; Charger littéralement 2 dans le registre de travail
    movwf   FSR1H, ACCESS	    ; Charger WREG dans FSR1H pour l'innitialisé sur la banque 2
    movf    lenght_crypt, W	    ; Charger lenght_crypt + 1 dans le registre de travail
    movwf   FSR1L, ACCESS	    ; Charger WREG dans FSR1L pour sélectionner la case 09
    
    movlw   0x03		    ; Charger littéralement 3 dans le registre de travail
    movwf   FSR0H, ACCESS	    ; Charger WREG dans FSR0H pour l'innitialisé sur la banque 3
    movlw   0x01		    ; Charger littéralement 1 dans le registre de travail
    movwf   FSR0L, ACCESS	    ; Charger WREG dans FSR0L pour sélectionner la case 1
    
    movf    lenght_crypt, W	    ; Charger lenght_crypt dans le registre de travail
    MOVLB   0x03		    ; Changer le BSR pour sélectionner la banque 3
    movwf   lenght_crypt_inv, 1	    ; Charger WREG dans lenght_crypt_inv
loop_inv_pwd
    movlw   0x00		    ; Charger littéralement 0 dans le registre de travail
    CPFSEQ  lenght_crypt, 1	    ; Si lenght_crypt = 0 alors skip la prochaine instruction
    goto    inv_crypt		    ; jump to ""
    movlw   0x00		    ; Charger littéralement 0 dans le registre de travail
    movwf   INDF0, ACCESS	    ; Charger WREG dans l'adresse de INDF0 pour ajouter le caractère de fin de chaîne
fin_inv_pwd_crypt
    return
    
DEBUT

    ; TODO Step #5 - Insert Your Program Here
   
    ; 1.0 Écriture dans la RAM du code d?accès JUNIA_STUDENTS
    MOVLB   0x01		    ; choisir la banque 1
   
    MOVLW   0x01		    ; Charger l'addresse de la banque de password dans WREG (ici banque = 1)
    MOVWF   FSR0H		    ; Mettre la valeur de WREG dans le registre FSRHigh
    CLRF    FSR0L		    ; reset la valeur de FSRLow à 0 pour sélectionner l'addresse de password
    
    ; 813nv3nu3
    ; Écrire la valeur A'8' à l'emplacement mémoire pointé par FSR
    MOVLW   A'8'		    ; Charger la valeur A'8' dans WREG
    ; POSTINC0 écrit la valeur de WREG à l'emplacement mémoire pointé par FSR puis ajoute 1 au FRS
    MOVWF   POSTINC0		    ; Écrire la valeur de WREG à l'emplacement mémoire pointé par FSR
    
    MOVLW   A'1'		    ; Charger la valeur A'1' dans WREG
    MOVWF   POSTINC0		    ; Écrire la valeur de WREG à l'emplacement mémoire pointé par FSR
    MOVLW   A'3'		    ; Charger la valeur A'1' dans WREG
    MOVWF   POSTINC0		    ; Écrire la valeur de WREG à l'emplacement mémoire pointé par FSR
    MOVLW   A'n'		    ; Charger la valeur A'1' dans WREG
    MOVWF   POSTINC0		    ; Écrire la valeur de WREG à l'emplacement mémoire pointé par FSR
    MOVLW   A'v'		    ; Charger la valeur A'1' dans WREG
    MOVWF   POSTINC0		    ; Écrire la valeur de WREG à l'emplacement mémoire pointé par FSR
    MOVLW   A'3'		    ; Charger la valeur A'1' dans WREG
    MOVWF   POSTINC0		    ; Écrire la valeur de WREG à l'emplacement mémoire pointé par FSR
    MOVLW   A'n'		    ; Charger la valeur A'1' dans WREG
    MOVWF   POSTINC0		    ; Écrire la valeur de WREG à l'emplacement mémoire pointé par FSR
    MOVLW   A'u'		    ; Charger la valeur A'1' dans WREG
    MOVWF   POSTINC0		    ; Écrire la valeur de WREG à l'emplacement mémoire pointé par FSR
    MOVLW   A'3'		    ; Charger la valeur A'1' dans WREG
    MOVWF   POSTINC0		    ; Écrire la valeur de WREG à l'emplacement mémoire pointé par FSR3
    MOVLW   0x00		    ; Charger la valeur 0x00 dans WREG
    MOVWF   POSTINC0		    ; Écrire la valeur de WREG à l'emplacement mémoire pointé par FSR3
    
    
    ; 2.0 Calcul de la longueur de la chaîne
    
    call    calcul_longueur
    
    ; 3.0 Chiffrement du code
    
    call    chiffrement
    call    calcul_longueur_crypt
    
    ; 4.0 chiffrement du code chiffré
    
    call    inv_pwd_crypt
    
    GOTO $                          ; loop forever

    END
