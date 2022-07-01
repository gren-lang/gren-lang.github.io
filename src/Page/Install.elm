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
            [ Html.text "The latest version of the Gren compiler is 0.1.0."
            ]
        , Html.p []
            [ Html.text "There are several ways to install this on your system." ]
        , Html.p []
            [ Html.text "If you already have NodeJS and NPM installed on your system, the fastest way to get Gren installed is by downloading the "
            , Html.a
                [ Attribute.href "https://www.npmjs.com/package/gren-lang"
                , Attribute.title "Download Gren from NPM"
                ]
                [ Html.text "NPM package" ]
            , Html.text ". "
            , Html.text "If you do, then you don't need to read the rest of this document."
            ]
        , Html.p []
            [ Html.text "If you don't have, or prefer not to use, NPM then you can find pre-compiled binaries for Windows, Mac OS and Linux at "
            , Html.a
                [ Attribute.href "https://github.com/gren-lang/compiler/releases/tag/v0.1.0"
                , Attribute.title "Download the v0.1.0 compiler from Github"
                ]
                [ Html.text "GitHub" ]
            , Html.text ". "
            , Html.text "If you're interested in trying out the latest unstable compiler, then you can find builds of the "
            , Html.a
                [ Attribute.href "https://github.com/gren-lang/compiler/actions/workflows/releases.yml"
                , Attribute.title "Download the latest compiler from Github"
                ]
                [ Html.text "main branch" ]
            , Html.text " here as well."
            ]
        , Html.p []
            [ Html.text "If none of these options work for you, then you can always build your own compiler "
            , Html.a
                [ Attribute.href "https://github.com/gren-lang/compiler"
                , Attribute.title "Compile the compiler from source"
                ]
                [ Html.text "from source" ]
            , Html.text "."
            ]
        , Html.p []
            [ Html.text "Once you have the binary, you'll need to give it permission to execute and place it somewhere in your PATH. Below is an example for Mac OS:" ]
        , Html.pre []
            [ multilineHtmlText """
              chmod +x gren_mac
              mv gren_mac /usr/local/bin/gren
              """
            ]
        , Html.p []
            [ Html.text "You should now be able to execute the "
            , Html.code [] [ Html.text "gren" ]
            , Html.text " command and see a friendly greeting."
            ]
        , Html.p []
            [ Html.text "If you haven't done so already, now is the time to check out the "
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
