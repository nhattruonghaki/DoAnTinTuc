import 'package:flutter/material.dart';
// import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Models/FontChange.dart';
import 'package:itnew/Models/ThemeProvider.dart';
import 'package:provider/provider.dart';

class LichSu extends StatefulWidget {
  const LichSu({super.key});

  @override
  State<LichSu> createState() => _LichSuState();
}

class _LichSuState extends State<LichSu> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FontTextProvider()..init()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()..init()),
      ],
      child: Consumer2<FontTextProvider, ThemeProvider>(
          builder: (context, fontProvider, themeProvider, child) {
        Color textColor = themeProvider.isDarkMode
            ? Colors.white
            : const Color.fromARGB(255, 24, 24, 24);
        return Scaffold(
          backgroundColor: themeProvider.isDarkMode
              ? Color.fromARGB(255, 24, 24, 24)
              : Colors.white,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(222, 0, 183, 255),
            title: Text(
              'History',
              style: TextStyle(
                  fontFamily:
                      fontProvider.selectedFont == 'Inter' ? 'Inter' : 'Kalam',
                  color: Colors.white),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.black, size: 40))
            ],
          ),
        );
      }),
    );
  }
}
