#!/usr/bin/env python3

import subprocess
from pathlib import Path

ENVIRONMENT_FILES = [
    "conda-environment.yaml",
    ".devcontainer/dev-conda-environment.yaml",
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
    subprocess.run(cmd, check=True)


if __name__ == "__main__":
    main()