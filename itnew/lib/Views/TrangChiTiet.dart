import 'package:flutter/material.dart';
import 'package:itnew/ViewModels/News.dart';

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
    String noidung = widget.description.toString();
    int startDivIndex = noidung.indexOf('<div>', noidung.indexOf('<div>') + 1);
    int endDivIndex = noidung.indexOf('</div>', startDivIndex);
    String contentdescription =
        noidung.substring(startDivIndex + 5, endDivIndex);
    return Scaffold(
      appBar: AppBar(title: const Text('Trang Chi Tiết')),
      body: ListView(
        children: [
          Image.network(
            widget.imagedata ?? Container(),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title ?? Container(),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    widget.date.toString().substring(5, 34),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                ),
                Text(
                  contentdescription,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
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
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Xem chi tiết >>>",
                style: TextStyle(
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
