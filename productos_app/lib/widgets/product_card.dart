import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';

import '../themes/app_theme.dart';

class ProductCard extends StatelessWidget {
  final Product product; 
  const ProductCard({Key? key, required this.product}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(

        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgoundImage(product.picture),
            _ProductDetail(title: product.name, subTitle: product.id!),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(price: product.price)
            ),

            if ( !product.available )
            Positioned(
              top: 0,
              left: 0,
              child: _NotAvailable()
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 7),
        blurRadius: 10
      )
    ]
  );
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: sort_child_properties_last
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25)
        )
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric( horizontal: 10 ),
          child: Text(
            'No Disponible', 
            style: TextStyle( color: Colors.white, fontSize: 20 )
          )
        ),
      )
    );
  }
}

class _PriceTag extends StatelessWidget {

  final double price;
  const _PriceTag({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: sort_child_properties_last
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 10 ),
          child: Text('\$$price', style: TextStyle( color: Colors.white, fontSize: 20 ))
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.only( topRight: Radius.circular(25), bottomLeft: Radius.circular(25) )
      ),
    );
  }
}

class _ProductDetail extends StatelessWidget {

  final String title;
  final String subTitle;

  const _ProductDetail({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( right: 50 ),
      child: Container(
        padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle( fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subTitle,
              style: const TextStyle( fontSize: 15, color: Colors.white )
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: AppTheme.primary,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

class _BackgoundImage extends StatelessWidget {

  final String? url;

  const _BackgoundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null
          ? const Image(
            image: AssetImage('assets/no-image.png'),
            fit: BoxFit.cover
          )
          : FadeInImage(
            placeholder: const AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(url!),
            fit: BoxFit.cover,
          ),
      ),
    );
  }
}