import 'package:app_mobile/common/network/http/default_remote_data_client.dart';
import 'package:app_mobile/data/datasources/remotes/stock_remote_datasources.dart';
import 'package:app_mobile/data/datasources/remotes/watchlist_remote_datasources.dart';
import 'package:app_mobile/data/repositories/stock_repository_impl.dart';
import 'package:app_mobile/data/repositories/watchlist_repository_imp.dart';
import 'package:app_mobile/domain/repositories/stock_repository.dart';
import 'package:app_mobile/domain/repositories/watchlist_repository.dart';
import 'package:app_mobile/domain/usecases/stock_usecase.dart';
import 'package:app_mobile/domain/usecases/watchlist_usecase.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_bloc.dart';
import 'package:app_mobile/presentation/journey/home/watchlist_bloc/watchlist_bloc.dart';
import 'package:kiwi/kiwi.dart';

part 'injector_config.g.dart';

abstract class InjectorConfig {
  static KiwiContainer container;

  static void setup() {
    final injector = _$InjectorConfig();
    injector._configure();
  }

  void _configure() {
    _configureUseCases();
    _configureRepositories();
    _configureRemoteDataSources();
    _configureBlocs();
    _configureCommon();
  }

  // ==== USECASES
  @Register.singleton(StockUseCase)
  @Register.singleton(WatchlistUseCase)
  void _configureUseCases();

  // ==== REPOSITORIES
  @Register.singleton(StockRepository, from: StockRepositoryImpl)
  @Register.singleton(WatchlistRepository, from: WatchlistRepositoryImpl)
  void _configureRepositories();

  // ==== BLOCS
  @Register.factory(StockBloc)
  @Register.factory(WatchlistBloc)
  void _configureBlocs();

  // ==== REMOTE DATASOURCES
  @Register.singleton(StockRemoteDataSource)
  @Register.factory(WatchlistRemoteDatasource)
  void _configureRemoteDataSources();
  
  // ==== COMMON
  @Register.singleton(DefaultRemoteClient)
  void _configureCommon();
}
