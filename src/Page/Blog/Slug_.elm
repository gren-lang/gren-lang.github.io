module Page.Blog.Slug_ exposing (Data, Model, Msg, page)

import Data.Article as Article exposing (Article)
import DataSource exposing (DataSource)
import DataSource.File as File
import Head
import Head.Seo as Seo
import Html
import Markdown.Parser
import Markdown.Renderer
import OptimizedDecoder as Decode exposing (Decoder)
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
    { slug : String }


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
    Article.filePaths
        |> DataSource.map
            (List.map (File.onlyFrontmatter routeParamDecoder))
        |> DataSource.resolve


routeParamDecoder : Decoder RouteParams
routeParamDecoder =
    Decode.map RouteParams
        (Decode.field "title" Decode.string)


data : RouteParams -> DataSource Data
data routeParams =
    Article.filePaths
        |> DataSource.map
            (List.map (File.bodyWithFrontmatter Article.decoder))
        |> DataSource.resolve
        |> DataSource.map
            (List.filter (\article -> article.title == routeParams.slug))
        |> DataSource.andThen
            (\results ->
                case List.head results of
                    Just result ->
                        DataSource.succeed result

                    Nothing ->
                        DataSource.fail <|
                            "Could not find article with slug: "
                                ++ routeParams.slug
            )
        |> DataSource.map Data


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


type alias Data =
    { article : Article }


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View msg
view _ _ static =
    { title = static.data.article.title
    , body =
        case Markdown.Parser.parse static.data.article.body of
            Ok markdown ->
                case Markdown.Renderer.render Markdown.Renderer.defaultHtmlRenderer markdown of
                    Ok html ->
                        html

                    Err _ ->
                        [ Html.text "Failed to render markdown" ]

            Err _ ->
                [ Html.text "Failed to parse markdown." ]
    }
