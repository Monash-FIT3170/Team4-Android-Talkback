import 'package:flutter/material.dart';

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
        child: Text(
          'This module represents a practical scenario that requires navigating a menu, moving a slider, and activating buttons. The scenario is that we want to add some items from an online shop to the watch list. To complete this module, add the following items to your watch list: $items.',
        ),
      ),
    );
  }
}

class _ControlsReminder extends StatelessWidget {
  const _ControlsReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text(
        'Reminder that you can swipe left to navigate to the previous item, swipe right to navigate to the next item, and double tap to activate an element. To interact with a slider, navigate until the slider is selected and swipe up or down to move the slider.',
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Text(
        "Price Range",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _ItemsHeading extends StatelessWidget {
  const _ItemsHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Text(
        "Items",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
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
                  Text("Rating: ${data.rating}"),
                  Text("Price: ${data.priceCents / 100}"),
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
    return const Center(
      child: Focus(
        autofocus: true,
        child: Text(
          "You have completed this module!",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double minRange = 0;
  static const double maxRange = 100;
  static const int divisions = 10;

  Iterable<ItemData> _data = data;
  RangeValues _currentRangeValues = const RangeValues(minRange, maxRange);

  final Map<String, int> _cart;
  final Map<String, int> _watchList;

  final List<String> _targetKeys = ["3"];

  _HomePageState()
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
        title: const Text("Tutorial 2 Practical Exercise"),
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
