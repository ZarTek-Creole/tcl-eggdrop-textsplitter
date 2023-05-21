namespace eval textSplitter {
    variable splitLength 50

    proc setSplitLength {newLimit} {
        variable splitLength
        if {$newLimit < 10} {
            return -code error "Limit must be higher than 9"
        }
        set splitLength $newLimit
    }

    proc getSplitLength {} {
        variable splitLength
        return $splitLength
    }

    proc splitLine {data} {
        variable splitLength
        set splitLimit [expr {$splitLength - 1}]
        set outputList {}

        if {[string bytelength $data] <= $splitLimit} {
            lappend outputList [expr {$data eq "" ? [list ""] : [split $data "\n"]}]
            return $outputList
        }

        set middlePos [expr round($splitLimit / 2.0)]

        while {1} {
            if {([set cutIndex [string first "\n" $data]] != -1) && ($cutIndex <= $splitLimit)} {
                # Do nothing, cutIndex is already set.
            } elseif {([set cutIndex [string last " " $data [expr {$splitLimit + 1}]]] == -1) || ($cutIndex < $middlePos)} {
                set cutIndex [updateCutIndex $data $splitLimit]
            }

            set newPart [string range $data 0 $cutIndex]
            set data [string range $data $cutIndex+1 end]

            if {[isDataNotEmpty $newPart]} {
                lappend outputList [string trimright $newPart]
            }

            if {![isDataNotEmpty $data]} {
                break
            }

            set taglist [regexp -all -inline {\002|\003(?:[0-9]{0,2}(?:,[0-9]{0,2})?)?|\037|\026|\017} $newPart]
            set tagStatus [resetTagStatus]

            foreach tag $taglist {
                set tagStatus [updateTagStatus $tag $tagStatus]
            }

            set lineStart [getLineStart $tagStatus]
            set data ${lineStart}${data}
        }

        return $outputList
    }

    proc isDataNotEmpty {data} {
        set cleanData [string trim [string map [list \002 {} \037 {} \026 {} \017 {}] [regsub -all {\003([0-9]{0,2}(,[0-9]{0,2})?)?} $data {}]]]
        return [expr {$cleanData ne ""}]
    }

    proc updateCutIndex {data splitLimit} {
        set newCutIndex -1
        for {set i 0} {$i < 6} {incr i} {
            if {[isDataSpecialChar $data [expr {$splitLimit - $i}]]} {
                set newCutIndex [expr {$splitLimit - $i - 1}]
            }
        }
        return [expr {($newCutIndex == -1) ? ($splitLimit) : ($newCutIndex)}]
    }

    proc isDataSpecialChar {data index} {
        set testChar [string index $data $index]
        set isSpecialChar [expr {$testChar eq "\003" && [regexp {^\003([0-9]{1,2}(,[0-9]{1,2})?)} [string range $data $index end]]}]
        return $isSpecialChar
    }

    proc resetTagStatus {} {
        return [list 0 0 0 "-1" "-1"]
    }

    proc updateTagStatus {tag tagStatus} {
        lassign $tagStatus bold underline italic foregroundColor backgroundColor

        switch -- $tag {
            "\002" { set bold [invertBoolean $bold] }
            "\037" { set underline [invertBoolean $underline] }
            "\026" { set italic [invertBoolean $italic] }
            "\017" { set bold 0 ; set underline 0 ; set italic 0 ; set foregroundColor "-1" ; set backgroundColor "-1" }
            default {
                lassign [split [regsub {\003([0-9]{0,2}(,[0-9]{0,2})?)?} $tag {\1}] ","] foregroundColor backgroundColor
                lassign [setTagColors $foregroundColor $backgroundColor] foregroundColor backgroundColor
            }
        }

        return [list $bold $underline $italic $foregroundColor $backgroundColor]
    }

    proc invertBoolean {booleanValue} {
        return [expr {!$booleanValue}]
    }

    proc setTagColors {foreground background} {
        set foreground [setProperColor $foreground]
        set background [setProperColor $background]
        return [list $foreground $background]
    }

    proc setProperColor {colorValue} {
        if {$colorValue eq ""} {
            set colorValue -1
        } elseif {($colorValue < 10) && ([string index $colorValue 0] ne "0")} {
            set colorValue 0$colorValue
        }
        return $colorValue
    }

    proc getLineStart {tagStatus} {
        lassign $tagStatus bold underline italic foregroundColor backgroundColor
        set lineStart ""
        if {$bold} { append lineStart \002 }
        if {$underline} { append lineStart \037 }
        if {$italic} { append lineStart \026 }
        if {($foregroundColor != -1) && ($backgroundColor == -1)} { append lineStart \003$foregroundColor }
        if {($foregroundColor != -1) && ($backgroundColor != -1)} { append lineStart \003$foregroundColor,$backgroundColor }
        return $lineStart
    }
}
