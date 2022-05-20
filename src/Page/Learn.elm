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
        , siteName = "Gren"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "Gren logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Learn how to program in Gren"
        , locale = Nothing
        , title = "Gren - Learn"
        }
        |> Seo.website


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View msg
view _ _ payload =
    { title = "Gren - Learn"
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
            [ Html.text "So you want to learn Gren?" ]
        , Html.p []
            [ Html.text <|
                String.trim """
                This is the official language guide. It covers everything from why
                you would use Gren, to write your first application. To get started, just
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
            [ Html.text "If you need any help along the way, or just want to chat with other people "
            , Html.text "who're enthusiastic about Gren, then you can join our "
            , Html.a
                [ Attribute.href "https://gren.zulipchat.com/"
                , Attribute.title "Join our community at Zulip"
                ]
                [ Html.text "Zulip" ]
            , Html.text "."
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
