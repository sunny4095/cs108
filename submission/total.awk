#!/bin/awk -f

BEGIN {
    FS=","
    OFS=","
    ORS="\n"
    RS="\n"
}

{
    if (NR == 1) {
        print $0 ",Total"
    }
    else {
        total = 0
        for (i = 3; i <= NF; i++) {
            if ($i != "a"){
                total = total + $i
            }
        }
        sub(/\r/, "", $0)  # remove newline character
        printf "%s,%d\n", $0, total
    }
}
