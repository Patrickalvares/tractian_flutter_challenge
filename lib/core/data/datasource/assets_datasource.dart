import 'package:dio/dio.dart';
import 'package:tractian_challenge/utils/exceptions.dart';

abstract interface class IAssetsDataSource {
  Future<List<Map>> getLocations({required String companieId});
  Future<List<Map>> getAssets({required String companieId});
}

class AssetsDataSourceImpl implements IAssetsDataSource {
  final http = Dio(BaseOptions(baseUrl: 'https://fake-api.tractian.com'));

  @override
  Future<List<Map>> getLocations({required String companieId}) async {
    try {
      final response = await http.get('/companies/$companieId/locations');

      if (response.statusCode == 200) {
        return (response.data).cast<Map>();
      }
      throw ApplicationException(response.data ?? 'erroGenerico');
    } on DioException catch (e, s) {
      throw ApplicationException(e.message ?? 'erroGenerico', stackTrace: s);
    }
  }

  @override
  Future<List<Map>> getAssets({required String companieId}) async {
    try {
      final response = await http.get('/companies/$companieId/assets');

      if (response.statusCode == 200) {
        return (response.data).cast<Map>();
      }
      throw ApplicationException(response.data ?? 'erroGenerico');
    } on DioException catch (e, s) {
      throw ApplicationException(e.message ?? 'erroGenerico', stackTrace: s);
    }
  }
}
