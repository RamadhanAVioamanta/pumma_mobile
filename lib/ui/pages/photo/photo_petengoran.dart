import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoPagePetengoran extends StatefulWidget {
  const PhotoPagePetengoran({Key? key}) : super(key: key);

  @override
  State<PhotoPagePetengoran> createState() => _PhotoPagePetengoranState();
}

class _PhotoPagePetengoranState extends State<PhotoPagePetengoran> {
  @override
  Widget build(BuildContext context) {
    return PhotoView(
        imageProvider:
            NetworkImage("https://vps.isi-net.org/api/petengoran/image")
        //client.subscribe('topic/test', MqttQos.atLeastOnce).toString()),
        );
  }
}
