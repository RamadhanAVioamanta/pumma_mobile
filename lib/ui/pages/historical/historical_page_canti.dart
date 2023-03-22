import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

import 'data_modeling/api_historicalDataModel.dart';

DateTime now = DateTime.now();
Timer? timer;

List<historycalModel> historyData = [];

class HistoricalPageCanti extends StatefulWidget {
  const HistoricalPageCanti({Key? key}) : super(key: key);

  @override
  State<HistoricalPageCanti> createState() => _HistoricalCantiState();
}

class _HistoricalCantiState extends State<HistoricalPageCanti>
    with SingleTickerProviderStateMixin {
  void getData() async {
    var response = await http.get(
        Uri.parse("https://vps.isi-net.org/api/panjang/time/24?timer=hour"),
        headers: {"Accept": "application/json"});
    List data = json.decode(response.body)['result'];
    setState(() {
      historyData = dataAPIFromJson(data);
    });
  }

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), updateDataSource);
    timer;
    super.initState();
    getData();
  }

  void updateDataSource(Timer timer) {
    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // CREATE CHART BY DATA FROM REST-API

  // ---------------
  List<charts.Series<historycalModel, DateTime>> _createSampleData() {
    return [
      //charts.Series memiliki 4 paramter wajib
      charts.Series<historycalModel, DateTime>(
        data: historyData,
        id: 'Water',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (historycalModel DataApi, _) => DataApi.datetime,
        measureFn: (historycalModel DataApi, _) => DataApi.waterlevel.round(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SizedBox(
          height: 300,
          child: charts.TimeSeriesChart(
            _createSampleData(),
            animate: false,
          )),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _createDataTable(),
      )
    ]);
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
          label: Container(
        width: 150,
        child: const Text(
          'Tanggal & Waktu',
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      )),
      DataColumn(
        label: Container(
            width: 150,
            child: const Text(
              'Ketinggian Air',
              softWrap: true,
              textAlign: TextAlign.center,
            )),
      ),
    ];
  }

  List<DataRow> _createRows() {
    return historyData
        .map((data) => DataRow(cells: [
              DataCell(Container(
                width: 150,
                child: Text(
                    textAlign: TextAlign.center,
                    DateFormat('MM/dd/yyyy hh:mm a').format(data.datetime)),
              )),
              DataCell(Container(
                width: 150,
                child: Text(
                    textAlign: TextAlign.center, data.waterlevel.toString()),
              )),
            ]))
        .toList();
  }
}
