# Dance

Plugin to automatically generate Dockerfile for DanceJL project.

| **Build Status**                                       |
|:------------------------------------------------------:|
| [![Build Status](https://travis-ci.com/DanceJL/DanceDocker.jl.svg?branch=master)](https://travis-ci.com/DanceJL/DanceDocker.jl)  [![codecov](https://codecov.io/gh/DanceJL/DanceDocker.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/DanceJL/DanceDocker.jl)|

## 1 - Installation

Package can be installed with Julia's package manager, either by using Pkg REPL mode (*press ]*):

```
pkg> add https://github.com/DanceJL/DanceDocker.jl
```

or by using Pkg functions

```julia
julia> using Pkg; Pkg.add(Pkg.PackageSpec(url="https://github.com/DanceJL/DanceDocker.jl"))
```

Compatibility is with Julia 1.1 and Dance 0.0.1 upward.


## 2 - Setup

**Please make sure your project contains a `Project.toml` file in its root, at same level as `dance.jl` file.**

**If testing Docker on `localhost`, is recommended to set DanceJL setting's `:server_host` parameter to `0.0.0.0`.**
Else connections from host to Docker container might not work smoothly.

Invoke terminal in project root directory and:

```julia
using DanceDocker
setup()
```

Optionally if you wish to use different Julia version than one used on your machine, one can do so via `version` kwarg.
For example:

```julia
using DanceDocker
setup(;version=1.4)
```

## 3 - Docker Integration

Following section requires Docker to be installed on system.

### 3.1 - Building Docker Image

To build Docker image:

```
docker build -t <name>:<version> .
```

where

- `name` is name of output DOcker image.
- `version` is optional, as Docker will default tag to `latest`.

### 3.2 - Running Docker Image

To run built Docker image:

```
docker run -d -p <host port>:<docker port> <build name>:<build version>
```

where:

- `host port` and `docker port` correspond to ports on host and what was specified under Dockerfile respectively. For example: `8000:8000`.
- `build name` is the name of Docker image, as specified under previous section.
- `build version` is optional, depending on if specified under previous section.

Above command will output a Docker container id.
Hence when finished, simply end Docker instance by running:

```
docker container stop <container id>
```
