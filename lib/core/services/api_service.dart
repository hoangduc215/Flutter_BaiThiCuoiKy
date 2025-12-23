import 'package:dio/dio.dart';
import 'package:flutter_baithicuoiky/models/login_response.dart';
import 'package:flutter_baithicuoiky/models/product_model.dart';
import 'package:flutter_baithicuoiky/models/user_model.dart';

class ApiService {
  static const String baseUrl = "https://dummyjson.com";

  static final Dio dio = Dio();

  /// Lấy tất cả điện thoại + phụ kiện:
  static Future<List<Product>> fetchPhonesAndAccessories() async {
    List<Product> result = [];
    try {
      // 1. Lấy điện thoại:
      final phonesResponse = await dio.get(
        "$baseUrl/products/category/smartphones",
        queryParameters: {"limit": 10, "skip": 0},
      );
      if (phonesResponse.statusCode == 200) {
        final data = phonesResponse.data;
        result.addAll(
          (data['products'] as List).map((e) => Product.fromJson(e)).toList(),
        );
      }

      // 2. Lấy phụ kiện:
      final accessoriesResponse = await dio.get(
        "$baseUrl/products/category/mobile-accessories",
        queryParameters: {"limit": 10, "skip": 0},
      );
      if (accessoriesResponse.statusCode == 200) {
        final data = accessoriesResponse.data;
        result.addAll(
          (data['products'] as List).map((e) => Product.fromJson(e)).toList(),
        );
      }

      //3. Trả về danh sách cả điện thoại và phụ kiện:
      return result;
    } catch (e) {
      throw Exception("Failed to load products: $e");
    }
  }

  /// Lấy số lượng điện thoại:
  static Future<List<Product>> fetchPhones(int limit) async {
    List<Product> result = [];
    try {
      final phonesResponse = await dio.get(
        "$baseUrl/products/category/smartphones",
        queryParameters: {"limit": limit, "skip": 0},
      );
      if (phonesResponse.statusCode == 200) {
        final data = phonesResponse.data;
        result.addAll(
          (data['products'] as List).map((e) => Product.fromJson(e)).toList(),
        );
      }
      return result;
    } catch (e) {
      throw Exception("Failed to load products: $e");
    }
  }

  /// Lấy số lượng phụ kiện:
  static Future<List<Product>> fetchAccessories(int limit) async {
    List<Product> result = [];
    try {
      final phonesResponse = await dio.get(
        "$baseUrl/products/category/mobile-accessories",
        queryParameters: {"limit": limit, "skip": 0},
      );
      if (phonesResponse.statusCode == 200) {
        final data = phonesResponse.data;
        result.addAll(
          (data['products'] as List).map((e) => Product.fromJson(e)).toList(),
        );
      }
      return result;
    } catch (e) {
      throw Exception("Failed to load products: $e");
    }
  }

  //Lấy chìa khóa đăng nhập:
  Future<LoginResponse> login(String username, String password) async {
    try {
      var response = await dio.post(
        'https://dummyjson.com/auth/login',
        data: {"username": username, "password": password, "expiresInMins": 30},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception("Login thất bại: ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioException) {
        final msg = e.response?.data['message'] ?? 'Lỗi đăng nhập';
        throw Exception(msg);
      }
      throw Exception('Lỗi không xác định');
    }
  }

  //Lấy user với chìa khóa:
  Future<User> getUser(String accessToken) async {
    try {
      var response = await dio.get(
        "https://dummyjson.com/auth/me",
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      return User.fromMap(response.data);
    } catch (e) {
      if (e is DioException) {
        final msg = e.response?.data['message'] ?? 'Lỗi đăng nhập';
        throw Exception(msg);
      }
      throw Exception('Lỗi không xác định');
    }
  }
}
