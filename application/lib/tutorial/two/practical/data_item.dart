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
    "name": "Tennis Ball",
    "rating": 3.0,
    "price": 200,
    "description":
        "This extra duty tennis ball is ideal for longer play on the courts. Perfect for all levels of tournament and recreational play.",
  },
  {
    "id": "1",
    "name": "Basketball",
    "rating": 4.5,
    "price": 300,
    "description":
        "This basketball is designed for indoor or outdoor play. It features a deep channel design for easier hand alignment and ball control.",
  },
  {
    "id": "2",
    "name": "Soccer Ball",
    "rating": 4.0,
    "price": 1000,
    "description": "This soccer ball is designed for indoor or outdoor play.",
  },
  {
    "id": "3",
    "name": "Baseball",
    "rating": 4.5,
    "price": 500,
    "description": "This baseball has a cork core and a leather cover.",
  },
  {
    "id": "4",
    "name": "Football",
    "rating": 4.0,
    "price": 1000,
    "description":
        "This football is ideal for recreational play or practice. It features a leather cover for durability and a deep pebble surface for grip.",
  },
  {
    "id": "5",
    "name": "Train Set",
    "rating": 4.0,
    "price": 10000,
    "description":
        "This train set is ideal for children. It features a train, tracks, and a station.",
  },
  {
    "id": "6",
    "name": "Doll",
    "rating": 4.0,
    "price": 2000,
    "description":
        "This doll is ideal for children. It can be dressed up in different outfits. Outfits sold separately.",
  },
  {
    "id": "7",
    "name": "Unicorn Plush",
    "rating": 4.0,
    "price": 8000,
    "description":
        "This unicorn plush is ideal for children. It is soft and cuddly.",
  },
  {
    "id": "8",
    "name": "Plastic Castle",
    "rating": 4.0,
    "price": 5000,
    "description":
        "Contains multiple pieces to build a castle including walls, towers, and a gate. For children ages 3 and up. Choking hazard.",
  },
].map(ItemData.fromJson).toList();
