import 'package:flutter/foundation.dart';

/// 开发模式使用的打印
void printWithDebug(Object object) {
  if (kDebugMode) {
    print(object);
  }
}