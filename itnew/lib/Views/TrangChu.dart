import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:itnew/Views/BottomNavi.dart';
import 'package:itnew/Views/TimKiem.dart';
import 'package:itnew/Views/TrangChiTiet.dart';
import 'package:itnew/Views/TrangThongBao.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class TrangChu extends StatefulWidget {
  const TrangChu({super.key, required this.title});
  final String title;
  @override
  State<TrangChu> createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChu>
    with SingleTickerProviderStateMixin {
  // minxin cung cấp đối tượng đối tượng TickerProvider
// duy nhất và có thể sử dụng cho 1 Ticker (đối tượng thời gian) -> animation
  final Xml2Json xml2json = Xml2Json();
  List NewsTop = [];
  Future newsFeed() async {
    final url = Uri.parse('https://rss.app/feeds/M2tei6dXHcrp41Wk.xml');
    final response = await http.get(url);
    xml2json.parse(response.body.toString());
    var jsondata = await xml2json.toGData();
    var data = json.decode(jsondata);
    NewsTop = data['rss']['channel']['item'];
    print(NewsTop);
  }

  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //return DefaultTabController(
    //  length: 2,
    //child:
    newsFeed();
    return Scaffold(
// ----------------------------------------------- LOGO -----------------------------------------------
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(222, 0, 183, 255),
        title: const Text(
          'ITNew Internet Society',
          style: TextStyle(
            //fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TimKiem(),
                    ));
              },
              icon: const Icon(
                Icons
                    .search, // ------------------------------------- TÌM KIẾM ------------------------
                color: Colors.black,
                size: 30.0,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TrangThongBao()),
                );
              },
              icon: const Icon(
                Icons
                    .notifications_outlined, // ------------------------------------- THÔNG BÁO ------------------------
                color: Colors.black,
                size: 30.0,
              )),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(40), // kích thước tối ưu cho TabBar
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.black, // unfocus

              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flash_on_sharp),
                      SizedBox(width: 1),
                      Text('Mới nhất')
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.trending_up_outlined),
                      SizedBox(width: 1),
                      Text('Xu hướng')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
// ----------------------------------------------- DANH MỤC -------------------------------------------
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(222, 0, 183, 255)),
                child: Image.asset('assets/ITNew.png')),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                _tabController
                    ?.animateTo(0); // hiệu ứng chuyển đến tab "Mới nhất"
              },
              leading: const Icon(Icons.flash_on_sharp),
              title: const Text('Mới nhất'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                _tabController
                    ?.animateTo(1); // hiệu ứng chuyển đến tab "Xu hướng"
              },
              leading: const Icon(Icons.trending_up_outlined),
              title: const Text('Xu hướng'),
            ),
          ],
        ),
      ),
// -------------------------------------------- FOOTER -----------------------------------------------------------------------------
      bottomNavigationBar: const BottomNavi(index: 0),

// -------------------------------------------- BODY --------TAB BAR VIEW ----------------------------------------------------------
      body: TabBarView(controller: _tabController, children: [
        FutureBuilder(
            future: newsFeed(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
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
                                        SizedBox(
                                          width: double.infinity,
                                          child: NewsTop[index]
                                                      ['media\$content'] !=
                                                  null
                                              ? CachedNetworkImage(
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
                                                  ), // Hiển thị indicator khi đang tải
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Container(), // Hiển thị icon lỗi nếu không tải được
                                                )
                                              : null, // Nếu không tìm thấy mục media\$content, không hiển thị gì lên giao diện
                                        ),
                                        SizedBox(width: 30),
                                        Text(
                                          NewsTop[index]['link']
                                              .toString()
                                              .substring(
                                                  13,
                                                  NewsTop[index]['link']
                                                      .toString()
                                                      .indexOf('/', 13)),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          NewsTop[index]['pubDate']
                                              .toString()
                                              .substring(5, 30),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            NewsTop[index]['title']['__cdata'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        const Divider(
                                          thickness:
                                              10, // ------------------------- ĐỘ DÀY
                                          color: Colors
                                              .white, // ----------------- MÀU SẮC
                                          indent:
                                              1, // ---------------------------- LÙI SANG TRÁI
                                          endIndent:
                                              1, // ------------------------- LÙI SANG PHẢI
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
        FutureBuilder(
            future: newsFeed(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Container(
                      height: 45,
                      width: 45,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.75,
                      ))
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
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: NewsTop[index]
                                                      ['media\$content'] !=
                                                  null
                                              ? Image.network(
                                                  NewsTop[index]
                                                      ['media\$content']['url'],
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            NewsTop[index]['pubDate'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            NewsTop[index]['title']['__cdata'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
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
      ]),
    );
    //);
  }
}
