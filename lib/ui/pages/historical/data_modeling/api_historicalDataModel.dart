import 'dart:convert';
import 'package:intl/intl.dart';

List<historycalModel> dataAPIFromJson(List data) => List<historycalModel>.from(
      data.map(
        (x) => historycalModel.fromJson(x),
      ),
    );

class historycalModel {
  historycalModel({
    required this.datetime,
    required this.waterlevel,
  });

  late DateTime datetime;
  late double waterlevel;

  factory historycalModel.fromJson(Map<String, dynamic> json) =>
      historycalModel(
        datetime: DateTime.parse(json['datetime']).toLocal(),
        waterlevel: json['waterlevel'].toDouble(),
      );
}
