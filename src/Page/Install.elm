module Page.Install exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
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
        , description = "Get started with Gren"
        , locale = Nothing
        , title = Site.subTitle "Install"
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
    { title = Site.subTitle "Install"
    , body =
        [ Html.h3 []
            [ Html.text "Install" ]
        , Html.p []
            [ Html.text "The latest version of the Gren compiler is 0.4.5 ("
            , Html.a
                [ Attribute.href "https://github.com/gren-lang/compiler/releases/tag/0.4.5"
                , Attribute.title "Read the changelog for Gren 0.4.5"
                ]
                [ Html.text "changelog" ]
            , Html.text ")."
            ]
        , Html.p []
            [ Html.text "The fastest way to install the compiler is through NPM:"
            ]
        , Html.pre []
            [ Html.text " > npm install -g gren-lang"
            ]
        , Html.p []
            [ Html.text "It's also possible to use "
            , Html.a
                [ Attribute.href "https://asdf-vm.com"
                , Attribute.title "The asdf runtime manager"
                ]
                [ Html.text "asdf" ]
            , Html.text " with the "
            , Html.a
                [ Attribute.href "https://github.com/eberfreitas/asdf-gren"
                , Attribute.title "Gren plugin for asdf"
                ]
                [ Html.text "asdf-gren" ]
            , Html.text " plugin."
            ]
        , Html.p []
            [ Html.text "If none of these work for you, then you can always build your own compiler "
            , Html.a
                [ Attribute.href "https://github.com/gren-lang/compiler"
                , Attribute.title "Compile the compiler from source"
                ]
                [ Html.text "from source" ]
            , Html.text "."
            ]
        , Html.p []
            [ Html.text "Once you have the compiler installed on your system, it is time to "
            , Html.a
                [ Attribute.href "/learn"
                , Attribute.title "learning resources"
                ]
                [ Html.text "learn the language" ]
            , Html.text "."
            ]
        ]
    }
