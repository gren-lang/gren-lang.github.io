module Site exposing
    ( config
    , defaultImage
    , name
    , subTitle
    )

import DataSource
import Head
import Head.Seo as Seo
import LanguageTag exposing (LanguageTag)
import LanguageTag.Language
import MimeType
import Pages.Manifest as Manifest
import Pages.Url as Url
import Route
import SiteConfig exposing (SiteConfig)


type alias Data =
    ()


config : SiteConfig Data
config =
    { data = data
    , canonicalUrl = "https://gren-lang.org"
    , manifest = manifest
    , head = head
    }


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


name : String
name =
    "Gren"


head : Data -> List Head.Tag
head _ =
    [ Head.rootLanguage language
    , Head.icon favicon.sizes MimeType.Png favicon.src
    , Head.appleTouchIcon (Just 192) favicon.src
    , Head.sitemapLink "/sitemap.xml"
    , Head.rssLink "/news/feed.xml"
    ]


language : LanguageTag
language =
    LanguageTag.Language.en
        |> LanguageTag.build LanguageTag.emptySubtags


favicon : Manifest.Icon
favicon =
    { src = Url.external "/favicon.png"
    , sizes = [ ( 192, 192 ) ]
    , mimeType = Just MimeType.Png
    , purposes = [ Manifest.IconPurposeAny ]
    }


defaultImage : Seo.Image
defaultImage =
    { url = Url.external "/external.png"
    , alt = "Gren logo"
    , dimensions = Nothing
    , mimeType = Just "image/png"
    }


subTitle : String -> String
subTitle title =
    title ++ " | Gren"


manifest : Data -> Manifest.Config
manifest _ =
    Manifest.init
        { name = name
        , description = "The official homepage of the Gren programming language"
        , startUrl = Route.Index |> Route.toPath
        , icons = [ favicon ]
        }
        |> Manifest.withLang language
