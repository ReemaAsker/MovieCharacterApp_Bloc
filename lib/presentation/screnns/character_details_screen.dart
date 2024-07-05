import 'package:flutter/material.dart';
import 'package:movie_characters/constants/my_colors.dart';

import '../../data/model/character.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  Widget buildSliverAppBa() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: my_color.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name,
          style: TextStyle(color: my_color.myWhitew),
        ),
        background: Hero(
            tag: character.id,
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget characterInfo(String title, value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
            text: title,
            style: TextStyle(
                color: my_color.myWhitew,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        TextSpan(
            text: value,
            style: TextStyle(color: my_color.myWhitew, fontSize: 16)),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      thickness: 2,
      color: my_color.myYellow,
      height: 30,
      endIndent: endIndent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: my_color.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBa(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo('Status : ', character.status),
                  buildDivider(400),
                  characterInfo('Species : ', character.species),
                  buildDivider(385),
                  characterInfo('Gender : ', character.gender),
                  buildDivider(390),
                  character.type.isEmpty
                      ? Container()
                      : characterInfo('Type : ', character.type),
                  character.type.isEmpty ? Container() : buildDivider(410),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 450,
            )
          ])),
          // buildSliverList(),
        ],
      ),
    );
  }
}
