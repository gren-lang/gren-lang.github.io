module Data.GuideChapter exposing (Chapter, decoder, filePaths)

import DataSource exposing (DataSource)
import DataSource.Glob as Glob
import OptimizedDecoder as Decode exposing (Decoder)


type alias Chapter =
    { title : String
    , slug : String
    , body : String
    }


type alias File =
    { name : String
    , path : String
    }


filePaths : DataSource (List File)
filePaths =
    Glob.succeed
        (\prefix filename suffix ->
            { name = filename
            , path =
                prefix ++ filename ++ suffix
            }
        )
        |> Glob.capture (Glob.literal "guide/")
        |> Glob.capture Glob.wildcard
        |> Glob.capture (Glob.literal ".md")
        |> Glob.toDataSource


decoder : String -> String -> Decoder Chapter
decoder filename body =
    Decode.map
        (\title ->
            { title = title
            , slug = filename
            , body = body
            }
        )
        (Decode.field "title" Decode.string)
