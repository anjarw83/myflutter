import 'package:app_mobile/domain/usecases/watchlist_usecase.dart';
import 'package:app_mobile/presentation/journey/home/watchlist_bloc/watchlist_event.dart';
import 'package:app_mobile/presentation/journey/home/watchlist_bloc/watchlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistUseCase watchlistUseCase;

  WatchlistBloc({
    @required this.watchlistUseCase,
  }) : super(WatchlistInitialState());

  @override
  Stream<WatchlistState> mapEventToState(WatchlistEvent event) async* {
    debugPrint('WatchlistBloc:MapEventToState');
    switch (event.runtimeType) {
      case FetchWatchlistEvent:
        yield* _mapFetchWatchlistToState(event);
        break;
      case UpdateWatchlistEvent:
        yield* _mapUpdateWatchlistToState(event);
        break;
    }
  }

  Stream<WatchlistState> _mapFetchWatchlistToState(
      FetchWatchlistEvent event) async* {
    debugPrint('WatchlistBloc:Fetchin Watchlist');
    yield WatchlistLoadingState();
    try {
      final result = await watchlistUseCase.getWatchlistByUserId(event.userId);
      debugPrint('[WatchlistLoadedState]');
      yield WatchlistLoadedState(stocks: result);
    } catch (error) {
      debugPrint(error.toString());
      yield WatchlistLoadFailedState();
    }
  }

  Stream<WatchlistState> _mapUpdateWatchlistToState(
      UpdateWatchlistEvent event) async* {
    yield UpdatedWatchlistInProgressState();
    try {
      await watchlistUseCase.updateWatchlistByUserId(
          event.userId, event.stocks);
      debugPrint('[UpdatedWatchlistSuccessState]');
      yield UpdatedWatchlistSuccessState();
    } catch (error) {
      debugPrint(error.toString());
      yield UpdatedWatchlistFailedState();
    }
  }
}
