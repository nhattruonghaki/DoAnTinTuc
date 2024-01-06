import 'package:flutter/material.dart';

class TrangChiTiet extends StatefulWidget {
  const TrangChiTiet({super.key});

  @override
  State<TrangChiTiet> createState() => _TrangChiTietState();
}

class _TrangChiTietState extends State<TrangChiTiet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang Chi Tiết')),
    );
  }
}
