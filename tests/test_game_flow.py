"""Tests for game flow: start, tick, check_win, end_game, reset."""

import re

import pytest

from conftest import BF_FUNCTIONS_DIR


class TestGameStart:
    def test_sets_tickets(self):
        text = (BF_FUNCTIONS_DIR / "game" / "game_start.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "Red bf_tickets 1000" in text
        assert "Blue bf_tickets 1000" in text

    def test_sets_gamestate_to_1(self):
        text = (BF_FUNCTIONS_DIR / "game" / "game_start.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "Game bf_gamestate 1" in text

    def test_resets_flags(self):
        text = (BF_FUNCTIONS_DIR / "game" / "game_start.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "bf_capture 0" in text
        assert "bf_owner 0" in text

    def test_teleports_both_teams(self):
        text = (BF_FUNCTIONS_DIR / "game" / "game_start.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "team=Red" in text
        assert "team=Blue" in text

    def test_displays_start_title(self):
        text = (BF_FUNCTIONS_DIR / "game" / "game_start.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "title @a title" in text


class TestCheckWin:
    def test_checks_both_team_ticket_depletion(self):
        text = (BF_FUNCTIONS_DIR / "game" / "check_win.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "Red bf_tickets matches ..0" in text
        assert "Blue bf_tickets matches ..0" in text

    def test_calls_end_game(self):
        text = (BF_FUNCTIONS_DIR / "game" / "check_win.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "function bf:game/end_game" in text

    def test_both_win_conditions_present(self):
        """Both Red-wins and Blue-wins must be handled."""
        text = (BF_FUNCTIONS_DIR / "game" / "check_win.mcfunction").read_text(
            encoding="utf-8"
        )
        lines = [l.strip() for l in text.splitlines() if l.strip() and not l.strip().startswith("#")]
        assert len(lines) == 2, (
            f"check_win should have exactly 2 condition lines, got {len(lines)}"
        )


class TestEndGame:
    def test_sets_gamestate_to_2(self):
        text = (BF_FUNCTIONS_DIR / "game" / "end_game.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "Game bf_gamestate 2" in text

    def test_displays_winner(self):
        text = (BF_FUNCTIONS_DIR / "game" / "end_game.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "BLUE WINS" in text or "blue" in text.lower()
        assert "RED WINS" in text or "red" in text.lower()

    def test_schedules_reset(self):
        text = (BF_FUNCTIONS_DIR / "game" / "end_game.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "schedule function bf:game/reset" in text

    def test_restores_nametag_visibility(self):
        text = (BF_FUNCTIONS_DIR / "game" / "end_game.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "nametagVisibility always" in text


class TestReset:
    def test_sets_gamestate_to_0(self):
        text = (BF_FUNCTIONS_DIR / "game" / "reset.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "Game bf_gamestate 0" in text

    def test_clears_player_inventory(self):
        text = (BF_FUNCTIONS_DIR / "game" / "reset.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "clear @a" in text

    def test_resets_tickets(self):
        text = (BF_FUNCTIONS_DIR / "game" / "reset.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "Red bf_tickets 1000" in text
        assert "Blue bf_tickets 1000" in text

    def test_resets_flags(self):
        text = (BF_FUNCTIONS_DIR / "game" / "reset.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "bf_capture 0" in text
        assert "bf_owner 0" in text

    def test_removes_lobby_tag(self):
        text = (BF_FUNCTIONS_DIR / "game" / "reset.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "tag @a remove in_lobby" in text


class TestTickMainLoop:
    def test_tick_calls_core_subsystems(self):
        text = (BF_FUNCTIONS_DIR / "tick.mcfunction").read_text(encoding="utf-8")
        expected_calls = [
            "bf:mechanics/capture",
            "bf:mechanics/setup_bases",
            "bf:mechanics/base_protection",
            "bf:mechanics/bleed",
            "bf:mechanics/boundary",
            "bf:mechanics/death",
            "bf:mechanics/bossbar",
        ]
        for call in expected_calls:
            assert call in text, f"tick.mcfunction must call {call}"

    def test_tick_checks_gamestate_for_win(self):
        text = (BF_FUNCTIONS_DIR / "tick.mcfunction").read_text(encoding="utf-8")
        assert "bf_gamestate matches 1" in text
        assert "bf:game/check_win" in text

    def test_tick_enables_triggers(self):
        text = (BF_FUNCTIONS_DIR / "tick.mcfunction").read_text(encoding="utf-8")
        for trigger in ["bf_click_id", "bf_click_act", "bf_class"]:
            assert f"enable @a {trigger}" in text, (
                f"tick.mcfunction must enable trigger {trigger}"
            )

    def test_tick_handles_cooldown(self):
        text = (BF_FUNCTIONS_DIR / "tick.mcfunction").read_text(encoding="utf-8")
        assert "bf_cd" in text, "tick.mcfunction must handle cooldown (bf_cd)"

    def test_tick_resets_menu_refresh(self):
        text = (BF_FUNCTIONS_DIR / "tick.mcfunction").read_text(encoding="utf-8")
        assert "#menu_refresh bf_temp 0" in text


class TestGameStateTransitions:
    """Verify that the game state machine is consistent:
    0 (idle) -> 1 (running) -> 2 (ended) -> 0 (reset)."""

    def test_start_transitions_0_to_1(self):
        text = (BF_FUNCTIONS_DIR / "game" / "game_start.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "bf_gamestate 1" in text

    def test_end_transitions_to_2(self):
        text = (BF_FUNCTIONS_DIR / "game" / "end_game.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "bf_gamestate 2" in text

    def test_reset_transitions_to_0(self):
        text = (BF_FUNCTIONS_DIR / "game" / "reset.mcfunction").read_text(
            encoding="utf-8"
        )
        assert "bf_gamestate 0" in text

    def test_check_win_only_runs_during_state_1(self):
        text = (BF_FUNCTIONS_DIR / "tick.mcfunction").read_text(encoding="utf-8")
        # check_win is gated by gamestate == 1
        for line in text.splitlines():
            if "bf:game/check_win" in line:
                assert "bf_gamestate matches 1" in line, (
                    "check_win must only run when gamestate is 1"
                )
                break
        else:
            pytest.fail("check_win call not found in tick.mcfunction")
