import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/core/app_style.dart';
import 'package:untitled/ui/widgets/sky_box.dart';

class DataWrapperWidget extends StatelessWidget {
  final String data;
  final String title;
  final Color color;

  DataWrapperWidget({
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
          Text(
            DateFormat('d MMM yyy, HH:mm:ss').format(DateTime.now()) +
                ' (UTC+7)',
          ),
          const SizedBox(height: 24),
          Center(
            child: (data == "0")
                ? const CircularProgressIndicator()
                : Text(
                    data,
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
