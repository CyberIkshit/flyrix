import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyrix/bloc/TracksListBloc/TracksList_bloc.dart';
import 'package:flyrix/data/repository/TracksListRepository.dart';
import 'screens/HomePage.dart';

void main() {
  runApp(new MaterialApp(
    title: "Flyrix",
    debugShowCheckedModeBanner: false,
    home: BlocProvider(
      create:(context)=>TracksListBloc(repository: TracksListImpl()),
      child: HomePage(),
    ),
  ));
}
