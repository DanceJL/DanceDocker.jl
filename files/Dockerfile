# Install Julia and copy project files
FROM julia:${version}
COPY . /dance
WORKDIR /dance

# Install Julia deps
RUN julia -e"using Pkg; pkg\"activate .\"; Pkg.instantiate(); -03"

# Compile project files

# Open ports
EXPOSE ${port}

# Start web server
CMD julia -e"include(\"dance.jl\"); -03"
