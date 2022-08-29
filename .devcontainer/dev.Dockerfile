FROM ghcr.io/mamba-org/micromamba-devcontainer:git-66b407f

# Ensure that all users have read-write access to all files created in the subsequent commands.
ARG DOCKERFILE_UMASK=0000

# Install hadolint for Dockerfile linting (unfortunately not yet available on conda-forge)
# <https://github.com/conda-forge/staged-recipes/pull/14581>
ADD https://github.com/hadolint/hadolint/releases/download/v2.10.0/hadolint-Linux-x86_64 /usr/local/bin/hadolint
# hadolint ignore=DL3004
RUN sudo chmod a+rx /usr/local/bin/hadolint

# Install the Conda packages.
COPY --chown=$MAMBA_USER:$MAMBA_USER conda-lock.yml /tmp/conda-lock.yml
RUN : \
    # Configure Conda to use the conda-forge channel
    && micromamba config append channels conda-forge \
    # Micromamba will install only things from the "main" category, so
    # we convert the "dev" category to "main"
    && sed -i 's|- category: dev|- category: main|' /tmp/conda-lock.yml \
    # Install and clean up
    && micromamba install --yes --name base --file /tmp/conda-lock.yml \
    && micromamba clean --all --yes \
;

# Activate the conda environment for the Dockerfile.
# <https://github.com/mamba-org/micromamba-docker#running-commands-in-dockerfile-within-the-conda-environment>
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Create and set the workspace folder
ARG CONTAINER_WORKSPACE_FOLDER=/workspaces/default-workspace-folder
RUN mkdir -p "${CONTAINER_WORKSPACE_FOLDER}"
WORKDIR "${CONTAINER_WORKSPACE_FOLDER}"

# Copy only the files necessary to install the project.
# (Remember that we will bind-mount the full project folder after build time.)
COPY --chown=$MAMBA_USER:$MAMBA_USER pyproject.toml ./
# hadolint ignore=DL3021
COPY --chown=$MAMBA_USER:$MAMBA_USER \
    "packages/example_project/__init__.py" \
    "packages/example_project/"

# Install the package
RUN pip install --no-cache-dir --editable .
