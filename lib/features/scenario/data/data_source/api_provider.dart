import 'package:dio/dio.dart';
import '../../../../../core/constants/url_constant.dart';
import 'aip_interseptor.dart';

class ScenarioApiProvider {
  final Dio _dio = Dio();

  Future<dynamic> deleteHardwareScenarioById(
    int id,
  ) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.delete(
        '${UrlConstant.baseUrl}${UrlConstant.hardwareScenario}$id/',
        options: Options(responseType: ResponseType.json, method: 'DELETE'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getRelayDevices(int projectId, String type) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.device,
        queryParameters: {'project': projectId, 'type': type},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getHardwareScenarios(int projectId, String type) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.hardwareScenario,
        queryParameters: {'project': projectId, 'type': type},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> setHardwareScenario(Map<String, dynamic> data, int projectId,) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.post(
          UrlConstant.baseUrl + UrlConstant.hardwareScenario,
          options: Options(responseType: ResponseType.json, method: 'POST'),
          queryParameters: {'project': projectId},
          data: data);
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getHardwareScenarioMessage(
      int projectId, int scenarioId) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.get(
          UrlConstant.baseUrl + UrlConstant.hardwareScenarioMessage,
          options: Options(responseType: ResponseType.json, method: 'GET'),
          queryParameters: {
            'project': projectId,
            'scenario': scenarioId,
          });
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }
}
