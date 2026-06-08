"""Tests for the class/loadout selection system."""

import re

import pytest

from conftest import BF_FUNCTIONS_DIR

CLASS_DIR = BF_FUNCTIONS_DIR / "class"
CLASS_FILES = {
    1: "assault",
    2: "medic",
    3: "support",
    4: "recon",
    5: "assassin",
}


class TestClassSelect:
    def test_select_file_exists(self):
        assert (CLASS_DIR / "select.mcfunction").is_file()

    def test_select_maps_all_class_ids(self):
        text = (CLASS_DIR / "select.mcfunction").read_text(encoding="utf-8")
        for class_id, class_name in CLASS_FILES.items():
            expected = f"bf:class/{class_name}"
            assert expected in text, (
                f"select.mcfunction must reference {expected} for class ID {class_id}"
            )

    def test_select_resets_class_score(self):
        text = (CLASS_DIR / "select.mcfunction").read_text(encoding="utf-8")
        assert "scoreboard players set @s bf_class 0" in text, (
            "select.mcfunction must reset bf_class to 0 after processing"
        )

    @pytest.mark.parametrize(
        "class_id,class_name",
        CLASS_FILES.items(),
        ids=CLASS_FILES.values(),
    )
    def test_select_checks_correct_score(self, class_id, class_name):
        text = (CLASS_DIR / "select.mcfunction").read_text(encoding="utf-8")
        pattern = f"bf_class={class_id}"
        assert pattern in text, (
            f"select.mcfunction must check bf_class={class_id} for {class_name}"
        )


class TestClassFiles:
    @pytest.mark.parametrize("class_name", CLASS_FILES.values())
    def test_class_file_exists(self, class_name):
        path = CLASS_DIR / f"{class_name}.mcfunction"
        assert path.is_file(), f"Missing class file: {class_name}.mcfunction"

    @pytest.mark.parametrize("class_name", CLASS_FILES.values())
    def test_class_clears_inventory(self, class_name):
        """Each class should clear the player's inventory before equipping."""
        text = (CLASS_DIR / f"{class_name}.mcfunction").read_text(encoding="utf-8")
        assert "clear @s" in text, (
            f"{class_name}.mcfunction must clear player inventory"
        )

    @pytest.mark.parametrize("class_name", CLASS_FILES.values())
    def test_class_sets_health(self, class_name):
        """Each class should set player health via sh_health."""
        text = (CLASS_DIR / f"{class_name}.mcfunction").read_text(encoding="utf-8")
        assert "sh_health set @s" in text, (
            f"{class_name}.mcfunction must set player health"
        )

    @pytest.mark.parametrize("class_name", CLASS_FILES.values())
    def test_class_gives_speed_effect(self, class_name):
        """Each class should grant a speed effect."""
        text = (CLASS_DIR / f"{class_name}.mcfunction").read_text(encoding="utf-8")
        assert "effect give @s speed" in text, (
            f"{class_name}.mcfunction must grant a speed effect"
        )

    @pytest.mark.parametrize("class_name", CLASS_FILES.values())
    def test_class_has_melee_weapon(self, class_name):
        """Each class should include a melee weapon (netherite_sword)."""
        text = (CLASS_DIR / f"{class_name}.mcfunction").read_text(encoding="utf-8")
        assert "netherite_sword" in text, (
            f"{class_name}.mcfunction must include a melee weapon"
        )

    @pytest.mark.parametrize("class_name", CLASS_FILES.values())
    def test_class_equips_armor(self, class_name):
        """Each class should equip all four armor slots."""
        text = (CLASS_DIR / f"{class_name}.mcfunction").read_text(encoding="utf-8")
        for slot in ["armor.head", "armor.chest", "armor.legs", "armor.feet"]:
            assert slot in text, (
                f"{class_name}.mcfunction must equip {slot}"
            )

    @pytest.mark.parametrize("class_name", CLASS_FILES.values())
    def test_class_sends_tellraw(self, class_name):
        """Each class should display a confirmation message."""
        text = (CLASS_DIR / f"{class_name}.mcfunction").read_text(encoding="utf-8")
        assert "tellraw @s" in text, (
            f"{class_name}.mcfunction must send a tellraw confirmation"
        )


class TestClassBalance:
    def test_assassin_has_low_health(self):
        text = (CLASS_DIR / "assassin.mcfunction").read_text(encoding="utf-8")
        m = re.search(r"sh_health set @s (\d+)", text)
        assert m, "assassin must set health"
        health = int(m.group(1))
        assert health < 10, f"Assassin should have low health, got {health}"

    def test_non_assassin_classes_have_standard_health(self):
        for name in ["assault", "medic", "support", "recon"]:
            text = (CLASS_DIR / f"{name}.mcfunction").read_text(encoding="utf-8")
            m = re.search(r"sh_health set @s (\d+)", text)
            assert m, f"{name} must set health"
            health = int(m.group(1))
            assert health >= 20, (
                f"{name} should have ≥20 health, got {health}"
            )
