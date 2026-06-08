"""Tests for the overall datapack structure and pack.mcmeta validity."""

import json
from pathlib import Path


def test_pack_mcmeta_exists(repo_root):
    assert (repo_root / "pack.mcmeta").is_file(), "pack.mcmeta is missing"


def test_pack_mcmeta_valid_json(repo_root):
    text = (repo_root / "pack.mcmeta").read_text(encoding="utf-8")
    data = json.loads(text)
    assert "pack" in data, "pack.mcmeta must have a top-level 'pack' key"


def test_pack_mcmeta_has_format(repo_root):
    data = json.loads((repo_root / "pack.mcmeta").read_text(encoding="utf-8"))
    assert "pack_format" in data["pack"], "Missing pack_format in pack.mcmeta"
    assert isinstance(data["pack"]["pack_format"], int)


def test_pack_mcmeta_has_description(repo_root):
    data = json.loads((repo_root / "pack.mcmeta").read_text(encoding="utf-8"))
    assert "description" in data["pack"], "Missing description in pack.mcmeta"
    assert len(data["pack"]["description"]) > 0


def test_pack_format_matches_1_20_1(repo_root):
    """Minecraft 1.20.1 uses pack_format 15."""
    data = json.loads((repo_root / "pack.mcmeta").read_text(encoding="utf-8"))
    assert data["pack"]["pack_format"] == 15, (
        f"Expected pack_format 15 for 1.20.1, got {data['pack']['pack_format']}"
    )


def test_data_directory_exists(data_dir):
    assert data_dir.is_dir(), "data/ directory is missing"


def test_bf_namespace_exists(data_dir):
    assert (data_dir / "bf").is_dir(), "data/bf/ namespace directory is missing"


def test_functions_directory_exists(bf_functions_dir):
    assert bf_functions_dir.is_dir(), "data/bf/functions/ directory is missing"


def test_minecraft_tags_exist(data_dir):
    tags_dir = data_dir / "minecraft" / "tags" / "functions"
    assert tags_dir.is_dir(), "data/minecraft/tags/functions/ directory is missing"


def test_load_json_exists(data_dir):
    assert (data_dir / "minecraft" / "tags" / "functions" / "load.json").is_file()


def test_tick_json_exists(data_dir):
    assert (data_dir / "minecraft" / "tags" / "functions" / "tick.json").is_file()


def test_expected_subdirectories_exist(bf_functions_dir):
    expected = {"game", "mechanics", "class", "team"}
    actual = {d.name for d in bf_functions_dir.iterdir() if d.is_dir()}
    missing = expected - actual
    assert not missing, f"Missing subdirectories: {missing}"


def test_no_empty_mcfunction_files(all_mcfunction_files):
    empty = [
        str(f.relative_to(f.parents[4]))
        for f in all_mcfunction_files
        if f.stat().st_size == 0
    ]
    assert not empty, f"Empty .mcfunction files found: {empty}"
