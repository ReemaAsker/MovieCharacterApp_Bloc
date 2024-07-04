import 'package:movie_characters/data/model/characterM.dart';
import 'package:movie_characters/data/web_services/character_web_services.dart';

import '../model/character.dart';

class CharacterRepo {
  final CharacterWebServices characterWebServices;

  CharacterRepo(this.characterWebServices);

  Future<List<Character>> fectchCharacters() async {
    final characters = await characterWebServices.getCharacters();
    print('1111111111');
    print(CharacterM.fromJson(characters).chars);
    return CharacterM.fromJson(characters).chars;
  }
}
