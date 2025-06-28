import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/core/data/datasource/companie_datasource.dart';
import 'package:tractian_challenge/core/data/repositorie/companie_repository.dart';
import 'package:tractian_challenge/core/domain/usecases/get_companies_usecase.dart';
import 'package:tractian_challenge/features/home/home_viewmodel.dart';

final GetIt i = GetIt.instance;

void setupInjections() {
  // Services

  // Providers

  // Data sources
  i.registerFactory<ICompanieDataSource>(() => CompanieDataSourceImpl());
  // Repositories
  i.registerFactory<ICompanieRepository>(
    () => CompanieRepositoryImpl(dataSource: i.get<ICompanieDataSource>()),
  );
  // Usecases
  i.registerFactory<IGetCompaniesUsecase>(
    () => GetCompaniesUsecaseImpl(repository: i.get<ICompanieRepository>()),
  );
  // ViewModels
  i.registerFactory<HomeViewmodel>(
    () => HomeViewmodel(getCompaniesUsecase: i.get<IGetCompaniesUsecase>()),
  );
}
