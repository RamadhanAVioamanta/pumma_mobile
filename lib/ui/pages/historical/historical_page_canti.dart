import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoricalPageCanti extends StatefulWidget {
  const HistoricalPageCanti({Key? key}) : super(key: key);

  @override
  State<HistoricalPageCanti> createState() => _HistoricalCantiState();
}

class _HistoricalCantiState extends State<HistoricalPageCanti>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('DataTable Demo'),
        ),
        body: ListView(
          children: [_createDataTable()],
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('ID')),
      DataColumn(label: Text('Book')),
      DataColumn(label: Text('Author'))
    ];
  }

  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('Flutter Basics')),
        DataCell(Text('David John'))
      ]),
      DataRow(cells: [
        DataCell(Text('#101')),
        DataCell(Text('Dart Internals')),
        DataCell(Text('Alex Wick'))
      ])
    ];
  }
}
