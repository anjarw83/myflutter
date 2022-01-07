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
      ..registerFactory(
          (c) => StockUseCase(stockRepository: c<StockRepository>()));
  }

  @override
  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<StockRepository>((c) => StockRepositoryImpl(
          stockRemoteDataSource: c<StockRemoteDataSource>()));
  }

  @override
  void _configureBlocs() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => StockBloc(stockUseCase: c<StockUseCase>()));
  }

  @override
  void _configureRemoteDataSources() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) =>
          StockRemoteDataSource(remoteDataClient: c<DefaultRemoteClient>()));
  }

  @override
  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container..registerSingleton((c) => DefaultRemoteClient());
  }
}
