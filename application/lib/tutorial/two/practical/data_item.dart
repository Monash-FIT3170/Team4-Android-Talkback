import 'package:easy_localization/easy_localization.dart';

class ItemData {
  final String id;
  final String name;
  final double rating;
  final int priceCents;
  final String description;

  ItemData(
      {required this.id,
      required this.name,
      required this.rating,
      required this.priceCents,
      required this.description});

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
        id: json['id'],
        name: json['name'],
        rating: json['rating'],
        priceCents: json['price'],
        description: json['description']);
  }
}

var data = [
  {
    "id": "0",
    "name": "tennis_ball".tr(),
    "rating": 3.0,
    "price": 200,
    "description": "tennis_ball_desc".tr(),
  },
  {
    "id": "1",
    "name": "basketball".tr(),
    "rating": 4.5,
    "price": 300,
    "description": "basketball_desc".tr(),
  },
  {
    "id": "2",
    "name": "soccer_ball".tr(),
    "rating": 4.0,
    "price": 1000,
    "description": "soccer_ball_desc".tr(),
  },
  {
    "id": "3",
    "name": "baseball".tr(),
    "rating": 4.5,
    "price": 500,
    "description": "baseball_desc".tr(),
  },
  {
    "id": "4",
    "name": "football".tr(),
    "rating": 4.0,
    "price": 1000,
    "description": "football_desc".tr(),
  },
  {
    "id": "5",
    "name": "train_set".tr(),
    "rating": 4.0,
    "price": 10000,
    "description": "train_set_desc".tr(),
  },
  {
    "id": "6",
    "name": "doll".tr(),
    "rating": 4.0,
    "price": 2000,
    "description": "doll_desc".tr()
  },
  {
    "id": "7",
    "name": "unicorn_plush".tr(),
    "rating": 4.0,
    "price": 8000,
    "description": "unicorn_plush_desc".tr(),
  },
  {
    "id": "8",
    "name": "plastic_castle".tr(),
    "rating": 4.0,
    "price": 5000,
    "description": "plastic_castle_desc".tr(),
  },
].map(ItemData.fromJson).toList();
