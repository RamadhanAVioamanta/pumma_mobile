/*import 'package:flutter/material.dart';

class ChoosePummaBottomSheet extends StatelessWidget {
  const ChoosePummaBottomSheet({Key? key, required this.data}) : super(key: key);

  final List<String> data;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            shrinkWrap: true,
            itemCount: data.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(thickness: 1, height: 36);
            },
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data[index]),
                    const Icon(Icons.arrow_forward_ios, size: 18)
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}*/
