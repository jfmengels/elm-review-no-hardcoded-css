module NoStyleTest exposing (all)

import NoStyle exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


message : String
message =
    "Do not use the style function"


details : List String
details =
    [ "TailWind provides functions to do all that you need to do with CSS, and using `style` makes it harder to see what is happening."
    ]


all : Test
all =
    describe "NoStyle"
        [ test "should report an error when using TW.style" <|
            \() ->
                """module A exposing (..)
import TW
a = div [ TW.style "color: red" ] [ text "Hello" ]
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "TW.style"
                            }
                        ]
        , test "should report an error when using TW.style using an alias" <|
            \() ->
                """module A exposing (..)
import TW as T
a = div [ T.style "color: red" ] [ text "Hello" ]
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "T.style"
                            }
                        ]
        ]
