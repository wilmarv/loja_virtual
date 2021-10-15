import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{

  late String id;
  late String category;

  late String title;
  late String description;

  late double price;

  late List image;
  late List? size;



  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    price = snapshot.data["price"] + 0.0;
    image = snapshot.data["image"];
    size = snapshot.data["size"];
  }

}