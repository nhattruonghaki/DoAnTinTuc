import 'package:flutter/material.dart';

class CoChuvaFontChu extends StatefulWidget {
  const CoChuvaFontChu({super.key});

  @override
  State<CoChuvaFontChu> createState() => _CoChuvaFontChuState();
}

class _CoChuvaFontChuState extends State<CoChuvaFontChu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cỡ chữ và Font chữ')),
    );
  }
}
