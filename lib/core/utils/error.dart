import 'package:borigarn/core/manager/network.dart';

extension ObjectExtension on Object {
  String toError() {
    try {
      return (this as NetworkException).data['display'].toString();
    }catch(e){
      return 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง';
    }
  }
}