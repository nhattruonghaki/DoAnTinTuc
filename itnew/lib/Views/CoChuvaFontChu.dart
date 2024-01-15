import 'package:flutter/material.dart';
import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Models/TangGiamFont.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoChuvaFontChu extends StatefulWidget {
  const CoChuvaFontChu({Key? key}) : super(key: key);

  //const CoChuvaFontChu({super.key});

  @override
  State<CoChuvaFontChu> createState() => _CoChuvaFontChuState();
}

class _CoChuvaFontChuState extends State<CoChuvaFontChu> {
  void updateFontsChus(String newFont) async {
    // ----------------------------------------------- CẬP NHẬT FONT CHỮ -------------------
    setState(() {
      fontsChu.updateFontsChu(newFont);
      selectedFont = newFont; // cập nhật kiểu chữ đã chọn
      saveSelectedFont(); // lưu kiểu chữ đã chọn voà sharepre
    });
  }

  void updateFontSize_CoChu(int newFontSize) {
    // ----------------------------------------------- CẬP NHẬT CỠ CHỮ -------------------
    setState(() {
      fontSize.updateFontSize(newFontSize);
    });
  }

// lưu dữ liệu đã cài đặt
Future<void> saveSelectedFont() async{
  SharedPreferences saveShaPre = await SharedPreferences.getInstance();
  await saveShaPre.setString('selectedFont', selectedFont);
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
    loadSelectedFont();
  }

// tải dữ liệu đã cài đặt
  Future<void> loadSelectedFont() async{
    SharedPreferences shaPre = await SharedPreferences.getInstance();
    setState(() {
      selectedFont = shaPre.getString('selectedFont') ?? fontsChu.fontInter;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(222, 0, 183, 255),
          title: const Text(
            'Cỡ chữ và Font chữ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              'assets/g63.jpg',
              width: double.infinity, // Đặt kích thước theo chiều ngang
              height: 200, // Đặt kích thước theo chiều dọc
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Row(
              key: UniqueKey(),
              children: [
                Expanded(
                  child: Text(
                    'App tin tức đang phát triển, đang cố gắng hết sức',
                    style: TextStyle(
                        fontSize: fontSize.coChu.toDouble(),
                        fontFamily:
                            fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam'
                        //fontFamily: 'Inter'
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 15,
                      height: 120,
                    ),
                    const Text('Cỡ chữ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight
                                .bold)), // ----------------------------------CỠ CHỮ ------------------------
                    const SizedBox(width: 60),
                    IconButton(
                      onPressed: () {
                        updateFontSize_CoChu(fontSize.coChu -
                            2); // ---------------------- GIẢM CỠ CHỮ ---------------------
                      },
                      icon: const Icon(
                        Icons.arrow_circle_down_outlined,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Text(fontSize.coChu.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 30),
                    IconButton(
                      onPressed: () {
                        updateFontSize_CoChu(fontSize.coChu +
                            2); // ------------------------ TĂNG CỠ CHỮ ---------------------
                      },
                      icon: const Icon(
                        Icons.arrow_circle_up_outlined,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 4,
                    ),
                    const Text('Font chữ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          updateFontsChus(selectedFont =
                              'Inter'); // ------------------------------------------ ĐỔI FONT CHỮ ------------------------
                          // selectedFont = 'Inter';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        backgroundColor: selectedFont == 'Inter'
                            ? Colors.green
                            : Colors.white,
                      ),
                      child: const Text('Inter',
                          style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          updateFontsChus(selectedFont =
                              'Kalam'); // ------------------------------------------ ĐỔI FONT CHỮ ------------------------
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        backgroundColor: selectedFont == 'Kalam'
                            ? Colors.green
                            : Colors.white,
                      ),
                      child: const Text('Kalam',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
