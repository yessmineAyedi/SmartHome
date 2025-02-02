import 'package:dio/dio.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/api_provider.dart';
import '../model/login_reposnse.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiProvider _apiProvider;

  AuthRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<String>> registerUser(String username, String password,
      String mobileNumber, String email, String birthDate) async {
    Map<String, dynamic> data = {
      'username': username,
      'password': password,
      'mobile_number': mobileNumber,
      "email": email,
      "birth_date": birthDate
    };
    var response = await _apiProvider.registerUser(data);
    if (response is! DioException) {
      if (response.statusCode == 201) {
        return const DataSuccess('success');
      } else {
        return DataFailed(response);
      }
    } else {
      print(response.response);
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<UserEntity>> loginUser(
      String username, String password) async {
    var response = await _apiProvider.loginUser(username, password);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        UserEntity userEntity = LoginResponse.fromJson(response.data);
        return DataSuccess(userEntity);
      } else if (response.statusCode == 400) {
        return const DataFailed('The username or password is incorrect');
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      print(response.response);
      return DataFailed(response.response.toString());
    }
  }
}
