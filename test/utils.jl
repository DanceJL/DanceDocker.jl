function add_project_toml() :: Int64
    touch("Project.toml")

    open("Project.toml", "w") do io_project
        open("../sample/Project.toml") do io_sample
            write(io_project, io_sample)
        end
    end
end


#=function compare_http_header(headers::Array, key::String, value::String) :: Nothing
    for item in headers
        if item[1]==key
            @test item[2]==value
        end
    end
end


function delete_docker_container_image_and_project(;container_id::String, image_id::String) :: Nothing
    run(`docker container stop $container_id`)
    run(`docker image rmi $image_id -f`)
    cd("..")
    rm("demo", recursive=true)
end=#


#=function extract_html_body_content(html_body::Array{UInt8,1}) :: String
    return split(
        split(String(html_body), "<div id=\"js-dance-json-data\">")[2],
        "</div>"
    )[1]
end=#


function project_settings() :: Nothing
    cd("settings")

    touch("dev.jl")
    open("dev.jl", "w") do io
        write(io, ":dev = true \n")
        write(io, ":server_host = 0.0.0.0\n")
    end

    open("Global.jl", "a+") do io
        write(io, "include(\"dev.jl\")")
    end

    cd("..")
end
