import 'package:flutter/material.dart';
import 'package:itnew/Models/ThemeProvider.dart';
import 'package:provider/provider.dart';

class DaLuu extends StatefulWidget {
  const DaLuu({super.key});

  @override
  State<DaLuu> createState() => _DaLuuState();
}

class _DaLuuState extends State<DaLuu> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Color.fromARGB(255, 24, 24, 24) : Colors.white,
      appBar: AppBar(
              backgroundColor: Color.fromARGB(222, 0, 183, 255),
              title: const Text('Đã lưu',
              style: TextStyle(color: Colors.white),),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black),
              actions: [
                IconButton(onPressed: (){}, 
                          icon: Icon(Icons.delete,color: Colors.black,size: 40,))
              ],),
    );
  }
}
