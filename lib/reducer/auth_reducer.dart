import 'package:movies_app/actions/index.dart';
import 'package:movies_app/models/index.dart';
import 'package:redux/redux.dart';

Reducer<AppState> authReducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, UserAction>(_userAction),
  TypedReducer<AppState, UpdateFavoritesStart>(_updateFavoritesStart),
  TypedReducer<AppState, UpdateFavoritesError>(_updateFavoritesError),
]);

AppState _userAction(AppState state, UserAction action) {
  return state.copyWith(user: action.user);
}

AppState _updateFavoritesStart(AppState state, UpdateFavoritesStart action) {
  final List<int> favoriteMovies = <int>[...state.user!.favoriteMovies];

  if (action.add) {
    favoriteMovies.add(action.id);
  } else {
    favoriteMovies.remove(action.id);
  }

  final AppUser user = state.user!.copyWith(favoriteMovies: favoriteMovies);
  return state.copyWith(user: user);
}

AppState _updateFavoritesError(AppState state, UpdateFavoritesError action) {
  final List<int> favoriteMovies = <int>[...state.user!.favoriteMovies];

  if (action.add) {
    favoriteMovies.remove(action.id);
  } else {
    favoriteMovies.add(action.id);
  }

  final AppUser user = state.user!.copyWith(favoriteMovies: favoriteMovies);
  return state.copyWith(user: user);
}
