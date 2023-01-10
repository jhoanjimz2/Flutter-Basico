import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';

import '../models/models.dart';

class HomeScreen extends StatelessWidget {

  static const String routerName = 'home';
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if ( productsService.isLoading ) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        leading: IconButton(
          icon: const Icon( Icons.login_outlined ),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, LoginScreen.routerName);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, ProductScreen.routerName);
          },
          child: ProductCard(product: productsService.products[index])
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct = Product(
            available: true, 
            name: '', 
            price: 0
          );
          Navigator.pushNamed(context, ProductScreen.routerName);
        },
      ),
    );
  }
}