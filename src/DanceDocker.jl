module DanceDocker

import Dance.Configuration


export setup


"""
    setup(path::String="."; version::String=string(VERSION))

- Julia version number can be overwritten, else defaults to that of system
- Check if project contains `Project.toml`, `dance.jl` and `settings` dir, else means project is not properly configured with DanceJL
- Obtain server port (specified under `Dockerfile`) from `Dance.Configuration.Settings` dict
- Generate `Dockerfile` using template from package `files` dir
"""
function setup(path::String="."; version::String=string(VERSION)) :: Nothing
    if !isfile("Project.toml")
        @error "Please add Project.toml to project root"
    elseif !isfile("dance.jl")
        @error "Please add dance.jl to project root"
    elseif !isdir("settings")
        @error "Please add settings dir to project root"
    else
        if Configuration.populate(path)
            settings::Dict{Symbol, Any} = Configuration.Settings
            port::Int64 = settings[:server_port]

            dest_dockerfile_path::String = joinpath(abspath(path), "Dockerfile")
            cp(joinpath(@__DIR__, "../files/Dockerfile"), dest_dockerfile_path)
            if !Sys.iswindows()
                run(`chmod 755 $dest_dockerfile_path`)
            end

            file_string::String = ""
            open("Dockerfile", "r") do io
                file_string = read(io, String)
            end
            file_string = replace(file_string, "\${version}" => version)
            file_string = replace(file_string, "\${port}" => string(port))
            open("Dockerfile", "w") do io
                write(io, file_string)
            end

            @info "Dockerfile added to project root"
        else
            @error "Error setting up project settings. Please see error above."
        end
    end
end

end
