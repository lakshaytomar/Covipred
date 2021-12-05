import 'package:dio/dio.dart';
import 'models/parameters.dart';

class DioClient {
  final Dio _dio = Dio();

  final _baseUrl = 'https://covid19prediction.herokuapp.com/prediction';

  Future<Parameters?> send({required Parameters parameters}) async {
    Parameters? retrieved;

    try {
      Response response = await _dio.post(
        _baseUrl,
        data: parameters.toJson(),
      );

      print('User created: ${response.data}');

      retrieved = Parameters.fromJson(response.data);
    } catch (e) {
      print('Error in sending: $e');
    }

    return retrieved;
  }
}