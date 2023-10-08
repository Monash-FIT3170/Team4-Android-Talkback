"""
This script is intended to make the process of translating the app into multiple
languages more automated.
"""
from pathlib import Path
import json


TranslationDict = dict[str, str]

def _load_translation_dicts(translations_dir: Path) -> dict[str, TranslationDict]:
    """Loads all translation files into a dictionary of <language_code> -> dict"""
    # Map of language code -> translation dict
    translation_dicts = {}
    
    for file in translations_dir.iterdir():
        if file.name.endswith(".json"):
            # Strip the '.json' at end
            language_code = file.name[:-5]

            with open(file, "r") as f:
                translation_dicts[language_code] = json.load(f)

    return translation_dicts

def _get_all_unique_keys(translation_dicts: dict[str, TranslationDict]) -> list[str]:
    """Get all unique keys found across all translation dictionaries."""
    unique_keys = []
    for translation_dict in translation_dicts.values():
        unique_keys.extend(translation_dict.keys())

    return unique_keys


def _find_missing_keys(translation_dict: TranslationDict, unique_keys: list[str]):
    """Find any missing keys in 'd' based on global list of unique keys."""
    d_keys = set(translation_dict.keys())
    unique_keys = set(unique_keys)
    return unique_keys.difference(d_keys)


if __name__ == "__main__":
    translation_dicts = _load_translation_dicts(Path("application/assets/translations"))
    print(f"Found language codes: {list(translation_dicts.keys())}")
    unique_keys = _get_all_unique_keys(translation_dicts)
    print(f"Found {len(unique_keys)} unique keys across all translation files")
    for language_code, translation_dict in translation_dicts.items():
        missing_keys = _find_missing_keys(translation_dict=translation_dict, unique_keys=unique_keys)
        print(f"{language_code:<5} has {len(missing_keys):>2} missing keys")