import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_characters/data/model/character.dart';
import 'package:movie_characters/data/repository/character_repo.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharactersState> {
  final CharacterRepo characterRepo;
  List<Character> characters = [];

  CharacterCubit(this.characterRepo) : super(CharacterInitial());
  Future<List<Character>> getCharacterList() async {
    try {
      // Await the result of fetchCharacters()
      List<Character> characters = await characterRepo.fectchCharacters();
      print('*********************');

      // Update the state using emit() once characters are fetched
      emit(CharactersLoaded(characters));

      // Optionally store characters in a class-level variable if needed
      this.characters = characters;

      return characters; // Return the fetched characters
    } catch (e) {
      throw Exception('Failed to fetch characters: $e');
    }
  }
}
