wm attributes . -fullscreen 1

label .hello -text "Device Booted!" -font {{DejaVu Sans} 22}

ttk::button .console -text "Console ..." -width 14 \
    -command {console hide ; console show}
ttk::button .exit -text "Exit" -width 14 \
    -command exit
pack .hello .console .exit -side top -expand 1

bind . <<WillEnterBackground>> {
    console hide
}

bind . <<WillEnterForeground>> {
    focus .
}

bind . <Key-Break> exit

after 400 {borg beep}

