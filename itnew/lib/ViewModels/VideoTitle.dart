import 'package:flutter/material.dart';
import 'package:itnew/Models/Video.dart';
import 'package:video_player/video_player.dart';

class VideoTitle extends StatefulWidget {
  const VideoTitle(
      {super.key,
      required this.video,
      required this.currentIndex,
      required this.snappedPageIndex});
  final Video video;
  final int snappedPageIndex;
  final int currentIndex;

  @override
  State<VideoTitle> createState() => _VideoTitleState();
}

class _VideoTitleState extends State<VideoTitle> {
  late VideoPlayerController _videoController;
  late Future _initializeVideoPlayer;
  bool _isVideoPlaying = true;
  @override
  void initState() {
    _videoController =
        VideoPlayerController.asset('assets/video/${widget.video.videoUrl}');

    _initializeVideoPlayer = _videoController.initialize();
    _videoController.setLooping(true);
    _videoController.play();
    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _pausePlayVideo() {
    _isVideoPlaying ? _videoController.pause() : _videoController.play();

    setState(() {
      _isVideoPlaying = !_isVideoPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    (widget.snappedPageIndex == widget.currentIndex && _isVideoPlaying)
        ? _videoController.play()
        : _videoController.pause();
    return Container(
      color: Colors.black,
      child: FutureBuilder(
        future: _initializeVideoPlayer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () => {_pausePlayVideo()},
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_videoController),
                  IconButton(
                    onPressed: () => {_pausePlayVideo()},
                    icon: Icon(Icons.play_arrow),
                    color: Colors.white.withOpacity(_isVideoPlaying ? 0 : 0.5),
                    iconSize: 70,
                  )
                ],
              ),
            );
          } else {
            return Container(
              color: Colors.black,
            );
          }
        },
      ),
    );
  }
}
