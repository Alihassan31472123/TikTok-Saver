import 'dart:async';
import 'dart:developer' as developer;
import 'package:tiktokesaverproject/api/tiktok_api.dart';
import 'package:tiktokesaverproject/models/Tiktok.dart';
import 'package:tiktokesaverproject/widgets/home/guide_widget.dart';
import 'package:tiktokesaverproject/widgets/home/result.dart';
import 'package:tiktokesaverproject/widgets/text_field.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  // Network connection.

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // Tiktok api request.
  final tiktokLinkController = TextEditingController();
  bool isValidUrl = false;
  late final TiktokApiClient tiktokApiClient;
  late Future<Tiktok?> tiktokInfo;

  @override
  void initState() {
    super.initState();
    // _loadBannerAd();
    // _createInterstitialAd();

    tiktokApiClient = TiktokApiClient(apiUrl: '');
    tiktokInfo = tiktokApiClient.fetchTiktokInfo();

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    tiktokLinkController.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  bool _isConnectionPresent() {
    return _connectionStatus.toString() == "ConnectivityResult.wifi" ||
        _connectionStatus.toString() == "ConnectivityResult.mobile";
  }

  bool _isValidTiktokLink(String url) {
    RegExp tiktokUrlRegex =
        RegExp(r'https:\/\/(www\.|vm\.|vt\.)?tiktok\.com\/.*');

    return tiktokUrlRegex.hasMatch(url);
  }

  void _handleLinkChange(String value) {
    if (_isValidTiktokLink(value)) {
      setState(() {
        tiktokApiClient.apiUrl = value;
        tiktokInfo = tiktokApiClient.fetchTiktokInfo();
      });

      // Show interstitial ad
      // if (_interstitialAd != null) {
      //   _interstitialAd!.show();
      // }
    }
  }

  // late BannerAd _bannerAd;
  // bool _isBannerAdLoaded = false;

  // void _loadBannerAd() {
  //   // Initialize banner ad
  //   _bannerAd = BannerAd(
  //     adUnitId:
  //         'ca-app-pub-6611686410771379/5494930255', // Replace with your actual ad unit ID
  //     size: AdSize.banner,
  //     request: const AdRequest(),
  //     listener: BannerAdListener(
  //       onAdLoaded: (_) {
  //         setState(() {
  //           _isBannerAdLoaded = true;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, error) {
  //         ad.dispose();
  //       },
  //     ),
  //   );

  //   // Load the banner ad
  //   _bannerAd.load();
  // }

  // InterstitialAd? _interstitialAd;

  // void _createInterstitialAd() {
  //   InterstitialAd.load(
  //     adUnitId: 'ca-app-pub-6611686410771379/4901895705',
  //     request: const AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (InterstitialAd ad) {
  //         print('$ad loaded');
  //         _interstitialAd = ad;
  //         _interstitialAd!.setImmersiveMode(true);
  //       },
  //       onAdFailedToLoad: (LoadAdError error) {
  //         print('InterstitialAd failed to load: $error.');
  //         _interstitialAd!.dispose();
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   height: 50,
              //   color: Colors.red,
              //   child: Column(
              //     children: [
              //       if (_isBannerAdLoaded)
              //         SizedBox(
              //           width: _bannerAd.size.width.toDouble(),
              //           height: _bannerAd.size.height.toDouble(),
              //           child: AdWidget(ad: _bannerAd),
              //         ),
              //     ],
              //   ),
              // ),
            ],
          ),
          Container(
          
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
            child: MyTextField(
              controller: tiktokLinkController,
              hintText: "Paste tiktok video link here",
              obscureText: false,
              icon: const Icon(Icons.link_outlined),
              borderRadius: 5.0,
              readOnly: _isConnectionPresent() ? false : true,
              onChange: (value) => _handleLinkChange(value),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          FutureBuilder<Tiktok?>(
            future: tiktokInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                // Final check if.
                return snapshot.data!.data == null
                    ? const Center(
                        child: Text("No video data found."),
                      )
                    : Result(
                        cover: "${snapshot.data!.data?.originCover}",
                        author: "${snapshot.data!.data?.author?.nickname}",
                        title: snapshot.data!.data?.title == null
                            ? ""
                            : "${snapshot.data!.data?.title}",
                        play: "${snapshot.data!.data?.play}",
                        id: "${snapshot.data!.data?.id}",
                      );
              } else {
                return _isConnectionPresent()
                    ? const GuideWidget()
                    : const Center(
                        child: Text("No network."),
                      );
              }
            },
          ),
        ],
      ),
    );
  }
}
