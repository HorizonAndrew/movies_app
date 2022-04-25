import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movies_app/actions/get_movies.dart';
import 'package:movies_app/actions/index.dart';
import 'package:movies_app/containers/home_page_container.dart';
import 'package:movies_app/containers/movies_container.dart';
import 'package:movies_app/models/app_state.dart';
import 'package:movies_app/models/movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    StoreProvider.of<AppState>(context, listen: false).dispatch(GetMovies(_onResult));
  }

  void _onResult(AppAction action) {
    if (action is GetMoviesSuccessful) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Page loaded')));
    } else if (action is GetMoviesError) {
      final Object error = action.error;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error happened $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomePageContainer(
      builder: (BuildContext context, AppState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Movies ${state.pageNumber - 1}'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  StoreProvider.of<AppState>(context).dispatch(GetMovies(_onResult));
                },
              ),
            ],
          ),
          body: MoviesContainer(
            builder: (BuildContext context, List<Movie> movies) {
              if (state.isLoading && movies.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  final Movie movie = movies[index];

                  return Column(
                    children: <Widget>[
                      Image.network(movie.poster),
                      Text(movie.title),
                      Text('${movie.year}'),
                      Text(movie.genres.join(', ')),
                      Text('${movie.rating}')
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}