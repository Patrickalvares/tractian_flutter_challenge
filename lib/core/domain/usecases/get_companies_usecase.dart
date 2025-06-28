import 'package:tractian_challenge/core/data/repositorie/companie_repository.dart';
import 'package:tractian_challenge/core/domain/entities/companie.dart';
import 'package:tractian_challenge/utils/result.dart';

abstract class IGetCompaniesUsecase {
  Future<Result<ApplicationFailure, List<Companie>>> call();
}

class GetCompaniesUsecaseImpl extends IGetCompaniesUsecase {
  final ICompanieRepository repository;

  GetCompaniesUsecaseImpl({required this.repository});

  @override
  Future<Result<ApplicationFailure, List<Companie>>> call() async {
    return await repository.getCompanies();
  }
}
