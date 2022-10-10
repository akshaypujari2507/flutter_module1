
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_module1/network/interceptors/authorization_interceptor.dart';
import 'package:flutter_module1/network/interceptors/logger_interceptor.dart';

import '../models/user.dart';
import 'dio_exception.dart';
import 'endpoints.dart';

class DioClient {

  late final Dio _dio;

  DioClient() : _dio = Dio(BaseOptions(
    baseUrl: Endpoints.baseURL,
    connectTimeout: Endpoints.connectionTimeout,
    receiveTimeout: Endpoints.receiveTimeout,
    responseType: ResponseType.json
  ))..interceptors.addAll([AuthorizationInterceptor(), LoggerInterceptor()]);

// HTTP request methods will go here

  // Fetches an user based on the given `id`.
  // Future<User?> getUser({required int id}) async {
  //   final response = await _dio.get('/users/$id');
  //   return User.fromJson(response.data);
  // }

  // Fetches an user based on the provided id.
  // Also handles exceptions if there are any network issues or server problems.
  Future<User?> getUser({required int id}) async {
    try {
      final response = await _dio.get('${Endpoints.endpoint}/$id');
      return User.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<User?> createUser({required User user}) async {
    try {
      final response = await _dio.post(
        Endpoints.endpoint,
        data: user.toJson(),
        // options: Options(
        //   headers: {
        //     'Authorization': 'Bearer a'
        //   },
        // ),
      );
      return User.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = err.response.toString();
      // final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  // Deletes a user having the provided `id`.
  // The access-token has been passed using [AuthorizationInterceptor].
  Future<void> deleteUser({required int id}) async {
    try {
      // await _dio.delete('/users/$id');
      await _dio.delete(Endpoints.endpoint + '/$id');
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }
}