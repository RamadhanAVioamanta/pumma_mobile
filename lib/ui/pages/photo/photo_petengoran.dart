import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';

class PhotoPagePetengoran extends StatefulWidget {
  const PhotoPagePetengoran({Key? key}) : super(key: key);

  @override
  State<PhotoPagePetengoran> createState() => _PhotoPagePetengoranState();
}

class _PhotoPagePetengoranState extends State<PhotoPagePetengoran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            DateFormat('d MMM yyy, HH:mm:ss').format(DateTime.now()) +
                ' (GMT+7)',
          ),
        ),
        body: PhotoView(
            imageProvider:
                NetworkImage("https://vps.isi-net.org/api/petengoran/image")
            //client.subscribe('topic/test', MqttQos.atLeastOnce).toString()),
            ));
  }
}
