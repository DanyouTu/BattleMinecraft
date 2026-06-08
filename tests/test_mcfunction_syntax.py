"""Basic syntax validation for .mcfunction files."""

import re

import pytest

from conftest import BF_FUNCTIONS_DIR

# Valid top-level Minecraft commands (1.20.1)
VALID_COMMANDS = {
    "advancement", "attribute", "ban", "bossbar", "clear", "clone",
    "damage", "data", "datapack", "debug", "defaultgamemode",
    "deop", "difficulty", "effect", "enchant", "execute", "experience",
    "fill", "forceload", "function", "gamemode", "gamerule", "give",
    "item", "kick", "kill", "list", "locate", "loot", "me", "msg",
    "op", "particle", "place", "playsound", "recipe", "reload",
    "return", "ride", "say", "schedule", "scoreboard", "seed",
    "setblock", "setworldspawn", "spawnpoint", "spectate", "spreadplayers",
    "stopsound", "summon", "tag", "team", "teleport", "tell",
    "tellraw", "time", "title", "tm", "tp", "trigger", "weather",
    "whitelist", "worldborder", "xp",
    # Mod commands used in this datapack
    "sh_health",
}


def _get_all_mcfunction_files():
    return sorted(BF_FUNCTIONS_DIR.rglob("*.mcfunction"))


def _get_command_lines(path):
    """Return (line_number, line) tuples for non-comment, non-blank lines."""
    result = []
    for i, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        stripped = line.strip()
        if stripped and not stripped.startswith("#"):
            result.append((i, stripped))
    return result


@pytest.mark.parametrize(
    "mcf_path",
    _get_all_mcfunction_files(),
    ids=[str(p.relative_to(BF_FUNCTIONS_DIR)) for p in _get_all_mcfunction_files()],
)
def test_commands_start_with_valid_keyword(mcf_path):
    """Every non-comment line must start with a recognized Minecraft command."""
    for lineno, line in _get_command_lines(mcf_path):
        first_word = line.split()[0] if line.split() else ""
        assert first_word in VALID_COMMANDS, (
            f"{mcf_path.relative_to(BF_FUNCTIONS_DIR)}:{lineno} "
            f"starts with unknown command '{first_word}'"
        )


@pytest.mark.parametrize(
    "mcf_path",
    _get_all_mcfunction_files(),
    ids=[str(p.relative_to(BF_FUNCTIONS_DIR)) for p in _get_all_mcfunction_files()],
)
def test_no_trailing_whitespace_on_commands(mcf_path):
    """Command lines should not have excessive trailing whitespace."""
    for lineno, line in enumerate(
        mcf_path.read_text(encoding="utf-8").splitlines(), 1
    ):
        if line.strip() and not line.strip().startswith("#"):
            # Allow up to 1 trailing space (some editors add it)
            trailing = len(line) - len(line.rstrip())
            assert trailing <= 1, (
                f"{mcf_path.relative_to(BF_FUNCTIONS_DIR)}:{lineno} "
                f"has {trailing} trailing whitespace characters"
            )


@pytest.mark.parametrize(
    "mcf_path",
    _get_all_mcfunction_files(),
    ids=[str(p.relative_to(BF_FUNCTIONS_DIR)) for p in _get_all_mcfunction_files()],
)
def test_balanced_brackets(mcf_path):
    """Check that curly braces, square brackets, and parentheses are balanced
    on each non-comment line."""
    for lineno, line in _get_command_lines(mcf_path):
        for open_ch, close_ch, name in [
            ("{", "}", "curly braces"),
            ("[", "]", "square brackets"),
        ]:
            depth = 0
            in_string = False
            prev_char = ""
            for ch in line:
                if ch == '"' and prev_char != "\\":
                    in_string = not in_string
                if not in_string:
                    if ch == open_ch:
                        depth += 1
                    elif ch == close_ch:
                        depth -= 1
                prev_char = ch
            assert depth == 0, (
                f"{mcf_path.relative_to(BF_FUNCTIONS_DIR)}:{lineno} "
                f"has unbalanced {name} (depth={depth})"
            )


def test_consistent_line_endings(all_mcfunction_files):
    """All mcfunction files should use the same line ending style."""
    crlf_files = []
    lf_files = []
    for mcf in all_mcfunction_files:
        raw = mcf.read_bytes()
        if b"\r\n" in raw:
            crlf_files.append(str(mcf.relative_to(BF_FUNCTIONS_DIR)))
        elif b"\n" in raw:
            lf_files.append(str(mcf.relative_to(BF_FUNCTIONS_DIR)))
    # All files should use the same convention
    if crlf_files and lf_files:
        assert False, (
            f"Mixed line endings: {len(crlf_files)} files use CRLF, "
            f"{len(lf_files)} files use LF. "
            f"LF files: {lf_files[:5]}"
        )
