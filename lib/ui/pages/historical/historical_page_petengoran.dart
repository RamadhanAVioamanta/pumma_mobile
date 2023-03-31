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
const String defaultUrl = "https://vps.isi-net.org/api/petengoran/time/1?timer=hour&data=waterlevel";

class HistoricalPagePetengoran extends StatefulWidget {
  const HistoricalPagePetengoran({Key? key}) : super(key: key);

  @override
  State<HistoricalPagePetengoran> createState() => _HistoricalPetengoranState();
}

class _HistoricalPetengoranState extends State<HistoricalPagePetengoran>
    with SingleTickerProviderStateMixin {
  String selectedValue = defaultUrl;  
  bool _isLoading = true;

  void getData(url) async {
    var response = await http.get(
        Uri.parse(url),
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
    super.initState();
    getData(defaultUrl);
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

  // Dropdown items
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("1 Hour"),value: "https://vps.isi-net.org/api/petengoran/time/1?timer=hour&data=waterlevel"),
      DropdownMenuItem(child: Text("12 Hour"),value: "https://vps.isi-net.org/api/petengoran/time/12?timer=hour&data=waterlevel"),
      DropdownMenuItem(child: Text("24 Hours"),value: "https://vps.isi-net.org/api/petengoran/time/24?timer=hour&data=waterlevel"),
      DropdownMenuItem(child: Text("3 Days"),value: "https://vps.isi-net.org/api/petengoran/time/3?timer=day&data=waterlevel"),
      DropdownMenuItem(child: Text("7 Days"),value: "https://vps.isi-net.org/api/petengoran/time/7?timer=day&data=waterlevel"),
      DropdownMenuItem(child: Text("30 Days"),value: "https://vps.isi-net.org/api/petengoran/time/30?timer=day&data=waterlevel"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      DropdownButton(
        items: dropdownItems, 
        value: selectedValue,
        onChanged: ((String? newValue){
          setState(() {
            _isLoading = true;
            getData(newValue);
            selectedValue = newValue!;
          });
          }
        ),
      ),
      SizedBox(
          height: 120,
          child: charts.TimeSeriesChart(
            _createSampleData(),
            animate: false,
            domainAxis: const charts.DateTimeAxisSpec(
              tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                hour: charts.TimeFormatterSpec(
                  format: 'hh:mm:ss',
                  transitionFormat: 'hh:mm:ss',
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
            rowsPerPage: 8,
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
                getData(selectedValue);
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
            "time":
                DateFormat('hh:mm:ss a').format(historyData[index].datetime),
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
