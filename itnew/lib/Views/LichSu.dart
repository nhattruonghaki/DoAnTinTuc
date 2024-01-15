import 'package:flutter/material.dart';

class LichSu extends StatefulWidget {
  const LichSu({super.key});

  @override
  State<LichSu> createState() => _LichSuState();
}

class _LichSuState extends State<LichSu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch Sử',
              style: TextStyle(color: Colors.black),),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black),
              actions: [
                IconButton(onPressed: (){}, 
                          icon: Icon(Icons.delete,color: Colors.black,))
              ],),
    );
  }
}
