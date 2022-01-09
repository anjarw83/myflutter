// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector_config.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$InjectorConfig extends InjectorConfig {
  @override
  void _configureUseCases() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton(
          (c) => StockUseCase(stockRepository: c<StockRepository>()))
      ..registerSingleton((c) =>
          WatchlistUseCase(watchlistRepository: c<WatchlistRepository>()))
      ..registerSingleton((c) => AuthenticationUseCase(
          authenticationRepository: c<AuthenticationRepository>()));
  }

  @override
  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<StockRepository>((c) => StockRepositoryImpl(
          stockRemoteDataSource: c<StockRemoteDataSource>()))
      ..registerSingleton<WatchlistRepository>((c) => WatchlistRepositoryImpl(
          watchlistRemoteDatasource: c<WatchlistRemoteDatasource>()))
      ..registerSingleton<AuthenticationRepository>((c) =>
          AuthenticationRepositoryImpl(
              authenticationRemoteDatasource:
                  c<AuthenticationRemoteDatasource>()));
  }

  @override
  void _configureBlocs() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) =>
          AuthenticationBloc(authenticationUseCase: c<AuthenticationUseCase>()))
      ..registerFactory((c) => StockBloc(stockUseCase: c<StockUseCase>()))
      ..registerFactory(
          (c) => WatchlistBloc(watchlistUseCase: c<WatchlistUseCase>()));
  }

  @override
  void _configureRemoteDataSources() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) =>
          StockRemoteDataSource(remoteDataClient: c<DefaultRemoteClient>()))
      ..registerFactory((c) =>
          WatchlistRemoteDatasource(remoteClient: c<DefaultRemoteClient>()))
      ..registerSingleton((c) => AuthenticationRemoteDatasource(
          remoteClient: c<DefaultRemoteClient>()));
  }

  @override
  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container..registerSingleton((c) => DefaultRemoteClient());
  }
}
