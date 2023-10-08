# Localisation
We can use the [easy_localization](https://pub.dev/packages/easy_localization) plugin to help us translate our app into different languages. This plugin seems slightly easier to use than the [in-built](https://docs.flutter.dev/ui/accessibility-and-localization/internationalization) Flutter support for localisation.

## Add new language
In order to add a new language, you must:
1. Create a new JSON file for its translations in `assets/translations`. E.g. `assets/translations/es.json` for Spanish.
2. In `main.dart`, add the new language code to `supportedLocales: const [Locale('en'), Locale('es')],` in the `EasyLocalization()` call.
3. For iOS, you must add e.g. `<string>es</string>` to `application/ios/Runner/Info.plist` in the `CFBundleLocalizations` section.
4. Copy the English JSON into ChatGPT, and ask for the *values* to be translated into your desired language. Copy and paste the result into your new JSON file.

## To add translatable text
We'll use the example of translating Tutorial 3's challenge to Spanish.

To start, ensure `import 'package:easy_localization/easy_localization.dart';` is imported at the top of any relevant files (e.g. `tutorial/three/module/challenge.dart`).

Now search for any `Text()` elements or other strings. `easy_localization` adds a translate method `.tr()` to both `Text` and `String`. You should prefer calling this method on `Text` rather than on `String` directly if possibly.

The tutorial 3 challenge had this class for a scaled text widget, and I've included a concrete use of this widget too (`_mainTitle`).

```dart
class _ScaledText extends StatelessWidget {
  final String text;
  
  // constructor and other stuff...

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        text,
        textScaleFactor: textScaleFactor,
        textAlign: textAlign,
      ),
    );
  }
}

StatelessWidget _mainTitle = const _ScaledText(
    text: 'Baking recipes',
    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
    textScaleFactor: 3,
    textAlign: TextAlign.center);
```

Note that `_mainTitle` has some hardcoded text in it. To make this translatable, we do the following:
1. Make a new entry in `assets/translations/en.json`: e.g. `"tutorial3_challenge_baking_recipes": "Baking recipes"`.
2. Replace the text in `_mainTitle` with the JSON key, i.e. change it to `text: 'tutorial3_challenge_baking_recipes'`.

```dart
StatelessWidget _mainTitle = const _ScaledText(
    text: 'tutorial3_challenge_baking_recipes', // Changed text
    // ...
)
```

3. We still haven't asked this text to be translated anywhere. To do that in this example, I could simply call `.tr()` inside of the `_ScaledText` class as seen below. You'll typically just be adding `.tr()` to the end of any `Text` elements you see.

```dart
class _ScaledText extends StatelessWidget {
  // ...
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        text,
        // ...
      ).tr(), // Note the .tr()
    );
  }
}
```

4. Again, you should try to do this for all `Text` elements, and only then repeat this for any leftover `String`s that need to be translated. An example of the latter is the `label` for a `Semantics` widget, which really is just a `String` that doesn't belong to a `Text` element. In this case, you do just add `.tr()` to the end of the `String`.
5. Once you've done this for all strings/text in a module, copy all of your *new* JSON and write the following prompt into [ChatGPT](https://chat.openai.com/). Replace \<language\> with your desired language and that JSON of course:

```
Translate the *values* in the following JSON to <language>:

{
<your JSON here>
}
```

6. Copy the output of ChatGPT into the corresponding language translation file. E.g. for Spanish, we would copy the output into `es.json`. *Warning: The translation may not always be suitable for its context! E.g. for a baking recipe, ChatGPT translated "Method" into "Método". I'm not certain, but I believe "Preparación" is a better translation in this context so I manually changed it. It's unreasonable for us to do this for every language and every bit of text, but it's something to consider.*
7. Repeat steps 5 and 6 for all supported languages. If you don't provide a translation for a particular entry, it will fallback to English.

### Using automated script
A python script called [languages.py](../scripts/languages.py) is available that can automate the ChatGPT translation process. It automatically identifies missing translations in your translation JSON files.

There are two main ways of using this script.
1. Manual: the script will print out prompts for you to copy-paste into ChatGPT. When you get the response from ChatGPT, add its translations to the relevant JSON file.
2. Fully automatic: the script will ask if you want to ask ChatGPT for each language's required translations. If you say yes, then the script uses the OpenAI API to query ChatGPT. Once ChatGPT has finished the translation, you'll see it printed out. Then you'll be asked if you want to update the translation file.


#### Manual mode
You need:
- Python>=3.6

Steps:
1. Set `ASK_GPT = False`
2. Run the script: `python scripts/languages.py`
3. The script should print out prompts for any languages that are missing translations. For each language: 
   1. Copy-paste the prompt into ChatGPT.
   2. Copy-paste ChatGPT's response into that language's JSON file, but exclude the "{" and "}".


#### Fully automatic mode
You need:
- Python>=3.7.1
- **Paid** OpenAI account.

To set up your environment:
1. Create a virtual environment with `python -m venv venv`.
2. Activate it with `source venv/bin/activate` (assuming Linux/MacOS, Google it if on Windows).
3. Install dependencies with `pip install -r scripts/requirements.txt`.
4. Create a `.env` file and paste `OPENAI_API_KEY=<your OpenAI secret key>`.

Steps:
1. Set `ASK_GPT = True`
2. Run the script: `python scripts/languages.py`
3. For each language that is missing translations:
   1. you'll be asked if you want ChatGPT's translation. Enter "y" for yes.
   2. Wait for ChatGPT's response. This may take a minute or two.
   3. Once you see ChatGPT's response, you'll be asked if you want to add these new translations to that language's file. If you enter "y", then that language's file will automaticalyl be updated with the new translations!

## Testing a language
The best way to do this is probably to change the language of your test device. E.g. in Android, go to Settings and change the System Language, then rerun the app and you should see strings translated into that language.