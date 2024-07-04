import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_characters/business_logic/cubit/character_cubit.dart';
import 'package:movie_characters/constants/my_colors.dart';

import '../../data/model/character.dart';
import '../widgets/charactersWidget.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> allCharaters = [];
  late List<Character> searchedCharacter;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: my_color.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: my_color.myGrey,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        color: my_color.myGrey,
        fontSize: 18,
      ),
      onChanged: (seaxrchedCharacter) {
        addSearchedOrItemsToSearchList(seaxrchedCharacter);
      },
    );
  }

  void addSearchedOrItemsToSearchList(String searchedChar) {
    searchedCharacter = allCharaters
        .where((charachter) =>
            charachter.name.toLowerCase().startsWith(searchedChar))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSeach();
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
          color: my_color.myGrey,
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(Icons.search),
          color: my_color.myGrey,
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stropSeacrhing));
    setState(() {
      _isSearching = true;
    });
  }

  void _stropSeacrhing() {
    _clearSeach();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSeach() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharacterCubit>(context)
        .getCharacterList()
        .then((Characters) => {
              // allCharaters = Characters
            }); //CharacterScreen request the CharacterCubit to get the all chacter that it get it from characterRepo tahat is fecth it from API using character_web_services
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharactersState>(
        builder: (context, state) {
      print(state);
      if (state is CharactersLoaded) {
        allCharaters = state.characters;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: my_color.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: my_color.myGrey,
        child: Column(
          children: [buildCharactersList()],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty
            ? allCharaters.length
            : searchedCharacter.length,
        itemBuilder: (context, index) {
          return CharacterWidget(
              character: _searchTextController.text.isEmpty
                  ? allCharaters[index]
                  : searchedCharacter[index]);
        });
  }

  Widget _buildAppBarTitle() {
    return Center(
      child: Text(
        'Characters',
        style: TextStyle(color: my_color.myGrey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: my_color.myYellow,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        leading: _isSearching
            ? BackButton(
                color: my_color.myGrey,
              )
            : Container(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}
