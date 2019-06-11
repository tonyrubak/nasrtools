function round(x, ival, aval, fraction) {
    ival = int(x)
    if (ival == x)
        return ival
    if (x < 0) {
        aval = -x
        ival = int(aval)
        fraction = aval - ival
        if (fraction >= 0.5)
            return int(x) - 1
        else
            return int(x)
    }
    else {
        fraction = x - ival
        if (fraction >= 0.5)
            return ival + 1
        else
            return ival
    }
}

BEGIN {
    FIELDWIDTHS = "4 4 20 4 10 30 40 30 2 3 30 2 50 50 1 1 11 11 4 30 4 30 14 11 14 11 1 14 11 14 11 7 5 4 3 4 3 1 30 4 6 24 10 3 1 3 3 9 20 4 30 100 4 16 30 1 1 1 1 1 1"
    OFS=","
}

$1 ~ /^NAV1/ {
    gsub(/ /,"",$2)               # NAVAID ID
    N = substr($23,13,1)
    LATD = substr($23,1,2)
    LATM = substr($23,4,2)
    LATS = round(substr($23,7,6))
    W = substr($25,14,1)
    LONGD = substr($25, 1, 3)
    LONGM = substr($25, 5, 2)
    LONGS = round(substr($25,8,6))
    printf("%s,%s%02d %02d %02d,%s%d %02d %02d\n", $2, N, LATD, LATM, LATS,
           W, LONGD, LONGM, LONGS)
}
