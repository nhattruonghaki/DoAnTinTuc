import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/ThemeProvider.dart';

class BottomNavi extends StatelessWidget {
  const BottomNavi({super.key, required this.index});
  final index;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey
        )
      ),
      child: BottomNavigationBar(
      backgroundColor: themeProvider.isDarkMode ? Color.fromARGB(255, 24, 24, 24) : Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: themeProvider.isDarkMode ? Colors.white : Color.fromARGB(255, 24, 24, 24),
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
        } else
        if (indexOfItem == 1 &&
            ModalRoute.of(context)?.settings.name != '/video') {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushNamed(context, '/video');
        } else
        if (indexOfItem == 2 &&
            ModalRoute.of(context)?.settings.name != '/canhan') {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushNamed(context, '/canhan');  
        }
      },
    ),
    );
  }
}
