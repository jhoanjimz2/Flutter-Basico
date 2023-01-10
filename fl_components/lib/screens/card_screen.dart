import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Widget'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: const [
          CustomCardType1(),
          SizedBox(height: 10),
          CustomCardType2(
            name: 'Akali',
            imageUrl:
                'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Akali_32.jpg',
          ),
          SizedBox(height: 10),
          CustomCardType2(
              name: 'Viego',
              imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY1GLc8ZBuQomtWfxDc2UwfrGBGY7saI6nmA&usqp=CAU'),
          SizedBox(height: 10),
          CustomCardType2(
              name: 'Kindred',
              imageUrl:
                  'https://static.wikia.nocookie.net/leagueoflegends/images/1/15/04SI005T1-full.png/revision/latest?cb=20210226042024'),
          SizedBox(height: 10),
          CustomCardType2(
              name: 'Kalista',
              imageUrl:
                  'https://static.wikia.nocookie.net/leagueoflegends/images/c/c5/01SI030T2-full.png/revision/latest?cb=20200407033350'),
          SizedBox(height: 10),
          CustomCardType2(
              name: 'Draven',
              imageUrl:
                  'https://juegoscompetitivos.com/wp-content/uploads/2021/05/draven-mecha-kingdoms.jpg'),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
