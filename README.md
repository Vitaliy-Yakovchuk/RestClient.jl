# RestClient.jl
Julia macro set to make REPL like REST requests

This package wraps [HTTP.jl]([HTTP.jl](https://github.com/JuliaWeb/HTTP.jl)) requests with one multiline string in HTTP format.

The macro emulates HTTP request:
- First line: is the URL
- [Optional] Second+ lines (til empty line): headers
- [Optional] Lines after the empty one: body

## Supported methods:
- GET
- POST
- PUT
- DELETE
- OPTIONS

## Examples

### Simple get

```julia-repl
julia> GET"http://httpbin.org/ip"
HTTP.Messages.Response:
"""
HTTP/1.1 200 OK
Date: Tue, 17 Aug 2021 14:45:27 GMT
Content-Type: application/json
Content-Length: 31
Connection: keep-alive
Server: gunicorn/19.9.0
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true

{
  "origin": "123.164.233.190"
}
"""
```
### Post with headers and body

```julia-repl
julia> POST"""http://httpbin.org/post?arg1=value1&arg2=value2
Content-Type: application/json;charset=utf-8

{
    "title":"empty json"
}
"""
HTTP.Messages.Response:
"""
HTTP/1.1 200 OK
Date: Tue, 17 Aug 2021 14:47:15 GMT
Content-Type: application/json
Content-Length: 537
Connection: keep-alive
Server: gunicorn/19.9.0
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true

{
  "args": {
    "arg1": "value1", 
    "arg2": "value2"
  }, 
  "data": "{\n    \"title\":\"empty json\"\n}\n", 
  "files": {}, 
  "form": {}, 
  "headers": {
    "Accept": "*/*", 
    "Content-Length": "29", 
    "Content-Type": "application/json;charset=utf-8", 
    "Host": "httpbin.org", 
    "User-Agent": "HTTP.jl/1.6.2", 
    "X-Amzn-Trace-Id": "Root=1-611bcbf3-72fb412b568f8da543534982"
  }, 
  "json": {
    "title": "empty json"
  }, 
  "origin": "123.164.233.190", 
  "url": "http://httpbin.org/post?arg1=value1&arg2=value2"
}
"""
```
