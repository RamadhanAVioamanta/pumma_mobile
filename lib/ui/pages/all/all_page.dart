import 'package:flutter/material.dart';
import 'package:untitled/ui/pages/all/data/data_page.dart';

class AllPage extends StatelessWidget {
  const AllPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: const [
            DataPage(),
            //GaugePage(),
            //ChartPage(),
          ],
        ),
      ),
    );
  }
}
