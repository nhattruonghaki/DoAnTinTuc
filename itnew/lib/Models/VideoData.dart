import 'package:itnew/Models/User.dart';
import 'package:itnew/Models/Video.dart';

User currentUser = User('www.baomoi.com');
User user1 = User('indianexpress.com');
User user2 = User('tech.hindustantimes.com');
User user3 = User('indiatechnologynews.in');
User user4 = User('dunyanews.tv');
User user5 = User('usnews.com');
User user6 = User('indiatoday.in');
User user7 = User('financialexpress.com');
User user8 = User('etnownews.com');
User user9 = User('thepress.net');
User user10 = User('advocateanddemocrat.com');

final List<Video> videos = <Video>[
  Video('v1.mp4', user1, 'Which story gets you stoked?', '12.5K', '123'),
  Video('v2.mp4', user2, 'Tin tức công nghệ 24h', '1809', '123'),
  Video(
      'v3.mp4',
      user3,
      'Bionic eye technology helps people see things clearly at night',
      '807',
      '123'),
  Video('v4.mp4', user4, 'Make it happen NOW 😡', '1M', '823'),
  Video(
      'v5.mp4',
      user5,
      'NAMTECH partners with Cisco to advance cybersecurity education and training for the manufacturing sector in India',
      '829',
      '123'),
  Video(
      'v6.mp4', user6, 'Scientists say they have uncovered a', '10.7K', '623'),
  Video(
      'v7.mp4',
      user7,
      'AI has played a transformative role in healthcare, particularly in the realm of diagnostics',
      '807.K',
      '893'),
  Video(
      'v8.mp4',
      user8,
      'Microsoft is phasing out the classic text editor for good.',
      '117.K',
      '293'),
  Video('v9.mp4', user9, 'Gaming All In One M3', '9807', '723'),
  Video(
      'v10.mp4',
      user10,
      'Technological Singularity ยุคที่เรากำลังเดินทางด้วยความเร็วสูงเข้าสู่ยุคที่ AI เหนือกว่ามนุษย์ทุกด้าน ',
      '2M',
      '251'),
];
