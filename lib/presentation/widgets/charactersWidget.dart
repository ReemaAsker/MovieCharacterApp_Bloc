import 'package:flutter/material.dart';
import 'package:movie_characters/constants/my_colors.dart';
import 'package:movie_characters/constants/strings.dart';
import 'package:movie_characters/data/model/character.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({super.key, required this.character});
  final Character character;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
          color: my_color.myWhitew, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charactersScreenDetails,
            arguments: character),
        child: GridTile(
          child: Hero(
            tag: character.id,
            child: Container(
              color: my_color.myGrey,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: 'assets/images/loading.gif',
                      image: character.image)
                  : Image.asset('assets/images/placeholder.jpg'),
            ),
          ),
          footer: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                '${character.name}',
                style: TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: my_color.myWhitew,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
