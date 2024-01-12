import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itnew/Views/TrangChiTiet.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:xml2json/xml2json.dart';
import 'package:itnew/Models/ThemeProvider.dart';
import 'package:provider/provider.dart';

class TrangThongBao extends StatefulWidget {
  const TrangThongBao({super.key, required this.title});
  final String title;

  @override
  State<TrangThongBao> createState() => _TrangThongBaoState();
}

class _TrangThongBaoState extends State<TrangThongBao> {
  final Xml2Json xml2json = Xml2Json();
  List NewsTop = [];
  Future newsFeed() async {
    final url = Uri.parse('https://rss.app/feeds/gfHt3tVFhNSilX87.xml');
    final response = await http.get(url);
    xml2json.parse(response.body.toString());
    var jsondata = await xml2json.toGData();
    var data = json.decode(jsondata);
    NewsTop = data['rss']['channel']['item'];
    print(NewsTop);
  }

  @override
  Widget build(BuildContext context) {
    newsFeed();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo mới',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder(
          future: newsFeed(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: NewsTop.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return TrangChiTiet(
                                            title: NewsTop[index]['title']
                                                ['__cdata'],
                                            imagedata: NewsTop[index][
                                                            'media\$content'] !=
                                                        null &&
                                                    NewsTop[index][
                                                                'media\$content']
                                                            ['url'] !=
                                                        null
                                                ? NewsTop[index]
                                                    ['media\$content']['url']
                                                : null,
                                            description: NewsTop[index]
                                                ['description']['__cdata'],
                                            date: NewsTop[index]['pubDate'],
                                            link: NewsTop[index]['link'],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[
                                              200], // Chọn màu xám cho nền khung
                                          borderRadius: BorderRadius.circular(
                                              10), // Bo tròn góc của khung
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (NewsTop[index]
                                                    ['media\$content'] !=
                                                null)
                                              SizedBox(
                                                width:
                                                    80, // Điều chỉnh kích thước của hình ảnh tại đây
                                                height: 80,
                                                child: CachedNetworkImage(
                                                  imageUrl: NewsTop[index]
                                                      ['media\$content']['url'],
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child: SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.blue),
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(),
                                                ),
                                              ),
                                            SizedBox(
                                                width:
                                                    5), // Tạo khoảng cách giữa hình ảnh và văn bản
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    NewsTop[index]['link']
                                                        .toString()
                                                        .substring(
                                                            13,
                                                            NewsTop[index]
                                                                    ['link']
                                                                .toString()
                                                                .indexOf(
                                                                    '/', 13)),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    NewsTop[index]['pubDate']
                                                        .toString()
                                                        .substring(5, 30),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 9,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8, bottom: 8),
                                                    child: Text(
                                                      NewsTop[index]['title']
                                                          ['__cdata'],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  );
          }),

    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Color.fromARGB(255, 24, 24, 24) : Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(222, 0, 183, 255),
        title: const Text('Thông báo',
                    style: TextStyle(color: Colors.white),),
      centerTitle: true,),
                    style: TextStyle(color: Colors.black),),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),),
    );
  }
}
