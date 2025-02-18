#Requires AutoHotkey v2.0

; Global variables
insert_mode := false
k_blocked := false
combo_timeout := 200     ; Max time (in ms) to detect 'j' followed by 'k'

; Pause or resume the script with F12
~Home::{
    Pause(!A_IsPaused)  ; Toggle pause state based on current status
}

; When 'j' is pressed
$j::{
    global insert_mode, k_blocked, combo_timeout
    if (!insert_mode) {
        Send("j")
        return
    }

    k_blocked := true       ; Start blocking 'k'

    start_time := A_TickCount
    Loop {
        Sleep(10)
        if (A_TickCount - start_time > combo_timeout)  ; Break loop if timeout exceeds
            break

        if GetKeyState("k", "P") {
            Send("{Esc}")
            insert_mode := false
            k_blocked := true    ; Keep blocking 'k' until key is released

            ; Wait until 'k' is released
            While GetKeyState("k", "P") {
                Sleep(10)
            }

            k_blocked := false   ; Stop blocking after release
            return
        }
    }

    Send("j")
    k_blocked := false
}
return

; Suppress 'k' behavior if it was already handled
$k::{
    global k_blocked
    if (!k_blocked) {
        Send("k")
    }
    return
}

; Enable insert mode with 'i'
~i::{
    global insert_mode
    insert_mode := true
    return
}

; Enable insert mode with 'I'
~+i::{
    global insert_mode
    insert_mode := true
    return
}

; Enable insert mode with 'a'
~a::{
    global insert_mode
    insert_mode := true
    return
}

; Enable insert mode with 'A'
~+a::{
    global insert_mode
    insert_mode := true
    return
}

; Enable insert mode with 's'
~s::{
    global insert_mode
    insert_mode := true
    return
}

; Enable insert mode with 'S'
~+s::{
    global insert_mode
    insert_mode := true
    return
}

; Enable insert mode with 'c'
~c::{
    global insert_mode
    insert_mode := true
    return
}

; Enable insert mode with 'C'
~+c::{
    global insert_mode
    insert_mode := true
    return
}

; Enable insert mode with 'o'
~o::{
    global insert_mode
    insert_mode := true
    return
}

; Enable insert mode with 'O'
~+o::{
    global insert_mode
    insert_mode := true
    return
}

; Reset everything with 'Esc'
~Esc::{
    global insert_mode, k_blocked
    insert_mode := false
    k_blocked := false
    return
}
