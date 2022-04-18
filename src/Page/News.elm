module Page.News exposing (Data, Model, Msg, page)

import Data.Article as Article exposing (Article)
import DataSource exposing (DataSource)
import DataSource.File as File
import DataSource.Glob as Glob
import Head
import Head.Seo as Seo
import Html exposing (Html)
import Html.Attributes as Attribute
import Page exposing (Page, StaticPayload)
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


data : DataSource Data
data =
    Article.filePaths
        |> DataSource.map
            (List.map (File.bodyWithFrontmatter Article.decoder))
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
        [ Html.a
            [ Attribute.href <| "/news/" ++ article.title ]
            [ Html.text article.title ]
        ]
