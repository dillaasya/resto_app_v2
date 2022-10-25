import 'package:flutter/material.dart';
import 'package:resto_app_v2/common/result_state.dart';
import 'package:resto_app_v2/data/api/api_service.dart';
import 'package:resto_app_v2/data/model/resto_list.dart';

class ListProvider extends ChangeNotifier {
  final ApiService apiService;

  ListProvider({required this.apiService}) {
    _fetchRestaurantList();
  }

  late RestaurantList _restaurantList;
  late ResultState _state;
  String _message = '';
  String get message => _message;
  RestaurantList get result => _restaurantList;
  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Turn on your internet connection';
    }
  }
}
