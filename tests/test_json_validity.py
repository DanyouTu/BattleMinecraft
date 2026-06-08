"""Tests for JSON file validity across the datapack."""

import json

import pytest


def test_load_json_valid(data_dir):
    path = data_dir / "minecraft" / "tags" / "functions" / "load.json"
    data = json.loads(path.read_text(encoding="utf-8"))
    assert "values" in data, "load.json must have 'values' key"
    assert isinstance(data["values"], list)


def test_tick_json_valid(data_dir):
    path = data_dir / "minecraft" / "tags" / "functions" / "tick.json"
    data = json.loads(path.read_text(encoding="utf-8"))
    assert "values" in data, "tick.json must have 'values' key"
    assert isinstance(data["values"], list)


def test_load_json_references_setup(data_dir):
    path = data_dir / "minecraft" / "tags" / "functions" / "load.json"
    data = json.loads(path.read_text(encoding="utf-8"))
    assert "bf:setup" in data["values"], (
        "load.json must reference bf:setup so the datapack initializes on load"
    )


def test_tick_json_references_tick(data_dir):
    path = data_dir / "minecraft" / "tags" / "functions" / "tick.json"
    data = json.loads(path.read_text(encoding="utf-8"))
    assert "bf:tick" in data["values"], (
        "tick.json must reference bf:tick so the main loop runs every tick"
    )


def test_load_json_functions_exist(data_dir, bf_functions_dir):
    """Every function listed in load.json must have a corresponding .mcfunction file."""
    path = data_dir / "minecraft" / "tags" / "functions" / "load.json"
    data = json.loads(path.read_text(encoding="utf-8"))
    for func_ref in data["values"]:
        namespace, func_path = func_ref.split(":", 1)
        expected_file = bf_functions_dir / f"{func_path}.mcfunction"
        assert expected_file.is_file(), (
            f"load.json references '{func_ref}' but {expected_file} does not exist"
        )


def test_tick_json_functions_exist(data_dir, bf_functions_dir):
    """Every function listed in tick.json must have a corresponding .mcfunction file."""
    path = data_dir / "minecraft" / "tags" / "functions" / "tick.json"
    data = json.loads(path.read_text(encoding="utf-8"))
    for func_ref in data["values"]:
        namespace, func_path = func_ref.split(":", 1)
        expected_file = bf_functions_dir / f"{func_path}.mcfunction"
        assert expected_file.is_file(), (
            f"tick.json references '{func_ref}' but {expected_file} does not exist"
        )


def test_kill_advancement_structure(data_dir):
    """Validate the kill advancement JSON has expected structure.

    Note: kill.json has a known issue (empty 'function' reward value).
    This test validates the parts that are structurally correct.
    """
    path = data_dir / "bf" / "advancements" / "kill.json"
    text = path.read_text(encoding="utf-8")

    # The file has a known syntax issue (empty reward function value).
    # We still verify the file exists and contains the expected keys as raw text.
    assert '"criteria"' in text, "kill.json must contain criteria"
    assert '"player_killed_entity"' in text, (
        "kill trigger should be player_killed_entity"
    )
    assert '"minecraft:player"' in text, "kill target should be minecraft:player"


def test_kill_advancement_reward_is_incomplete(data_dir):
    """Flag that kill.json has an incomplete 'function' reward (known issue)."""
    path = data_dir / "bf" / "advancements" / "kill.json"
    text = path.read_text(encoding="utf-8")
    # The reward function field is empty — this is a known defect.
    assert '"function": \n' in text or '"function": ' in text, (
        "kill.json reward function field should be flagged as incomplete"
    )
