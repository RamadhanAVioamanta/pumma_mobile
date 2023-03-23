import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

import 'data_modeling/api_historicalDataModel.dart';

DateTime now = DateTime.now();
Timer? timer;
List data = [];
DataTableSource _data = MyData();
List<historycalModel> historyData = dataAPIFromJson(data);

class HistoricalPageCanti extends StatefulWidget {
  const HistoricalPageCanti({Key? key}) : super(key: key);

  @override
  State<HistoricalPageCanti> createState() => _HistoricalCantiState();
}

class _HistoricalCantiState extends State<HistoricalPageCanti>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;

  void getData() async {
    var response = await http.get(
        Uri.parse("https://vps.isi-net.org/api/panjang/time/1?timer=minute"),
        headers: {"Accept": "application/json"});
    _isLoading = false;
    debugPrint(response.body);
    List data = json.decode(response.body)['result'];
    setState(() {
      historyData = dataAPIFromJson(data);
      _data = MyData();
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
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
          height: 120,
          child: charts.TimeSeriesChart(
            _createSampleData(),
            animate: false,
            domainAxis: const charts.DateTimeAxisSpec(
              tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                hour: charts.TimeFormatterSpec(
                  format: 'hh:mm',
                  transitionFormat: 'hh:mm',
                ),
                day: charts.TimeFormatterSpec(
                  format: 'dd MMM',
                  transitionFormat: 'dd MMM',
                ),
              ),
            ),
          )),
      Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: PaginatedDataTable(
            source: _data,
            horizontalMargin: 20,
            dataRowHeight: 39,
            columns: const [
              DataColumn(
                  label: Expanded(
                      child: Text(
                'Date',
                textAlign: TextAlign.center,
              ))),
              DataColumn(
                  label: Expanded(
                      child: Text('Time', textAlign: TextAlign.center))),
              DataColumn(
                  label: Expanded(
                      child: Text('Water Level', textAlign: TextAlign.center)))
            ],
            rowsPerPage: 10,
          ),
        ),
      ),
      Container(
          child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: !_isLoading
                  ? const Text('Refresh')
                  : const CircularProgressIndicator(),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                getData();
              }))
    ]);
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      historyData.length,
      (index) => {
            "date":
                DateFormat('MM/dd/yyyy').format(historyData[index].datetime),
            "time": DateFormat('hh:mm a').format(historyData[index].datetime),
            "waterlevel": historyData[index].waterlevel
          });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]["date"].toString())),
      DataCell(Text(_data[index]["time"].toString())),
      DataCell(Text(_data[index]["waterlevel"].toString())),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
