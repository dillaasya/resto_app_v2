import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:resto_app_v2/data/model/resto_detail.dart';
import 'package:resto_app_v2/data/model/resto_list.dart';
import 'package:resto_app_v2/data/model/resto_review.dart';
import 'package:resto_app_v2/data/model/resto_search.dart';

import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _main = 'list';
  static const String _detail = 'detail/';
  static const String _review = 'review';
  static const String _search = 'search?q=';

  Future<RestaurantList> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + _main));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<http.Response?> postReview(CustomerReviews review) async {
    http.Response? response;

    try{
      response = await http.post(
        Uri.parse(_baseUrl + _review),
        headers: {"Content-Type": " application/json"},
        body: json.encode(review),

      );
    }catch(e){
      log(e.toString());
    }

    if (kDebugMode) {
      print('Tipe future di API : ${http.Response}');
    }
    return response;
  }

  Future<RestaurantDetail> detailList(String? id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id!));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }

  Future<RestaurantSearch> searchList(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + query));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }
}
