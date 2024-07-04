import 'package:dio/dio.dart';
import 'package:movie_characters/constants/strings.dart';

class CharacterWebServices {
  late Dio dio;
  CharacterWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: baseurl,
        receiveDataWhenStatusError: true,
        connectTimeout: Duration(seconds: 20),
        receiveTimeout: Duration(seconds: 20));

    dio = Dio(options);
  }

  Future<dynamic> getCharacters() async {
    try {
      Response response = await dio.get('character/');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }
}
