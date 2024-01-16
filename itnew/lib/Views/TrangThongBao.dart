import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Models/TangGiamFont.dart';
import 'package:itnew/Views/TrangChiTiet.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:xml2json/xml2json.dart';

class TrangThongBao extends StatefulWidget {
  const TrangThongBao({super.key, required this.title});
  final String title;

  @override
  State<TrangThongBao> createState() => _TrangThongBaoState();
}

class _TrangThongBaoState extends State<TrangThongBao> {
  FontsChu fontsChu = FontsChu();
  TangGiamFont fontSize = TangGiamFont();
  final Xml2Json xml2json = Xml2Json();
  List NewsTop = [];
  Future newsFeed() async {
    final url = Uri.parse('https://rss.app/feeds/gfHt3tVFhNSilX87.xml');
    final response = await http.get(url);
    xml2json.parse(response.body.toString());
    var jsondata = xml2json.toGData();
    var data = json.decode(jsondata);
    NewsTop = data['rss']['channel']['item'];
    print(NewsTop);
  }

  @override
  Widget build(BuildContext context) {
    newsFeed();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông báo mới',
          style: TextStyle(
              fontFamily: fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
              color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder(
          future: newsFeed(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: NewsTop.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
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
                                        padding: const EdgeInsets.all(10),
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
                                                      const Center(
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
                                            const SizedBox(
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
                                                      fontFamily:
                                                          fontsChu.fontInter ==
                                                                  'Inter'
                                                              ? 'Inter'
                                                              : 'Kalam',
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
                                                      fontFamily:
                                                          fontsChu.fontInter ==
                                                                  'Inter'
                                                              ? 'Inter'
                                                              : 'Kalam',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 9,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                        fontFamily:
                                                            fontsChu.fontInter ==
                                                                    'Inter'
                                                                ? 'Inter'
                                                                : 'Kalam',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: fontSize.coChu
                                                            .toDouble(),
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
    );
  }
}
