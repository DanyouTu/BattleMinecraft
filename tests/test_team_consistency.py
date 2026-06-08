"""Tests for team setup/teardown consistency and usage."""

import re

import pytest

from conftest import BF_FUNCTIONS_DIR


def _extract_teams_added(lines):
    """Extract team names from 'team add <name> ...' lines."""
    pattern = re.compile(r"team\s+add\s+(\S+)")
    return {m.group(1) for line in lines for m in [pattern.search(line)] if m}


def _extract_teams_removed(lines):
    """Extract team names from 'team remove <name>' lines."""
    pattern = re.compile(r"team\s+remove\s+(\S+)")
    return {m.group(1) for line in lines for m in [pattern.search(line)] if m}


class TestTeamSetup:
    def test_red_and_blue_teams_defined(self, setup_lines):
        teams = _extract_teams_added(setup_lines)
        assert "Red" in teams, "Red team must be defined in setup"
        assert "Blue" in teams, "Blue team must be defined in setup"

    def test_teams_have_colors(self, setup_lines):
        text = "\n".join(setup_lines)
        assert "team modify Red color red" in text
        assert "team modify Blue color blue" in text

    def test_friendly_fire_disabled(self, setup_lines):
        text = "\n".join(setup_lines)
        assert "team modify Red friendlyFire false" in text
        assert "team modify Blue friendlyFire false" in text


class TestTeamTeardown:
    def test_all_teams_removed_in_uninstall(self, setup_lines, uninstall_lines):
        added = _extract_teams_added(setup_lines)
        removed = _extract_teams_removed(uninstall_lines)
        orphaned = added - removed
        assert not orphaned, (
            f"Teams added in setup but not removed in uninstall: {orphaned}"
        )

    def test_no_extra_teams_removed(self, setup_lines, uninstall_lines):
        added = _extract_teams_added(setup_lines)
        removed = _extract_teams_removed(uninstall_lines)
        extra = removed - added
        assert not extra, (
            f"Teams removed in uninstall but never defined in setup: {extra}"
        )


class TestTeamUsage:
    def test_join_red_uses_red_team(self):
        path = BF_FUNCTIONS_DIR / "team" / "join_red.mcfunction"
        text = path.read_text(encoding="utf-8")
        assert "team join Red" in text

    def test_join_blue_uses_blue_team(self):
        path = BF_FUNCTIONS_DIR / "team" / "join_blue.mcfunction"
        text = path.read_text(encoding="utf-8")
        assert "team join Blue" in text

    def test_game_start_teleports_both_teams(self):
        path = BF_FUNCTIONS_DIR / "game" / "game_start.mcfunction"
        text = path.read_text(encoding="utf-8")
        assert "team=Red" in text, "game_start must handle Red team"
        assert "team=Blue" in text, "game_start must handle Blue team"
