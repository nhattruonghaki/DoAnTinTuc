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
  List NewsTechnology = [];
  List NewsBusiness = [];
  List NewsEntertainment = [];
  List NewsSports = [];
  Future NewsTechnologyFeed() async {
    final url = Uri.parse('https://rss.app/feeds/LsUd1xHIfAg8itgQ.xml');
    final response = await http.get(url);
    xml2json.parse(response.body.toString());
    var jsondata = await xml2json.toGData();
    var data = json.decode(jsondata);
    NewsTechnology = data['rss']['channel']['item'];
    print(NewsTechnology);
  }

  Future NewsBusinessFeed() async {
    final url = Uri.parse('https://rss.app/feeds/Zaja3mUJaDXWRS9I.xml');
    final response = await http.get(url);
    xml2json.parse(response.body.toString());
    var jsondata = await xml2json.toGData();
    var data = json.decode(jsondata);
    NewsBusiness = data['rss']['channel']['item'];
    print(NewsBusiness);
  }

  Future NewsEntertainmentFeed() async {
    final url = Uri.parse('https://rss.app/feeds/xPJw6UXRS4zCnlTu.xml');
    final response = await http.get(url);
    xml2json.parse(response.body.toString());
    var jsondata = await xml2json.toGData();
    var data = json.decode(jsondata);
    NewsEntertainment = data['rss']['channel']['item'];
    print(NewsEntertainment);
  }

  Future NewsSportsFeed() async {
    final url = Uri.parse('https://rss.app/feeds/vrXylEUtQ94wyXRK.xml');
    final response = await http.get(url);
    xml2json.parse(response.body.toString());
    var jsondata = await xml2json.toGData();
    var data = json.decode(jsondata);
    NewsSports = data['rss']['channel']['item'];
    print(NewsSports);
  }

  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //return DefaultTabController(
    //  length: 2,
    //child:
    NewsTechnologyFeed();
    NewsBusinessFeed();
    NewsEntertainmentFeed();
    NewsSportsFeed();

    return Scaffold(
// ----------------------------------------------- LOGO -----------------------------------------------
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(222, 0, 183, 255),
        title: const Text(
          'ITFEEDS Internet Society',
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
                      builder: (context) => const TrangThongBao(
                            title: '',
                          )),
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
              isScrollable: true,
              labelColor: Colors.blue,
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.black, // unfocus

              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SizedBox(width: 1), Text('Technology')],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SizedBox(width: 1), Text('Business')],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SizedBox(width: 1), Text('Entertainment')],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SizedBox(width: 1), Text('Sports')],
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
                child: Image.asset('assets/itfeeds.png')),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                _tabController
                    ?.animateTo(0); // hiệu ứng chuyển đến tab "Mới nhất"
              },
              title: const Text('Technology'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                _tabController
                    ?.animateTo(1); // hiệu ứng chuyển đến tab "Xu hướng"
              },
              title: const Text('Business'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                _tabController
                    ?.animateTo(2); // hiệu ứng chuyển đến tab "Xu hướng"
              },
              title: const Text('Entertainment'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                _tabController
                    ?.animateTo(3); // hiệu ứng chuyển đến tab "Xu hướng"
              },
              title: const Text('Sports'),
            ),
          ],
        ),
      ),
// -------------------------------------------- FOOTER -----------------------------------------------------------------------------
      bottomNavigationBar: const BottomNavi(index: 0),

// -------------------------------------------- BODY --------TAB BAR VIEW ----------------------------------------------------------
      body: TabBarView(controller: _tabController, children: [
        FutureBuilder(
            future: NewsTechnologyFeed(),
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
                              itemCount: NewsTechnology.length,
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
                                              title: NewsTechnology[index]
                                                  ['title']['__cdata'],
                                              imagedata: NewsTechnology[index][
                                                              'media\$content'] !=
                                                          null &&
                                                      NewsTechnology[index][
                                                                  'media\$content']
                                                              ['url'] !=
                                                          null
                                                  ? NewsTechnology[index]
                                                      ['media\$content']['url']
                                                  : null,
                                              description: NewsTechnology[index]
                                                              ['description'] !=
                                                          null &&
                                                      NewsTechnology[index][
                                                                  'description']
                                                              ['__cdata'] !=
                                                          null
                                                  ? NewsTechnology[index]
                                                      ['description']['__cdata']
                                                  : null,
                                              date: NewsTechnology[index]
                                                  ['pubDate'],
                                              link: NewsTechnology[index]
                                                  ['link'],
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
                                          child: NewsTechnology[index]
                                                      ['media\$content'] !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl:
                                                      NewsTechnology[index]
                                                              ['media\$content']
                                                          ['url'],
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
                                          NewsTechnology[index]['link']
                                              .toString()
                                              .substring(
                                                  13,
                                                  NewsTechnology[index]['link']
                                                      .toString()
                                                      .indexOf('/', 13)),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          NewsTechnology[index]['pubDate']
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
                                            NewsTechnology[index]['title']
                                                ['__cdata'],
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
            future: NewsBusinessFeed(),
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
                              itemCount: NewsTechnology.length,
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
                                              title: NewsBusiness[index]
                                                  ['title']['__cdata'],
                                              imagedata: NewsBusiness[index][
                                                              'media\$content'] !=
                                                          null &&
                                                      NewsBusiness[index][
                                                                  'media\$content']
                                                              ['url'] !=
                                                          null
                                                  ? NewsBusiness[index]
                                                      ['media\$content']['url']
                                                  : null,
                                              description: NewsBusiness[index]
                                                  ['description']['__cdata'],
                                              date: NewsBusiness[index]
                                                  ['pubDate'],
                                              link: NewsBusiness[index]['link'],
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
                                          child: NewsBusiness[index]
                                                      ['media\$content'] !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl: NewsBusiness[index]
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
                                          NewsBusiness[index]['link']
                                              .toString()
                                              .substring(
                                                  13,
                                                  NewsBusiness[index]['link']
                                                      .toString()
                                                      .indexOf('/', 13)),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          NewsBusiness[index]['pubDate']
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
                                            NewsBusiness[index]['title']
                                                ['__cdata'],
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
            future: NewsEntertainmentFeed(),
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
                              itemCount: NewsEntertainment.length,
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
                                              title: NewsEntertainment[index]
                                                  ['title']['__cdata'],
                                              imagedata: NewsEntertainment[
                                                                  index][
                                                              'media\$content'] !=
                                                          null &&
                                                      NewsEntertainment[index][
                                                                  'media\$content']
                                                              ['url'] !=
                                                          null
                                                  ? NewsEntertainment[index]
                                                      ['media\$content']['url']
                                                  : null,
                                              description:
                                                  NewsEntertainment[index]
                                                          ['description']
                                                      ['__cdata'],
                                              date: NewsEntertainment[index]
                                                  ['pubDate'],
                                              link: NewsEntertainment[index]
                                                  ['link'],
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
                                          child: NewsEntertainment[index]
                                                      ['media\$content'] !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl:
                                                      NewsEntertainment[index]
                                                              ['media\$content']
                                                          ['url'],
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
                                          NewsEntertainment[index]['link']
                                              .toString()
                                              .substring(
                                                  13,
                                                  NewsEntertainment[index]
                                                          ['link']
                                                      .toString()
                                                      .indexOf('/', 13)),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          NewsEntertainment[index]['pubDate']
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
                                            NewsEntertainment[index]['title']
                                                ['__cdata'],
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
            future: NewsSportsFeed(),
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
                              itemCount: NewsSports.length,
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
                                              title: NewsSports[index]['title']
                                                  ['__cdata'],
                                              imagedata: NewsSports[index][
                                                              'media\$content'] !=
                                                          null &&
                                                      NewsSports[index][
                                                                  'media\$content']
                                                              ['url'] !=
                                                          null
                                                  ? NewsSports[index]
                                                      ['media\$content']['url']
                                                  : null,
                                              description: NewsSports[index]
                                                              ['description'] !=
                                                          null &&
                                                      NewsSports[index][
                                                                  'description']
                                                              ['__cdata'] !=
                                                          null
                                                  ? NewsSports[index]
                                                      ['description']['__cdata']
                                                  : null,
                                              date: NewsSports[index]
                                                  ['pubDate'],
                                              link: NewsSports[index]['link'],
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
                                          child: NewsSports[index]
                                                      ['media\$content'] !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl: NewsSports[index]
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
                                          NewsSports[index]['link']
                                              .toString()
                                              .substring(
                                                  13,
                                                  NewsSports[index]['link']
                                                      .toString()
                                                      .indexOf('/', 13)),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          NewsSports[index]['pubDate']
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
                                            NewsSports[index]['title']
                                                ['__cdata'],
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
      ]),
    );
    //);
  }
}
