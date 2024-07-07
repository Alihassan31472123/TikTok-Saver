import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdManagerWidget extends StatefulWidget {
  const NativeAdManagerWidget({super.key});

  @override
  State<NativeAdManagerWidget> createState() => _NativeAdManagerWidgetState();
}

class _NativeAdManagerWidgetState extends State<NativeAdManagerWidget> {
  NativeAd? nativeAd;

  bool _isAdLoaded = false;

  void loadNativeAd() {
    nativeAd = NativeAd(
        adUnitId: ('ca-app-pub-6611686410771379/9033530648'),
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            debugPrint('$NativeAd loaded.');
            setState(() {
              _isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            debugPrint('$NativeAd failed to load: $error');
            ad.dispose();
          },
          // // Called when a click is recorded for a NativeAd.
          // onAdClicked: (ad) {},
          // // Called when an impression occurs on the ad.
          // onAdImpression: (ad) {},
          // // Called when an ad removes an overlay that covers the screen.
          // onAdClosed: (ad) {},
          // // Called when an ad opens an overlay that covers the screen.
          // onAdOpened: (ad) {},
          // // For iOS only. Called before dismissing a full screen view
          // onAdWillDismissScreen: (ad) {},
          // // Called when an ad receives revenue value.
          // onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
        ),

        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
            // Required: Choose a template.
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.white,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.green,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }

  @override
  void initState() {
    loadNativeAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? Padding(
          padding: const EdgeInsets.all(10),
          child: Container(decoration:const BoxDecoration(),
              constraints: const BoxConstraints(
                minWidth: 320, // minimum recommended width
                minHeight: 120, // minimum recommended height
                maxWidth: 400,
                maxHeight: 200,
              ),
              child: Center(child: AdWidget(ad: nativeAd!)),
            ),
        )
        : Container();
  }
}