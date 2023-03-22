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
  void getData() async {
    var response = await http.get(
        Uri.parse("https://vps.isi-net.org/api/panjang/time/24?timer=hour"),
        headers: {"Accept": "application/json"});
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
    return Column(children: [
      SizedBox(
          height: 120,
          child: charts.TimeSeriesChart(
            _createSampleData(),
            animate: false,
          )),
      Center(
        //scrollDirection: Axis.horizontal,
        child: PaginatedDataTable(
          columnSpacing: 100,
          source: _data,
          columns: const [
            DataColumn(
                label: Center(
                    child: Text(
              'Date & Time',
              textAlign: TextAlign.right,
            ))),
            DataColumn(label: Text('Water Level'))
          ],
          rowsPerPage: 8,
        ),
      ),
      Container(
          child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text('Refresh'),
              onPressed: getData))
    ]);
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      historyData.length,
      (index) => {
            "datetime": DateFormat('MM/dd/yyyy hh:mm a')
                .format(historyData[index].datetime),
            "waterlevel": historyData[index].waterlevel
          });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]["datetime"].toString())),
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
