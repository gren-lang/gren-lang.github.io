module Data.Article exposing (Article, decoder, filePaths)

import DataSource exposing (DataSource)
import DataSource.Glob as Glob
import OptimizedDecoder as Decode exposing (Decoder)


type alias Article =
    { body : String
    , title : String
    , date : String
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
    Decode.map2 (Article body)
        (Decode.field "title" Decode.string)
        (Decode.field "date" Decode.string)
