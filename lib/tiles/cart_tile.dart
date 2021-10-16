import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/model/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            width: 120,
            child: Image.network(cartProduct.productData.image[0],
                fit: BoxFit.cover),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cartProduct.productData.title,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
                cartProduct.size!=null ? Text("Tamanho: ${cartProduct.size}",
                    style: TextStyle(fontWeight: FontWeight.w300)):Container(),
                Text(
                  "R\$ ${cartProduct.productData.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: cartProduct.quantity>1?(){
                      CartModel.of(context).decProduct(cartProduct);
                    }:null, icon: Icon(Icons.remove),color: Theme.of(context).primaryColor,),
                    Text(cartProduct.quantity.toString()),
                    IconButton(onPressed: () {
                      CartModel.of(context).incProduct(cartProduct);
                    }, icon: Icon(Icons.add),color: Theme.of(context).primaryColor),
                    FlatButton(onPressed: (){
                      CartModel.of(context).removeCartItem(cartProduct);
                    }, child: Text("Remover"),textColor:Colors.grey[500])
                  ],
                )
              ],
            ),
          )),
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProduct.productData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection("products")
                  .document(cartProduct.category)
                  .collection("itens")
                  .document(cartProduct.pid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cartProduct.productData =
                      ProductData.fromDocument(snapshot.data);
                  return _buildContent();
                } else {
                  return Container(
                    height: 70,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
            )
          : _buildContent(),
    );
  }
}