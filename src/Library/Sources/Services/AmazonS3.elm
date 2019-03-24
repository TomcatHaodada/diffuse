module Sources.Services.AmazonS3 exposing (defaults, initialData, makeTrackUrl, makeTree, parseErrorResponse, parsePreparationResponse, parseTreeResponse, postProcessTree, prepare, properties)

{-| Amazon S3 Service.

Resources:

  - <http://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html>

-}

import Dict
import Http
import Sources exposing (..)
import Sources.Pick
import Sources.Processing exposing (..)
import Sources.Services.AmazonS3.Parser as Parser
import Sources.Services.AmazonS3.Presign exposing (..)
import Sources.Services.Common exposing (cleanPath, nameProperty, noPrep)
import Time



-- PROPERTIES
-- 📟


defaults =
    { bucketName = "music"
    , directoryPath = "/"
    , name = "Music from Amazon S3"
    , region = "eu-west-1"
    }


{-| The list of properties we need from the user.
-}
properties : List Property
properties =
    [ { k = "accessKey", l = "Access key", h = "Fv6EWfLfCcMo", p = True }
    , { k = "secretKey", l = "Secret key", h = "qeNcqiMpgqC8", p = True }
    , { k = "bucketName", l = "Bucket name", h = "music", p = False }
    , { k = "region", l = "Region", h = defaults.region, p = False }
    , { k = "directoryPath", l = "Directory", h = defaults.directoryPath, p = False }
    , { k = "host", l = "Host (optional)", h = "http://127.0.0.1:9000", p = False }
    ]


{-| Initial data set.
-}
initialData : SourceData
initialData =
    Dict.fromList
        [ ( "accessKey", "" )
        , ( "bucketName", defaults.bucketName )
        , ( "directoryPath", defaults.directoryPath )
        , ( "host", "" )
        , ( "name", defaults.name )
        , ( "region", defaults.region )
        , ( "secretKey", "" )
        ]



-- PREPARATION


prepare : String -> SourceData -> Marker -> (Result Http.Error String -> msg) -> Maybe (Cmd msg)
prepare _ _ _ _ =
    Nothing



-- TREE


{-| Create a directory tree.

List all the tracks in the bucket.
Or a specific directory in the bucket.

-}
makeTree : SourceData -> Marker -> Time.Posix -> (Result Http.Error String -> msg) -> Cmd msg
makeTree srcData marker currentTime resultMsg =
    let
        directoryPath =
            srcData
                |> Dict.get "directoryPath"
                |> Maybe.withDefault defaults.directoryPath
                |> cleanPath

        initialParams =
            [ ( "list-type", "2" )

            -- NOTE: Can be 1000, but the XML parser seems to have trouble with that number.
            , ( "max-keys", "750" )
            ]

        prefix =
            if String.length directoryPath > 0 then
                [ ( "prefix", directoryPath ) ]

            else
                []

        continuation =
            case marker of
                InProgress s ->
                    [ ( "continuation-token", s ) ]

                _ ->
                    []

        params =
            initialParams ++ prefix ++ continuation

        url =
            presignedUrl Get (60 * 5) params currentTime srcData "/"
    in
    Http.get
        { url = url
        , expect = Http.expectString resultMsg
        }


{-| Re-export parser functions.
-}
parsePreparationResponse : String -> SourceData -> Marker -> PrepationAnswer Marker
parsePreparationResponse =
    noPrep


parseTreeResponse : String -> Marker -> TreeAnswer Marker
parseTreeResponse =
    Parser.parseTreeResponse


parseErrorResponse : String -> String
parseErrorResponse =
    Parser.parseErrorResponse



-- Post


{-| Post process the tree results.

Make sure we only use music files that we can use.

-}
postProcessTree : List String -> List String
postProcessTree =
    Sources.Pick.selectMusicFiles



-- Track URL


{-| Create a public url for a file.

We need this to play the track.
Creates a presigned url that's valid for 48 hours

-}
makeTrackUrl : Time.Posix -> SourceData -> HttpMethod -> String -> String
makeTrackUrl currentTime srcData method pathToFile =
    presignedUrl method 172800 [] currentTime srcData pathToFile
