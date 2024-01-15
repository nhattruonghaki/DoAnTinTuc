import 'package:flutter/material.dart';
import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Models/TangGiamFont.dart';
import 'package:itnew/Views/BottomNavi.dart';
import 'package:itnew/Views/CoChuvaFontChu.dart';
import 'package:itnew/Views/TimKiem.dart';
import 'package:itnew/Views/TrangThongBao.dart';

class TrangChu extends StatefulWidget {
  const TrangChu({super.key});

  @override
  State<TrangChu> createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChu>
    with SingleTickerProviderStateMixin {
  final TangGiamFont fontSize = TangGiamFont();
  final FontsChu fontsChu = FontsChu();
  // minxin cung cấp đối tượng đối tượng TickerProvider
// duy nhất và có thể sử dụng cho 1 Ticker (đối tượng thời gian) -> animation
  TabController? _tabController;
  //late int coChu;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(222, 0, 183, 255),
        title: const Text(
          'ITFeeds',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
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

              tabs: const [
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
                child: Image.asset('assets/itfeeds.png')),
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
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            // --------THANH CUỘN CỦA TAB MỚI NHẤT -----------------------------
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(context, '/trangchitiet');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset('assets/itfeeds.png'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Text(
                              'ITNEWIS',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '2 giờ',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        key: UniqueKey(),
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Text(
                          'App tin tức xịn nhất được phát triển gần đây',
                          style:
                              TextStyle(fontSize: fontSize.coChu.toDouble(), fontFamily: fontsChu.fontInter == 'Inter'? 'Inter':'Kalam'),
                        ),
                      ),
                      const Divider(
                        thickness: 2, // ------------------------- ĐỘ DÀY
                        color: Color.fromARGB(
                            255, 199, 199, 199), // ----------------- MÀU SẮC
                        indent: 1, // ---------------------------- LÙI SANG TRÁI
                        endIndent: 1, // ------------------------- LÙI SANG PHẢI
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushNamed(context, '/trangchitiet');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Image.asset('assets/itfeeds.png'),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                Text(
                                  'ITNEWIS',
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '2 giờ',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Text(
                              'Tin tức mới toanh',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            // --------THANH CUỘN CỦA TAB XU HƯỚNG -----------------------------
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(context, '/trangchitiet');
                  },
                  child: const Text('hãy chọn trang chi tiết'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
