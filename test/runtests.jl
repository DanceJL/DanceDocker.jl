#!/usr/bin/env julia

using Test, SafeTestsets


@time begin
@time @safetestset "Dockerfile file creation" begin include("docker_creation_test.jl") end
end
