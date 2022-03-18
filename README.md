# micromamba-devcontainer-example

This is an example project which uses [micromamba-devcontainer](https://github.com/maresb/micromamba-devcontainer).

## Deploying with an existing project

Maybe we can automate this, but currently the procedure is:

* Copy `.dockerignore` and `.devcontainer` to the root of your project.
* Customize `.devcontainer/dev-conda-environment.yaml` to install the desired Conda packages.
* Customize `.devcontainer/dev.Dockerfile` to install (a skeleton of) your project, preferrably in editable mode (e.g. `pip install -e .` or `poetry install`). This way the project dependencies will be installed in the Docker image.
* Customize the settings in `.devcontainer/devcontainer.json` to specify the title, hostname, or mounts.
* Press Ctrl+Shift+P and select "Remote-Containers: Rebuild and Reopen in Container", and if all goes well, this will load successfully.
