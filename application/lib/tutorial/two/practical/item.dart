import 'package:application/tutorial/two/practical/data_item.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final ItemData data;

  final ValueChanged<ItemData>? onAddToCart;
  final ValueChanged<ItemData>? onAddToWatchList;

  Item({
    required this.data,
    this.onAddToCart,
    this.onAddToWatchList,
  }) : super(key: Key(data.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data.name,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Price: \$${data.priceCents / 100}"),
                Text("Rating: ${data.rating}"),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (onAddToCart != null)
                ElevatedButton(
                  onPressed: () {
                    onAddToCart!(data);
                    Navigator.pop(context);
                  },
                  child: const Text('Add to Cart'),
                ),
              if (onAddToWatchList != null)
                ElevatedButton(
                  onPressed: () {
                    onAddToWatchList!(data);
                    Navigator.pop(context);
                  },
                  child: const Text('Add to Watch List'),
                ),
            ],
          )
        ],
      ),
    );
  }
}
