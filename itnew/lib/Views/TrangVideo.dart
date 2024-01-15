import 'package:flutter/material.dart';
import 'package:itnew/Views/BottomNavi.dart';

class TrangVideo extends StatefulWidget {
  const TrangVideo({super.key});

  @override
  State<TrangVideo> createState() => _TrangVideoState();
}

class _TrangVideoState extends State<TrangVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Các video')),
      bottomNavigationBar: const BottomNavi(index: 1),
    );
  }
}
