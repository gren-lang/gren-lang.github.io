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
    { showMobileMenu : Bool
    }


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
init navigationKey flags maybePagePath =
    ( { showMobileMenu = False }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnPageChange _ ->
            ( { model | showMobileMenu = False }, Cmd.none )

        SharedMsg globalMsg ->
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
view sharedData page model toMsg pageView =
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
                        [ Html.text "Gren" ]
                    , Html.ul
                        [ Attributes.class "navigation-list float-right" ]
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
                            { label = "Blog"
                            , link = "/blog"
                            , title = "Read the latest news from the core team"
                            }
                        ]
                    ]
                ]
            , Html.section
                [ Attributes.class "container content" ]
                pageView.body
            , Html.footer []
                [ Html.small
                    [ Attributes.class "container" ]
                    [ Html.text "Copyright © 2022, The Gren Contributors" ]
                ]
            ]
    }


type alias NavLink =
    { label : String
    , link : String
    , title : String
    }


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
