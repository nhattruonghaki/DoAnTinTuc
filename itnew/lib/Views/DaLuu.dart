import 'package:flutter/material.dart';
import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Models/ThemeProvider.dart';
import 'package:provider/provider.dart';

class DaLuu extends StatefulWidget {
  const DaLuu({super.key});

  @override
  State<DaLuu> createState() => _DaLuuState();
}

class _DaLuuState extends State<DaLuu> {
  FontsChu fontsChu = FontsChu();
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? const Color.fromARGB(255, 24, 24, 24)
          : Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(222, 0, 183, 255),
        title: Text(
          'Đã lưu',
          style: TextStyle(
              fontFamily: fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
              color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
                size: 40,
              ))
        ],
      ),
    );
  }
}
