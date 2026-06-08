"""Tests that every `function bf:...` call in .mcfunction files
resolves to an existing .mcfunction file on disk."""

import re
from pathlib import Path

import pytest

from conftest import BF_FUNCTIONS_DIR


def _extract_function_calls(text):
    """Extract all 'function <namespace>:<path>' references from mcfunction text."""
    return re.findall(r"\bfunction\s+([\w]+:[\w/]+)", text)


def _collect_all_calls():
    """Yield (source_file_rel, called_function) tuples."""
    for mcf in sorted(BF_FUNCTIONS_DIR.rglob("*.mcfunction")):
        text = mcf.read_text(encoding="utf-8")
        rel = mcf.relative_to(BF_FUNCTIONS_DIR)
        for call in _extract_function_calls(text):
            yield str(rel), call


ALL_CALLS = list(_collect_all_calls())


# Calls where the on-disk path uses different casing than the function reference.
# These are real bugs: Minecraft function namespaces are lowercase on Linux.
KNOWN_CASE_BUGS = {
    "bf:mechanics/squad/confirm_join",
    "bf:mechanics/squad/check_and_print_line",
    "bf:mechanics/squad/print_join_list",
}


@pytest.mark.parametrize(
    "source_file,func_ref",
    ALL_CALLS,
    ids=[f"{src} -> {ref}" for src, ref in ALL_CALLS],
)
def test_function_reference_resolves(source_file, func_ref):
    """Each `function bf:<path>` call must point to an existing .mcfunction file."""
    namespace, func_path = func_ref.split(":", 1)
    if namespace != "bf":
        pytest.skip(f"Skipping non-bf namespace: {namespace}")
    if func_ref in KNOWN_CASE_BUGS:
        pytest.xfail(
            f"Known bug: '{func_ref}' uses lowercase 'squad' but directory is 'Squad'"
        )
    expected_file = BF_FUNCTIONS_DIR / f"{func_path}.mcfunction"
    assert expected_file.is_file(), (
        f"{source_file} calls 'function {func_ref}' but "
        f"{expected_file.relative_to(BF_FUNCTIONS_DIR)} does not exist"
    )


def test_no_self_referencing_functions(all_mcfunction_files):
    """A function should not directly call itself (infinite recursion)
    unless it is an intentional recursive iterator."""
    known_recursive = {"mechanics/menu/iterator.mcfunction"}
    for mcf in all_mcfunction_files:
        rel = str(mcf.relative_to(BF_FUNCTIONS_DIR)).replace("\\", "/")
        if rel in known_recursive:
            continue
        func_ns_path = "bf:" + rel.replace(".mcfunction", "").replace("\\", "/")
        text = mcf.read_text(encoding="utf-8")
        calls = _extract_function_calls(text)
        assert func_ns_path not in calls, (
            f"{rel} calls itself ({func_ns_path}) — possible infinite recursion"
        )
