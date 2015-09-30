wm attributes . -fullscreen 1

label .hello -text "Hello World!" -font {{DejaVu Sans} 22}

set colorList {red blue yellow magenta cyan orange green}

proc rcolor {colorList} {
    return [lindex $colorList \
       [expr {int(rand() * [llength $colorList])}]]
}

set c_width [expr {[winfo screenwidth .] / 2}]
set c_height [expr {[winfo screenheight . ] / 2}]
if {$c_width > $c_height} {
    set c_width $c_height
} else {
    set c_height $c_width
}
set radius [expr {round($c_width / 33.0)}]

catch {borg camera open}
catch {borg camera mirror 0 [lindex [borg camera info] 1]}
if {$c_width < 640} {
    catch {borg camera parameters preview-size 320x240}
}

image create photo camera_img
canvas .canvas -bg black -width $c_width -height $c_height
.canvas create image [expr {$c_width / 2}] [expr {$c_height / 2}] \
    -image camera_img -anchor center -tags image
.canvas create rectangle 0 0 1 1 -tags img_rect -width 5 -outline #000000
.canvas lower img_rect image

proc img_reconf {} {
    camera_img blank
    camera_img configure -width 1 -height 1
    camera_img configure -width 0 -height 0
    .canvas coords img_rect 0 0 1 1
    .canvas itemconfigure img_rect -outline #000000
    catch {borg camera orientation [dict get [borg displaymetrics] rotation]}
}

bind . <Configure> {
    after cancel img_reconf
    after idle img_reconf
}

bind . <<DidEnterForeground>> {
    after cancel img_reconf
    after idle img_reconf
}

bind . <<ImageCapture>> {
    borg camera image camera_img
    .canvas coords img_rect {*}[.canvas bbox image]
    .canvas itemconfigure img_rect -outline #008000
}

bind .canvas <1> {
    catch {
	if {[borg camera state] eq "capture"} {
	    borg camera stop
	    .canvas itemconfigure img_rect -outline #800000
	} else {
	    borg camera start
	}
    }
}

proc make_items {} {
    global c_width c_height radius DX DY itemList colorList
    catch {unset itemList}
    for {set count 0} {$count < 10} {incr count} {
        set item [.canvas create oval \
            [expr {$c_width / 2 - $radius}] \
            [expr {$c_height / 2 - $radius}] \
            [expr {$c_width / 2 + $radius}] \
            [expr {$c_height / 2 + $radius}] \
            -fill [rcolor $colorList] \
            -width 0]
        set DX($item) [expr {(rand() -0.5) * 10}]
        set DY($item) [expr {(rand() -0.5) * 10}]
        lappend itemList $item
    }
}

proc move_items {} {
    global c itemList DX DY c_width c_height
    set collision 0
    .hello configure -foreground black
    foreach item $itemList {
        .canvas move $item $DX($item) $DY($item)
        foreach i {xmin ymin xmax ymax} j [.canvas coords $item] {
            set $i $j
        }
        if {$xmax > $c_width || $xmin < 0} {
            set DX($item) [expr {-$DX($item)}]
            incr collision
        }
        if {$ymax > $c_height || $ymin < 0} {
            set DY($item) [expr {-$DY($item)}]
            incr collision
        }
    }
    after 40 move_items
    if {$collision} {
	.hello configure -foreground #707070
        catch {borg vibrate 50}
    }
}

make_items

ttk::button .console -text "Console ..." -width 14 \
    -command {console hide ; console show}
ttk::button .exit -text "Exit" -width 14 \
    -command exit
pack .hello .canvas .console .exit -side top -expand 1

bind . <<WillEnterBackground>> {
    after cancel move_items
    console hide
}

bind . <<WillEnterForeground>> {
    after cancel move_items
    after idle move_items
    focus .
}

bind . <Key-Break> {borg withdraw}

move_items
