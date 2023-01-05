#!/usr/bin/env python3

import subprocess
from pathlib import Path

ENVIRONMENT_FILES = [
    "conda-environment.yaml",
    ".devcontainer/dev-conda-environment.yaml",
]
PLATFORMS = [
    "linux-64",
    "osx-arm64",
]


def main():
    current_path: Path = Path(__file__).parent.resolve()
    cmd = ["conda-lock"]
    for env_file in ENVIRONMENT_FILES:
        env_file_path = current_path / env_file
        if env_file_path.exists():
            cmd.extend(["--file", str(env_file_path)])
        else:
            raise FileNotFoundError(f"File not found: {env_file_path}")
        for platform in PLATFORMS:
            cmd.extend(["--platform", platform])
    Path(current_path / "conda-lock.yml").unlink(missing_ok=True)
    subprocess.run(cmd, check=True)


if __name__ == "__main__":
    main()
