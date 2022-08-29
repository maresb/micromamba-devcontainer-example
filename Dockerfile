# This is a non-development container for deploying your project.

FROM ghcr.io/mamba-org/micromamba-devcontainer:git-66b407f

WORKDIR /usr/src/

# Set the timezone
ENV TZ=Europe/Berlin

# Install the Conda packages.
COPY --chown=$MAMBA_USER:$MAMBA_USER conda-lock.yml ./
RUN : \
    && micromamba install --yes --name base --file conda-lock.yml \
    && micromamba clean --all --yes \
    ;

# Activate the environment for this Dockerfile
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Copy relevant files to the container
COPY "python/example_project/" "python/example_project/"
COPY pyproject.toml ./

# Install the package
RUN pip install --editable .
