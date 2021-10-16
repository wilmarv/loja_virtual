import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;
  String category;

  String title;
  String description;

  double price;

  List image;
  List size;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    price = snapshot.data["price"] + 0.0;
    image = snapshot.data["image"];
    size = snapshot.data["size"];
  }

  Map<String, dynamic> toResumedMap() {
    return {"title": title, "description": description, "price": price};
  }
}
