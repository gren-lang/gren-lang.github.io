module Data.Article exposing (Article, decoder)

import OptimizedDecoder as Decode exposing (Decoder)


type alias Article =
    { body : String
    , title : String
    , date : String
    }


decoder : String -> Decoder Article
decoder body =
    Decode.map2 (Article body)
        (Decode.field "title" Decode.string)
        (Decode.field "date" Decode.string)
