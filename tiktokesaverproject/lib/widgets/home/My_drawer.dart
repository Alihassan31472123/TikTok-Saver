import 'package:flutter/material.dart';
import 'package:tiktokesaverproject/Google_ads_manager/nativeads.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  // Function to launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Center(
              child: Text(
                'TikToke Saver',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Rate us'),
            onTap: () {
              // Handle rate us action
              // Replace 'url' with your actual rating link
              _launchURL('https://play.google.com/store/apps/details?id=com.ah.developers.tiktoke.saver');
            },
          ),
          ListTile(
            title: const Text('Share us'),
            onTap: () {
              // Handle share us action
              // Replace 'url' with your actual share link
              _launchURL('https://play.google.com/store/apps/details?id=com.ah.developers.tiktoke.saver');
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () {
              // Handle privacy policy action
              // Replace 'url' with your actual privacy policy link
              _launchURL('https://hasolution.org/privacy-policy.html');
            },
          ),
          const NativeAdManagerWidget(),
          const NativeAdManagerWidget(), 
        ],
      ),
    );
  }
}
