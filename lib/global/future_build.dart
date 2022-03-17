import 'package:flutter/material.dart';
import '../util/debug_print.dart';

FutureBuilder<dynamic> buildFutureBuilder({required Function buildWidgetBody, required Future future}) {
  return FutureBuilder(
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          printWithDebug('还没有开始网络请求');
          return const Text('还没有开始网络请求');
        case ConnectionState.active:
          printWithDebug('active');
          return const Text('ConnectionState.active');
        case ConnectionState.waiting:
          printWithDebug('waiting');
          return const Center(
            child: CircularProgressIndicator(),
          );
        case ConnectionState.done:
          printWithDebug('done');
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          return buildWidgetBody(snapshot.data);
        default:
          return const Text('还没有开始网络请求');
      }
    },
    future: future,
  );
}