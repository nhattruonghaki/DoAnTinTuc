import 'package:flutter/material.dart';
import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Models/ThemeProvider.dart';
import 'package:provider/provider.dart';

class LichSu extends StatefulWidget {
  const LichSu({super.key});

  @override
  State<LichSu> createState() => _LichSuState();
}

class _LichSuState extends State<LichSu> {
  FontsChu fontsChu = FontsChu();
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Color.fromARGB(255, 24, 24, 24) : Colors.white,
      appBar: AppBar(
              backgroundColor: Color.fromARGB(222, 0, 183, 255),
              title: Text('Lịch Sử',
              style: TextStyle(fontFamily: fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',color: Colors.black),),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black),
              actions: [
                IconButton(onPressed: (){}, 
                          icon: Icon(Icons.delete,color: Colors.black,size: 40))
              ],),
    );
  }
}
