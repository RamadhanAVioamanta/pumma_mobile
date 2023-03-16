/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled/data/models/server/data_sensor.dart';
import 'package:untitled/data/models/server/water_level.dart';
import 'package:untitled/ui/widgets/sky_box.dart';


class GraphComponentHistory extends StatefulWidget {
  const GraphComponentHistory({Key? key}) : super(key: key);

  @override
  State<GraphComponentHistory> createState() => _GraphComponentHistoryState();
}

class _GraphComponentHistoryState extends State<GraphComponentHistory> {
  late Result? objectResult = Result();
  DateTime now = DateTime.now();
  final String yTitle;
  final List<Result> chartData;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      timenow();
      refresh();
    });
  }

  @override
  void setState(fn) {
    if (mounted){
      super.setState(fn);
    }
  }

  @override
  void dispose(){
    super.dispose();
  }

  void timenow(){
    setState(() {
      now = DateTime.now();
    });
  }

  void refresh() async{
    try{

    }
  }



  @override
  Widget build(BuildContext context) {
    return SkyBox(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 380,
      child: (widget.chartData)
          ? Column(
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Data History",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        DateFormat('d MMM yyy, HH:mm:ss')
                                .format(DateTime.now()) +
                            ' (UTC+7)',
                        // convertDateTime(chartData[0].timeStamp!),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SfCartesianChart(
                  series: <SplineSeries<WaterLevel, DateTime>>[
                    SplineSeries<WaterLevel, DateTime>(
                      dataSource: chartData,
                      /*trendlines: <Trendline>[
                        Trendline(
                            type: TrendlineType.polynomial,
                            forwardForecast: 30,
                            color: Colors.red)
                      ],*/
                      color: const Color.fromARGB(255, 0, 26, 255),
                      xValueMapper: (WaterLevel data, _) => data.timeStamp,
                      yValueMapper: (WaterLevel data, _) => data.tinggi,
                    )
                  ],
                  primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat('mm:ss'),
                      majorGridLines: const MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      title: AxisTitle(text: 'Time ')),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: yTitle),
                  ),
                  //series: <LineSeries<Data, DateTime>>[
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}*/
