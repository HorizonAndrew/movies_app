import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movies_app/models/app_state.dart';
import 'package:movies_app/models/movie.dart';
import 'package:redux/redux.dart';

class MoviesContainer extends StatelessWidget {
  const MoviesContainer({Key? key, required this.builder}) : super(key: key);

  final ViewModelBuilder<List<Movie>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Movie>>(
      converter: (Store<AppState> store) => store.state.movies,
      builder: builder,
    );
  }
}
