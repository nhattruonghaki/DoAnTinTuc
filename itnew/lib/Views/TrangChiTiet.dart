import 'package:flutter/material.dart';
// import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Models/FontChange.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FontTextProvider()..init()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()..init()),
      ],
      child: Consumer2<FontTextProvider, ThemeProvider>(
          builder: (context, fontProvider, themeProvider, child) {
        Color textColor = themeProvider.isDarkMode
            ? Colors.white
            : const Color.fromARGB(255, 24, 24, 24);
        return Scaffold(
          backgroundColor:
              themeProvider.isDarkMode ? Colors.black : Colors.white,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(222, 0, 183, 255),
            title: Text(
              'ITFEEDS',
              style: TextStyle(
                  fontFamily:
                      fontProvider.selectedFont == 'Inter' ? 'Inter' : 'Kalam',
                  color: Colors.white),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark,
                    color: Colors.black,
                    size: 40,
                  ))
            ],
          ),
          body: ListView(
            children: [
              Image.network(
                widget.imagedata ?? Container(),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title ?? Container(),
                      style: TextStyle(
                          fontFamily: fontProvider.selectedFont == 'Inter'
                              ? 'Inter'
                              : 'Kalam',
                          fontWeight: FontWeight.w500,
                          fontSize: fontProvider.fontSize.toDouble(),
                          color: textColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        widget.date.toString().substring(5, 34),
                        style: TextStyle(
                            fontFamily: fontProvider.selectedFont == 'Inter'
                                ? 'Inter'
                                : 'Kalam',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: textColor),
                      ),
                    ),
                    Text(
                      (widget.description != null &&
                              widget.description.toString().contains('<div>'))
                          ? (() {
                              String noidung = widget.description.toString();
                              int startDivIndex = noidung.indexOf(
                                  '<div>', noidung.indexOf('<div>') + 1);
                              int endDivIndex =
                                  noidung.indexOf('</div>', startDivIndex);
                              String contentdescription = noidung.substring(
                                  startDivIndex + 5, endDivIndex);
                              return contentdescription;
                            })()
                          : 'Không có mô tả hoặc mô tả không hợp lệ',
                      style: TextStyle(
                          fontFamily: fontProvider.selectedFont == 'Inter'
                              ? 'Inter'
                              : 'Kalam',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: textColor),
                    ),
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
                      fontFamily: fontProvider.selectedFont == 'Inter'
                          ? 'Inter'
                          : 'Kalam',
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
      }),
    );
  }
}
