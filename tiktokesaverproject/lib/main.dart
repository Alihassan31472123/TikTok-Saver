import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tiktokesaverproject/Google_ads_manager/ads.manager.dart';
import 'package:tiktokesaverproject/firebase_options.dart';
import 'package:tiktokesaverproject/models/History.dart';
import 'package:tiktokesaverproject/widgets/home/splash.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    Platform.isAndroid
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
          ),
  );
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryAdapter());
  await Hive.openBox("historyBox");

  // Request necessary permissions
  await requestPermissions();

  runApp(const MyApp());
}

Future<void> requestPermissions() async {
  final mediaStorePlugin = MediaStore();
  final permissions = [Permission.storage];
  if (Platform.isAndroid &&
      (await mediaStorePlugin.getPlatformSDKInt()) >= 33) {
    permissions
        .addAll([Permission.photos, Permission.audio, Permission.videos]);
  }
  await permissions.request();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tiktoke Saver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        fontFamily: GoogleFonts.outfit().fontFamily,
        useMaterial3: true,
      ),
      home: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return const Splashscreen();
        },
      ),
    );
  }
}
