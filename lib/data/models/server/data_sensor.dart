import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:untitled/data/models/server/data.dart';

DataSensor waterLevelFromJson(String str) =>
    DataSensor.fromJson(json.decode(str));

String waterLevelToJson(DataSensor data) => json.encode(data.toJson());

class DataSensor {
  DataSensor({
    this.TS,
    this.Date,
    required this.tinggi,
    required this.tegangan,
    required this.suhu,
    required this.timeStamp,
    required this.frcst30,
    required this.rms,
    required this.status,
    required this.frcst300,
    required this.threshold,
  });

  String? TS;
  DateTime? Date;
  double tinggi;
  double suhu;
  double frcst30;
  double frcst300;
  double tegangan;
  double rms;
  double threshold;
  DateTime timeStamp;
  String status;

  factory DataSensor.fromJson(Map<String, dynamic> json) => DataSensor(
      TS: json["TS"],
      Date: DateTime.parse(json["Date"]),
      tinggi: json["tinggi"]?.toDouble(),
      suhu: json["suhu"].toDouble(),
      tegangan: json["tegangan"]?.toDouble(),
      timeStamp: DateFormat("hh:mm:ss,yyy-MM-dd")
          .parse('${json["TS"]},${json["Date"]}'),
      frcst30: json["frcst30"].toDouble(),
      threshold: json["threshold"].toDouble(),
      rms: json["rms"].toDouble(),
      status: json["status"].toString(),
      frcst300: json["frcst300"].toDouble());

  Map<String, dynamic> toJson() => {
        "TS": TS,
        "Date":
            "${Date?.year.toString().padLeft(4, '0')}-${Date?.month.toString().padLeft(2, '0')}-${Date?.day.toString().padLeft(2, '0')}",
        "tinggi": tinggi,
        "suhu": suhu,
        "tegangan": tegangan,
        "time_stamp": DateFormat("hh:mm:ss,YY-MM-dd").format(timeStamp),
        "frcst30": frcst30,
        "rms": rms,
        "threshold": threshold,
        "frcst300": frcst300,
        "status": status
      };

  map(String Function(dynamic e) param0) {}
}
