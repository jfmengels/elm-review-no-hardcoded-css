module NoHardcoded.Sizes exposing (rule)

{-|

@docs rule

-}

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Review.Rule as Rule exposing (Error, Rule)
import Scope
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
    Rule.newModuleRuleSchema "NoHardcoded.Sizes" initialContext
        |> Scope.addModuleVisitors
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { scope : Scope.ModuleContext
    }


initialContext : Context
initialContext =
    { scope = Scope.initialModuleContext
    }


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case Node.value node of
        Expression.FunctionOrValue moduleName name ->
            if
                Set.member name sizeFunctions
                    && (Scope.moduleNameForValue context.scope name moduleName == [ "Css" ])
            then
                ( [ Rule.error
                        { message = "REPLACEME"
                        , details = [ "REPLACEME" ]
                        }
                        (Node.range node)
                  ]
                , context
                )

            else
                ( [], context )

        _ ->
            ( [], context )


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
