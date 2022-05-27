module Page.Install exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import Head
import Head.Seo as Seo
import Html
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
        , description = "Get started with Gren"
        , locale = Nothing
        , title = Site.subTitle "Install"
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
    { title = Site.subTitle "Install"
    , body =
        [ Html.h3 []
            [ Html.text "Install" ]
        ]
    }
