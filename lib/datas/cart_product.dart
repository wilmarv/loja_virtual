import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartProduct{

  CartProduct();

  late String cid;
  late String category;
  late String pid;

  late int quantity;
  late String? size;

  late ProductData productData;

  CartProduct.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    quantity = document.data["quantity"];
    size = document.data["size"];
  }

  Map<String,dynamic> toMap(){
    return {
      "category":category,
      "pid":pid,
      "quantity":quantity,
      "size":size,
      //"product":productData.toResumedMap()
    };
  }

}