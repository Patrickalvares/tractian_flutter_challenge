import 'package:tractian_challenge/core/data/repositorie/assets_repository.dart';
import 'package:tractian_challenge/core/domain/entities/location.dart';
import 'package:tractian_challenge/utils/result.dart';

abstract interface class IGetLocationsUsecase {
  Future<Result<ApplicationFailure, List<Location>>> call({required String companieId});
}

class GetLocationsUsecaseImpl implements IGetLocationsUsecase {
  final IAssetsRepository repository;

  GetLocationsUsecaseImpl({required this.repository});

  @override
  Future<Result<ApplicationFailure, List<Location>>> call({required String companieId}) async {
    return await repository.getLocations(companieId: companieId);
  }
}
