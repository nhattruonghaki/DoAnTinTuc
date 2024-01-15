import 'package:itnew/Models/User.dart';

class Video {
  final String videoUrl;
  final User posteBy;
  final String caption;
  final String likes;
  final String dislikes;

  Video(this.videoUrl, this.posteBy, this.caption, this.likes, this.dislikes);
}
