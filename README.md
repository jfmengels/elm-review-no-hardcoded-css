# elm-review-no-hardcoded-css

Provides [`elm-review`](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/) rules to prevents hardcoding CSS values.


## Provided rules

- [`NoStyle`](https://package.elm-lang.org/packages/jfmengels/elm-review-no-hardcoded-css/1.0.0/NoStyle) - Reports REPLACEME.
- [`NoHardcoded.Sizes`](https://package.elm-lang.org/packages/jfmengels/elm-review-no-hardcoded-css/1.0.0/NoHardcoded-Sizes) - Reports hardcoded sizes.


## Configuration

```elm
module ReviewConfig exposing (config)

import NoHardcoded.Sizes
import NoStyle
import Review.Rule exposing (Rule)

config : List Rule
config =
    [ NoHardcoded.Sizes.rule
    , NoStyle.rule
    ]
```


## Try it out

You can try the example configuration above out by running the following command:

```bash
elm-review --template jfmengels/elm-review-no-hardcoded-css/example
```
