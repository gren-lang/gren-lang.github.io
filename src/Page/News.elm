module Page.News exposing (Data, Model, Msg, page)

import Date
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
            [ Html.text "Here you can find news related to the "
            , Html.a
                [ Attribute.href "https://github.com/gren-lang/compiler"
                , Attribute.title "Github repository of the Gren compiler"
                ]
                [ Html.text "compiler" ]
            , Html.text " and "
            , Html.a
                [ Attribute.href "https://github.com/gren-lang"
                , Attribute.title "Gren's github organization"
                ]
                [ Html.text "core packages" ]
            , Html.text "."
            ]
        , Html.p []
            [ Html.text "For more frequent news regarding the community, development of Gren"
            , Html.text " and other things, consider following us on "
            , Html.a
                [ Attribute.href "https://twitter.com/gren_lang"
                , Attribute.title "Follow us on Twitter"
                ]
                [ Html.text "twitter" ]
            , Html.text " and join our "
            , Html.a
                [ Attribute.href "https://gren.zulipchat.com/"
                , Attribute.title "Join our Zulip"
                ]
                [ Html.text "Zulip" ]
            , Html.text "."
            ]
        ]
            ++ List.map viewArticle static.data
    }


viewArticle : Article -> Html msg
viewArticle article =
    Html.article []
        [ Html.header []
            [ Html.h4 [] [ Html.text article.title ]
            , Html.small [] [ Html.text <| "Published: " ++ Date.toIsoString article.published ]
            ]
        , Html.p []
            [ Html.text article.description ]
        , Html.small []
            [ Html.a
                [ Attribute.href <| "/news/" ++ article.slug
                , Attribute.title <| "Read the rest of '" ++ article.title ++ "'"
                ]
                [ Html.text "Continue reading" ]
            ]
        ]
