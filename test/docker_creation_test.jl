import Dance
import DanceDocker
import HTTP

include("./utils.jl")


# Dance by default does not automatically add Project.toml
Dance.start_project("demo")
cd("demo")
@test_logs (:error, "Please add Project.toml to project root") DanceDocker.setup()
cd("..")

# Add Project.toml, generate Dockerfile and build Docker image
project_settings_and_launch()
add_project_toml()
@test_logs (:info, "Dockerfile added to project root") DanceDocker.setup()


#=
    TODO: Code below fails on Travis-CI
    Uncomment below as well as functions in `utils.jl`, if you want to test Docker image locally
=#
#=@info "Building Docker image ..."
docker_build_output = replace(read(`docker build -t demo .`, String), "\n" => "")
container_id = replace(read(`docker run -d -p 80:8000 demo`, String), "\n" => "")
image_id = string(split(split(docker_build_output, "Successfully built ")[2], "Successfully tagged")[1])

# Test Docker port is accessible and rendering correctly
r = HTTP.request("GET", "http://127.0.0.1/")
@test r.status==200
compare_http_header(r.headers, "content_type", "text/html; charset=UTF-8")
@test extract_html_body_content(r.body)=="Hello World"


delete_docker_container_image_and_project(;container_id=container_id, image_id=image_id)=#
