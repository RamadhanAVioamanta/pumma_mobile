import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return PhotoView(
        imageProvider: NetworkImage("https://vps.isi-net.org/api/panjang/image")
        //client.subscribe('topic/test', MqttQos.atLeastOnce).toString()),
        );
  }
}
