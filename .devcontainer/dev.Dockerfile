FROM ghcr.io/maresb/micromamba-devcontainer:git-b346b42

# Copy over the list of Conda packages for our development environment.
COPY --chown=$MAMBA_USER:$MAMBA_USER .devcontainer/dev-conda-environment.yaml /tmp/dev-conda-environment.yaml

# Ensure that all users have read-write access to all files created in the subsequent commands.
ARG DOCKERFILE_UMASK=0000

# Install the Conda packages.
RUN : \
    && micromamba install -y -f /tmp/dev-conda-environment.yaml \
    && micromamba clean --all --yes \
    ;

# Activate the conda environment for the Dockerfile.
# <https://github.com/mamba-org/micromamba-docker#running-commands-in-dockerfile-within-the-conda-environment>
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Tell poetry to install things in the base conda environment instead of a separate venv.
RUN poetry config virtualenvs.create false

ARG CONTAINER_WORKSPACE_FOLDER=/workspaces/default-workspace-folder

RUN : \
    && sudo mkdir /workspaces \
    && sudo chown "${MAMBA_USER}":"${MAMBA_USER}" /workspaces \
    && sudo mkdir -p "${CONTAINER_WORKSPACE_FOLDER}" \
    && sudo chown $MAMBA_USER:$MAMBA_USER "${CONTAINER_WORKSPACE_FOLDER}" \
    ;
WORKDIR "${CONTAINER_WORKSPACE_FOLDER}"

# Copy only the files necessary to install the dependencies.
# (Remember that we will bind-mount the full project folder after build time.)
COPY --chown=$MAMBA_USER:$MAMBA_USER pyproject.toml poetry.lock ./

# An __init__.py is also required for poetry to perform the initial install.
RUN : \
    && mkdir -p pypackages/example_project \
    && touch pypackages/example_project/__init__.py \
    ;

# Install dependencies
RUN poetry install
