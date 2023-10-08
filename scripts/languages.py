"""
This script is intended to make the process of translating the app into multiple
languages more automated.
"""
from pathlib import Path
import json
import os

import dotenv
import openai

dotenv.load_dotenv()


ASK_GPT = True
TRANSLATIONS_DIR = Path("application/assets/translations")
if ASK_GPT:
    openai.api_key = os.environ["OPENAI_API_KEY"]


LanguageCode = str
TranslationDict = dict[str, str]


def _load_translation_dicts(translations_dir: Path) -> dict[LanguageCode, TranslationDict]:
    """Loads all translation files into a dictionary of <language_code> -> dict"""
    # Map of language code -> translation dict
    translation_dicts = {}
        
    files = sorted(translations_dir.iterdir())
    for file in files:
        if file.name.endswith(".json"):
            # Strip the '.json' at end
            language_code = file.name[:-5]

            with open(file, "r") as f:
                translation_dicts[language_code] = json.load(f)

    return translation_dicts


def _get_all_unique_keys(translation_dicts: dict[LanguageCode, TranslationDict]) -> set[str]:
    """Get all unique keys found across all translation dictionaries."""
    unique_keys = set()
    for translation_dict in translation_dicts.values():
        unique_keys.update(set(translation_dict.keys()))

    return unique_keys


def _find_missing_keys(translation_dict: TranslationDict, unique_keys: set[str]) -> set[str]:
    """Find any missing keys in 'd' based on global list of unique keys."""
    d_keys = set(translation_dict.keys())
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


def _get_chatgpt_response(prompt: str):
    """Get only the actual text of ChatGPT's reponse to the given 'prompt'."""
    messages = [{"role": "user", "content": prompt}]
    response = openai.ChatCompletion.create( 
        model="gpt-3.5-turbo", messages=messages 
    )
    message = response.choices[0].message.content
    return message


def _update_translation_file(language_code: str, translation_dict: TranslationDict, gpt_translation: str):
    """Appends ChatGPT translation to existing translation file."""
    output_file = TRANSLATIONS_DIR / f"{language_code}.json"
    print(f"Updating {output_file}...")
    new_dict = json.loads(gpt_translation)
    translation_dict.update(new_dict)
    with open(output_file, "w") as f:
        json.dump(translation_dict, f, ensure_ascii=False, indent=4)


def _get_user_response(question: str, options: list[str]) -> str:
    """
    Continuously prompt user for response to 'question' until they answer with
    any of the given 'options'.
    """
    while True:
        response = input(question)
        if response not in options:
            print(f"    Must provide response from {options}\n")
        else:
            return response


if __name__ == "__main__":
    translation_dicts = _load_translation_dicts(TRANSLATIONS_DIR)
    print(f"Found language codes: {list(translation_dicts.keys())}")
    unique_keys = _get_all_unique_keys(translation_dicts)
    print(f"Found {len(unique_keys)} unique keys across all translation files\n")
    
    any_language_missing_keys = False
    for language_code, translation_dict in translation_dicts.items():
        print("="*64, f"\nLanguage code='{language_code}'\n", "="*64, sep="")
        missing_keys = _find_missing_keys(translation_dict=translation_dict, unique_keys=unique_keys)
        print(f"{language_code:<5} has {len(missing_keys):>2} missing keys")
        if len(missing_keys) > 0:
            any_language_missing_keys = True
            print(f"Missing keys: {missing_keys}")
            prompt = _generate_chatgpt_prompt(language_code=language_code, keys=missing_keys, translation_dicts=translation_dicts)
            
            # In this case, user would manually copy-paste so they need to see the prompt
            if ASK_GPT:
                print()
                want_gpt = _get_user_response(f"Do you want ChatGPT to translate these into '{language_code}' [y/n]?: ", options=["y", "n"])
                if want_gpt == "y":
                    gpt_translation = _get_chatgpt_response(prompt=prompt)
                    
                    print(gpt_translation)
                    is_good_response = _get_user_response("Received response from ChatGPT. Do you want to write this to file (y/n)?: ", ["y", "n"])
                    if is_good_response == "y":
                        _update_translation_file(language_code=language_code, translation_dict=translation_dict, gpt_translation=gpt_translation)
                    else:
                        print("Not writing to file")
                else:
                    print("Not asking ChatGPT for translation")
            else:
                print(prompt)
        
        print("\n")

    if not any_language_missing_keys:
        print("="*64, "\nSUCCESS! All language files are consistent\n", "="*64, sep="")