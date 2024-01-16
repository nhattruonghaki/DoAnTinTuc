import 'package:flutter/material.dart';
import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Models/TangGiamFont.dart';
import 'package:itnew/ViewModels/News.dart';
import 'package:provider/provider.dart';
import '../Models/ThemeProvider.dart';

// import 'package:flutter/src/widgets/container.dart';

// import 'package:html/parser.dart' show parse;
// import 'package:html/dom.dart' as dom;

class TrangChiTiet extends StatefulWidget {
  final title;
  final imagedata;
  final description;
  final date;
  final link;

  const TrangChiTiet({
    super.key,
    required this.title,
    required this.imagedata,
    required this.description,
    required this.date,
    required this.link,
  });

  @override
  State<TrangChiTiet> createState() => _TrangChiTietState();
}

class _TrangChiTietState extends State<TrangChiTiet> {
  FontsChu fontsChu = FontsChu();
  TangGiamFont fontSize = TangGiamFont();
  @override
  Widget build(BuildContext context) {
    String noidung = widget.description.toString();
    int startDivIndex = noidung.indexOf('<div>', noidung.indexOf('<div>') + 1);
    int endDivIndex = noidung.indexOf('</div>', startDivIndex);
    String contentdescription =
        noidung.substring(startDivIndex + 5, endDivIndex);

    var themeProvider = Provider.of<ThemeProvider>(context);

    Color scaffoldBackgroundColor = themeProvider.isDarkMode ? Color.fromARGB(255, 24, 24, 24) : Colors.white;
    Color textColor = themeProvider.isDarkMode ? Colors.white : Color.fromARGB(255, 24, 24, 24);
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Trang Chi Tiết', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(222, 0, 183, 255),),
      body: ListView(
        children: [
          Image.network(
            widget.imagedata ?? Container(),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title ?? Container(),

                  style: TextStyle(
                    fontFamily:
                        fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize.coChu.toDouble(),
                    color: textColor
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    widget.date.toString().substring(5, 34),

                    style: TextStyle(
                        fontFamily:
                            fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                    color: textColor),

                  ),
                ),
                Text(
                  contentdescription,

                  style: TextStyle(
                      fontFamily:
                          fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                  color: textColor),

                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsWebView(
                        url: widget.link.toString().substring(
                            5, widget.link.toString().indexOf('}', 5))),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Xem chi tiết >>>",
                style: TextStyle(
                  fontFamily: fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.blue, // Màu sắc có thể thay đổi tùy ý
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
