module Iso8601 exposing (Mode(..), toString, toUtcString)

import Time exposing (Month, Posix, Zone)


type Mode
    = Year
    | Milli
    | Second
    | Minute
    | Hour
    | Day
    | Month
    | HourMilli
    | HourSecond
    | HourMinute
    | HourOnly


toUtcString : Mode -> Posix -> String
toUtcString mode time =
    toString mode Time.utc time


{-| convert a positive integer into a string of at least two digits
-}
iToS2 : Int -> String
iToS2 i =
    if i < 10 then
        "0" ++ String.fromInt i

    else
        String.fromInt i


{-| convert a positive integer into a string of at least three digits
-}
iToS3 : Int -> String
iToS3 i =
    if i < 10 then
        "00" ++ String.fromInt i

    else if i < 100 then
        "0" ++ String.fromInt i

    else
        String.fromInt i


monthToS : Month -> String
monthToS month =
    case month of
        Time.Jan ->
            "01"

        Time.Feb ->
            "02"

        Time.Mar ->
            "03"

        Time.Apr ->
            "04"

        Time.May ->
            "05"

        Time.Jun ->
            "06"

        Time.Jul ->
            "07"

        Time.Aug ->
            "08"

        Time.Sep ->
            "09"

        Time.Oct ->
            "10"

        Time.Nov ->
            "11"

        Time.Dec ->
            "12"


{-| Convert a posix time into a ISO8601 string
-}
toString : Mode -> Zone -> Posix -> String
toString mode zone time =
    case mode of
        Year ->
            time |> Time.toYear zone |> String.fromInt

        Month ->
            (time |> Time.toYear zone |> String.fromInt)
                ++ "-"
                ++ (time |> Time.toMonth zone |> monthToS)

        Day ->
            (time |> Time.toYear zone |> String.fromInt)
                ++ "-"
                ++ (time |> Time.toMonth zone |> monthToS)
                ++ "-"
                ++ (time |> Time.toDay zone |> iToS2)

        HourOnly ->
            time |> Time.toHour zone |> iToS2

        HourMinute ->
            (time |> Time.toHour zone |> iToS2)
                ++ ":"
                ++ (time |> Time.toMinute zone |> iToS2)

        HourSecond ->
            (time |> Time.toHour zone |> iToS2)
                ++ ":"
                ++ (time |> Time.toMinute zone |> iToS2)
                ++ ":"
                ++ (time |> Time.toSecond zone |> iToS2)

        HourMilli ->
            (time |> Time.toHour zone |> iToS2)
                ++ ":"
                ++ (time |> Time.toMinute zone |> iToS2)
                ++ ":"
                ++ (time |> Time.toSecond zone |> iToS2)
                ++ "."
                ++ (time |> Time.toMillis zone |> iToS3)

        Hour ->
            (time |> toString Day zone)
                ++ "T"
                ++ (time |> toString HourOnly zone)

        Minute ->
            (time |> toString Day zone)
                ++ "T"
                ++ (time |> toString HourMinute zone)

        Second ->
            (time |> toString Day zone)
                ++ "T"
                ++ (time |> toString HourSecond zone)

        Milli ->
            (time |> toString Day zone)
                ++ "T"
                ++ (time |> toString HourMilli zone)
