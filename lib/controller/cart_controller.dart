import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:untitled/data/models/server/data.dart';
import 'package:untitled/data/models/server/water_level.dart';
import 'package:untitled/data/network/mqtt_client.dart';

class CartController extends GetxController {
  String tag = 'CartController::->';
  final client = MqttNetwork.client();

  // --------------------------------------------------------
  //              TODO: Fetch Data From Server
  // --------------------------------------------------------
  final waterLevel = Rxn<WaterLevel>();
  final tegangan = Rxn<WaterLevel>();
  final forecast = Rxn<WaterLevel>();
  final threshold = Rxn<WaterLevel>();
  final rms = Rxn<WaterLevel>();

  @override
  void onReady() async {
    try {
      await client.connect();

      // TODO: Add Here if have another data
      client.subscribe('pumma/panjang', MqttQos.atLeastOnce);
      loadWaterLevel();
      loadBatteryVoltage();
      loadForecast();
      loadThreshold();
      loadRms();
      // ...
      // ...
    } catch (e) {
      debugPrint('Errornya karena : $e');
      client.disconnect();
    }
    super.onReady();
  }

  loadWaterLevel() {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      final data = waterLevelFromJson(payload);
      waterLevel.value = data;
      updateWaterLevel(waterLevel: waterLevel.value!);
      debugPrint('$tag payload = ${waterLevel.toJson()}');
    });
  }

  loadBatteryVoltage() {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      final data = waterLevelFromJson(payload);
      tegangan.value = data;
      updateBatteryVoltage(batteryVoltage: tegangan.value!);
      debugPrint('$tag payload = ${tegangan.toJson()}');
    });
  }

  loadForecast() {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      final data = waterLevelFromJson(payload);
      forecast.value = data;
      updateForecast(forecastWater: forecast.value!);
      debugPrint('$tag payload = ${forecast.toJson()}');
    });
  }

  loadThreshold() {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      final data = waterLevelFromJson(payload);
      threshold.value = data;
      updateThreshold(thresholdWarning: threshold.value!);
      debugPrint('$tag payload = ${threshold.toJson()}');
    });
  }

  loadRms() {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      final data = waterLevelFromJson(payload);
      rms.value = data;
      updateRms(rmsValue: rms.value!);
      debugPrint('$tag payload = ${rms.toJson()}');
    });
  }

  updateWaterLevel({required WaterLevel waterLevel}) {
    dataWaterLevel.add(waterLevel);
    debugPrint('connect bro');
    if (dataWaterLevel.length > 50) dataWaterLevel.removeAt(0);
  }

  updateBatteryVoltage({required WaterLevel batteryVoltage}) {
    dataBatteryVoltage.add(batteryVoltage);
    if (dataBatteryVoltage.length > 50) dataBatteryVoltage.removeAt(0);
  }

  updateForecast({required WaterLevel forecastWater}) {
    dataForecast.add(forecastWater);
    if (dataForecast.length > 50) dataForecast.removeAt(0);
  }

  updateThreshold({required WaterLevel thresholdWarning}) {
    dataThreshold.add(thresholdWarning);
    if (dataThreshold.length > 50) dataThreshold.removeAt(0);
  }

  updateRms({required WaterLevel rmsValue}) {
    dataRms.add(rmsValue);
    if (dataRms.length > 50) dataRms.removeAt(0);
  }

  @override
  void onClose() {
    timer?.cancel(); // Delete this line if all data already fetch from engine
    client.disconnect();
    super.onClose();
  }

  // --------------------------------------------------------
  //                 TODO: Fetch Using Dummy Data
  // --------------------------------------------------------
  RxList<WaterLevel> dataWaterLevel = <WaterLevel>[].obs;
  RxList<WaterLevel> dataForecast = <WaterLevel>[].obs;
  RxList<Data> dataPressure = <Data>[].obs;
  RxList<Data> dataHumidity = <Data>[].obs;
  RxList<Data> dataTemp = <Data>[].obs;
  RxList<WaterLevel> dataBatteryVoltage = <WaterLevel>[].obs;
  RxList<WaterLevel> dataThreshold = <WaterLevel>[].obs;
  RxList<WaterLevel> dataRms = <WaterLevel>[].obs;
  DateTime now = DateTime.now();
  Timer? timer;

  @override
  void onInit() {
    //timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //update();
    //});
    update();
    timer;
    refreshData();
    timeNow();
    super.onInit();
  }

  void timeNow() {
    now = DateTime.now();
    //Future.delayed(const Duration(seconds: 1), () {
    //  timeNow();
    //});
  }

  void refreshData() async {
    try {
      // TODO: Uncomment code below if you want use Dummy Data
      // updateWaterLevel(
      //   waterLevel: WaterLevel(
      //     tinggi: Random().nextInt(2000).toDouble(),
      //     timeStamp: DateTime.now(),
      //   ),
      // );
      updatePressure();
      updateHumidity();
      updateTemperature();
      refreshData();

      //Future.delayed(const Duration(seconds: 1), () async {
      //  refreshData();
      //});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  updatePressure() {
    Data newPressure = Data(
      value: Random().nextInt(2000).toString(),
      timeStamp: DateTime.now(),
    );
    dataPressure.add(newPressure);
    if (dataPressure.length > 50) dataPressure.removeAt(0);
  }

  updateHumidity() {
    Data newHumidity = Data(
        value: Random().nextInt(100).toString(), timeStamp: DateTime.now());
    dataHumidity.add(newHumidity);
    if (dataHumidity.length > 10) dataHumidity.removeAt(0);
  }

  updateTemperature() {
    Data newTemp = Data(
        value: Random().nextInt(100).toString(), timeStamp: DateTime.now());
    dataTemp.add(newTemp);
    if (dataTemp.length > 10) dataTemp.removeAt(0);
  }
}
