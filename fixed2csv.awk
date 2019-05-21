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
    FIELDWIDTHS = "4 30 30 2 14 14 3 22 22 33 38 1 15 5 4 4 30 1 1 1 192"
    OFS=","
}

      {
          gsub(/ /,"",$2)               # FIX NAME
          gsub(/ /,"",$5)               # LATITUDE
          gsub(/ /,"",$6)               # LONGITUDE
          gsub(/ /,"",$15)              # ARTCC
          N = substr($5,13,1)
          LATD = substr($5,1,2)
          LATM = substr($5,4,2)
          LATS = round(substr($5,7,6))
          W = substr($6,14,1)
          LONGD = substr($6, 1, 3)
          LONGM = substr($6, 5, 2)
          LONGS = round(substr($6,8,6))
          printf("%s,%s%02d %02d %02d,%s%d %02d %02d,%s\n", $2, N, LATD, LATM, LATS,
                 W, LONGD, LONGM, LONGS, $15)
      }
