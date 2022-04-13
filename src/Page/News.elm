module Page.News exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import DataSource.File as File
import DataSource.Glob as Glob
import Head
import Head.Seo as Seo
import Html exposing (Html)
import OptimizedDecoder as Decode exposing (Decoder)
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    {}


page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildNoState { view = view }


type alias Data =
    List Article


type alias Article =
    { body : String
    , title : String
    , date : String
    }


articleDecoder : String -> Decoder Article
articleDecoder body =
    Decode.map2 (Article body)
        (Decode.field "title" Decode.string)
        (Decode.field "date" Decode.string)


data : DataSource Data
data =
    Glob.succeed (\prefix filename suffix -> prefix ++ filename ++ suffix)
        |> Glob.capture (Glob.literal "articles/")
        |> Glob.capture Glob.wildcard
        |> Glob.capture (Glob.literal ".md")
        |> Glob.toDataSource
        |> DataSource.map
            (List.map (File.bodyWithFrontmatter articleDecoder))
        |> DataSource.resolve


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "TODO title" -- metadata.title -- TODO
        }
        |> Seo.website


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View msg
view maybeUrl sharedModel static =
    { title = "Gren - News"
    , body =
        [ Html.h1 []
            [ Html.text "News" ]
        , Html.ul []
            (List.map viewArticle static.data)
        ]
    }


viewArticle : Article -> Html msg
viewArticle article =
    Html.li []
        [ Html.text article.body ]
