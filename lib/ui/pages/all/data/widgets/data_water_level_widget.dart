import 'package:flutter/material.dart';
import 'package:untitled/core/app_style.dart';
import 'package:untitled/ui/widgets/sky_box.dart';

import '../../../../../../data/models/server/water_level.dart';

class DataWaterLevelWidget extends StatelessWidget {
  final List<WaterLevel> data;
  final String title;
  final Color color;

  DataWaterLevelWidget({
    Key? key,
    required this.data,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(ChartController());
    return SkyBox(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Center(
            child: (data == "0")
                ? const CircularProgressIndicator()
                : Text(
                    data.toString(),
                    style: AppStyle.headline0.copyWith(color: color),
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppStyle.subtitle3.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
