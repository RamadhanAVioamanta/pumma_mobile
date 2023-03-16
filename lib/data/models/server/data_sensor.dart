/*import 'dart:convert';
import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:untitled/data/models/server/data.dart';

class DataSensor {
  bool? success;
  String? message;
  int? count;
  List<Result>? result;

  DataSensor({this.success, this.message, this.count, this.result});

  DataSensor.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    count = json['count'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  final String? time;
  final String? date;
  final double? waterlevel;
  final double? voltage;
  final double? temperature;

  const Result(
      {this.time, this.date, this.waterlevel, this.voltage, this.temperature});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        time: json['time'],
        date: json['date'].toString(),
        waterlevel: json['waterlevel'].toDouble(),
        voltage: json['voltage'].toDouble(),
        temperature: json['temperature'].toDouble());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['date'] = this.date;
    data['waterlevel'] = this.waterlevel;
    data['voltage'] = this.voltage;
    data['temperature'] = this.temperature;
    return data;
  }
}*/
