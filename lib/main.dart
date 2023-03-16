import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:untitled/ui/pages/home_page/home_page.dart';
import 'package:untitled/ui/pages/home_page/petengoran_page.dart';
import 'package:untitled/ui/pages/splash/splash_page.dart';
import 'dart:async';
import 'package:untitled/notification/notification_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'notification/notif.dart';
import 'ui/widgets/widget.dart';

part 'backgroundService.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  // init database local
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  // init notif
  NotificationService().initNotification();
  // bckground service init
  if (UniversalPlatform.isAndroid) {
    await initializeService();
  }
  runApp(const MyApp());
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool notif = false;
  late Box box;
  @override
  void initState() {
    super.initState();
    // untuk membind data ketika widget dibuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // fungsi untuk menggambil data notif
      getDataNotif();
    });
  }

  // deklrasi fungsi void untuk menggambil data notif di local database
  void getDataNotif() async {
    if (UniversalPlatform.isAndroid) {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      box = await Hive.openBox('notif');
      setState(() {
        notif = box.get('notif') ?? false;
      });
      box.close();
    }
  }

  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  // deklarasi fungsi void untuk mengganti state data notif on dan of
  void toggleSwitch(bool value) async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('notif');
    notif = box.get('notif') ?? false;
    setState(() {
      if (value) {
        notif = true;
        Notif.Status = true;
        box.put('notif', true);
      } else {
        notif = false;
        Notif.Status = false;
        box.put('notif', false);
      }
    });
    box.close();
  }

  // membuat tampilan halaman utama
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Row(
            children: [
              Text(
                (notif) ? "Notif On" : "Notif Off",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                child: Switch(
                    onChanged: toggleSwitch,
                    value: notif,
                    activeColor: Color.fromARGB(255, 0, 37, 248),
                    activeTrackColor: Color.fromARGB(255, 129, 151, 250),
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Color.fromARGB(255, 255, 145, 145)),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 229, 230, 248),
          child: Center(
            child: ListView(
              children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' Early Warning System Gunung Anak Krakatau',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  // mediaquery ini digunakan untuk membuat data yang berdasarkan tampilan aplikasi yang bisa berupa ukuran layar
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // cardmenu digunakan untuk membuat widget yang berisi gambar judul dan sebuath fungsi ketika widget ini di tekan
                      CardMenu(
                        assetImage: "assets/app_logo.png",
                        title: "PUMMA Canti",
                        onTap: () {
                          Get.to(() => HomePage());
                        },
                      ),
                      CardMenu(
                        assetImage: "assets/app_logo.png",
                        title: "PUMMA Patengoran",
                        onTap: () {
                          Get.to(() => PetengoranPage());
                        },
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// pembuatan classs card menu
class CardMenu extends StatelessWidget {
  // deklarasi atibut
  final String assetImage;
  final String title;
  final Function onTap;
  // deklarasi kontruktor
  CardMenu(
      {required this.assetImage, required this.title, required this.onTap});
  // pembatan tampilan card menu
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: (() => onTap()),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5,
          child: Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 129, 151, 250), width: 1),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  padding: EdgeInsets.all(10),
                  child: Image.asset(assetImage, fit: BoxFit.contain),
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Early Warning System Krakatau',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
