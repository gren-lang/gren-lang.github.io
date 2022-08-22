module Page.News exposing (Data, Model, Msg, page)

import Data.Article as Article exposing (Article)
import DataSource exposing (DataSource)
import Date
import Head
import Head.Seo as Seo
import Html exposing (Html)
import Html.Attributes as Attribute
import Markdown.Parser
import Markdown.Renderer
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Shared
import Site
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
    Article.all


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = Site.name
        , image = Site.defaultImage
        , description = "News from the Gren core team"
        , locale = Nothing
        , title = Site.subTitle "News"
        }
        |> Seo.website


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View msg
view _ _ static =
    { title = Site.subTitle "News"
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
            [ Html.text "For more news regarding the community, development of Gren"
            , Html.text " and other things, consider following us on "
            , Html.a
                [ Attribute.href "https://twitter.com/gren_lang"
                , Attribute.title "Follow us on Twitter"
                ]
                [ Html.text "Twitter" ]
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
    let
        renderedDescription =
            case Markdown.Parser.parse article.description of
                Ok markdown ->
                    case Markdown.Renderer.render Markdown.Renderer.defaultHtmlRenderer markdown of
                        Ok html ->
                            html

                        Err _ ->
                            [ Html.text article.description ]

                Err _ ->
                    [ Html.text article.description ]
    in
    Html.article []
        [ Html.header []
            [ Html.h4 [] [ Html.text article.title ]
            , Html.small [] [ Html.text <| "Published: " ++ Date.toIsoString article.published ]
            ]
        , Html.p []
            renderedDescription
        , Html.small []
            [ Html.a
                [ Attribute.href <| "/news/" ++ article.slug
                , Attribute.title <| "Read the rest of '" ++ article.title ++ "'"
                ]
                [ Html.text "Continue reading" ]
            ]
        ]
