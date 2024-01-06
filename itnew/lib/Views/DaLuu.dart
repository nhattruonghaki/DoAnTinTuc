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
      appBar: AppBar(title: const Text('Đã lưu')),
    );
  }
}
