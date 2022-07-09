import 'package:mvvm/model/api_response.dart';
import 'package:mvvm/model/network_manager.dart';
import 'package:mvvm/model/my_user.dart';
import 'package:mvvm/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// MyHomePageViewModelの状態を管理するProvider
final MyHomePageViewModelProvider =
  StateNotifierProvider.autoDispose<MyHomePageViewModel, MyUser>(
      (ref) => MyHomePageViewModel(),
);

class MyHomePageViewModel extends StateNotifier<MyUser> {

  MyHomePageViewModel() : super(MyUser());

  ApiResponse? _apiResponse;
  ApiResponse? get apiResponse => _apiResponse;

  void startApi(String str, Function closure) async {

    Logging.d("");

    NetworkManager().startApi(str).then((value){

      Logging.d("");
      _apiResponse = value;
      if (_apiResponse != null) {
        //state = state..result = "success";
        state = MyUser(
          name: _apiResponse!.args.userName,
          url: _apiResponse!.url,
          result: "Success",
        );
        // 書き換えたい値以外まで毎回指定することとなるのを解決するには、freezedパッケージを使う。
      } else {
        state = MyUser(
          name: "",
          url: "",
          result: "Error",
        );
      }
      closure(); // プログレスダイアログを閉じる
    });
  }

  // 誰からも参照されなくなるとコールされる
  @override
  void dispose() {
    Logging.d('disposed!');
    super.dispose();
  }
}