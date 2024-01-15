import 'package:flutter/material.dart';

class BottomNavi extends StatelessWidget {
  const BottomNavi({super.key, required this.index});
  final index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: Colors.blue,
      unselectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          label: 'Tin Tức',
          icon: Icon(Icons.mail_outline),
        ),
        BottomNavigationBarItem(
            label: 'Video', icon: Icon(Icons.video_collection_outlined)),
        BottomNavigationBarItem(
            label: 'Cá nhân', icon: Icon(Icons.account_circle_outlined)),
      ],
      currentIndex: index,
      onTap: (int indexOfItem) {
        if (indexOfItem == 0 && ModalRoute.of(context)?.settings.name != '/') {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, '/');
        }
        if (indexOfItem == 1 &&
            ModalRoute.of(context)?.settings.name != '/video') {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushNamed(context, '/video');
        }
        if (indexOfItem == 2 &&
            ModalRoute.of(context)?.settings.name != '/canhan') {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushNamed(context, '/canhan');
        }
      },
    );
  }
}
