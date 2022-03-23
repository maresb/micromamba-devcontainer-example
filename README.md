# micromamba-devcontainer-example

This is an example project which uses [micromamba-devcontainer](https://github.com/maresb/micromamba-devcontainer).

## Deploying with an existing project

Maybe we can automate this, but currently the procedure is:

* Copy `.dockerignore` and `.devcontainer` to the root of your project.
* Customize `.devcontainer/dev-conda-environment.yaml` to install the desired Conda packages.
* Customize `.devcontainer/dev.Dockerfile` to install (a skeleton of) your project, preferrably in editable mode (e.g. `pip install -e .` or `poetry install`). This way the project dependencies will be installed in the Docker image.
* Customize the settings in `.devcontainer/devcontainer.json` to specify the title, hostname, or mounts.
* Press Ctrl+Shift+P and select "Remote-Containers: Rebuild and Reopen in Container", and if all goes well, this will load successfully.

## Troubleshooting

Right after the container starts, the user account should be given group access to the Docker socket in `/var/run/docker.sock`. It can however happen that VS Code itself (and the terminals spawned from it) have not been registered in the group yet. In this case, the problem seems to fix itself when the window is reloaded (Ctrl+Shift+P → "Developer: Reload Window").

This all assumes that the Docker socket is group-accessible. (If not, consider running `sudo chmod g+rw /var/run/docker.sock`.)
