"""Shared fixtures for BattleMinecraft datapack tests."""

import json
import re
from pathlib import Path

import pytest

REPO_ROOT = Path(__file__).resolve().parent.parent
DATA_DIR = REPO_ROOT / "data"
BF_FUNCTIONS_DIR = DATA_DIR / "bf" / "functions"


@pytest.fixture(scope="session")
def repo_root():
    return REPO_ROOT


@pytest.fixture(scope="session")
def data_dir():
    return DATA_DIR


@pytest.fixture(scope="session")
def bf_functions_dir():
    return BF_FUNCTIONS_DIR


@pytest.fixture(scope="session")
def all_mcfunction_files():
    """Return all .mcfunction files in the datapack."""
    return sorted(BF_FUNCTIONS_DIR.rglob("*.mcfunction"))


@pytest.fixture(scope="session")
def all_json_files():
    """Return all .json files in the data directory (excluding .git)."""
    return sorted(p for p in DATA_DIR.rglob("*.json"))


@pytest.fixture(scope="session")
def mcfunction_contents(all_mcfunction_files):
    """Map from relative function path to list of non-comment, non-blank lines."""
    result = {}
    for path in all_mcfunction_files:
        rel = path.relative_to(BF_FUNCTIONS_DIR)
        lines = []
        for line in path.read_text(encoding="utf-8").splitlines():
            stripped = line.strip()
            if stripped and not stripped.startswith("#"):
                lines.append(stripped)
        result[str(rel)] = lines
    return result


@pytest.fixture(scope="session")
def function_call_pattern():
    """Compiled regex that matches `function <namespace>:<path>` calls."""
    return re.compile(r"\bfunction\s+([\w]+:[\w/]+)")


@pytest.fixture(scope="session")
def setup_lines():
    """Return the non-comment lines of setup.mcfunction."""
    path = BF_FUNCTIONS_DIR / "setup.mcfunction"
    return [
        line.strip()
        for line in path.read_text(encoding="utf-8").splitlines()
        if line.strip() and not line.strip().startswith("#")
    ]


@pytest.fixture(scope="session")
def uninstall_lines():
    """Return the non-comment lines of uninstall.mcfunction."""
    path = BF_FUNCTIONS_DIR / "uninstall.mcfunction"
    return [
        line.strip()
        for line in path.read_text(encoding="utf-8").splitlines()
        if line.strip() and not line.strip().startswith("#")
    ]
