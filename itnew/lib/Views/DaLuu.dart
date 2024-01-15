import 'package:flutter/material.dart';

class DaLuu extends StatefulWidget {
  const DaLuu({super.key});

  @override
  State<DaLuu> createState() => _DaLuuState();
}

class _DaLuuState extends State<DaLuu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đã lưu',
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
