import 'package:tiktokesaverproject/widgets/steps.dart';
import 'package:flutter/material.dart';

class GuideWidget extends StatelessWidget {
  const GuideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Card(
          elevation: 20,
          shadowColor: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "How to download?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Steps(
                no: "1",
                message:
                    "Open tiktok app and find the video that you want to download, and click on share.",
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(10), // Adjust the radius as needed
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          0.5), // Adjust the shadow color and opacity
                      spreadRadius: 5, // Adjust the spread radius
                      blurRadius: 10, // Adjust the blur radius
                      offset: Offset(1, 2), // Adjust the offset if needed
                    ),
                  ],
                ),
                child: Image.asset(
                  "assets/step_1.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // const NativeAdManagerWidget(),
              const Steps(
                no: "2",
                message: "Click on copy link and close the tiktok app.",
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.5), // Adjust the shadow color and opacity
                        spreadRadius: 5, // Adjust the spread radius
                        blurRadius: 10, // Adjust the blur radius
                        offset: Offset(1, 2), // Adjust the offset if needed
                      ),
                    ],
                  ),
                  child: Image.asset("assets/step_2.png")),
              const SizedBox(
                height: 10,
              ),
              const Steps(
                no: "3",
                message:
                    "Open Tiktok Save app and paste the tiktok video link you copied.",
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.5), // Adjust the shadow color and opacity
                        spreadRadius: 5, // Adjust the spread radius
                        blurRadius: 10, // Adjust the blur radius
                        offset: Offset(1, 2), // Adjust the offset if needed
                      ),
                    ],
                  ),
                  child: Image.asset("assets/step_3.png")),
              const SizedBox(
                height: 10,
              ),
              // const NativeAdManagerWidget(),
              const Steps(
                no: "4",
                message: "Wait for the application to fetch the video info.",
              ),
              const SizedBox(
                height: 10,
              ),
              const Steps(
                no: "5",
                message: "Click the download button to start downloading.",
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.5), // Adjust the shadow color and opacity
                        spreadRadius: 5, // Adjust the spread radius
                        blurRadius: 10, // Adjust the blur radius
                        offset: Offset(1, 2), // Adjust the offset if needed
                      ),
                    ],
                  ),
                  child: Image.asset("assets/step5.jpeg")),
            ],
          ),
        ),
      ),
    );
  }
}
