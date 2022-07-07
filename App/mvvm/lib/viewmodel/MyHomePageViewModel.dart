import 'package:flutter/foundation.dart';
import 'package:mvvm/model/api_response.dart';
import 'package:mvvm/model/network_manager.dart';

class MyHomePageViewModel extends ChangeNotifier {

  ApiResponse? _apiResponse;
  ApiResponse? get apiResponse => _apiResponse;

  void startApi() {
    NetworkManager().startApi().then((value){
      _apiResponse = value;
      notifyListeners();
    });
  }

  }