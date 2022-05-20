module Data.Article exposing (Article, all, decoder, filePaths)

import DataSource exposing (DataSource)
import DataSource.File as File
import DataSource.Glob as Glob
import Date exposing (Date)
import OptimizedDecoder as Decode exposing (Decoder)


type alias Article =
    { title : String
    , description : String
    , body : String
    , published : Date
    , slug : String
    }


type alias File =
    { path : String
    , name : String
    }


filePaths : DataSource (List File)
filePaths =
    Glob.succeed
        (\prefix filename suffix ->
            { path = prefix ++ filename ++ suffix
            , name = filename
            }
        )
        |> Glob.capture (Glob.literal "articles/")
        |> Glob.capture Glob.wildcard
        |> Glob.capture (Glob.literal ".md")
        |> Glob.toDataSource


all : DataSource (List Article)
all =
    filePaths
        |> DataSource.map
            (List.map (\f -> File.bodyWithFrontmatter (decoder f.name) f.path))
        |> DataSource.resolve
        |> DataSource.map
            (List.sortBy
                (\article -> -(Date.toRataDie article.published))
            )


decoder : String -> String -> Decoder Article
decoder filename body =
    Decode.map2
        (\title published ->
            { title = title
            , description = descriptionFromBody body
            , body = body
            , published = published
            , slug = filename
            }
        )
        (Decode.field "title" Decode.string)
        (Decode.field "published" (Decode.string |> Decode.andThen dateDecoder))


dateDecoder : String -> Decoder Date
dateDecoder value =
    case Date.fromIsoString value of
        Ok date ->
            Decode.succeed date

        Err err ->
            Decode.fail err


descriptionFromBody : String -> String
descriptionFromBody body =
    body
        |> String.trim
        |> String.lines
        |> List.head
        |> Maybe.withDefault ""
