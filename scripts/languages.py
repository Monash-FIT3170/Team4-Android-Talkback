"""
This script is intended to make the process of translating the app into multiple
languages more automated.
"""
from pathlib import Path
import json


LanguageCode = str
TranslationDict = dict[str, str]


def _load_translation_dicts(translations_dir: Path) -> dict[LanguageCode, TranslationDict]:
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


def _get_all_unique_keys(translation_dicts: dict[LanguageCode, TranslationDict]) -> list[str]:
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


def _generate_chatgpt_prompt(language_code: str, keys: list[str], translation_dicts: dict[LanguageCode, TranslationDict], preferred_language: str="en") -> str:
    prompt = f"Could you please translate only the *values* of the following JSON into the language corresponding to '{language_code}'?\n"
    prompt_dict = {}
    for key in keys:
        if key in translation_dicts[preferred_language]:
            prompt_dict[key] = translation_dicts[preferred_language][key]
        else:
            # Find this key in any of the other dicts
            found_str = None
            for other_language_code, d in translation_dicts.items():
                # Shouldn't be translating a language into itself
                if other_language_code == language_code:
                    continue

                if key in d:
                    found_str = d[key]
                    break

            if found_str is None:
                raise ValueError(f"Could not find key '{key}' in any of the given translation dicts ({list(translation_dicts.keys())}), so cannot translate")
            prompt_dict[key] = found_str

    prompt_dict_json = json.dumps(prompt_dict, indent=4)
    prompt += prompt_dict_json
    return prompt


if __name__ == "__main__":
    translation_dicts = _load_translation_dicts(Path("application/assets/translations"))
    print(f"Found language codes: {list(translation_dicts.keys())}")
    unique_keys = _get_all_unique_keys(translation_dicts)
    print(f"Found {len(unique_keys)} unique keys across all translation files")
    for language_code, translation_dict in translation_dicts.items():
        missing_keys = _find_missing_keys(translation_dict=translation_dict, unique_keys=unique_keys)
        print(f"{language_code:<5} has {len(missing_keys):>2} missing keys")
        if len(missing_keys) > 0:
            print(_generate_chatgpt_prompt(language_code=language_code, keys=missing_keys, translation_dicts=translation_dicts))
            print("\n\n")