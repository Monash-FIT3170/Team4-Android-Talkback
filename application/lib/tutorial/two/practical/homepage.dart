import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'item.dart';
import 'data_item.dart' show ItemData, data;

class _Instructions extends StatelessWidget {
  final List<String> targetKeys;

  const _Instructions({Key? key, required this.targetKeys}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String items = targetKeys
        .map((key) => data.singleWhere((d) => d.id == key).name)
        .join(", ");

    return ListTile(
      title: Focus(
        autofocus: true,
        child: const Text('tutorial2_practical_instr1').tr(args: [items]),
      ),
    );
  }
}

class _ControlsReminder extends StatelessWidget {
  const _ControlsReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('tutorial2_practical_instr2').tr(),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: const Text(
        'price_range',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ).tr(),
    );
  }
}

class _ItemsHeading extends StatelessWidget {
  const _ItemsHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: const Text(
        'items',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ).tr(),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final ItemData data;

  final ValueChanged<ItemData> onAddToCart;
  final ValueChanged<ItemData> onAddToWatchList;

  const _ItemCard({
    Key? key,
    required this.data,
    required this.onAddToCart,
    required this.onAddToWatchList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: Text(data.name)),
              body: Item(
                data: data,
                onAddToCart: onAddToCart,
                onAddToWatchList: onAddToWatchList,
              ),
            ),
          ),
        );
      },
      child: Card(
        key: Key(data.id.toString()),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(data.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${'rating'.tr()}: ${data.rating}"),
                  Text("${'price'.tr()}: ${data.priceCents / 100}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Completed extends StatelessWidget {
  const _Completed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Focus(
        autofocus: true,
        child: const Text(
          'completed_module',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ).tr(),
      ),
    );
  }
}

class Tutorial2Practical extends StatefulWidget {
  const Tutorial2Practical({Key? key}) : super(key: key);

  @override
  State<Tutorial2Practical> createState() => _Tutorial2PracticalState();
}

class _Tutorial2PracticalState extends State<Tutorial2Practical> {
  static const double minRange = 0;
  static const double maxRange = 100;
  static const int divisions = 10;

  Iterable<ItemData> _data = data;
  RangeValues _currentRangeValues = const RangeValues(minRange, maxRange);

  final Map<String, int> _cart;
  final Map<String, int> _watchList;

  final List<String> _targetKeys = ["3"];

  _Tutorial2PracticalState()
      : _cart = {},
        _watchList = {};

  _ItemCard createItemCard(ItemData data) {
    return _ItemCard(
      data: data,
      onAddToCart: (ItemData data) {
        setState(() {
          _cart.update(data.id, (value) => value + 1, ifAbsent: () => 1);
          print(_cart);
        });
      },
      onAddToWatchList: (ItemData data) {
        setState(() {
          _watchList.update(data.id, (value) => value + 1, ifAbsent: () => 1);
          print(_watchList);
        });
      },
    );
  }

  void onRangeUpdate(RangeValues values) {
    setState(() {
      _data = data.where(
        (d) =>
            d.priceCents / 100 >= values.start &&
            d.priceCents / 100 <= values.end,
      );
      print("Range updated: ${values.start} - ${values.end}");
    });
  }

  bool isCompleted() {
    return _targetKeys.every((key) => _watchList.containsKey(key));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${'tutorial'.tr(args: ['2'])} ${'practical_application'.tr()}"),
      ),
      body: !isCompleted()
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Instructions(targetKeys: _targetKeys),
                  const _ControlsReminder(),
                  const _Title(),
                  RangeSlider(
                    values: _currentRangeValues,
                    min: minRange,
                    max: maxRange,
                    divisions: divisions,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                        onRangeUpdate(_currentRangeValues);
                      });
                    },
                  ),
                  const _ItemsHeading(),
                  Expanded(
                    child: ListView(
                      children: _data.map(createItemCard).toList(),
                    ),
                  ),
                ],
              ),
            )
          : const _Completed(),
    );
  }
}
