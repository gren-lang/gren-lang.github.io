module Page.Index exposing (Data, Model, Msg, page)

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
        , description = "A pure functional language for writing simple and correct applications"
        , locale = Nothing
        , title = "Gren"
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
    { title = "Gren"
    , body =
        [ Html.div
            [ Attribute.id "banner" ]
            [ Html.img
                [ Attribute.src "/bigbird.png"
                , Attribute.alt "Robin, the Gren mascot"
                ]
                []
            ]
        , Html.article
            []
            [ Html.h3 []
                [ Html.text "A programming language for simple and correct applications" ]
            , Html.p []
                [ Html.text "Gren is a functional programming language with carefully managed side-effects and a strong static type system. The language consists of a few concepts with human readable names that compose well together, so you can do more with less." ]
            , Html.p []
                [ Html.text "Programs written in Gren are simple, have few or no runtime exceptions and are fun to work with." ]
            ]
        , Html.article
            []
            [ Html.h3 []
                [ Html.text "Runs Anywhere" ]
            , Html.pre []
                [ Html.code [] 
                    [ Html.text 
                        """viewItems : Array String -> String
viewItems items =
    items
        |> Array.sort
        |> String.join ", "
"""
                    ]
                ]
            , Html.p []
                [ Html.text "In the "
                , Html.a 
                    [ Attribute.href "https://packages.gren-lang.org/package/gren-lang/browser/version/latest/overview" ]
                    [ Html.text "browser:" ]
                ]
            , Html.pre []
                [ Html.code [] 
                    [ Html.text 
                        """Html.p [] [ Html.text (viewItems model.items) ]"""
                    ]
                ]
            , Html.p []
                [ Html.text "In the "
                , Html.a 
                    [ Attribute.href "https://packages.gren-lang.org/package/gren-lang/node/version/latest/overview" ]
                    [ Html.text "terminal:" ]
                ]
            , Html.pre []
                [ Html.code [] 
                    [ Html.text 
                        """Stream.writeLineAsBytes (viewItems model.items) model.stdout"""
                    ]
                ]
            , Html.p []
                [ Html.text "On the "
                , Html.a 
                    [ Attribute.href "https://packages.gren-lang.org/package/gren-lang/node/version/latest/module/HttpServer" ]
                    [ Html.text "server:" ]
                ]
            , Html.pre []
                [ Html.code [] 
                    [ Html.text 
                        """response
    |> Response.setHeader "Content-type" "text/csv"
    |> Response.setBody (viewItems model.items)
    |> Response.send
"""
                    ]
                ]
            ]
        , Html.article
            []
            [ Html.h3 []
                [ Html.text "Compiler as an assistant" ]
            , Html.p []
                [ Html.text "Since side effects and error handling is represented in Gren's type system, the compiler can catch a lot of errors which are usually only discovered when the program is running in other languages." ]
            , Html.p []
                [ Html.text "In Gren, a lot of time has been invested in how error messages are presented to you, so that the compiler feels more like a helpful assistant." ]
            , Html.pre []
                [ Html.code []
                    [ Html.span
                        [ Attribute.style "color" "rgb(36, 163, 175)" ]
                        [ Html.text "-- TYPE MISMATCH ------------------------------------------------- src/Main.gren\n\n" ]
                    , Html.text "The 1st argument to `viewItems` is not what I expect:\n\n14|    Html.text (\"Item IDs: \" ++ (viewItems [1, 2, 3]))\n"
                    , Html.span
                        [ Attribute.style "color" "rgb(194, 54, 33)" ]
                        [ Html.text <| (String.repeat 45 " ") ++ "^^^^^^^^^\n" ]
                    , Html.text "This argument is an array of type:\n\n    Array "
                    , Html.span
                        [ Attribute.style "color" "rgb(173, 173, 39)" ]
                        [ Html.text "number\n\n" ]
                    , Html.text "But `viewItems` needs the 1st argument to be:\n\n    Array "
                    , Html.span
                        [ Attribute.style "color" "rgb(173, 173, 39)" ]
                        [ Html.text "String\n\n" ]
                    , Html.span
                        [ Attribute.style "text-decoration" "underline" ]
                        [ Html.text "Hint" ]
                    , Html.text ": Try using ", Html.span
                        [ Attribute.style "color" "rgb(40, 187, 28)" ]
                        [ Html.text "String.fromInt" ]
                    , Html.text " to convert it to a String?" 
                    ]
                ]
            ]
        , Html.article
            []
            [ Html.h3 []
                [ Html.text "Efficiency" ]
            , Html.p []
                [ Html.text "Gren produces small JavaScript files, and runs surprisingly fast. Applications written in Gren can be both smaller and faster than your average React-based application." ]
            ]
        ]
    }
