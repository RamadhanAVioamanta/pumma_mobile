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
    required this.data,
  });

  late DateTime datetime;
  late double data;

  factory historycalModel.fromJson(List json) =>
      historycalModel(
        datetime: DateTime.parse(json[0]).toLocal(),
        data: json[1].toDouble(),
      );
}
