import 'package:tractian_challenge/core/data/datasource/assets_datasource.dart';
import 'package:tractian_challenge/core/domain/entities/asset.dart';
import 'package:tractian_challenge/core/domain/entities/location.dart';
import 'package:tractian_challenge/utils/exceptions.dart';
import 'package:tractian_challenge/utils/result.dart';

abstract interface class IAssetsRepository {
  Future<Result<ApplicationFailure, List<Location>>> getLocations({required String companieId});
  Future<Result<ApplicationFailure, List<Asset>>> getAssets({required String companieId});
}

class AssetsRepositoryImpl implements IAssetsRepository {
  final IAssetsDataSource dataSource;

  AssetsRepositoryImpl({required this.dataSource});

  @override
  Future<Result<ApplicationFailure, List<Location>>> getLocations({
    required String companieId,
  }) async {
    try {
      final locations = await dataSource.getLocations(companieId: companieId);
      return Result.success(locations.map((e) => Location.fromMap(e)).toList());
    } on ApplicationException catch (e) {
      return Result.failure(ApplicationFailure(e.message));
    }
  }

  @override
  Future<Result<ApplicationFailure, List<Asset>>> getAssets({required String companieId}) async {
    try {
      final assets = await dataSource.getAssets(companieId: companieId);
      return Result.success(assets.map((e) => Asset.fromMap(e)).toList());
    } on ApplicationException catch (e) {
      return Result.failure(ApplicationFailure(e.message));
    }
  }
}
