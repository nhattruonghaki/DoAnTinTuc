import 'package:flutter/material.dart';
import 'package:itnew/Models/FontsChu.dart';
import 'package:provider/provider.dart';
import '../Models/ThemeProvider.dart';

class BottomNavi extends StatelessWidget {
  BottomNavi({super.key, required this.index});
  final index;
  FontsChu fontsChu = FontsChu();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    TextStyle labelStyle = TextStyle(
      fontFamily: fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
    );
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: BottomNavigationBar(
        backgroundColor: themeProvider.isDarkMode
            ? const Color.fromARGB(255, 24, 24, 24)
            : Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: themeProvider.isDarkMode
            ? Colors.white
            : const Color.fromARGB(255, 24, 24, 24),
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
          if (indexOfItem == 0 &&
              ModalRoute.of(context)?.settings.name != '/') {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(context, '/');
          } else if (indexOfItem == 1 &&
              ModalRoute.of(context)?.settings.name != '/video') {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushNamed(context, '/video');
          } else if (indexOfItem == 2 &&
              ModalRoute.of(context)?.settings.name != '/canhan') {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushNamed(context, '/canhan');
          }
        },
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle,
      ),
    );
  }
}
