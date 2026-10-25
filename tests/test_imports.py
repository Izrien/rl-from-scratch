"""Smoke test: every package imports and says what goes in it."""

import importlib

import pytest

PACKAGES = ["src.nn", "src.tabular", "src.dqn"]


@pytest.mark.parametrize("name", PACKAGES)
def test_package_imports_with_a_docstring(name: str) -> None:
    module = importlib.import_module(name)

    assert module.__doc__
