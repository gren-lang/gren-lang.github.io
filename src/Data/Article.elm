module Data.Article exposing (Article, decoder, filePaths)

import DataSource exposing (DataSource)
import DataSource.Glob as Glob
import OptimizedDecoder as Decode exposing (Decoder)


type alias Article =
    { title : String
    , body : String
    , date : String
    , slug : String
    }


filePaths : DataSource (List String)
filePaths =
    Glob.succeed (\prefix filename suffix -> prefix ++ filename ++ suffix)
        |> Glob.capture (Glob.literal "articles/")
        |> Glob.capture Glob.wildcard
        |> Glob.capture (Glob.literal ".md")
        |> Glob.toDataSource


decoder : String -> Decoder Article
decoder body =
    Decode.map3
        (\title date slug ->
            { title = title
            , body = body
            , date = date
            , slug = slug
            }
        )
        (Decode.field "title" Decode.string)
        (Decode.field "date" Decode.string)
        (Decode.field "slug" Decode.string)
