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
    
var_ACS	UDATA_ACS
taille_tableau	RES	1
min		RES	1
max		RES	1
index		RES	1

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

; la routine tableau permet de stocker les instructions suivantes dans la mémoire programme
tableau
    ; récupérer la valeur de index, multiplier par 2 et ajouter à Program Counter
    rlncf   index, W, ACCESS	    ; on le multiplie index par 2 et on le stocke dans WREG
				    ; attention au dépassement méoire lors de la multiplication
    addwf   PCL, F, ACCESS	    ; ajouter index*2 à PCL
    
    ; Tableau stocké en mémoire programme
    retlw   0x19		    ; retourne à l'instruction du Program Counter et charge 19 dans WREG
    retlw   0x04		    ; retourne à l'instruction du Program Counter et charge 4 dans WREG
    retlw   0x02		    ; retourne à l'instruction du Program Counter et charge 2 dans WREG
    retlw   0x0F		    ; retourne à l'instruction du Program Counter et charge 15 dans WREG
    retlw   0x10		    ; retourne à l'instruction du Program Counter et charge 16 dans WREG
    retlw   0x65		    ; retourne à l'instruction du Program Counter et charge 101 dans WREG
    retlw   0x21		    ; retourne à l'instruction du Program Counter et charge 33 dans WREG
    retlw   0x03		    ; retourne à l'instruction du Program Counter et charge 3 dans WREG
    
swap    
    ; charger la valeur tableau[index]
    call    tableau		    ; appel de la routine tableau
    ; tester si tableau[index] < min
    cpfslt  min, ACCESS		    ; Si min < WREG alors on skip la prochaine instruction
    movwf   min, ACCESS		    ; Charger WREG dans min
    ; tester si tableau[index] > max
    cpfsgt  max, ACCESS		    ; Si max > WREG alors on skip la prochaine instruction
    movwf   max, ACCESS		    ; Charger WREG dans max
   
    incf    index, F, ACCESS	    ; Incrémentation de l'index
    decf    taille_tableau, F, ACCESS ; Décrémenter l'indice du tableau
    
    goto    loop_search		    ; jump to ""
    
recherche_tab
    ; initialiser index = 0
    movlw   0x00		    ; Charger 0 dans WREG
    movwf   index, ACCESS	    ; Charger WREG dans index
    ; initialiser taille_tableau = 8
    movlw   0x08		    ; on charge la valeur 8 dans WREG
    movwf   taille_tableau, ACCESS  ; charger WREG à l'adresse de taille_tableau
    ; initialiser min et max avec la première valeur du tableau
    call    tableau
    movwf   min, ACCESS		    ; charger WREG dans min
    movwf   max, ACCESS		    ; charger WREG dans min
    
    loop_search
    ; tester si on est arrivé à la fin du tableau
    movlw   0x00		    ; Charger littéralement 0 dans le registre de travail
    cpfseq  taille_tableau, ACCESS  ; Si taille_tableau = 0 alors skip la prochaine instruction
    goto    swap
    fin_recherche
    return			    ; retourne à l'adresse de fin de routine 
    
    
DEBUT

    ; Appel de la routine recherche min et max
    call    recherche_tab
    
    GOTO $                          ; loop forever

    END