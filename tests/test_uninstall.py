"""Tests for the uninstall/cleanup procedure."""

import re

import pytest

from conftest import BF_FUNCTIONS_DIR


class TestUninstallCompleteness:
    def _text(self):
        return (BF_FUNCTIONS_DIR / "uninstall.mcfunction").read_text(encoding="utf-8")

    def test_kills_all_datapack_entities(self):
        text = self._text()
        expected_tags = [
            "bf_flag", "bf_node", "bf_flag_item", "bf_node_item",
            "bf_base_red", "bf_base_blue", "bf_spawn_point",
        ]
        for tag in expected_tags:
            assert tag in text, (
                f"uninstall must kill entities with tag {tag}"
            )

    def test_removes_player_tags(self):
        text = self._text()
        assert "tag @a remove IsSafe" in text
        assert "tag @a remove in_lobby" in text

    def test_clears_player_effects(self):
        text = self._text()
        assert "effect clear @a" in text

    def test_clears_player_inventory(self):
        text = self._text()
        assert "clear @a" in text

    def test_clears_scheduled_functions(self):
        text = self._text()
        assert "schedule clear" in text

    def test_kills_all_armor_stands(self):
        """Final safety net: kill all armor stands."""
        text = self._text()
        assert "kill @e[type=armor_stand]" in text

    def test_sends_uninstall_message(self):
        text = self._text()
        assert "tellraw @a" in text
