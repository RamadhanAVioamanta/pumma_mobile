/*import '../models/server/ApiReturnValue.dart';
import '../models/server/data_sensor.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Uri domain = Uri.parse("http://server.isi-net.org:8081/petengoran/latest");

class DataSensorService {
  static Future<ApiReturnValue<List<DataSensor>>> index() async {
    try {
      final responseResult = await http.get(Uri.parse(domain.toString()));
      final jsonResult = json.decode(responseResult.body);
      final List<DataSensor> dataSensor = [
        (responseResult.statusCode == 200)
            ? DataSensor.fromJson(jsonResult)
            : DataSensor(),
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
}
*/