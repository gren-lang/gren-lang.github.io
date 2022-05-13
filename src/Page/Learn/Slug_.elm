module Page.Learn.Slug_ exposing (Data, Model, Msg, page)

import Data.GuideChapter as GuideChapter exposing (Chapter)
import DataSource exposing (DataSource)
import DataSource.File as File
import Head
import Head.Seo as Seo
import Html
import List.Extra
import Markdown.Parser
import Markdown.Renderer
import OptimizedDecoder
import Page exposing (Page, StaticPayload)
import Page.Learn as Learn
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    { slug : String }


type alias Data =
    { currentChapter : Chapter
    , chapters : List Chapter
    }


page : Page RouteParams Data
page =
    Page.prerender
        { head = head
        , routes = routes
        , data = data
        }
        |> Page.buildNoState { view = view }


routes : DataSource (List RouteParams)
routes =
    GuideChapter.filePaths
        |> DataSource.map
            (List.map (\file -> RouteParams file.name))


data : RouteParams -> DataSource Data
data routeParams =
    GuideChapter.filePaths
        |> DataSource.map
            (List.map (\file -> File.bodyWithFrontmatter (GuideChapter.decoder file.name) file.path))
        |> DataSource.resolve
        |> DataSource.andThen
            (\chapters ->
                case List.Extra.find (\chapter -> chapter.slug == routeParams.slug) chapters of
                    Just currentChapter ->
                        DataSource.succeed
                            { currentChapter = currentChapter
                            , chapters = chapters
                            }

                    Nothing ->
                        DataSource.fail <|
                            "Could not find chapter with slug: "
                                ++ routeParams.slug
            )


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "TODO title" -- metadata.title -- TODO
        }
        |> Seo.website


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View msg
view _ _ static =
    let
        { currentChapter, chapters } =
            static.data
    in
    { title = "Gren - " ++ currentChapter.title
    , body =
        case Markdown.Parser.parse currentChapter.body of
            Ok markdown ->
                case Markdown.Renderer.render Markdown.Renderer.defaultHtmlRenderer markdown of
                    Ok html ->
                        [ Html.h3 [] [ Html.text currentChapter.title ]
                        , Learn.chapterBox chapters
                        ]
                            ++ html

                    Err _ ->
                        [ Html.text "Failed to render markdown" ]

            Err _ ->
                [ Html.text "Failed to parse markdown." ]
    }
