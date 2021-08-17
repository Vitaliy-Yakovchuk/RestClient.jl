module RestClient

using HTTP

macro GET_str(data)
    return prepare_request(:GET, data)
end

macro POST_str(data)
    return prepare_request(:POST, data)
end

macro PUT_str(data)
    return prepare_request(:PUT, data)
end

macro DELETE_str(data)
    return prepare_request(:DELETE, data)
end

macro OPTIONS_str(data)
    return prepare_request(:OPTIONS, data)
end

function make_request(method, data)
    #=
    transforms " Key1 : Value 233 44 " to "Key1" => "Value 233 44"
    (split by : and trims)
    =#
    parse_header(header) = Pair(strip.(split(header, ":"))...)

    lines = split(data, "\n")
    url = lines[1]
    empty_index = findfirst(isequal(""), lines)
    body = HTTP.nobody
    if empty_index === nothing
        headers = []
    else
        headers = parse_header.(lines[2:empty_index - 1])
        if empty_index < length(lines)
            body = join(lines[empty_index + 1:end], "\n")
        end
    end

    return HTTP.request(method, url, headers, body)
end

function prepare_request(method, data)
    data = replace(data, "\"" => "\\\"")
    m = Base.string(method)
    return esc(
            :(RestClient.make_request(Symbol($m), $(Meta.parse("\"$data\""))))
        )
end

export @GET_str, @POST_str,  @PUT_str, @DELETE_str, @OPTIONS_str

end
