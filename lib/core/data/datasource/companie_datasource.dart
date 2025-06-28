import 'package:dio/dio.dart';
import 'package:tractian_challenge/utils/exceptions.dart';

abstract class ICompanieDataSource {
  Future<List<Map>> getCompanies();
}

class CompanieDataSourceImpl extends ICompanieDataSource {
  final http = Dio(BaseOptions(baseUrl: 'https://fake-api.tractian.com'));

  @override
  Future<List<Map>> getCompanies() async {
    try {
      final response = await http.get('/companies');

      if (response.statusCode == 200) {
        return (response.data).cast<Map>();
      }
      throw ApplicationException(response.data['error'] ?? 'erroGenerico');
    } on DioException catch (e, s) {
      throw ApplicationException(e.message ?? 'erroGenerico', stackTrace: s);
    }
  }
}
