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
 #include "p18F23K20.inc"

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
var	UDATA_ACS
taille_tableau	RES	1
min		RES	1
max		RES	1

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

; Fonction d'écriture du tableau par adressage indirecte
ecrire_tableau
    
    movlw   0x01		    ; Charger l'addresse de la banque de password dans WREG (ici banque = 1)
    movwf   FSR0H		    ; Mettre la valeur de WREG dans le registre FSRHigh
    clrf    FSR0L		    ; reset la valeur de FSRLow à 0 pour sélectionner l'addresse de password
    
    movlw   0x19		    ; Charger la valeur 25 dans WREG
    movwf   POSTINC0, ACCESS	    ; charger WREG à l'adresse de FSR0 puis incrémenter l'adresse
    movlw   0x04		    ; Charger la valeur 4 dans WREG
    movwf   POSTINC0, ACCESS	    ; charger WREG à l'adresse de FSR0 puis incrémenter l'adresse
    movlw   0x02		    ; Charger la valeur 2 dans WREG
    movwf   POSTINC0, ACCESS	    ; charger WREG à l'adresse de FSR0 puis incrémenter l'adresse
    movlw   0x0F		    ; Charger la valeur 15 dans WREG
    movwf   POSTINC0, ACCESS	    ; charger WREG à l'adresse de FSR0 puis incrémenter l'adresse
    movlw   0x10		    ; Charger la valeur 16 dans WREG
    movwf   POSTINC0, ACCESS	    ; charger WREG à l'adresse de FSR0 puis incrémenter l'adresse
    movlw   0x65		    ; Charger la valeur 101 dans WREG
    movwf   POSTINC0, ACCESS	    ; charger WREG à l'adresse de FSR0 puis incrémenter l'adresse
    movlw   0x21		    ; Charger la valeur 33 dans WREG
    movwf   POSTINC0, ACCESS	    ; charger WREG à l'adresse de FSR0 puis incrémenter l'adresse
    movlw   0x03		    ; Charger la valeur 3 dans WREG
    movwf   INDF0		    ; charger WREG à l'adresse de FSR0 
    
    movlw   0x08		    ; on charge la valeur 8 dans WREG
    movwf   taille_tableau, ACCESS  ; charger WREG à l'adresse de taille_tableau
    return			    ; retourne à l'adresse de fin de routine
    
swap_min    
    movf    POSTINC0, W		    ; On charge la valeur à l'adresse du FRS0 dans WREG
    cpfslt  min, ACCESS		    ; Si min < WREG alors on skip la prochaine instruction
    movwf   min, ACCESS		    ; Charger WREG dans min
    
    decf    taille_tableau, F, ACCESS ; Décrémenter l'indice du tableau
    
    goto    loop_search_min	    ; jump to ""
    
recherche_min
    movlw   0x01		    ; Charger l'addresse de la banque de password dans WREG (ici banque = 1)
    movwf   FSR0H		    ; Mettre la valeur de WREG dans le registre FSRHigh
    clrf    FSR0L		    ; reset la valeur de FSRLow à 0 pour sélectionner l'addresse de password
    
    movlw   0x08		    ; on charge la valeur 8 dans WREG
    movwf   taille_tableau, ACCESS  ; charger WREG à l'adresse de taille_tableau
    movf    INDF0, W		    ; On charge la valeur à l'adresse du FRS0 dans WREG
    movwf   min, ACCESS		    ; charger WREG dans min
    
    loop_search_min
    movlw   0x00		    ; Charger littéralement 0 dans le registre de travail
    cpfseq  taille_tableau, ACCESS  ; Si taille_tableau = 0 alors skip la prochaine instruction
    goto    swap_min
    fin_recherche_min
    return			    ; retourne à l'adresse de fin de routine 
    
swap_max    
    movf    POSTINC0, W		    ; On charge la valeur à l'adresse du FRS0 dans WREG
    cpfsgt  max, ACCESS		    ; Si max > WREG alors on skip la prochaine instruction
    movwf   max, ACCESS		    ; Charger WREG dans max
    
    decf    taille_tableau, F, ACCESS ; Décrémenter l'indice du tableau
    
    goto    loop_search_max	    ; jump to ""
    
recherche_max
    movlw   0x01		    ; Charger l'addresse de la banque de password dans WREG (ici banque = 1)
    movwf   FSR0H		    ; Mettre la valeur de WREG dans le registre FSRHigh
    clrf    FSR0L		    ; reset la valeur de FSRLow à 0 pour sélectionner l'addresse de password
    
    movlw   0x08		    ; on charge la valeur 8 dans WREG
    movwf   taille_tableau, ACCESS  ; charger WREG à l'adresse de taille_tableau
    movf    INDF0, W		    ; On charge la valeur à l'adresse du FRS0 dans WREG
    movwf   max, ACCESS		    ; charger WREG dans max
    
    loop_search_max
    movlw   0x00		    ; Charger littéralement 0 dans le registre de travail
    cpfseq  taille_tableau, ACCESS  ; Si taille_tableau = 0 alors skip la prochaine instruction
    goto    swap_max
    fin_recherche_max
    return			    ; retourne à l'adresse de fin de routine     

DEBUT
    
    call    ecrire_tableau	    ; appel de la fonction d'écriture du tableau
    
    call    recherche_min	    ; appel de la fonction de recherche du min
    
    call    recherche_max	    ; appel de la focntion de recherche du max
    
    GOTO $			    ; loop forever
    
    END