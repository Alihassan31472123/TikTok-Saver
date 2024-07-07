import 'package:tiktokesaverproject/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  late final Box historyBox;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    historyBox = Hive.box('historyBox');
  }

  Future<void> _refreshHistory() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a delay to fetch new data
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshHistory,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show the count of videos saved
            Text(
              'Videos Saved: ${historyBox.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // const NativeAdManagerWidget(),
            SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ValueListenableBuilder(
                      valueListenable: historyBox.listenable(),
                      builder: (context, Box box, widget) {
                        if (box.isEmpty) {
                          return const Center(child: Text("No history."));
                        } else {
                          return ListView.builder(
                            itemCount: box.length,
                            itemBuilder: (context, index) {
                              var currentBox = box;
                              var historyData =
                                  currentBox.getAt(box.length - 1 - index)!;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Card(
                                  elevation: 10,
                                  child: MyCard(
                                    cover: historyData.cover,
                                    author: historyData.author,
                                    title: historyData.title,
                                    filePath: historyData.filePath,
                                    index: box.length - 1 - index,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
