import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:itnew/Models/Video.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeSideBar extends StatefulWidget {
  const HomeSideBar({super.key, required this.video});
  final Video video;

  @override
  State<HomeSideBar> createState() => _HomeSideBarState();
}

class _HomeSideBarState extends State<HomeSideBar> {
  @override
  Widget build(BuildContext context) {
    String solikes = widget.video.likes.toString();
    String sodislikes = widget.video.dislikes.toString();
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            child: Icon(
              Icons.thumb_up,
              color: Colors.white,
              size: 40,
            ), // Icon like màu đen
            height: 5,
          ),
          Text(
            solikes,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            // Khoảng cách 10px giữa dislike và share
            child: Icon(
              Icons.thumb_down,
              color: Colors.white,
              size: 40,
            ),
            height: 5,
          ),
          Text(
            sodislikes,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            child: Icon(
              Icons.share,
              color: Colors.white,
              size: 40,
            ),
            height: 5,
          ),
          Text(
            'Share',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  _sideBarItem(String label) {
    return Column(
      children: [Text(label)],
    );
  }
}
