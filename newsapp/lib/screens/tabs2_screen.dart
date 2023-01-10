import 'package:flutter/material.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/services/services.dart';
import 'package:newsapp/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class Tab2Screen extends StatelessWidget {
   
  const Tab2Screen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListCategories(),
            if ( !newsService.isLoading )
              Expanded(
                child: ListNews( noticias: newsService.getArticlesCategorySelected! )
              ),

            if ( newsService.isLoading )
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                )
              )
          ],
        )
      ),
    );
  }
}

class _ListCategories extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: ( BuildContext context, int index ) {
          final cName = categories[index].name;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categories[index]),
                const SizedBox( height: 5 ),
                Text( '${ cName[0].toUpperCase() }${ cName.substring(1) }' )
              ],
            ),
          );
        }
      ),
    );

  }
}

class _CategoryButton extends StatelessWidget {

  final Category category;
  const _CategoryButton( this.category);
  
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context, listen: false);
    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric( horizontal: 10 ),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon( category.icon, color: (newsService.selectedCategory != category.name) ? Colors.black54 : AppTheme.primary ),
      ),
    );
  }
}