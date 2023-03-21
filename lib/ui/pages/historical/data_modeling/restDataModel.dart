 import 'dart:convert';
import 'package:intl/intl.dart';

    List<dataAPI> dataAPIFromJson(List data) => List<dataAPI>.from(
          data.map(
            (x) => dataAPI.fromJson(x),
          ),
        );
    
    class dataAPI {
      dataAPI({
        required this.id,
        required this.datetime,
        required this.time,
        required this.date,
        required this.waterlevel,
        required this.temperature,
        required this.forecast30,
        required this.forecast300,
        required this.rms,
        required this.threshold,
      });
    
      late String id;
      late DateTime datetime;
      late String time;
      late String date;
      late double waterlevel;
      late double temperature;
      late double forecast30;
      late double forecast300;
      late double rms;
      late double threshold;
    
      factory dataAPI.fromJson(Map<String, dynamic> json) => dataAPI(
            id: json['id'],
            datetime: DateTime.parse(json['datetime']).toLocal(),
            time: json['time'],
            date: json['date'],
            waterlevel: json['waterlevel'].toDouble(),
            temperature: json['temperature'].toDouble(),
            forecast30: json['forecast30'].toDouble(),
            forecast300: json['forecast300'].toDouble(),
            rms: json['rms'].toDouble(),
            threshold: json['threshold'].toDouble(),
          );
      
    }