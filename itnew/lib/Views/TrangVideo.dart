import 'package:flutter/material.dart';
import 'package:itnew/Models/VideoData.dart';
import 'package:itnew/ViewModels/HomeSideBar.dart';
import 'package:itnew/ViewModels/VideoDetail.dart';
import 'package:itnew/ViewModels/VideoTitle.dart';
import 'package:itnew/Views/BottomNavi.dart';

class TrangVideo extends StatefulWidget {
  TrangVideo({Key? key});
  @override
  State<TrangVideo> createState() => _TrangVideoState();
}

class _TrangVideoState extends State<TrangVideo> {
  int _snappedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Các video')),
      body: PageView.builder(
        onPageChanged: (int page) => {print("Page change to$page")},
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              VideoTitle(
                video: videos[index],
                currentIndex: index,
                snappedPageIndex: _snappedPageIndex,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      child: VideoDetail(
                        video: videos[index],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: HomeSideBar(
                        video: videos[index],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
      bottomNavigationBar: const BottomNavi(index: 1),
    );
  }
}
