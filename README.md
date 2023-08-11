# micromamba-devcontainer-example

This is an example project which uses [micromamba-devcontainer](https://github.com/maresb/micromamba-devcontainer). The `.devcontainer` folder was created using [Cruft](https://github.com/cruft/cruft) with [cookiecutter-micromamba-devcontainer](https://gitlab.com/bmares/cookiecutter-micromamba-devcontainer).

## Links

* This project's [GitHub repository](https://github.com/maresb/micromamba-devcontainer-example)
* The [micromamba-devcontainer](https://github.com/maresb/micromamba-devcontainer) base Docker image
* The [cookiecutter-micromamba-devcontainer](https://github.com/maresb/cookiecutter-micromamba-devcontainer) template for the `.devcontainer` folder
* [Cruft](https://github.com/cruft/cruft) for creating and updating projects from Cookiecutter templates

## Deploying with an existing project

* Install [Cruft](https://github.com/cruft/cruft) (also manages updates) or [Cookiecutter](https://cookiecutter.readthedocs.io/en/stable/installation.html).
* Create `.devcontainer` in the project root by running the command

  ```bash
  cruft create https://github.com/maresb/cookiecutter-micromamba-devcontainer
  ```

  or

  ```bash
  cookiecutter https://github.com/maresb/cookiecutter-micromamba-devcontainer
  ```

  You will be asked values for the following variables, which are stored in [`.devcontainer/.cruft.json`](.devcontainer/.cruft.json):

  * `package_name`: The name of the main package of your project, as you would `import` it from Python.
  * `timezone`: The [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) to configure in the devcontainer.
  * `packages_dir`: The directory where `package_name` is located (often `src`), or `.` for the project root.

* The project root should contain the subdirectory `[packages_dir]/[package_name]`, and moreover this subdirectory should contain an `__init__.py` file.
* If your project uses Docker, ensure that your `.dockerignore` contains `.devcontainer/cache`.
* Customize `.devcontainer/dev-conda-environment.yaml` with your desired Conda development packages.
* Customize `.devcontainer/dev.Dockerfile` to install (a skeleton of) your project, preferrably in editable mode (e.g. `pip install -e .`). This way the project dependencies will be installed in the devcontainer.
* Customize the `extensions` and `settings` in `.devcontainer/devcontainer.json`.
* Press Ctrl+Shift+P and select "Remote-Containers: Rebuild and Reopen in Container", and if all goes well, this will load successfully.

## Troubleshooting / Quickstart

For more information, see [micromamba-devcontainer](https://github.com/maresb/micromamba-devcontainer#troubleshooting).
