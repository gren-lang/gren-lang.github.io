module Page.Install exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import Head
import Head.Seo as Seo
import Html
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
        [ Html.article []
            [ Html.h3 []
                [ Html.text "Install" ]
            , Html.p []
                [ Html.text "The latest version of the Gren compiler is "
                , Html.a
                    [ Attribute.href "https://github.com/gren-lang/compiler/releases/tag/0.6.2"
                    , Attribute.title "Read the changelog"
                    ]
                    [ Html.text "0.6.2" ]
                ]
            , Html.p []
                [ Html.text "You can install the compiler with "
                , Html.a
                    [ Attribute.href "https://www.npmjs.com/package/gren-lang"
                    , Attribute.title "Node package manager"
                    ]
                    [ Html.text "npm" ]
                , Html.text ":"
                ]
            , Html.pre []
                [ Html.text " > npm install -g gren-lang"
                ]
            , Html.p []
                [ Html.text "Or "
                , Html.a
                    [ Attribute.href "https://search.nixos.org/packages?channel=unstable&show=gren&from=0&size=50&sort=relevance&type=packages&query=gren"
                    , Attribute.title "Nix package manager"
                    ]
                    [ Html.text "nix" ]
                , Html.text ":"
                ]
            , Html.pre []
                [ Html.text " > nix-shell -p gren"
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
            ]
        , Html.article []
            [ Html.h3 []
                [ Html.text "Editor support" ]
            , Html.p [] [ Html.text "Syntax highlighting is supported in several editors:" ]
            , Html.ul []
                [ Html.li []
                    [ Html.a
                        [ Attribute.href "https://github.com/MaeBrooks/tree-sitter-gren/tree/main/editors/nvim"
                        , Attribute.title "Gren support for NeoVim"
                        ]
                        [ Html.text "NeoVim" ]
                    ]
                , Html.li []
                    [ Html.a
                        [ Attribute.href "https://github.com/MaeBrooks/gren-mode"
                        , Attribute.title "Gren support for Emacs"
                        ]
                        [ Html.text "Emacs" ]
                    ]
                , Html.li []
                    [ Html.text "Helix (built-in)"
                    ]
                , Html.li []
                    [ Html.a
                        [ Attribute.href "https://github.com/MaeBrooks/tree-sitter-gren/blob/main/editors/zed"
                        , Attribute.title "Gren support for Zed"
                        ]
                        [ Html.text "Zed" ]
                    ]
                ]
            , Html.p []
                [ Html.text "Any editor that supports tree-sitter grammars can use "
                , Html.a
                    [ Attribute.href "https://github.com/MaeBrooks/tree-sitter-gren"
                    , Attribute.title "Tree-sitter grammar for Gren"
                    ]
                    [ Html.text "tree-sitter-gren" ]
                , Html.text "."
                ]
            ]
        ]
    }
