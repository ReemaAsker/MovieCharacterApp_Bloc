import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_characters/business_logic/cubit/character_cubit.dart';
import 'package:movie_characters/constants/strings.dart';
import 'package:movie_characters/data/repository/character_repo.dart';
import 'package:movie_characters/data/web_services/character_web_services.dart';
import 'package:movie_characters/presentation/screnns/characters_screen.dart';
import 'package:movie_characters/presentation/screnns/charcter_details_screen';

class AppRouter {
  late CharacterRepo characterRepo;
  late CharacterCubit characterCubit;

  AppRouter() {
    characterRepo = CharacterRepo(CharacterWebServices());
    characterCubit = CharacterCubit(characterRepo);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => characterCubit,
                  child: const CharactersScreen(),
                ));
      case charactersScreenDetails:
        return MaterialPageRoute(builder: (_) => CharacterDetailsScreen());
    }
  }
}
