import 'package:flutter/material.dart';

import '../Models/Video.dart';

class VideoDetail extends StatelessWidget {
  const VideoDetail({super.key, required this.video});
  final Video video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "${video.posteBy.username}",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            video.caption,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                ),
            // expandText: 'more',
            // collapseText: 'less',
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
