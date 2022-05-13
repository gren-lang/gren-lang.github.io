module Page.News exposing (Data, Model, Msg, page)

import Data.Article as Article exposing (Article)
import DataSource exposing (DataSource)
import DataSource.File as File
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
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "Gren"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "Gren logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "News from the Gren core team"
        , locale = Nothing
        , title = "Gren - News"
        }
        |> Seo.website


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View msg
view _ _ static =
    { title = "Gren - News"
    , body =
        [ Html.h3 []
            [ Html.text "News" ]
        , Html.p []
            [ Html.text "Here you can find announcements from the Gren core team. For more news, be sure to checkout our Twitter and join our Zulip instance." ]
        ]
            ++ List.map viewArticle static.data
    }


viewArticle : Article -> Html msg
viewArticle article =
    let
        firstParagraph =
            article.body
                |> String.trim
                |> String.lines
                |> List.head
                |> Maybe.withDefault ""
    in
    Html.article []
        [ Html.h4 [] [ Html.text article.title ]
        , Html.p [] [ Html.text article.date ]
        , Html.p [] [ Html.text firstParagraph ]
        , Html.a
            [ Attribute.href <| "/news/" ++ article.slug ]
            [ Html.text "Continue reading" ]
        ]
