import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class ResultScanner {
  ResultScanner({
    this.lectura,
    this.exist,
  });

  String lectura;
  bool exist;
}

class ScanCode {
  Future<ResultScanner> resultScanner() async {
    ResultScanner resultScanner = ResultScanner();
    try {
      var options = ScanOptions(
        strings: {
          "cancel": 'Cerrar',
          "flash_on": 'Linterna',
          "flash_off": 'Apagar',
        },
        useCamera: -1,
        autoEnableFlash: false,
      );
      var scanResult = await BarcodeScanner.scan(options: options);
      resultScanner.lectura = scanResult.rawContent;
      resultScanner.exist = scanResult.rawContent.isEmpty ? false : true;
    } on PlatformException catch (e) {
      var result =
          ScanResult(type: ResultType.Error, format: BarcodeFormat.unknown);
      resultScanner.lectura = "error $e : result $result";
      resultScanner.exist = false;
    }
    return resultScanner;
  }
}

final  barcodeScan  = ScanCode();
