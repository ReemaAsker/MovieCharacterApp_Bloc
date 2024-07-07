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
      // print(response.data.toString());
      return response.data;
    } catch (e) {
      // print(e.toString());
      return {};
    }
  }

  Future<dynamic> getQoute() async {
    print('here');
    BaseOptions options = BaseOptions(
        baseUrl: baseQouteurl,
        receiveDataWhenStatusError: true,
        connectTimeout: Duration(seconds: 20),
        receiveTimeout: Duration(seconds: 20));

    dio = Dio(options);
    print("88888888888888888888888888888");
    print("88888888888888888888888888888");

    print("88888888888888888888888888888");

    try {
      Response response = await dio.get('50');
      print(";;;;;;;;;;;;;;;;;;;;;;;;;");
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }
}
