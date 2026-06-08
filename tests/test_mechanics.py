"""Tests for core game mechanics: capture, bleed, death, boundary, bossbar, base protection."""

import re

import pytest

from conftest import BF_FUNCTIONS_DIR


class TestCaptureMechanic:
    def _text(self):
        return (BF_FUNCTIONS_DIR / "mechanics" / "capture.mcfunction").read_text(
            encoding="utf-8"
        )

    def test_initializes_flag_items(self):
        text = self._text()
        assert "bf_flag_item" in text
        assert "tag @s add bf_flag" in text

    def test_capture_increments_for_red(self):
        text = self._text()
        assert "team=Red" in text
        assert "bf_capture" in text
        assert "add @s bf_capture 1" in text

    def test_capture_decrements_for_blue(self):
        text = self._text()
        assert "team=Blue" in text
        assert "remove @s bf_capture 1" in text

    def test_red_captures_at_100(self):
        text = self._text()
        assert "bf_capture=100" in text
        assert "bf_owner 1" in text

    def test_blue_captures_at_negative_100(self):
        text = self._text()
        assert "bf_capture=-100" in text
        assert "bf_owner 2" in text

    def test_neutral_zone_resets_owner(self):
        text = self._text()
        assert "bf_capture=-50..50" in text
        assert "bf_owner 0" in text

    def test_visual_feedback_wool_colors(self):
        text = self._text()
        assert "white_wool" in text
        assert "red_wool" in text
        assert "blue_wool" in text

    def test_triggers_menu_refresh_on_ownership_change(self):
        text = self._text()
        assert "#menu_refresh bf_temp 1" in text

    def test_gives_glowing_effect(self):
        text = self._text()
        assert "effect give @s minecraft:glowing" in text

    def test_only_runs_during_game(self):
        """Capture progress should only change when gamestate is 1."""
        text = self._text()
        for line in text.splitlines():
            if "bf_capture 1" in line and "add" in line:
                assert "bf_gamestate matches 1" in line
            if "bf_capture 1" in line and "remove" in line:
                assert "bf_gamestate matches 1" in line


class TestBleedMechanic:
    def _text(self):
        return (BF_FUNCTIONS_DIR / "mechanics" / "bleed.mcfunction").read_text(
            encoding="utf-8"
        )

    def test_timer_increments(self):
        text = self._text()
        assert "add Global bf_timer 1" in text

    def test_timer_resets_at_20(self):
        text = self._text()
        assert "bf_timer matches 20" in text

    def test_counts_flags_per_team(self):
        text = self._text()
        assert "RedCount" in text
        assert "BlueCount" in text

    def test_deducts_tickets_from_losing_team(self):
        text = self._text()
        assert "remove Blue bf_tickets" in text
        assert "remove Red bf_tickets" in text

    def test_only_bleeds_during_game(self):
        text = self._text()
        for line in text.splitlines():
            if "remove" in line and "bf_tickets" in line:
                assert "bf_gamestate matches 1" in line


class TestDeathMechanic:
    def _text(self):
        return (BF_FUNCTIONS_DIR / "mechanics" / "death.mcfunction").read_text(
            encoding="utf-8"
        )

    def test_detects_deaths(self):
        text = self._text()
        assert "bf_deaths=1.." in text

    def test_calls_death_trigger(self):
        text = self._text()
        assert "function bf:mechanics/death_trigger" in text

    def test_countdown_timer(self):
        text = self._text()
        assert "bf_cam_timer" in text

    def test_returns_to_lobby_on_timeout(self):
        text = self._text()
        assert "function bf:mechanics/return_lobby" in text


class TestDeathTrigger:
    def _text(self):
        return (BF_FUNCTIONS_DIR / "mechanics" / "death_trigger.mcfunction").read_text(
            encoding="utf-8"
        )

    def test_deducts_ticket_for_red(self):
        text = self._text()
        assert "team=Red" in text
        assert "remove Red bf_tickets 1" in text

    def test_deducts_ticket_for_blue(self):
        text = self._text()
        assert "team=Blue" in text
        assert "remove Blue bf_tickets 1" in text

    def test_resets_death_count(self):
        text = self._text()
        assert "bf_deaths 0" in text

    def test_switches_to_spectator(self):
        text = self._text()
        assert "gamemode spectator @s" in text

    def test_sets_cam_timer(self):
        text = self._text()
        assert "bf_cam_timer 100" in text


class TestBoundaryMechanic:
    def _text(self):
        return (BF_FUNCTIONS_DIR / "mechanics" / "boundary.mcfunction").read_text(
            encoding="utf-8"
        )

    def test_reads_player_coordinates(self):
        text = self._text()
        assert "Pos[0]" in text
        assert "Pos[2]" in text

    def test_checks_all_four_boundaries(self):
        text = self._text()
        assert "BoundMinX" in text
        assert "BoundMaxX" in text
        assert "BoundMinZ" in text
        assert "BoundMaxZ" in text

    def test_tags_safe_players(self):
        text = self._text()
        assert "tag @a[gamemode=survival] add IsSafe" in text

    def test_removes_safe_for_out_of_bounds(self):
        text = self._text()
        assert "tag @s remove IsSafe" in text

    def test_spawns_direction_pointer(self):
        text = self._text()
        assert "bf_pointer" in text

    def test_garbage_collects_pointers(self):
        text = self._text()
        assert "bf_garbage" in text
        assert "kill @e[type=text_display,tag=bf_pointer,tag=bf_garbage]" in text

    def test_warns_out_of_bounds_players(self):
        text = self._text()
        assert "wither" in text


class TestBaseProtection:
    def _text(self):
        return (BF_FUNCTIONS_DIR / "mechanics" / "base_protection.mcfunction").read_text(
            encoding="utf-8"
        )

    def test_detects_enemy_in_base(self):
        text = self._text()
        assert "in_enemy_base" in text

    def test_uses_radius_detection(self):
        text = self._text()
        # 50-block diameter detection zone
        assert "dx=50" in text
        assert "dz=50" in text

    def test_countdown_timer_increments(self):
        text = self._text()
        assert "bf_base_warn 1" in text

    def test_resets_timer_when_outside(self):
        text = self._text()
        assert "tag=!in_enemy_base" in text
        assert "bf_base_warn 0" in text

    def test_kills_at_threshold(self):
        text = self._text()
        assert "bf_base_warn=260" in text
        assert "damage @s 1000" in text

    def test_applies_darkness_effect(self):
        text = self._text()
        assert "minecraft:darkness" in text


class TestBossbar:
    def test_bossbar_setup_in_setup(self, setup_lines):
        text = "\n".join(setup_lines)
        assert "bossbar add bf:red_tickets" in text
        assert "bossbar add bf:blue_tickets" in text

    def test_bossbar_removed_in_uninstall(self, uninstall_lines):
        text = "\n".join(uninstall_lines)
        assert "bossbar remove bf:red_tickets" in text
        assert "bossbar remove bf:blue_tickets" in text

    def test_bossbar_updates_in_tick(self):
        text = (BF_FUNCTIONS_DIR / "tick.mcfunction").read_text(encoding="utf-8")
        assert "bossbar bf:red_tickets" in text
        assert "bossbar bf:blue_tickets" in text

    def test_bossbar_display_names_set(self):
        text = (BF_FUNCTIONS_DIR / "mechanics" / "bossbar.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "bf:red_tickets" in text
        assert "bf:blue_tickets" in text
