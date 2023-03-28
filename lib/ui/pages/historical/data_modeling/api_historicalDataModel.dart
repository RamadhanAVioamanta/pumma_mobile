import 'dart:convert';
import 'package:intl/intl.dart';

List<historycalModel> dataAPIFromJson(List data) => List<historycalModel>.from(
      data.map(
        (x) => historycalModel.fromJson(x),
      ),
    );

class historycalModel {
  historycalModel({
    required this.id,
    required this.datetime,
    required this.waterlevel,
    required this.voltage,
    required this.temperature,
    required this.forecast30,
    required this.forecast300,
  });

  late int id;
  late DateTime datetime;
  late double waterlevel;
  late double voltage;
  late double temperature;
  late double forecast30;
  late double forecast300;

  factory historycalModel.fromJson(Map<String, dynamic> json) =>
      historycalModel(
        id :  int.parse(json['id']) ,
        datetime: DateTime.parse(json['datetime_utc']).toLocal(),
        waterlevel: json['waterlevel'].toDouble(),
        voltage: json['voltage'].toDouble(),
        temperature: json['temperature'].toDouble(),
        forecast30: json['forecast30'].toDouble(),
        forecast300: json['forecast300'].toDouble(),
      );
}
