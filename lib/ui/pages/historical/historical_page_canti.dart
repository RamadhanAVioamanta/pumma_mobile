import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/data/models/server/data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

DateTime now = DateTime.now();
Timer? timer;

class HistoricalPageCanti extends StatefulWidget {
  const HistoricalPageCanti({Key? key}) : super(key: key);

  @override
  State<HistoricalPageCanti> createState() => _HistoricalCantiState();
}

class _HistoricalCantiState extends State<HistoricalPageCanti>
    with SingleTickerProviderStateMixin {
  var dataJson = [];

  Future<List> getHttp() async {
    var url = Uri.parse('https://vps.isi-net.org/api/petengoran/latest');
    var response = await http.read(url);
    var jsonResponse = jsonDecode(response);
    debugPrint(jsonResponse['result'].toString());
    dataJson = jsonResponse['result'];
    return jsonResponse['result'];
  }

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), updateDataSource);
    timer;
    super.initState();
    getHttp();
  }

  void updateDataSource(Timer timer) {
    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [_createDataTable()]);
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Tanggal & Waktu')),
      DataColumn(label: Text('Ketinggian Air')),
      DataColumn(label: Text('Forecasting Ketinggian Air(30)'))
    ];
  }

  List<DataRow> _createRows() {
    return dataJson
        .map((data) => DataRow(cells: [
              DataCell(Text(dateTimeParse(data['datetime']))),
              DataCell(Text(data['waterlevel'].toString())),
              DataCell(Text(data['forecast30'].toString()))
            ]))
        .toList();
  }
}

String dateTimeParse(date) {
  DateTime parseDate =
      new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}
