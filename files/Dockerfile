# Install Julia and copy project files
FROM julia:${version}
COPY . /dance
WORKDIR /dance

# Install Julia deps
RUN julia -e"using Pkg; pkg\"activate .\"; Pkg.instantiate(); -03"

# Compile project files
RUN julia -e"using Pkg; pkg\"activate .\"; import Dance; Dance.pre_launch(\".\"); -03"

# Open ports
EXPOSE ${port}

# Start web server
CMD julia -e"using Pkg; pkg\"activate .\"; include(\"dance.jl\"); main();"
