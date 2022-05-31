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
            [ Html.text "The latest version of Gren is 0.1.0. You can find the compiler binary for your OS at "
            , Html.a
                [ Attribute.href "https://github.com/gren-lang/compiler/releases/tag/v0.1.0"
                , Attribute.title "Download the v0.1.0 compiler from Github"
                ]
                [ Html.text "GitHub" ]
            , Html.text "."
            ]
        , Html.p []
            [ Html.text "If you're interested in trying out the latest, though unstable, compiler then you can find builds of the main branch "
            , Html.a
                [ Attribute.href "https://github.com/gren-lang/compiler/actions/workflows/releases.yml"
                , Attribute.title "Download the latest compiler from Github"
                ]
                [ Html.text "here" ]
            , Html.text "."
            ]
        , Html.p []
            [ Html.text "Once you have the binary, you'll need to give it permission to execute and place it somewhere in your PATH. Below is an example for Mac OS." ]
        , Html.pre []
            [ multilineHtmlText """
              chmod +x gren_mac
              mv gren_mac /usr/local/bin/gren
              """
            ]
        , Html.p []
            [ Html.text "You should now be able to execute the 'gren' command and see a friendly greeting." ]
        , Html.p []
            [ Html.text "If you don't know what to do next, check out the "
            , Html.a
                [ Attribute.href "/learn"
                , Attribute.title "language guide"
                ]
                [ Html.text "official language guide" ]
            , Html.text "."
            ]
        ]
    }


multilineHtmlText : String -> Html a
multilineHtmlText input =
    input
        |> String.lines
        |> List.map String.trim
        |> List.filter (not << String.isEmpty)
        |> List.map (\s -> " " ++ s)
        |> String.join "\n"
        |> Html.text
