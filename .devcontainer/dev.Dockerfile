FROM ghcr.io/maresb/micromamba-devcontainer:git-32b6d3f

# Ensure that all users have read-write access to all files created in the subsequent commands.
ARG DOCKERFILE_UMASK=0000

# Install hadolint
ADD https://github.com/hadolint/hadolint/releases/download/v2.10.0/hadolint-Linux-x86_64 /usr/local/bin/hadolint
RUN sudo chmod a+rx /usr/local/bin/hadolint

# Install the Conda packages.
COPY --chown=$MAMBA_USER:$MAMBA_USER .devcontainer/dev-conda-environment.yaml /tmp/dev-conda-environment.yaml
RUN : \
    # Configure Conda to use the conda-forge channel.
    && micromamba config append channels conda-forge \
    && micromamba install -y -f /tmp/dev-conda-environment.yaml \
    && micromamba clean --all --yes \
    ;

# Activate the conda environment for the Dockerfile.
# <https://github.com/mamba-org/micromamba-docker#running-commands-in-dockerfile-within-the-conda-environment>
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Tell poetry to install things in the base conda environment instead of a separate venv.
RUN poetry config virtualenvs.create false

# Create and set the workspace folder
ARG CONTAINER_WORKSPACE_FOLDER=/workspaces/default-workspace-folder
RUN mkdir -p "${CONTAINER_WORKSPACE_FOLDER}"
WORKDIR "${CONTAINER_WORKSPACE_FOLDER}"

# Copy only the files necessary to install the dependencies.
# (Remember that we will bind-mount the full project folder after build time.)
COPY --chown=$MAMBA_USER:$MAMBA_USER pyproject.toml poetry.lock ./

# An __init__.py is also required for poetry to perform the initial install.
RUN : \
    && mkdir -p "pypackages/example_project" \
    && touch "pypackages/example_project/__init__.py" \
    ;

# Install dependencies
RUN poetry install
