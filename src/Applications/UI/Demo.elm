module UI.Demo exposing (tape)

{-| TODO: Update to new structure.
-}

import Base64
import Json.Decode as Json
import Json.Encode


tape : Json.Value
tape =
    "eyJmYXZvdXJpdGVzIjpbeyJhcnRpc3QiOiJKYW1lcyBCbGFrZSIsInRpdGxlIjoiRXNzZW50aWFsIE1peCAoMDktMTctMjAxMSkifV0sInNldHRpbmdzIjp7ImFwcGxpY2F0aW9uIjp7ImJhY2tncm91bmRJbWFnZSI6IjcuanBnIn0sImVxdWFsaXplciI6eyJsb3ciOjAsIm1pZCI6MCwiaGlnaCI6MCwidm9sdW1lIjoxfSwicXVldWUiOnsicmVwZWF0IjpmYWxzZSwic2h1ZmZsZSI6ZmFsc2V9LCJ0cmFja3MiOnsiZmF2b3VyaXRlc09ubHkiOmZhbHNlLCJzZWFyY2hUZXJtIjpudWxsLCJzZWxlY3RlZFBsYXlsaXN0IjpudWxsfX0sInNvdXJjZXMiOlt7ImlkIjoiMTUwNzY0MDIxODczNDIiLCJkYXRhIjp7ImFjY2Vzc0tleSI6IkFLSUFKUUNINTdZRkozVUVSWElBIiwiYnVja2V0TmFtZSI6Im9uZ2FrdS1yeW9oby1kZW1vIiwiZGlyZWN0b3J5UGF0aCI6Ii8iLCJuYW1lIjoiRGVtbyIsInJlZ2lvbiI6InVzLWVhc3QtMSIsInNlY3JldEtleSI6Ii9qSUM2REE5a2MyRFpTdzNLR3NGN1ZmdC94VEFSVHB0R2I5NmtrUDIifSwiZGlyZWN0b3J5UGxheWxpc3RzIjp0cnVlLCJlbmFibGVkIjp0cnVlLCJzZXJ2aWNlIjoiQW1hem9uUzMifV0sInRyYWNrcyI6W3siaWQiOiJNVFV3TnpZME1ESXhPRGN6TkRJdkwwWnlaV1VnYlhWemFXTXZLRk5YVERBeE15a3RiM0pwU21GdWRYTXRWMFZDTFRJd01UUXRSbEpGUlM4d01TMWliMjVwZEdFdWJYQXoiLCJwYXRoIjoiRnJlZSBtdXNpYy8oU1dMMDEzKS1vcmlKYW51cy1XRUItMjAxNC1GUkVFLzAxLWJvbml0YS5tcDMiLCJzb3VyY2VJZCI6IjE1MDc2NDAyMTg3MzQyIiwidGFncyI6eyJkaXNjIjoxLCJuciI6MSwiYWxidW0iOiJTb3VsZWN0aW9uIFdoaXRlIExhYmVsOiAwMTMiLCJhcnRpc3QiOiJvcmlKYW51cyIsInRpdGxlIjoiQm9uaXRhIiwiZ2VucmUiOiJTb3VsZWN0aW9uIiwicGljdHVyZSI6bnVsbCwieWVhciI6bnVsbH19LHsiaWQiOiJNVFV3TnpZME1ESXhPRGN6TkRJdkwwWnlaV1VnYlhWemFXTXZLRk5YVERBeE15a3RiM0pwU21GdWRYTXRWMFZDTFRJd01UUXRSbEpGUlM4d01pMDJMbTF3TXciLCJwYXRoIjoiRnJlZSBtdXNpYy8oU1dMMDEzKS1vcmlKYW51cy1XRUItMjAxNC1GUkVFLzAyLTYubXAzIiwic291cmNlSWQiOiIxNTA3NjQwMjE4NzM0MiIsInRhZ3MiOnsiZGlzYyI6MSwibnIiOjIsImFsYnVtIjoiU291bGVjdGlvbiBXaGl0ZSBMYWJlbDogMDEzIiwiYXJ0aXN0Ijoib3JpSmFudXMiLCJ0aXRsZSI6IjYiLCJnZW5yZSI6IlNvdWxlY3Rpb24iLCJwaWN0dXJlIjpudWxsLCJ5ZWFyIjpudWxsfX0seyJpZCI6Ik1UVXdOelkwTURJeE9EY3pOREl2TDBaeVpXVWdiWFZ6YVdNdktGTlhUREF4TXlrdGIzSnBTbUZ1ZFhNdFYwVkNMVEl3TVRRdFJsSkZSUzh3TXkxb2IzUmZjbVZ0YVhoZlpuUXVYM1JsYXk1c2RXNWZKbDk2YVd0dmJXOHViWEF6IiwicGF0aCI6IkZyZWUgbXVzaWMvKFNXTDAxMyktb3JpSmFudXMtV0VCLTIwMTQtRlJFRS8wMy1ob3RfcmVtaXhfZnQuX3Rlay5sdW5fJl96aWtvbW8ubXAzIiwic291cmNlSWQiOiIxNTA3NjQwMjE4NzM0MiIsInRhZ3MiOnsiZGlzYyI6MSwibnIiOjMsImFsYnVtIjoiU291bGVjdGlvbiBXaGl0ZSBMYWJlbDogMDEzIiwiYXJ0aXN0Ijoib3JpSmFudXMiLCJ0aXRsZSI6IkhvdCBSZW1peCBmdC4gVGVrLkx1biAmIFppa29tbyIsImdlbnJlIjoiU291bGVjdGlvbiIsInBpY3R1cmUiOm51bGwsInllYXIiOm51bGx9fSx7ImlkIjoiTVRVd056WTBNREl4T0Rjek5ESXZMMFp5WldVZ2JYVnphV012UTI5dFgxUnlkV2x6WlMxRGFHVnRhV05oYkY5TVpXZHpMVEl3TVRJdFJsSkZSUzh3TVMxamIyMWZkSEoxYVhObExXTm9aVzFwWTJGc1gyeGxaM011YlhBeiIsInBhdGgiOiJGcmVlIG11c2ljL0NvbV9UcnVpc2UtQ2hlbWljYWxfTGVncy0yMDEyLUZSRUUvMDEtY29tX3RydWlzZS1jaGVtaWNhbF9sZWdzLm1wMyIsInNvdXJjZUlkIjoiMTUwNzY0MDIxODczNDIiLCJ0YWdzIjp7ImRpc2MiOjEsIm5yIjo5LCJhbGJ1bSI6IkFkdWx0IFN3aW0gU2luZ2xlcyBQcm9qZWN0IDIwMTIiLCJhcnRpc3QiOiJDb20gVHJ1aXNlIiwidGl0bGUiOiJDaGVtaWNhbCBMZWdzIiwiZ2VucmUiOm51bGwsInBpY3R1cmUiOm51bGwsInllYXIiOjIwMTJ9fSx7ImlkIjoiTVRVd056WTBNREl4T0Rjek5ESXZMMFp5WldVZ2JYVnphV012VFdGdWRXVnNaVjlCZEhwbGJtbGZMVjh3TkY4dFgweHBkSFJzWlY5VGRHRnlMbTF3TXciLCJwYXRoIjoiRnJlZSBtdXNpYy9NYW51ZWxlX0F0emVuaV8tXzA0Xy1fTGl0dGxlX1N0YXIubXAzIiwic291cmNlSWQiOiIxNTA3NjQwMjE4NzM0MiIsInRhZ3MiOnsiZGlzYyI6MSwibnIiOjQsImFsYnVtIjoiVGhlIE1peWF6YWtpIFRvdXIgRVAiLCJhcnRpc3QiOiJNYW51ZWxlIEF0emVuaSIsInRpdGxlIjoiTGl0dGxlIFN0YXIiLCJnZW5yZSI6IkZ1bmsiLCJwaWN0dXJlIjpudWxsLCJ5ZWFyIjpudWxsfX0seyJpZCI6Ik1UVXdOelkwTURJeE9EY3pOREl2TDBaeVpXVWdiWFZ6YVdNdlVHRjBjbWxqYTE5TVpXVmZMVjh3TWw4dFgxRjFhWFIwYVc1ZlZHbHRaUzV0Y0RNIiwicGF0aCI6IkZyZWUgbXVzaWMvUGF0cmlja19MZWVfLV8wMl8tX1F1aXR0aW5fVGltZS5tcDMiLCJzb3VyY2VJZCI6IjE1MDc2NDAyMTg3MzQyIiwidGFncyI6eyJkaXNjIjoxLCJuciI6MiwiYWxidW0iOiJUaGUgTGFzdCBUaGluZyIsImFydGlzdCI6IlBhdHJpY2sgTGVlIiwidGl0bGUiOiJRdWl0dGluJyBUaW1lIiwiZ2VucmUiOiJFbGVjdHJvbmljIiwicGljdHVyZSI6bnVsbCwieWVhciI6bnVsbH19LHsiaWQiOiJNVFV3TnpZME1ESXhPRGN6TkRJdkwxSmhaR2x2TDJwaGJXVnpYMkpzWVd0bExXVnpjMlZ1ZEdsaGJGOXRhWGd0YzJGMExUQTVMVEUzTFRJd01URXViWEF6IiwicGF0aCI6IlJhZGlvL2phbWVzX2JsYWtlLWVzc2VudGlhbF9taXgtc2F0LTA5LTE3LTIwMTEubXAzIiwic291cmNlSWQiOiIxNTA3NjQwMjE4NzM0MiIsInRhZ3MiOnsiZGlzYyI6MSwibnIiOjEsImFsYnVtIjoiRXNzZW50aWFsIE1peC1TQVQtMDktMTciLCJhcnRpc3QiOiJKYW1lcyBCbGFrZSIsInRpdGxlIjoiRXNzZW50aWFsIE1peCAoMDktMTctMjAxMSkiLCJnZW5yZSI6IkVsZWN0cm9uaWMiLCJwaWN0dXJlIjpudWxsLCJ5ZWFyIjpudWxsfX1dfQ=="
        |> Base64.decode
        |> Result.mapError (\err -> Json.Failure err Json.Encode.null)
        |> Result.andThen (Json.decodeString Json.value)
        |> Result.withDefault (Json.Encode.object [])
