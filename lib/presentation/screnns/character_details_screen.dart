import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_characters/business_logic/cubit/character_cubit.dart';
import 'package:movie_characters/constants/my_colors.dart';
import 'package:movie_characters/data/model/quote.dart';

import '../../data/model/character.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  void initState() {
    super.initState();
    print('dddddddddddddd');
    BlocProvider.of<CharacterCubit>(context).getQoutesList();
  }

  Widget buildSliverAppBa() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: my_color.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.character.name,
          style: TextStyle(color: my_color.myWhitew),
        ),
        background: Hero(
            tag: widget.character.id,
            child: Image.network(
              widget.character.image,
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

  Widget checkIfQoutesAreLoaded(CharactersState state) {
    print(state);
    if (state is QoutesLoaded) {
      return displayRandomQuoteOrEmptySpace(state.qoutes);
    } else {
      return showProgressIndicator();
    }
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(color: my_color.myYellow),
    );
  }

  Widget displayRandomQuoteOrEmptySpace(List<Quote> qoutesQ) {
    if (qoutesQ.length != 0) {
      int randomQouteIndex = Random().nextInt(qoutesQ.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: my_color.myWhitew,
            shadows: [
              Shadow(
                  blurRadius: 7, color: my_color.myYellow, offset: Offset(0, 0))
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              RotateAnimatedText(qoutesQ[randomQouteIndex].quote.toString()),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
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
                  characterInfo('Status : ', widget.character.status),
                  buildDivider(400),
                  characterInfo('Species : ', widget.character.species),
                  buildDivider(385),
                  characterInfo('Gender : ', widget.character.gender),
                  buildDivider(390),
                  widget.character.type.isEmpty
                      ? Container()
                      : characterInfo('Type : ', widget.character.type),
                  widget.character.type.isEmpty
                      ? Container()
                      : buildDivider(410),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<CharacterCubit, CharactersState>(
                      builder: (context, state) {
                    return checkIfQoutesAreLoaded(state);
                  }),
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
