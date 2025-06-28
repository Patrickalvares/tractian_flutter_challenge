import 'package:tractian_challenge/core/data/repositorie/assets_repository.dart';
import 'package:tractian_challenge/core/domain/entities/asset.dart';
import 'package:tractian_challenge/utils/result.dart';

abstract interface class IGetAssetsUsecase {
  Future<Result<ApplicationFailure, List<Asset>>> call({required String companieId});
}

class GetAssetsUsecaseImpl implements IGetAssetsUsecase {
  final IAssetsRepository repository;

  GetAssetsUsecaseImpl({required this.repository});

  @override
  Future<Result<ApplicationFailure, List<Asset>>> call({required String companieId}) async {
    return await repository.getAssets(companieId: companieId);
  }
}
