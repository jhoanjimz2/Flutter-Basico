import 'package:flutter/material.dart';
import 'package:newsapp/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/services/services.dart';

class Tab1Screen extends StatefulWidget {
   
  const Tab1Screen({Key? key}) : super(key: key);

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {


    final headlines = Provider.of<NewsService>(context).headlines;
    
    return Scaffold(
      //body: ListNews(noticias: headlines)
      body: ( headlines.isEmpty )
          ? const Center( child: CircularProgressIndicator() )
          : ListNews(noticias: headlines)
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}