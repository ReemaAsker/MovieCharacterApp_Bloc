part of 'character_cubit.dart';

@immutable
abstract class CharactersState {}

final class CharacterInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;

  CharactersLoaded(this.characters);
}
