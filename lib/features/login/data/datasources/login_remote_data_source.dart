import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:zaha/core/error/exceptions.dart';
import 'package:zaha/core/util/constants.dart';
import 'package:zaha/features/login/data/models/login_model.dart';

class LoginRemoteDataSource {
  late final Dio client;

  LoginRemoteDataSource({required this.client});

  Future<void> loginReq(LoginModel login) async {
    try {
      final response = await client.post(
        '${Constants.baseUrl}/api/login',
        data: json.encode(login.toJson()),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      print(response);
      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

}
