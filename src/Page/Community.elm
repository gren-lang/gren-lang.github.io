module Page.Community exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import Head
import Head.Seo as Seo
import Html
import Html.Attributes as Attribute
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
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


data : DataSource Data
data =
    DataSource.succeed ()


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = Site.name
        , image = Site.defaultImage
        , description = "Join Gren's community"
        , locale = Nothing
        , title = Site.subTitle "Community"
        }
        |> Seo.website


type alias Data =
    ()


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View msg
view _ _ _ =
    { title = Site.subTitle "Community"
    , body =
        [ Html.h3 []
            [ Html.text "Community" ]
        , Html.p []
            [ Html.text "There are several ways to keep tabs on the Gren community." ]
        , Html.p []
            [ Html.a
                [ Attribute.href "https://discord.gg/J8aaGMfz"
                , Attribute.title "Join us on Discord"
                ]
                [ Html.text "Discord" ]
            , Html.text " is the official meeting place for people who are curious about Gren. "
            , Html.text "The core team posts development updates there at regular intervals, and there are "
            , Html.text "channels for people to ask questions."
            ]
        , Html.p
            []
            [ Html.text "Our official "
            , Html.a
                [ Attribute.href "https://fosstodon.org/@gren_lang"
                , Attribute.title "Follow us on Mastodon"
                ]
                [ Html.text "Mastodon account" ]
            , Html.text " might be worth following if you want to be notified of anything interesting "
            , Html.text "every once in a while."
            ]
        , Html.p
            []
            [ Html.text "If you want to keep up-to-date on the actual development of Gren, "
            , Html.text "you can find the source code and issue-tracker at "
            , Html.a
                [ Attribute.href "https://github.com/gren-lang"
                , Attribute.title "Read the source on Github"
                ]
                [ Html.text "Github" ]
            , Html.text "."
            ]
        ]
    }
