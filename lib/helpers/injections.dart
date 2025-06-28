import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/core/data/datasource/assets_datasource.dart';
import 'package:tractian_challenge/core/data/datasource/companie_datasource.dart';
import 'package:tractian_challenge/core/data/repositorie/assets_repository.dart';
import 'package:tractian_challenge/core/data/repositorie/companie_repository.dart';
import 'package:tractian_challenge/core/domain/usecases/get_assets_usecase.dart';
import 'package:tractian_challenge/core/domain/usecases/get_companies_usecase.dart';
import 'package:tractian_challenge/core/domain/usecases/get_locations_usecase.dart';
import 'package:tractian_challenge/features/assets_list/assets_list_viewmodel.dart';
import 'package:tractian_challenge/features/home/home_viewmodel.dart';

final GetIt i = GetIt.instance;

void setupInjections() {
  // Data sources
  i.registerFactory<ICompanieDataSource>(() => CompanieDataSourceImpl());
  i.registerFactory<IAssetsDataSource>(() => AssetsDataSourceImpl());
  // Repositories
  i.registerFactory<ICompanieRepository>(
    () => CompanieRepositoryImpl(dataSource: i.get<ICompanieDataSource>()),
  );
  i.registerFactory<IAssetsRepository>(
    () => AssetsRepositoryImpl(dataSource: i.get<IAssetsDataSource>()),
  );
  // Usecases
  i.registerFactory<IGetCompaniesUsecase>(
    () => GetCompaniesUsecaseImpl(repository: i.get<ICompanieRepository>()),
  );
  i.registerFactory<IGetLocationsUsecase>(
    () => GetLocationsUsecaseImpl(repository: i.get<IAssetsRepository>()),
  );
  i.registerFactory<IGetAssetsUsecase>(
    () => GetAssetsUsecaseImpl(repository: i.get<IAssetsRepository>()),
  );
  // ViewModels
  i.registerFactory<HomeViewmodel>(
    () => HomeViewmodel(getCompaniesUsecase: i.get<IGetCompaniesUsecase>()),
  );
  i.registerFactory<AssetsListViewmodel>(
    () => AssetsListViewmodel(
      getLocationsUsecase: i.get<IGetLocationsUsecase>(),
      getAssetsUsecase: i.get<IGetAssetsUsecase>(),
    ),
  );
}
