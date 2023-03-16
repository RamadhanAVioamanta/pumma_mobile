import 'package:flutter/material.dart';

SizedBox SizedBoxDefault = SizedBox(height: 10);
Widget LoadingIndicator = Center(
  child: CircularProgressIndicator(),
);

Widget LogoAplikasi = Hero(
  tag: "logo-aplikasi",
  child: Container(
    child: Image.asset(
      "assets/app_logo.png",
      width: 80,
      height: 80,
    ),
  ),
);
