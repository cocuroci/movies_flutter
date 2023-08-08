import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/movies_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  MoviesList? moviesList;

  void _getList() {
    String token = '';
    http.get(Uri.https('api.themoviedb.org', '4/list/1'),
        headers: {'authorization': 'Bearer $token'}).then((value) {
      if (value.statusCode == 200) {
        moviesList = MoviesList.fromJson(jsonDecode(value.body));
        print(moviesList.toString());
        setState(() {});
      }
      print(value.statusCode);
    });
  }

  @override
  void initState() {
    super.initState();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Movie: ${moviesList?.name}'),
        ),
      ),
    );
  }
}
