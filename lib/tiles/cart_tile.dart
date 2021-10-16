import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return Row(
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
              children: [
                Text(cartProduct.productData.title,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
                Text("Tamanho: ${cartProduct.size}",
                    style: TextStyle(fontWeight: FontWeight.w300)),
                Text(
                  "R\$ ${cartProduct.productData.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
                    Text(cartProduct.quantity.toString()),
                    IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                    FlatButton(onPressed: (){}, child: Text("Remover"),textColor:Colors.grey[500])
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
