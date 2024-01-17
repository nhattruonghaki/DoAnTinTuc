import 'package:flutter/material.dart';
import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Models/TangGiamFont.dart';
import 'package:itnew/Views/TrangCaNhan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../Models/ThemeProvider.dart';

class CoChuvaFontChu extends StatefulWidget {
  const CoChuvaFontChu({Key? key}) : super(key: key);

  //const CoChuvaFontChu({super.key});

  @override
  State<CoChuvaFontChu> createState() => _CoChuvaFontChuState();
}

class _CoChuvaFontChuState extends State<CoChuvaFontChu> {
  void updateFontsChus(String newFont) {
    // ----------------------------------------------- CẬP NHẬT FONT CHỮ -------------------
    setState(() {
      fontsChu.updateFontsChu(newFont);
      //selectedFont = newFont; // cập nhật kiểu chữ đã chọn
    });
  }

  void updateFontSize_CoChu(int newFontSize) {
    // ----------------------------------------------- CẬP NHẬT CỠ CHỮ -------------------
    setState(() {
      fontSize.updateFontSize(newFontSize);
    });
  }

  late FontsChu fontsChu;
  late TangGiamFont fontSize;
  late String selectedFont;

  @override
  void initState() {
    super.initState();
    fontsChu = FontsChu();
    fontSize = TangGiamFont();
    selectedFont = fontsChu.fontInter;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider()..init(),
      child: Consumer<ThemeProvider>(
          builder: (context, ThemeProvider notifier, child) {
        Color textColor = notifier.isDarkMode
            ? Colors.white
            : const Color.fromARGB(255, 24, 24, 24);
        return Scaffold(
          backgroundColor: notifier.isDarkMode ? Colors.black : Colors.white,
          appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              // leading: IconButton(
              //   icon: const Icon(Icons.arrow_back),
              //   onPressed: () {
              //     //Navigator.popUntil(context, (route) => route.isCurrent);
              //     Navigator.pushNamed(context, '/canhan');
              //   },
              // ),
              backgroundColor: const Color.fromARGB(222, 0, 183, 255),
              centerTitle: true,
              title: Text(
                'Font and Size Text',
                style: TextStyle(
                  fontFamily: fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  key: UniqueKey(),
                  children: [
                    Container(
                      margin: EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/img/g63.jpg',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'The news app is growing, trying its best...',
                      style: TextStyle(
                        fontSize: fontSize.coChu.toDouble(),
                        fontFamily:
                            fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
                        color: textColor,
                      ),
                    ),
                    // Các phần khác của mã ở đây
                    // ...
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15,
                          height: 120,
                        ),
                        Text(
                          'Size Text',
                          style: TextStyle(
                            fontFamily: fontsChu.fontInter == 'Inter'
                                ? 'Inter'
                                : 'Kalam',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        SizedBox(width: 60),
                        IconButton(
                          onPressed: () {
                            updateFontSize_CoChu(fontSize.coChu - 2);
                          },
                          icon: Icon(
                            Icons.arrow_circle_down_outlined,
                            color: textColor,
                            size: 50,
                          ),
                        ),
                        SizedBox(width: 30),
                        Text(
                          fontSize.coChu.toString(),
                          style: TextStyle(
                            color: textColor,
                            fontFamily: fontsChu.fontInter == 'Inter'
                                ? 'Inter'
                                : 'Kalam',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 30),
                        IconButton(
                          onPressed: () {
                            updateFontSize_CoChu(fontSize.coChu + 2);
                          },
                          icon: Icon(
                            Icons.arrow_circle_up_outlined,
                            color: textColor,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Font Text',
                          style: TextStyle(
                            color: textColor,
                            fontFamily: fontsChu.fontInter == 'Inter'
                                ? 'Inter'
                                : 'Kalam',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 50),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              updateFontsChus('Inter');
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            backgroundColor: selectedFont == 'Inter'
                                ? Colors.green
                                : Colors.white,
                          ),
                          child: Text(
                            'Inter',
                            style: TextStyle(
                              fontFamily: fontsChu.fontInter == 'Inter'
                                  ? 'Inter'
                                  : 'Kalam',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              updateFontsChus('Kalam');
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            backgroundColor: selectedFont == 'Kalam'
                                ? Colors.green
                                : Colors.white,
                          ),
                          child: Text(
                            'Kalam',
                            style: TextStyle(
                              fontFamily: fontsChu.fontInter == 'Inter'
                                  ? 'Inter'
                                  : 'Kalam',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
