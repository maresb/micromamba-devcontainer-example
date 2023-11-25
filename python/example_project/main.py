"""Example project main module."""

from cowsay import cow  # type: ignore  # (No available type stubs for cowsay)


def hello():
    """Cow says hello."""
    cow("Hello world!")
