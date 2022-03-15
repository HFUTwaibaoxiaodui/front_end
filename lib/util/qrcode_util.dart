/// 二维码工具
/// @author herunlin
/// @version 0.1.0

import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:image_picker/image_picker.dart';
import 'debug_print.dart';

class QRCodeUtil {

  static final ImagePicker _imagePicker = ImagePicker();

  /// 扫码获取二维码
  Future _scan() async {
    try {
      printWithDebug('开始请求权限');
      await Permission.camera.request();
      printWithDebug('获取摄像头权限成功，开始获得二维码');
      String? qrcode = await scanner.scan();
      if (qrcode == null) {
        printWithDebug('nothing print');
      } else {
        printWithDebug('获取二维码成功');
        return qrcode;
      }
    } on Exception catch(e) {
      printWithDebug('获取二维码失败');
      printWithDebug(e);
    }
  }

  Future _scanPhoto() async {
    await Permission.storage.request();
    String barcode = await scanner.scanPhoto();
    return barcode;
  }

  Future _scanPath(String path) async {
    await Permission.storage.request();
    String barcode = await scanner.scanPath(path);
    return barcode;
  }

  Future _scanBytes() async {
    XFile? file = await _imagePicker.pickImage(source: ImageSource.camera);
    if (file == null) return;
    Uint8List bytes = await file.readAsBytes();
    String barcode = await scanner.scanBytes(bytes);
    return barcode;
  }

  /// 生成二维码
  Future _generateQRCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    return result;
  }
}

