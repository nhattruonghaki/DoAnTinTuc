import 'package:flutter/material.dart';
import 'package:itnew/Models/ThemeProvider.dart';
import 'package:provider/provider.dart';

class TrangThongBao extends StatefulWidget {
  const TrangThongBao({super.key});

  @override
  State<TrangThongBao> createState() => _TrangThongBaoState();
}

class _TrangThongBaoState extends State<TrangThongBao> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Color.fromARGB(255, 24, 24, 24) : Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(222, 0, 183, 255),
        title: const Text('Thông báo',
                    style: TextStyle(color: Colors.white),),
      centerTitle: true,),
    );
  }
}
