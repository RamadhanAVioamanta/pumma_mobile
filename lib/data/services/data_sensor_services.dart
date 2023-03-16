/*import '../models/server/ApiReturnValue.dart';
import '../models/server/data_sensor.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Uri domain = Uri.parse("http://194.59.165.32:8081/getDataCanti");

class DataSensorService {
  static Future<ApiReturnValue<List<Result>>> index() async {
    try {
      final responseResult = await http.get(Uri.parse(domain.toString()));
      final jsonResult = json.decode(responseResult.body);
      final List<Result> dataSensor = [
        (responseResult.statusCode == 200)
            ? Result.fromJson(jsonResult)
            : Result(),
      ];
      if (responseResult.statusCode == 200) {
        return ApiReturnValue(value: dataSensor);
      } else {
        return ApiReturnValue(message: "Periksa koneksi");
      }
    } on SocketException {
      return ApiReturnValue(message: "tidak dapat terhubung ke server");
    } catch (e) {
      return ApiReturnValue(message: "terjadi kesalahan pada server");
    }
  }
}*/
