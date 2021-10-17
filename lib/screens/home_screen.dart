import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/tabs/orders_tab.dart';
import 'package:loja_virtual/tabs/places_tab.dart';
import 'package:loja_virtual/tabs/product_tab.dart';
import 'package:loja_virtual/widgets/CartButton.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
       Scaffold(
         appBar: AppBar(
           title: Text("Produtos"),
           centerTitle: true,
         ),
         drawer: CustomDrawer(_pageController),
         body: ProductsTab(),
         floatingActionButton: CartButton(),
       ),
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Lojas"),
          ),
          drawer: CustomDrawer(_pageController),
          body: PlacesTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}
