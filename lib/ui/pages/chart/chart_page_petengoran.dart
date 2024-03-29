import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/chart_controller_petengoran.dart';
import 'package:untitled/ui/pages/chart/components/graph_component_forecast.dart';
import 'package:untitled/ui/pages/chart/components/graph_component_seaRms.dart';
import 'components/graph_component_battery.dart';
import 'components/graph_component_sea.dart';

class ChartPagePetengoran extends StatelessWidget {
  const ChartPagePetengoran({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChartControllerPetengoran());
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Obx(
              () => GraphComponentSeaWaterLevel(
                chartData: controller.dataWaterLevel.toList(),
                yTitle: 'Sea Water Level (Cm)',
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => GraphComponentForecast(
                chartData: controller.dataForecast.toList(),
                yTitle: 'Forecast Water Level (Cm)',
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => GraphComponentBattery(
                chartData: controller.dataBatteryVoltage.value,
                yTitle: 'Battery Voltage (V)',
              ),
            ),
            const SizedBox(height: 12),
            /*Obx(
              () => GraphComponentForecast(
                chartData: controller.dataWaterLevel.toList(),
                yTitle: 'Air Humidity (%)',
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => GraphComponentPressure(
                chartData: controller.dataPressure.value,
                yTitle: 'Air Pressure (hPa)',
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
