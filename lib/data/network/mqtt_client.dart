import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttNetwork {
  static MqttServerClient client() {
    String tag = 'MqttClient';

    MqttServerClient client =
        MqttServerClient.withPort('194.59.165.32', 'rav_apk', 1883);
    client.logging(on: false);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    final connMessage = MqttConnectMessage()
        .authenticateAs('unila', 'pwdMQTT@123')
        .withClientIdentifier("Mqtt_MyClientUniqueId")
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;
    return client;
  }
}

void onConnected() {
  debugPrint('Connected');
}

void onDisconnected() {
  debugPrint('Disconnected');
}

void onSubscribed(String topic) {
  debugPrint('Subscribed topic: $topic');
}

void onSubscribeFail(String topic) {
  debugPrint('Failed to subscribe $topic');
}

void onUnsubscribed(String topic) {
  debugPrint('Unsubscribed topic: $topic');
}

void pong() {
  debugPrint('Ping response client callback invoked');
}
