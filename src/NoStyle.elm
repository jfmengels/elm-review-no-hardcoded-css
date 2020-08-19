module NoStyle exposing (rule)

{-|

@docs rule

-}

import Elm.Syntax.Expression exposing (Expression)
import Elm.Syntax.Node exposing (Node)
import Review.Rule as Rule exposing (Error, Rule)
import Scope


{-| Reports... REPLACEME

    config =
        [ NoStyle.rule
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
elm - review --template jfmengels/elm-review-no-hardcoded-css/example --rules NoStyle
```

-}
rule : Rule
rule =
    Rule.newModuleRuleSchema "NoStyle" initialContext
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
    ( [], context )
