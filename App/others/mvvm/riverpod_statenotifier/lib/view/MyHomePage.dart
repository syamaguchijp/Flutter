import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm/viewmodel/MyHomePageViewModel.dart';

class MyHomePage extends ConsumerWidget {

  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // state（状態）
    final _viewModelState = ref.watch(MyHomePageViewModelProvider);
    // provider（状態の操作）
    final _viewModelNotifier = ref.watch(MyHomePageViewModelProvider.notifier);

    String _inputStr = "";

    return Scaffold(
      appBar: AppBar(title: const Text('MVVM')),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
          _viewModelNotifier.startApi(_inputStr,
              () {Navigator.of(context).pop();}); // 通信完了時、ダイアログを閉じる
          },
        child: const Icon(Icons.add),
      ),

      body: ListView(
        children: [
          TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  hintText: "input some word."
              ),
              onChanged: (text) {
                print("$text");
                _inputStr = text;
              }
          ),
          Text(
              _viewModelState.name
          ),
          Text(
              _viewModelState.url
          ),
          Text(
              _viewModelState.result
          ),
        ],
      ),
    );
  }
}
