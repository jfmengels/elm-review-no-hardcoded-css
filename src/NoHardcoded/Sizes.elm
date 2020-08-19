module NoHardcoded.Sizes exposing (rule)

{-|

@docs rule

-}

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Review.Rule as Rule exposing (Error, Rule)
import Set exposing (Set)


{-| Reports... REPLACEME

    config =
        [ NoHardcoded.Sizes.rule
        ]


## Fail

    a =
        "REPLACEME example to replace"


## Success

    a =
        "REPLACEME example to replace"


## When (not) to enable this rule

This rule is useful when REPLACEME.
This rule is not useful when REPLACEME.


## Try it out

You can try this rule out by running the following command:

```bash
elm - review --template jfmengels/elm-review-no-hardcoded-css/example --rules NoHardcoded.Sizes
```

-}
rule : Rule
rule =
    Rule.newModuleRuleSchema "NoHardcoded.Sizes" ()
        |> Rule.withSimpleExpressionVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


expressionVisitor : Node Expression -> List (Error {})
expressionVisitor node =
    case Node.value node of
        Expression.FunctionOrValue [ "Css" ] name ->
            if Set.member name sizeFunctions then
                [ Rule.error
                    { message = "REPLACEME"
                    , details = [ "REPLACEME" ]
                    }
                    (Node.range node)
                ]

            else
                []

        _ ->
            []


sizeFunctions : Set String
sizeFunctions =
    Set.fromList
        [ "px"
        , "em"
        , "pt"
        , "ex"
        , "ch"
        , "rem"
        , "vh"
        , "vw"
        , "vmin"
        , "vmax"
        , "mm"
        , "cm"
        , "inches"
        , "pc"
        ]
