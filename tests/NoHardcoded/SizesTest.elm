module NoHardcoded.SizesTest exposing (all)

import NoHardcoded.Sizes exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


message : String
message =
    "REPLACEME"


details : List String
details =
    [ "REPLACEME" ]


all : Test
all =
    describe "NoHardcoded.Sizes"
        [ testForSize "px"
        , testForSize "em"
        , testForSize "pt"
        , testForSize "ex"
        , testForSize "ch"
        , testForSize "rem"
        , testForSize "vh"
        , testForSize "vw"
        , testForSize "vmin"
        , testForSize "vmax"
        , testForSize "mm"
        , testForSize "cm"
        , testForSize "inches"
        , testForSize "pc"
        ]


testForSize : String -> Test
testForSize functionName =
    test ("should report an error when using Css." ++ functionName) <|
        \() ->
            """module A exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Css

view = div [ css [ Css.width (Css."""
                ++ functionName
                ++ """ 1) ] ]
"""
                |> Review.Test.run rule
                |> Review.Test.expectErrors
                    [ Review.Test.error
                        { message = message
                        , details = details
                        , under = "Css." ++ functionName
                        }
                    ]
