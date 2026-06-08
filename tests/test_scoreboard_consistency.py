"""Tests for scoreboard objective consistency between setup and uninstall,
and that objectives used across functions are properly declared."""

import re

import pytest

from conftest import BF_FUNCTIONS_DIR


def _extract_objectives_added(lines):
    """Extract objective names from 'scoreboard objectives add <name> ...' lines."""
    pattern = re.compile(r"scoreboard\s+objectives\s+add\s+(\S+)")
    return {m.group(1) for line in lines for m in [pattern.search(line)] if m}


def _extract_objectives_removed(lines):
    """Extract objective names from 'scoreboard objectives remove <name>' lines."""
    pattern = re.compile(r"scoreboard\s+objectives\s+remove\s+(\S+)")
    return {m.group(1) for line in lines for m in [pattern.search(line)] if m}


def _extract_objectives_used_in_file(path):
    """Extract all scoreboard objective names referenced in a .mcfunction file."""
    text = path.read_text(encoding="utf-8")
    # Matches objective names in contexts like:
    #   scoreboard players ... <player> <objective>
    #   scores={<objective>=...}
    #   score ... <objective> matches ...
    used = set()
    # Pattern 1: scores={obj=...} selectors
    for m in re.finditer(r"scores=\{([^}]+)\}", text):
        inner = m.group(1)
        for obj_match in re.finditer(r"(\w+)\s*=", inner):
            used.add(obj_match.group(1))
    # Pattern 2: scoreboard players <action> <target> <objective>
    for m in re.finditer(
        r"scoreboard\s+players\s+\w+\s+\S+\s+(\w+)", text
    ):
        used.add(m.group(1))
    # Pattern 3: score ... <objective> matches/>/</>=/<=/=
    for m in re.finditer(r"score\s+\S+\s+(\w+)\s+(?:matches|[><=!]+)", text):
        used.add(m.group(1))
    # Pattern 4: scoreboard players operation ... <objective> ... <objective>
    for m in re.finditer(
        r"scoreboard\s+players\s+operation\s+\S+\s+(\w+)\s+[%*/+-]=\s+\S+\s+(\w+)",
        text,
    ):
        used.add(m.group(1))
        used.add(m.group(2))
    return used


class TestSetupUninstallConsistency:
    def test_setup_declares_objectives(self, setup_lines):
        objectives = _extract_objectives_added(setup_lines)
        assert len(objectives) > 0, "setup.mcfunction should declare scoreboard objectives"

    def test_uninstall_removes_objectives(self, uninstall_lines):
        objectives = _extract_objectives_removed(uninstall_lines)
        assert len(objectives) > 0, "uninstall.mcfunction should remove scoreboard objectives"

    def test_all_setup_objectives_are_uninstalled(self, setup_lines, uninstall_lines):
        """Every objective added in setup must be removed in uninstall."""
        added = _extract_objectives_added(setup_lines)
        removed = _extract_objectives_removed(uninstall_lines)
        orphaned = added - removed
        assert not orphaned, (
            f"Objectives added in setup but not removed in uninstall: {orphaned}"
        )

    def test_no_extra_uninstall_objectives(self, setup_lines, uninstall_lines):
        """Uninstall should not remove objectives that were never added."""
        added = _extract_objectives_added(setup_lines)
        removed = _extract_objectives_removed(uninstall_lines)
        extra = removed - added
        assert not extra, (
            f"Objectives removed in uninstall but never added in setup: {extra}"
        )


class TestObjectiveUsage:
    # Squad-related objectives are used in Squad/*.mcfunction files but never
    # declared in setup.mcfunction — this is a known bug in the datapack.
    KNOWN_UNDECLARED_OBJECTIVES = {
        "bf_squad", "bf_sq_count", "bf_sq_dep",
        "bf_sq_prev", "bf_join_sq",
    }

    def test_used_objectives_are_declared(self, setup_lines):
        """Objectives used across all .mcfunction files should be declared in setup."""
        declared = _extract_objectives_added(setup_lines)
        # Some pseudo-objectives or score holder names are not real objectives
        false_positives = {
            "Game", "Red", "Blue", "Global", "RedCount", "BlueCount",
            "#menu_refresh", "#global_ui_id", "#temp_gc_id", "#temp_id",
            "#20", "#2", "#CONST_2", "#Center_X", "#Center_Z",
            "TempAX", "TempAZ", "TempBX", "TempBZ",
            "BoundMinX", "BoundMaxX", "BoundMinZ", "BoundMaxZ",
        }
        all_used = set()
        for mcf in BF_FUNCTIONS_DIR.rglob("*.mcfunction"):
            if mcf.name == "setup.mcfunction":
                continue
            all_used |= _extract_objectives_used_in_file(mcf)
        # Remove false positives (score holder names, not objectives)
        all_used -= false_positives
        undeclared = all_used - declared
        # Separate known bugs from new regressions
        unexpected = undeclared - self.KNOWN_UNDECLARED_OBJECTIVES
        assert not unexpected, (
            f"Objectives used but never declared in setup: {unexpected}"
        )

    def test_known_undeclared_squad_objectives_flagged(self, setup_lines):
        """Flag that Squad-related objectives are missing from setup (known bug)."""
        declared = _extract_objectives_added(setup_lines)
        missing = self.KNOWN_UNDECLARED_OBJECTIVES - declared
        assert missing == self.KNOWN_UNDECLARED_OBJECTIVES, (
            "Expected Squad objectives to still be missing from setup. "
            "If they were added, remove them from KNOWN_UNDECLARED_OBJECTIVES."
        )
