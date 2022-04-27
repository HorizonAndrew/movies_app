import 'package:movies_app/actions/index.dart';
import 'package:movies_app/data/movie_api.dart';
import 'package:movies_app/models/index.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class MovieEpic {
  MovieEpic(this._api);

  final MovieApi _api;

  Epic<AppState> getEpics() {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, GetMoviesStart>(_getMovies),
    ]);
  }

  Stream<AppAction> _getMovies(Stream<GetMoviesStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((GetMoviesStart action) {
      return Stream<void>.value(null)
          .asyncMap((_) => _api.getMovies(store.state.pageNumber))
          .map<GetMovies>(GetMovies.successful)
          .onErrorReturnWith(GetMovies.error)
          .doOnData(action.onResult);
    });
  }
}
