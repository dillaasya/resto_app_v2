import 'package:flutter/material.dart';
import 'package:resto_app_v2/common/result_state.dart';
import 'package:resto_app_v2/data/api/api_service.dart';
import 'package:resto_app_v2/data/model/resto_search.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  String query;

  SearchProvider({required this.apiService, required this.query}) {
    fetchRestaurantSearch(query);
  }

  late RestaurantSearch _restaurantResult;
  late ResultState _state;
  String _message = '';
  String get message => _message;

  RestaurantSearch get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> fetchRestaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantSearch = await apiService.searchList(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurantSearch;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Turn on your internet connection';
    }
  }
}
