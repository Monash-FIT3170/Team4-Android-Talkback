import 'package:flutter/material.dart';
import 'package:application/routes.dart';
import 'package:flutter/semantics.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;

class _ScaledText extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry margin;
  final double textScaleFactor;
  final TextAlign textAlign;

  const _ScaledText(
      {required this.text,
      required this.margin,
      required this.textScaleFactor,
      required this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        text,
        textScaleFactor: textScaleFactor,
        textAlign: textAlign,
      ).tr(),
    );
  }
}

StatelessWidget _mainTitle = const _ScaledText(
    text: 'tutorial3_challenge_baking_recipes',
    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
    textScaleFactor: 3,
    textAlign: TextAlign.center);

class _RecipeTitle extends _ScaledText {
  const _RecipeTitle({required super.text})
      : super(
            margin: const EdgeInsets.all(5),
            textScaleFactor: 2,
            textAlign: TextAlign.center);
}

class _RecipeDescription extends _ScaledText {
  const _RecipeDescription({required super.text})
      : super(
            margin: const EdgeInsets.all(5),
            textScaleFactor: 1,
            textAlign: TextAlign.center);
}

class LabelledImage extends StatelessWidget {
  final String label;
  final String imageName;

  const LabelledImage(
      {required this.label, required this.imageName, super.key});

  @override
  Widget build(BuildContext context) {
    return
        // margin: const EdgeInsets.symmetric(horizontal: 60),
        Semantics(
            label: label.tr(),
            child: Image(
              image: AssetImage(imageName),
              height: 150,
            ));
  }
}

class Tutorial3Challenge extends StatelessWidget {
  const Tutorial3Challenge({super.key});
  final String instructions = 'tutorial3_challenge_instr1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('tutorial'.tr(args: ['3']) + ' ' + 'challenge'.tr()),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Semantics(
                label: 'instructions_button_label'.tr(),
                child: ElevatedButton(
                    // TODO: Avoid SemanticsService.announce() since we can't easily set appropriate textDirection for RTL languages
                    onPressed: () => SemanticsService.announce(
                        instructions.tr(), TextDirection.ltr),
                    child: const Text('instructions_button_text').tr())),
            _mainTitle,
            const _RecipeTitle(text: 'tutorial3_challenge_brownies'),
            const LabelledImage(
                label: 'tutorial3_challenge_brownie_picture',
                imageName: 'assets/images/brownie.jpeg'),
            const _RecipeDescription(
                text: 'tutorial3_challenge_brownie_description'),
            ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BrownieRecipe()),
                      )
                    },
                child: const Text('tutorial3_challenge_brownie_goto').tr()),
            const _RecipeTitle(text: 'tutorial3_challenge_cookies'),
            const LabelledImage(
                label: 'tutorial3_challenge_cookie_picture',
                imageName: 'assets/images/cookie.jpeg'),
            const _RecipeDescription(
                text: 'tutorial3_challenge_cookie_description'),
            ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CookieRecipe()),
                      )
                    },
                child: const Text('tutorial3_challenge_cookie_goto').tr()),
          ],
        )));
  }
}

class Ingredient extends StatefulWidget {
  final String name;
  final Function? onChanged;

  const Ingredient({required this.name, this.onChanged, super.key});

  @override
  State<StatefulWidget> createState() {
    return _IngredientState();
  }
}

class _IngredientState extends State<Ingredient> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(widget.name).tr(),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false;
        });
        widget.onChanged?.call();
      },
    );
  }
}

abstract class Tutorial3Recipe extends StatelessWidget {
  List<String> get ingredients;
  List<String> get methodSteps;
  LabelledImage get image;
  String get title;

  void successCallback(BuildContext context) {}
  bool checkSuccess(int ingredientIndex) {
    return false;
  }

  const Tutorial3Recipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('tutorial'.tr(args: ['3']) + ' ' + 'challenge'.tr()),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _RecipeTitle(text: title.tr()),
            image,
            const _ScaledText(
              text: 'tutorial3_challenge_ingredients',
              margin: EdgeInsets.symmetric(vertical: 10),
              textScaleFactor: 1.5,
              textAlign: TextAlign.left,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  if (checkSuccess(index)) {
                    return Ingredient(
                        name: ingredients[index],
                        onChanged: () => successCallback(context));
                  }
                  return Ingredient(name: ingredients[index]);
                }),
            const _ScaledText(
              text: 'tutorial3_challenge_method',
              margin: EdgeInsets.symmetric(vertical: 10),
              textScaleFactor: 1.5,
              textAlign: TextAlign.left,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: methodSteps.length,
              itemBuilder: (context, index) => _ScaledText(
                text: methodSteps[index],
                margin: const EdgeInsets.all(10),
                textScaleFactor: 1,
                textAlign: TextAlign.left,
              ),
            )
          ],
        ))));
  }
}

class BrownieRecipe extends Tutorial3Recipe {
  @override
  String get title => 'tutorial3_challenge_brownie_recipe';

  @override
  List<String> get ingredients => [
        'tutorial3_challenge_brownie_ingred1',
        'tutorial3_challenge_brownie_ingred2',
        'tutorial3_challenge_brownie_ingred3',
        'tutorial3_challenge_brownie_ingred4',
        'tutorial3_challenge_brownie_ingred5',
        'tutorial3_challenge_brownie_ingred6',
        'tutorial3_challenge_brownie_ingred7',
        'tutorial3_challenge_brownie_ingred8'
      ];

  @override
  List<String> get methodSteps => [
        'tutorial3_challenge_brownie_step1',
        'tutorial3_challenge_brownie_step2',
        'tutorial3_challenge_brownie_step3'
      ];

  @override
  LabelledImage get image => const LabelledImage(
      label: 'tutorial3_challenge_cookie_picture',
      imageName: 'assets/images/brownie.jpeg');

  const BrownieRecipe({super.key});
}

class CookieRecipe extends Tutorial3Recipe {
  @override
  String get title => 'tutorial3_challenge_cookie_recipe';

  final int eggIndex = 5;

  @override
  List<String> get ingredients => [
        'tutorial3_challenge_cookie_ingred1',
        'tutorial3_challenge_cookie_ingred2',
        'tutorial3_challenge_cookie_ingred3',
        'tutorial3_challenge_cookie_ingred4',
        'tutorial3_challenge_cookie_ingred5',
        'tutorial3_challenge_cookie_ingred6',
        'tutorial3_challenge_cookie_ingred7'
      ];

  @override
  List<String> get methodSteps => [
        'tutorial3_challenge_cookie_step1',
        'tutorial3_challenge_cookie_step2',
        'tutorial3_challenge_cookie_step3'
      ];

  @override
  LabelledImage get image => const LabelledImage(
      label: 'tutorial3_challenge_cookie_picture',
      imageName: 'assets/images/cookie.jpeg');

  const CookieRecipe({super.key});

  @override
  void successCallback(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(Routes.tutorialThree));
  }

  @override
  bool checkSuccess(int ingredientIndex) {
    return ingredientIndex == eggIndex;
  }
}
