# Autogenerated with DRAKON Editor 1.23
######### Public #########
proc reset_db {  } {
    variable f_department_rcount
    array unset f_department_rcount
    array set f_department_rcount {}

    variable f_department_type_id
    array unset f_department_type_id
    array set f_department_type_id {}

    variable f_department_title
    array unset f_department_title
    array set f_department_title {}

    variable f_company_rcount
    array unset f_company_rcount
    array set f_company_rcount {}

    variable f_company_type_id
    array unset f_company_type_id
    array set f_company_type_id {}

    variable f_company_marketing
    array unset f_company_marketing
    array set f_company_marketing {}

    variable f_employee_rcount
    array unset f_employee_rcount
    array set f_employee_rcount {}

    variable f_employee_type_id
    array unset f_employee_type_id
    array set f_employee_type_id {}

    variable f_employee_name
    array unset f_employee_name
    array set f_employee_name {}

    variable f_employee_department
    array unset f_employee_department
    array set f_employee_department {}

    variable i_department_title
    array unset i_department_title
    array set i_department_title {}

    variable i_employee_department_name
    array unset i_employee_department_name
    array set i_employee_department_name {}

    variable g_department_next
    set g_department_next 1
    variable g_company_next
    set g_company_next 1
    variable g_employee_next
    set g_employee_next 1
}
proc department_keys {  } {
    variable f_department_rcount
    set names [ array names f_department_rcount ]
    return $names
}
proc department_count {  } {
    variable f_department_rcount
    set names [ array names f_department_rcount ]
    return [ llength $names ]
}
proc department_exists { id } {
    variable f_department_rcount
    return [ info exists f_department_rcount($id) ]
}
proc department_insert { id title } {
    variable g_department_next
    if { $id == {} } {
        set id $g_department_next
    } else {
        if { [ department_exists $id ] } {
            set class_name [ get_department_type_id $id ]
            error "'$class_name' with id $id already exists."
        }
    }
    if { $id >= $g_department_next } {
        set g_department_next [ expr { $id + 1 } ]
    }
    variable i_department_title
    set _key_ "$title"
    if { [ info exists i_department_title($_key_) ] } {
        error "Fields 'title' are not unique for 'department'."
    }
    variable f_department_type_id
    set f_department_type_id($id) "department"
    variable f_department_rcount
    set f_department_rcount($id) 0
    variable f_department_title
    set f_department_title($id) $title
    variable i_department_title
    set _key_ "$title"
    set i_department_title($_key_) $id
    return $id
}
proc get_department_type_id { id } {
    variable f_department_type_id
    if { [ info exists f_department_type_id($id) ] } {
        return $f_department_type_id($id)
    } else {
        return {}
    }
}
proc department_delete { id } {
    variable g_del_list
    array unset g_del_list
    array set g_del_list {}

    if { ![ department_exists $id ] } {
        error "'department' with id '$id' does not exist."
    }
    department_pre_delete $id 0
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_can_delete"
        $proc_name $pk
    }
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_do_delete"
        $proc_name $pk
    }
    variable f_department_type_id
    unset f_department_type_id($id)
}
proc find_department_by_title { title } {
    variable i_department_title
    set _key_ "$title"
    if { [ info exists i_department_title($_key_) ] } {
        return $i_department_title($_key_)
    } else {
        return {}
    }
}
proc get_department_title { id } {
    variable f_department_title
    if { [ info exists f_department_title($id) ] } {
        return $f_department_title($id)
    } else {
        return {}
    }
}
proc set_department_title { id title } {
    if { ![ department_exists $id ] } {
        error "'department' with id '$id' does not exist."
    }
    set old [ get_department_title $id ]
    if { $old == $title } {
        return
    }
    variable i_department_title
    set _key_ "$title"
    if { [ info exists i_department_title($_key_) ] } {
        error "Fields 'title' are not unique for 'department'."
    }
    set _key_ "$old"
    unset i_department_title($_key_)
    variable f_department_title
    set f_department_title($id) $title
    variable i_department_title
    set _key_ "$title"
    set i_department_title($_key_) $id
}
proc company_keys {  } {
    variable f_company_rcount
    set names [ array names f_company_rcount ]
    return $names
}
proc company_count {  } {
    variable f_company_rcount
    set names [ array names f_company_rcount ]
    return [ llength $names ]
}
proc company_exists { id } {
    variable f_company_rcount
    return [ info exists f_company_rcount($id) ]
}
proc company_insert { id } {
    variable g_company_next
    if { $id == {} } {
        set id $g_company_next
    } else {
        if { [ company_exists $id ] } {
            set class_name [ get_company_type_id $id ]
            error "'$class_name' with id $id already exists."
        }
    }
    if { $id >= $g_company_next } {
        set g_company_next [ expr { $id + 1 } ]
    }
    variable f_company_type_id
    set f_company_type_id($id) "company"
    variable f_company_rcount
    set f_company_rcount($id) 0
    return $id
}
proc get_company_type_id { id } {
    variable f_company_type_id
    if { [ info exists f_company_type_id($id) ] } {
        return $f_company_type_id($id)
    } else {
        return {}
    }
}
proc company_delete { id } {
    variable g_del_list
    array unset g_del_list
    array set g_del_list {}

    if { ![ company_exists $id ] } {
        error "'company' with id '$id' does not exist."
    }
    company_pre_delete $id
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_can_delete"
        $proc_name $pk
    }
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_do_delete"
        $proc_name $pk
    }
    variable f_company_type_id
    unset f_company_type_id($id)
}
proc get_company_marketing { id } {
    variable f_company_marketing
    if { [ info exists f_company_marketing($id) ] } {
        return $f_company_marketing($id)
    } else {
        return {}
    }
}
proc set_company_marketing { id marketing } {
    if { ![ company_exists $id ] } {
        error "'company' with id '$id' does not exist."
    }
    set old [ get_company_marketing $id ]
    if { $old == $marketing } {
        return
    }
    if { $marketing != {} && ![ department_exists $marketing ] } {
        error "'department' with id '$marketing' does not exist."
    }
    if { $old != {} } {
        variable f_department_rcount
        set _ref_count $f_department_rcount($old)
        incr _ref_count -1
        set f_department_rcount($old) $_ref_count
    }
    variable f_company_marketing
    set f_company_marketing($id) $marketing
    if { $marketing != {} } {
        variable f_department_rcount
        set _ref_count $f_department_rcount($marketing)
        incr _ref_count
        set f_department_rcount($marketing) $_ref_count
    }
}
proc employee_keys {  } {
    variable f_employee_rcount
    set names [ array names f_employee_rcount ]
    return $names
}
proc employee_count {  } {
    variable f_employee_rcount
    set names [ array names f_employee_rcount ]
    return [ llength $names ]
}
proc employee_exists { id } {
    variable f_employee_rcount
    return [ info exists f_employee_rcount($id) ]
}
proc employee_insert { id name department } {
    variable g_employee_next
    if { $id == {} } {
        set id $g_employee_next
    } else {
        if { [ employee_exists $id ] } {
            set class_name [ get_employee_type_id $id ]
            error "'$class_name' with id $id already exists."
        }
    }
    if { $id >= $g_employee_next } {
        set g_employee_next [ expr { $id + 1 } ]
    }
    variable i_employee_department_name
    set _key_ "$department,|,$name"
    if { [ info exists i_employee_department_name($_key_) ] } {
        error "Fields 'department name' are not unique for 'employee'."
    }
    if { $department != {} && ![ department_exists $department ] } {
        error "'department' with id '$department' does not exist."
    }
    variable f_employee_type_id
    set f_employee_type_id($id) "employee"
    variable f_employee_rcount
    set f_employee_rcount($id) 0
    variable f_employee_name
    set f_employee_name($id) $name
    variable f_employee_department
    set f_employee_department($id) $department
    variable i_employee_department_name
    set _key_ "$department,|,$name"
    set i_employee_department_name($_key_) $id
    if { $department != {} } {
        variable f_department_rcount
        set _ref_count $f_department_rcount($department)
        incr _ref_count
        set f_department_rcount($department) $_ref_count
    }
    return $id
}
proc get_employee_type_id { id } {
    variable f_employee_type_id
    if { [ info exists f_employee_type_id($id) ] } {
        return $f_employee_type_id($id)
    } else {
        return {}
    }
}
proc employee_delete { id } {
    variable g_del_list
    array unset g_del_list
    array set g_del_list {}

    if { ![ employee_exists $id ] } {
        error "'employee' with id '$id' does not exist."
    }
    employee_pre_delete $id
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_can_delete"
        $proc_name $pk
    }
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_do_delete"
        $proc_name $pk
    }
    variable f_employee_type_id
    unset f_employee_type_id($id)
}
proc find_employee_by_department_name { department name } {
    variable i_employee_department_name
    set _key_ "$department,|,$name"
    if { [ info exists i_employee_department_name($_key_) ] } {
        return $i_employee_department_name($_key_)
    } else {
        return {}
    }
}
proc get_employee_name { id } {
    variable f_employee_name
    if { [ info exists f_employee_name($id) ] } {
        return $f_employee_name($id)
    } else {
        return {}
    }
}
proc set_employee_name { id name } {
    if { ![ employee_exists $id ] } {
        error "'employee' with id '$id' does not exist."
    }
    set old [ get_employee_name $id ]
    if { $old == $name } {
        return
    }
    set department [ get_employee_department $id ]
    variable i_employee_department_name
    set _key_ "$department,|,$name"
    if { [ info exists i_employee_department_name($_key_) ] } {
        error "Fields 'department name' are not unique for 'employee'."
    }
    set _key_ "$department,|,$old"
    unset i_employee_department_name($_key_)
    variable f_employee_name
    set f_employee_name($id) $name
    variable i_employee_department_name
    set _key_ "$department,|,$name"
    set i_employee_department_name($_key_) $id
}
proc get_employee_department { id } {
    variable f_employee_department
    if { [ info exists f_employee_department($id) ] } {
        return $f_employee_department($id)
    } else {
        return {}
    }
}
proc set_employee_department { id department } {
    if { ![ employee_exists $id ] } {
        error "'employee' with id '$id' does not exist."
    }
    set old [ get_employee_department $id ]
    if { $old == $department } {
        return
    }
    set name [ get_employee_name $id ]
    variable i_employee_department_name
    set _key_ "$department,|,$name"
    if { [ info exists i_employee_department_name($_key_) ] } {
        error "Fields 'department name' are not unique for 'employee'."
    }
    if { $department != {} && ![ department_exists $department ] } {
        error "'department' with id '$department' does not exist."
    }
    if { $old != {} } {
        variable f_department_rcount
        set _ref_count $f_department_rcount($old)
        incr _ref_count -1
        set f_department_rcount($old) $_ref_count
    }
    set _key_ "$old,|,$name"
    unset i_employee_department_name($_key_)
    variable f_employee_department
    set f_employee_department($id) $department
    variable i_employee_department_name
    set _key_ "$department,|,$name"
    set i_employee_department_name($_key_) $id
    if { $department != {} } {
        variable f_department_rcount
        set _ref_count $f_department_rcount($department)
        incr _ref_count
        set f_department_rcount($department) $_ref_count
    }
}
######### Private #########
variable g_del_list
array set g_del_list {}
variable f_department_rcount
array set f_department_rcount {}
variable f_department_type_id
array set f_department_type_id {}
variable g_department_next 1
variable f_department_title
array set f_department_title {}
variable f_company_rcount
array set f_company_rcount {}
variable f_company_type_id
array set f_company_type_id {}
variable g_company_next 1
variable f_company_marketing
array set f_company_marketing {}
variable f_employee_rcount
array set f_employee_rcount {}
variable f_employee_type_id
array set f_employee_type_id {}
variable g_employee_next 1
variable f_employee_name
array set f_employee_name {}
variable f_employee_department
array set f_employee_department {}
variable i_department_title
array set i_department_title {}
variable i_employee_department_name
array set i_employee_department_name {}
proc department_pre_delete { id master } {
    set type [ get_department_type_id $id ]
    variable g_del_list
    set key "$id,$type"
    if { [ info exists g_del_list($key) ] } {
        return
    } else {
        set g_del_list($key) 1
    }
    variable f_department_rcount
    set _ref_count_ $f_department_rcount($id)
    if { $master && $_ref_count_ > 1 || 
      !$master && $_ref_count_ > 0 } {
        set _type_id_ [ get_department_type_id $id ]
        error "'$_type_id_' with id '$id' is referenced by other record."
    }
    ${type}_pre_delete_middle $id
}
proc department_pre_delete_middle { id } {
    department_pre_delete_inner $id
}
proc department_pre_delete_inner { id } {
}
proc department_can_delete { id } {
}
proc department_do_delete { id } {
    set title [ get_department_title $id ]
    variable i_department_title
    set _key_ "$title"
    unset i_department_title($_key_)
    variable f_department_title
    if { [ info exists f_department_title($id) ] } {
        unset f_department_title($id)
    }
    variable f_department_rcount
    unset f_department_rcount($id)
}
proc company_pre_delete { id } {
    set type [ get_company_type_id $id ]
    variable g_del_list
    set key "$id,$type"
    if { [ info exists g_del_list($key) ] } {
        return
    } else {
        set g_del_list($key) 1
    }
    ${type}_pre_delete_middle $id
}
proc company_pre_delete_middle { id } {
    company_pre_delete_inner $id
}
proc company_pre_delete_inner { id } {
    set marketing [ get_company_marketing $id ]
    if { $marketing != {} } {
        department_pre_delete $marketing 1
    }
}
proc company_can_delete { id } {
}
proc company_do_delete { id } {
    set marketing [ get_company_marketing $id ]
    if { $marketing != {} } {
        variable g_del_list
        set _type_ [ get_department_type_id $marketing ]
        set _key_ "$marketing,$_type_"
        if { ![ info exists g_del_list($_key_) ] } {
            variable f_department_rcount
            set _ref_count $f_department_rcount($marketing)
            incr _ref_count -1
            set f_department_rcount($marketing) $_ref_count
        }
    }
    variable f_company_marketing
    if { [ info exists f_company_marketing($id) ] } {
        unset f_company_marketing($id)
    }
    variable f_company_rcount
    unset f_company_rcount($id)
}
proc employee_pre_delete { id } {
    set type [ get_employee_type_id $id ]
    variable g_del_list
    set key "$id,$type"
    if { [ info exists g_del_list($key) ] } {
        return
    } else {
        set g_del_list($key) 1
    }
    ${type}_pre_delete_middle $id
}
proc employee_pre_delete_middle { id } {
    employee_pre_delete_inner $id
}
proc employee_pre_delete_inner { id } {
}
proc employee_can_delete { id } {
}
proc employee_do_delete { id } {
    set department [ get_employee_department $id ]
    if { $department != {} } {
        variable g_del_list
        set _type_ [ get_department_type_id $department ]
        set _key_ "$department,$_type_"
        if { ![ info exists g_del_list($_key_) ] } {
            variable f_department_rcount
            set _ref_count $f_department_rcount($department)
            incr _ref_count -1
            set f_department_rcount($department) $_ref_count
        }
    }
    set department [ get_employee_department $id ]
    set name [ get_employee_name $id ]
    variable i_employee_department_name
    set _key_ "$department,|,$name"
    unset i_employee_department_name($_key_)
    variable f_employee_name
    if { [ info exists f_employee_name($id) ] } {
        unset f_employee_name($id)
    }
    variable f_employee_department
    if { [ info exists f_employee_department($id) ] } {
        unset f_employee_department($id)
    }
    variable f_employee_rcount
    unset f_employee_rcount($id)
}

proc equal { expected actual } {
    #item 18
    if { $expected != $actual } {
    	error "'equal' fails:\nExpected: $expected \nActual:   $actual"
    }
}

proc exception { expression } {
    #item 7
    if { ![ catch { uplevel $expression } ] } {
    	error "Error expected!"
    }
}

proc main { } {
    #item 19
    reset_db
    #item 108
    equal 0 [ employee_count ]
    equal 0 [ department_count ]
    equal 0 [ company_count ]
    #item 160
    set yellow [ company_insert "" ]
    set grey [ company_insert "" ]
    #item 161
    set yellow_m [ department_insert "" "Yellow marketing" ]
    set grey_m [ department_insert "" "Grey marketing" ]
    #item 162
    set grey_e [ employee_insert "" "Mark" $grey_m ]
    set grey_e2 [ employee_insert "" "John" "" ]
    #item 178
    exception { employee_insert "" "Mark" $grey_m }
    #item 163
    exception { employee_insert "" "Jack" 1000 }
    #item 164
    set_company_marketing $yellow $yellow_m
    set_company_marketing $grey $grey_m
    #item 165
    set_employee_department $grey_e2 $grey_m
    #item 169
    equal 1 [ department_exists $yellow_m ]
    #item 166
    exception { department_delete $yellow_m }
    #item 167
    company_delete $yellow
    #item 168
    equal 0 [ department_exists $yellow_m ]
    equal 0 [ company_exists $yellow ]
    #item 170
    exception { company_delete $grey }
    #item 171
    set_employee_department $grey_e ""
    #item 172
    employee_delete $grey_e2
    #item 173
    company_delete $grey
    #item 174
    equal 0 [ company_exists $grey ]
    equal 0 [ department_exists $grey_m ]
}

proc not_equal { left right } {
    #item 31
    if { $left == $right } {
    	error "'not_equal' fails:\nLeft:    $left \nRight:   $right"
    }
}

main