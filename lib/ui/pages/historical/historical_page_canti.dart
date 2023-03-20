import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/data/models/server/data.dart';

class HistoricalPageCanti extends StatefulWidget {
  const HistoricalPageCanti({Key? key}) : super(key: key);

  @override
  State<HistoricalPageCanti> createState() => _HistoricalCantiState();
}

class _HistoricalCantiState extends State<HistoricalPageCanti>
    with SingleTickerProviderStateMixin {
  final List<Map> _books = [
    {
      "DATETIME": "2023-03-20T11:22:50",
      "TS": "11:22:50",
      "Date": "2023-03-20",
      "tinggi": 38.55,
      "tegangan": 13.43,
      "suhu": 55.3,
      "frcst30": 35.15,
      "frcst300": 89.48,
      "rms": 49.23,
      "threshold": 443.07,
      "status": "SAFE"
    },
    {
      "DATETIME": "2023-03-20T11:34:59",
      "TS": "11:34:59",
      "Date": "2023-03-20",
      "tinggi": 67.36,
      "tegangan": 13.39,
      "suhu": 54.8,
      "frcst30": 56.91,
      "frcst300": 63.13,
      "rms": 56.33,
      "threshold": 506.97,
      "status": "SAFE"
    },
    {
      "DATETIME": "2023-03-20T11:35:00",
      "TS": "11:35:00",
      "Date": "2023-03-20",
      "tinggi": 59.1,
      "tegangan": 13.39,
      "suhu": 54.8,
      "frcst30": 54.21,
      "frcst300": 63.03,
      "rms": 56.06,
      "threshold": 504.54,
      "status": "SAFE"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(children: [_createDataTable()]);
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Tanggal')),
      DataColumn(label: Text('Waktu')),
      DataColumn(label: Text('Ketinggian Air')),
      DataColumn(label: Text('Forecasting Ketinggian Air(30)'))
    ];
  }

  List<DataRow> _createRows() {
    return _books
        .map((book) => DataRow(cells: [
              DataCell(Text(book['Date'])),
              DataCell(Text(book['TS'])),
              DataCell(Text(book['tinggi'].toString())),
              DataCell(Text(book['frcst30'].toString()))
            ]))
        .toList();
  }
}
