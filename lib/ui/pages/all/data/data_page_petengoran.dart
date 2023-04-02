import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:untitled/data/models/server/water_level.dart';
import 'package:untitled/data/network/mqtt_client.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/app_color.dart';
import 'package:untitled/ui/pages/all/widgets/data_wrapper_widget.dart';
import 'package:untitled/notification/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPagePetengoran extends StatefulWidget {
  const DataPagePetengoran({Key? key}) : super(key: key);

  @override
  State<DataPagePetengoran> createState() => _DataPagePetengoranState();
}

class _DataPagePetengoranState extends State<DataPagePetengoran> {
  RxList<WaterLevel> dataWaterLevel = <WaterLevel>[].obs;
  RxList<WaterLevel> dataBatteryVoltage = <WaterLevel>[].obs;
  RxList<WaterLevel> dataSuhu = <WaterLevel>[].obs;

  final client2 = MqttNetwork.client();
  final waterLevel = Rxn<WaterLevel>();

  DateTime now = DateTime.now();
  Timer? timer;

  var wlevel = "0";
  var voltage = "0";
  var suhu = "0";
  var TS = "0";
  var datamq;
  var status;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), updateDataSource);
    timer;

    NotificationService().initNotification();
    super.initState();
    clientConnect();
    loadData();
    refresh();
    timeNow();

    loadCounter();
  }

  Future<void> loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      wlevel = (prefs.getString('wlevel_ptg') ?? "120.1");
      voltage = (prefs.getString('voltage_ptg') ?? "13.1");
      suhu = (prefs.getString('suhu_ptg') ?? "39");
    });
  }

  Future<void> incrementCounter(wlevel, voltage, suhu) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('wlevel_ptg', wlevel);
      prefs.setString('voltage_ptg', voltage);
      prefs.setString('suhu_ptg', suhu);
    });
  }

  void updateDataSource(Timer timer) {
    setState(() {});
  }

  void clientConnect() async {
    try {
      await client2.connect();
      debugPrint("MQTT Connected");
      client2.subscribe('pumma/petengoran', MqttQos.atLeastOnce);
    } catch (e) {
      debugPrint(e.toString());
      client2.disconnect();
      Future.delayed(Duration(seconds: 5), () => client2.connect());
    }
  }

  loadData() {
    client2.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      var topic = c[0].topic;
      if (topic == "pumma/petengoran") {
        final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);
        datamq = jsonDecode(payload);
        wlevel = (datamq['tinggi'].toString());
        voltage = (datamq['tegangan'].toString());
        suhu = (datamq['suhu'].toString());
        TS = (datamq['TS'].toString());
        debugPrint('DATAPAGE : ${datamq.toString()}');
        status = (datamq['status'].toString());

        incrementCounter(wlevel, voltage, suhu);

        Future.delayed(Duration(seconds: 10), () {
          if (status == 'WARNING') {
            debugPrint("WARNING - ews is active");
            NotificationService().showNotification(
                Random.secure().nextInt(1000000),
                'peringatan dini, ketinggian air mencapai ${wlevel} cm',
                '',
                1);
          } else {
            debugPrint("ews not active");
          }
        });
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void timeNow() {
    setState(() {
      now = DateTime.now();
    });
    Future.delayed(const Duration(seconds: 1), () {
      timeNow();
    });
  }

  void refresh() async {
    try {
      setState(() {});
      Future.delayed(const Duration(seconds: 1), () async {
        refresh();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            DataWrapperWidget(
              title: 'Sea Water Level',
              color: Colors.blue,
              data: wlevel + " cm",
            ),
            const SizedBox(height: 12),
            DataWrapperWidget(
              title: 'Battery Voltage',
              color: Colors.red,
              data: voltage + " V",
            ),
            const SizedBox(height: 12),
            DataWrapperWidget(
              title: 'Device Temperature',
              color: AppColors.teal,
              data: suhu + " °C",
            ),
          ],
        ),
      ),
    );
  }
}
