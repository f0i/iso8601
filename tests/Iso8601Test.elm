module Iso8601Test exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Iso8601
import Test exposing (..)
import Time exposing (Posix)


time =
    Time.millisToPosix 1584875883199


time2 =
    Time.millisToPosix 1588082963012


suite : Test
suite =
    describe "The Iso8601 module"
        [ describe "Format posix time"
            -- Nest as many descriptions as you like.
            [ test "epoch" <|
                \_ ->
                    Time.millisToPosix 0
                        |> Iso8601.toUtcString Iso8601.Milli
                        |> Expect.equal "1970-01-01T00:00:00.000"
            , test "Year" <|
                \_ ->
                    time
                        |> Iso8601.toUtcString Iso8601.Year
                        |> Expect.equal "2020"
            , test "Month" <|
                \_ ->
                    time
                        |> Iso8601.toUtcString Iso8601.Month
                        |> Expect.equal "2020-03"
            , test "Day" <|
                \_ ->
                    time
                        |> Iso8601.toUtcString Iso8601.Day
                        |> Expect.equal "2020-03-22"
            , test "Hour" <|
                \_ ->
                    time
                        |> Iso8601.toUtcString Iso8601.Hour
                        |> Expect.equal "2020-03-22T11"
            , test "Minute" <|
                \_ ->
                    time
                        |> Iso8601.toUtcString Iso8601.Minute
                        |> Expect.equal "2020-03-22T11:18"
            , test "Second" <|
                \_ ->
                    time
                        |> Iso8601.toUtcString Iso8601.Second
                        |> Expect.equal "2020-03-22T11:18:03"
            , test "Millisecond" <|
                \_ ->
                    time
                        |> Iso8601.toUtcString Iso8601.Milli
                        |> Expect.equal "2020-03-22T11:18:03.199"
            , test "Hour to Millisecond" <|
                \_ ->
                    time
                        |> Iso8601.toUtcString Iso8601.HourMilli
                        |> Expect.equal "11:18:03.199"
            ]
        , describe "Tuples"
            [ test "toTuple" <|
                \_ ->
                    time2
                        |> Iso8601.toTuple Time.utc
                        |> Expect.equal
                            ( ( "2020", "04", "28" ), ( "14", "09", "23" ), "012" )
            ]
        ]
