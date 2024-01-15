import 'package:flutter/material.dart';

class TrangThongBao extends StatefulWidget {
  const TrangThongBao({super.key});

  @override
  State<TrangThongBao> createState() => _TrangThongBaoState();
}

class _TrangThongBaoState extends State<TrangThongBao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông báo',
                    style: TextStyle(color: Colors.black),),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),),
    );
  }
}
