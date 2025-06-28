import 'package:tractian_challenge/core/data/datasource/companie_datasource.dart';
import 'package:tractian_challenge/core/domain/entities/companie.dart';
import 'package:tractian_challenge/utils/exceptions.dart';
import 'package:tractian_challenge/utils/result.dart';

abstract class ICompanieRepository {
  Future<Result<ApplicationFailure, List<Companie>>> getCompanies();
}

class CompanieRepositoryImpl extends ICompanieRepository {
  final ICompanieDataSource dataSource;

  CompanieRepositoryImpl({required this.dataSource});

  @override
  Future<Result<ApplicationFailure, List<Companie>>> getCompanies() async {
    try {
      final companies = await dataSource.getCompanies();
      return Result.success(companies.map((e) => Companie.fromMap(e)).toList());
    } on ApplicationException catch (e) {
      return Result.failure(ApplicationFailure(e.message));
    }
  }
}
