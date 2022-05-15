module Api exposing (routes)

import ApiRoute
import Data.Article as Article
import DataSource exposing (DataSource)
import Html exposing (Html)
import Pages
import Route exposing (Route)
import Rss
import Sitemap
import Time


routes :
    DataSource (List Route)
    -> (Html Never -> String)
    -> List (ApiRoute.ApiRoute ApiRoute.Response)
routes getStaticRoutes _ =
    [ rss
        { siteTagline = "News from the Gren core team"
        , siteUrl = "https://gren-lang.org"
        , title = "Gren news"
        , builtAt = Pages.builtAt
        , indexPage = [ "news" ]
        }
        newsDataSource
    , ApiRoute.succeed
        (getStaticRoutes
            |> DataSource.map
                (\allRoutes ->
                    { body =
                        allRoutes
                            |> List.map
                                (\route ->
                                    { path = Route.routeToPath route |> String.join "/"
                                    , lastMod = Nothing
                                    }
                                )
                            |> Sitemap.build { siteUrl = "https://gren-lang.org" }
                    }
                )
        )
        |> ApiRoute.literal "sitemap.xml"
        |> ApiRoute.single
    ]


newsDataSource : DataSource.DataSource (List Rss.Item)
newsDataSource =
    Article.all
        |> DataSource.map
            (List.map
                (\article ->
                    { title = article.title
                    , description = article.description
                    , url =
                        Route.News__Slug_ { slug = article.slug }
                            |> Route.routeToPath
                            |> String.join "/"
                    , categories = []
                    , author = "Robin Heggelund Hansen"
                    , pubDate = Rss.Date article.published
                    , content = Just article.body
                    , contentEncoded = Nothing
                    , enclosure = Nothing
                    }
                )
            )


rss :
    { siteTagline : String
    , siteUrl : String
    , title : String
    , builtAt : Time.Posix
    , indexPage : List String
    }
    -> DataSource.DataSource (List Rss.Item)
    -> ApiRoute.ApiRoute ApiRoute.Response
rss options itemsRequest =
    ApiRoute.succeed
        (itemsRequest
            |> DataSource.map
                (\items ->
                    { body =
                        Rss.generate
                            { title = options.title
                            , description = options.siteTagline
                            , url = options.siteUrl ++ "/" ++ String.join "/" options.indexPage
                            , lastBuildTime = options.builtAt
                            , generator = Just "elm-pages"
                            , items = items
                            , siteUrl = options.siteUrl
                            }
                    }
                )
        )
        |> ApiRoute.literal "news/feed.xml"
        |> ApiRoute.single
