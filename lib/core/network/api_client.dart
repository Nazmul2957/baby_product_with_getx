// lib/core/network/api_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../errors/exception.dart';
import '../utils/snackbar_service.dart';
import 'api_logger.dart';
import 'api_interceptor.dart';

class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  Future<dynamic> get(String endpoint) async {
    final url = "${AppConstants.baseUrl}$endpoint";
    final headers = await ApiInterceptor.getHeaders();

    ApiLogger.logRequest(method: "GET", url: url, headers: headers);

    try {
      final response = await client.get(Uri.parse(url), headers: headers);

      ApiLogger.logResponse(
        url: url,
        statusCode: response.statusCode,
        body: response.body,
      );

      return _handleResponse(response);
    } catch (e) {
      ApiLogger.logError(url: url, error: e);
      rethrow;
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final url = "${AppConstants.baseUrl}$endpoint";
    final headers = await ApiInterceptor.getHeaders();

    ApiLogger.logRequest(
      method: "POST",
      url: url,
      headers: headers,
      body: body,
    );

    try {
      final response = await client.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      ApiLogger.logResponse(
        url: url,
        statusCode: response.statusCode,
        body: response.body,
      );

      return _handleResponse(response);
    } catch (e) {
      ApiLogger.logError(url: url, error: e);
      rethrow;
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final url = "${AppConstants.baseUrl}$endpoint";
    final headers = await ApiInterceptor.getHeaders();

    ApiLogger.logRequest(method: "PUT", url: url, headers: headers, body: body);

    try {
      final response = await client.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      ApiLogger.logResponse(
        url: url,
        statusCode: response.statusCode,
        body: response.body,
      );

      return _handleResponse(response);
    } catch (e) {
      ApiLogger.logError(url: url, error: e);
      rethrow;
    }
  }

  Future<dynamic> delete(String endpoint) async {
    final url = "${AppConstants.baseUrl}$endpoint";
    final headers = await ApiInterceptor.getHeaders();

    ApiLogger.logRequest(method: "DELETE", url: url, headers: headers);

    try {
      final response = await client.delete(Uri.parse(url), headers: headers);

      ApiLogger.logResponse(
        url: url,
        statusCode: response.statusCode,
        body: response.body,
      );

      return _handleResponse(response);
    } catch (e) {
      ApiLogger.logError(url: url, error: e);
      rethrow;
    }
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        // Optionally show success messages from API
        try {
          final data = jsonDecode(response.body);
          if (data is Map<String, dynamic> && data.containsKey("message")) {
            SnackbarService.instance.showSuccess(data["message"]);
          }
        } catch (_) {}
        return jsonDecode(response.body);

      case 400:
        SnackbarService.instance.showError("Bad Request");
        throw ServerException(message: "Bad Request");

      case 401:
        SnackbarService.instance.showError("Unauthorized");
        throw UnauthorizedException(message: "Unauthorized");

      case 404:
        SnackbarService.instance.showError("Not Found");
        throw NotFoundException(message: "Not Found");

      case 500:
        SnackbarService.instance.showError("Server Error");
        throw ServerException(message: "Server Error");

      default:
        SnackbarService.instance.showError("Unexpected Error");
        throw ServerException(message: "Unexpected Error");
    }
  }
}
