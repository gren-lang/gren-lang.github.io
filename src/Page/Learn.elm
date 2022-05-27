module Page.Learn exposing (Data, Model, Msg, chapterBox, page)

import Data.GuideChapter as GuideChapter exposing (Chapter)
import DataSource exposing (DataSource)
import DataSource.File as File
import Head
import Head.Seo as Seo
import Html exposing (Html)
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


type alias Data =
    List Chapter


page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildNoState { view = view }


data : DataSource Data
data =
    GuideChapter.filePaths
        |> DataSource.map
            (List.map (\file -> File.bodyWithFrontmatter (GuideChapter.decoder file.name) file.path))
        |> DataSource.resolve


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
view _ _ payload =
    { title = Site.subTitle "Learn"
    , body =
        [ Html.h3 []
            [ Html.text "Learn" ]
        , chapterBox Nothing payload.data
        , resources
        ]
    }


resources : Html msg
resources =
    Html.div []
        [ Html.p []
            [ Html.text <|
                String.trim """
                Welcome to the official language guide. It covers everything from why
                you would use Gren, to how you write your first application. To get started, just
                click on a interesting topic in the table of contents.
                """
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
                [ Html.text "Note: This language guide is still a work in progress. Large sections are unfished or simply missing. This will improve in time." ]
            ]
        ]


chapterBox : Maybe Chapter -> List Chapter -> Html msg
chapterBox currentChapter chapters =
    Html.details
        [ Attribute.class "guide"
        , Attribute.class "chapter-box"
        ]
        [ Html.summary
            []
            [ Html.text "Table of contents" ]
        , Html.ul
            []
            (List.map (chapterLink currentChapter) chapters)
        ]


chapterLink : Maybe Chapter -> Chapter -> Html msg
chapterLink currentChapter chapter =
    if Maybe.withDefault False <| Maybe.map ((==) chapter) currentChapter then
        Html.li []
            [ Html.text chapter.title
            ]

    else
        Html.li []
            [ Html.a
                [ Attribute.href <| "/learn/" ++ chapter.slug
                , Attribute.title <| "Read '" ++ chapter.title ++ "'"
                ]
                [ Html.text chapter.title ]
            ]
