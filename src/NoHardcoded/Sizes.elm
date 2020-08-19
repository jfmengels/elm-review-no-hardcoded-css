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

    import Css

    a =
        div
            [ css [ Css.width (Css.px 8) ]
            ]
            [ text "Hello" ]


## Success

    import Css
    import DesignSystem

    a =
        div
            [ css [ Css.width DesignSystem.medium ]
            ]
            [ text "Hello" ]


## When (not) to enable this rule

This rule is useful when your project has modules that sets standard sizes for all elements, in order to respect a design system.


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
                        { message = "Do not hardcode sizes using this function"
                        , details = [ "Your project has a specific module that sets the design standards, and you should use that." ]
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
