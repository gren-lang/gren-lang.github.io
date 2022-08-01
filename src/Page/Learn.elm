module Page.Learn exposing (Data, Model, Msg, page)

import DataSource
import Head
import Head.Seo as Seo
import Html exposing (Html)
import Html.Attributes as Attribute
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


type alias Data =
    ()


page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data = DataSource.succeed ()
        }
        |> Page.buildNoState { view = view }


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = Site.name
        , image = Site.defaultImage
        , description = "Learn how to program in Gren"
        , locale = Nothing
        , title = Site.subTitle "Learn"
        }
        |> Seo.website


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View msg
view _ _ _ =
    { title = Site.subTitle "Learn"
    , body =
        [ Html.h3 []
            [ Html.text "Learn" ]
        , resources
        ]
    }


resources : Html msg
resources =
    Html.div []
        [ Html.p []
            [ Html.text "If you're new to the Gren programming language, the best way to learn is to read "
            , Html.a
                [ Attribute.href "https://gren-lang.org/book"
                , Attribute.title "The Gren Programming Language"
                ]
                [ Html.text "the book" ]
            , Html.text "."
            ]
        , Html.p []
            [ Html.text "Once you understand the basics, you might want to take a look at a few "
            , Html.a
                [ Attribute.href "https://github.com/gren-lang/example-projects"
                , Attribute.title "example projects"
                ]
                [ Html.text "example projects" ]
            , Html.text " to get a better idea on the sort of things you can do."
            ]
        , Html.p []
            [ Html.text "You can also look at "
            , Html.a
                [ Attribute.href "https://github.com/gren-lang"
                , Attribute.title "Gren's GitHub Organization"
                ]
                [ Html.text "Gren's GitHub Organization" ]
            , Html.text " page to see all the different packages you can use in your applications."
            ]
        , Html.p []
            [ Html.text "If you need any help along the way, or just want to chat with other people "
            , Html.text "who're enthusiastic about Gren, then you can join our "
            , Html.a
                [ Attribute.href "https://gren.zulipchat.com/"
                , Attribute.title "Join our community at Zulip"
                ]
                [ Html.text "Zulip" ]
            , Html.text "."
            ]
        , Html.p []
            [ Html.i []
                [ Html.text "Note: The book is still a work in progress. Large sections are unfinished or simply missing. This will improve in time." ]
            ]
        ]
