module Site exposing (config)

import DataSource
import Head
import LanguageTag exposing (LanguageTag)
import LanguageTag.Language
import MimeType
import Pages.Manifest as Manifest
import Pages.Url as Url
import Path
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


head : Data -> List Head.Tag
head _ =
    [ Head.rootLanguage siteLanguage
    , Head.sitemapLink "/sitemap.xml"
    , Head.rssLink "/feed.xml"
    , Head.appleTouchIcon (Just 192) favicon.src
    , Head.icon favicon.sizes MimeType.Png favicon.src
    ]


siteLanguage : LanguageTag
siteLanguage =
    LanguageTag.Language.en
        |> LanguageTag.build LanguageTag.emptySubtags


favicon : Manifest.Icon
favicon =
    { src = Url.external "/favicon.png"
    , sizes = [ ( 192, 192 ) ]
    , mimeType = Just MimeType.Png
    , purposes = [ Manifest.IconPurposeAny ]
    }


manifest : Data -> Manifest.Config
manifest _ =
    Manifest.init
        { name = "Gren"
        , description = "The official homepage of the Gren programming language"
        , startUrl = Route.Index |> Route.toPath
        , icons = [ favicon ]
        }
        |> Manifest.withLang siteLanguage
