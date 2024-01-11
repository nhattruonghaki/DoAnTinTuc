import 'package:flutter/material.dart';
import 'package:itnew/Views/BottomNavi.dart';
import 'package:provider/provider.dart';
import '../Models/ThemeProvider.dart';

class TrangVideo extends StatefulWidget {
  const TrangVideo({super.key});

  @override
  State<TrangVideo> createState() => _TrangVideoState();
}

class _TrangVideoState extends State<TrangVideo> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Color.fromARGB(255, 24, 24, 24) : Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(222, 0, 183, 255),
        title: const Text('Các video'),
        centerTitle: true,),
      bottomNavigationBar: const BottomNavi(index: 1),
    );
  }
}
