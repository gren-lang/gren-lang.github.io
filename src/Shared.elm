module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

import Browser.Navigation
import DataSource
import Html exposing (Html)
import Html.Attributes as Attributes
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Path exposing (Path)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Just OnPageChange
    }


type Msg
    = OnPageChange
        { path : Path
        , query : Maybe String
        , fragment : Maybe String
        }
    | SharedMsg SharedMsg


type alias Data =
    ()


type SharedMsg
    = NoOp


type alias Model =
    {}


init :
    Maybe Browser.Navigation.Key
    -> Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : Path
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Cmd Msg )
init _ _ _ =
    ( {}
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnPageChange _ ->
            ( model, Cmd.none )

        SharedMsg _ ->
            ( model, Cmd.none )


subscriptions : Path -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


view :
    Data
    ->
        { path : Path
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : Html msg, title : String }
view _ _ _ _ pageView =
    { title = pageView.title
    , body =
        Html.main_ []
            [ Html.header
                []
                [ Html.nav
                    [ Attributes.class "container" ]
                    [ Html.a
                        [ Attributes.href "/"
                        , Attributes.title "Learn more about Gren"
                        ]
                        [ Html.img
                            [ Attributes.src "/big_icon.png"
                            , Attributes.alt "Robin, the Gren mascot"
                            ]
                            []
                        ]
                    , Html.ul
                        [ Attributes.class "navigation-list float-right" ]
                        navLinks
                    , Html.span
                        [ Attributes.class "navigation-icon float-right" ]
                        [ Html.label
                            [ Attributes.for "navigation-menu-checkbox" ]
                            [ Html.text "☰" ]
                        , Html.input
                            [ Attributes.id "navigation-menu-checkbox"
                            , Attributes.type_ "checkbox"
                            ]
                            []
                        , Html.ul
                            [ Attributes.class "mobile-navigation-list" ]
                            navLinks
                        ]
                    ]
                ]
            , Html.section
                [ Attributes.class "container content" ]
                pageView.body
            , Html.footer []
                [ Html.small
                    [ Attributes.class "container" ]
                    [ Html.text "Copyright © 2023, The Gren Contributors" ]
                ]
            ]
    }


type alias NavLink =
    { label : String
    , link : String
    , title : String
    }


navLinks : List (Html msg)
navLinks =
    [ navLink
        { label = "Install"
        , link = "/install"
        , title = "Get the compiler setup on your machine"
        }
    , navLink
        { label = "Learn"
        , link = "/learn"
        , title = "Learn how to write Gren code"
        }
    , navLink
        { label = "Community"
        , link = "/community"
        , title = "Ask questions, discuss ideas and contribute in our community"
        }
    , navLink
        { label = "News"
        , link = "/news"
        , title = "Read the latest news from the core team"
        }
    ]


navLink : NavLink -> Html msg
navLink options =
    Html.li
        [ Attributes.class "navigation-listitem" ]
        [ Html.a
            [ Attributes.href options.link
            , Attributes.title options.title
            ]
            [ Html.text options.label ]
        ]
