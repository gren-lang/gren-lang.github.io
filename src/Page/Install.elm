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
                [ Html.text "The latest version of the Gren compiler is 0.5.3."
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
                , Html.text " plugin. "
                , Html.a
                    [ Attribute.href "https://www.jetify.com/devbox"
                    , Attribute.title "Devbox package manager"
                    ]
                    [ Html.text "devbox" ]
                , Html.text " and "
                , Html.a
                    [ Attribute.href "https://nixos.org"
                    , Attribute.title "Nix package manager"
                    ]
                    [ Html.text "nix" ]
                , Html.text " support is available with this "
                , Html.a
                    [ Attribute.href "https://github.com/gren-lang/nix"
                    , Attribute.title "nix-flake for Gren"
                    ]
                    [ Html.text "nix flake" ]
                , Html.text "."
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
                    [ Html.a
                        [ Attribute.href "https://github.com/MaeBrooks/tree-sitter-gren/tree/main/editors/helix"
                        , Attribute.title "Gren support for Helix"
                        ]
                        [ Html.text "Helix" ]
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
