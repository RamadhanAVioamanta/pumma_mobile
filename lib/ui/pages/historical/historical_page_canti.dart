import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

import 'data_modeling/restDataModel.dart';


DateTime now = DateTime.now();
Timer? timer;

List<dataAPI> API = [];
bool loading = true;  

class HistoricalPageCanti extends StatefulWidget {
  const HistoricalPageCanti({Key? key}) : super(key: key);

  @override
  State<HistoricalPageCanti> createState() => _HistoricalCantiState();
}

class _HistoricalCantiState extends State<HistoricalPageCanti>
    with SingleTickerProviderStateMixin {
  
  final TextEditingController historyController = TextEditingController();
  void getData() async {
    var response = await http.get(
        Uri.parse("https://vps.isi-net.org/api/panjang/count/200"),
        headers: {"Accept": "application/json"});
    List data = json.decode(response.body)['result'];
    setState(() {
      API = dataAPIFromJson(data);
      loading = false;
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
  List<charts.Series<dataAPI, DateTime>> _createSampleData() {
    return [
      //charts.Series memiliki 4 paramter wajib
      charts.Series<dataAPI, DateTime>(
        data: API,
        id: 'Water',  
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (dataAPI DataApi, _) => DataApi.datetime,
        measureFn: (dataAPI DataApi, _) => DataApi.waterlevel.round(),
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
          width: 80,
          child: Text(
            'Tanggal & Waktu',
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        )
      ),
      DataColumn(
        label: Container(
          width: 80,
          child: Text(
            'Ketinggian Air',
            softWrap: true,
            textAlign: TextAlign.center,
          )
        ),
      ),
      DataColumn(
        label: Container(
        width: 80,
        child: Text(
          'Forecast 30',
          softWrap: true,
          textAlign: TextAlign.center
          )
        )
      )
    ];
  }

  List<DataRow> _createRows() {
    return API
        .map((data) => DataRow(cells: [
              DataCell(
                Container(
                  width: 80,
                  child: Text(
                    textAlign: TextAlign.center, 
                    DateFormat('MM/dd/yyyy hh:mm a').format(data.datetime)
                  ),
                )
              ),
              DataCell(
                Container(
                  width: 80,
                  child: Text(
                    textAlign: TextAlign.center, 
                    data.waterlevel.toString()
                  ),
                )
              ),
              DataCell(
                  Container(
                    width: 80,
                    child: Text(textAlign: TextAlign.center, 
                    data.forecast30.toString()
                                  ),
                  )
              )
            ]))
        .toList();
  }
}
